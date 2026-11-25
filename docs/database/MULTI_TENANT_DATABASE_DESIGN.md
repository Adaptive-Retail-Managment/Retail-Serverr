# Multi-tenant database design

**Status:** Step 3 baseline. Shared-schema multi-tenancy with database-level relationship
safeguards.
**Related:** [Multi-tenant security architecture](../architecture/MULTI_TENANT_SECURITY_ARCHITECTURE.md),
[Logical design](LOGICAL_DATABASE_DESIGN.md), [Entity catalog](DATABASE_REQUIREMENTS_AND_ENTITY_CATALOG.md).

## 1. Tenancy model

| Concept           | Storage                               | Meaning                                              |
| ----------------- | ------------------------------------- | ---------------------------------------------------- |
| User              | `User`                                | A person account, global to the platform             |
| Business          | `Business`                            | A tenant; one subscription, one Owner, many branches |
| Branch            | `Branch`                              | An operating location inside one business            |
| Membership        | `Membership`                          | A user's role inside one business                    |
| Branch assignment | `MembershipBranchAssignment`          | Which branches a membership may operate              |
| Platform role     | `User` + platform authorization scope | Super Admin; no business membership                  |

A user can be an Owner in business A, a Cashier in business B and have no access to business C.
There is no global role column on `User`. A Super Admin never receives a business membership to
gain access; support access is a separate, time-bound `SupportAccessGrant` with an audit trail.

The identity/tenancy ERD is in
[ER diagrams §1](ENTITY_RELATIONSHIP_DIAGRAM.md#1-identity-and-tenancy).

## 2. Column policy

- Every tenant-owned table has `businessId String @db.Uuid NOT NULL`.
- Every branch-scoped table has `businessId` and `branchId`, both required.
- Global tables have neither `businessId` nor `branchId`. They fall into three groups:
  - **Platform catalogue/configuration:** `Plan`, `PlanFeature`, `PlanPrice`, `Permission`,
    `RolePermission`, `PlatformSetting`, `ForecastModel`.
  - **Global user infrastructure:** `User`, `UserCredential`, `UserSession`,
    `EmailVerificationToken`, `PasswordResetToken`.
  - **User-owned cross-tenant preferences:** `NotificationPreference` — keyed by
    `(userId, channel, category)` with a `User` FK; notification channel/category opt-outs are a
    property of the person, not of a business, so no tenant scope applies. Services scope reads
    and writes by the authenticated `userId` only; a preference never leaks tenant data because it
    stores no business content. This is a legitimate global user-scoped exception, not a
    tenant-integrity concern.
- Ten tables allow a null `businessId`. They fall into three classes, detailed in §3.2:
  - **Platform-or-tenant rows:** `Role` (system role templates have `businessId = null`),
    `Unit` (platform units), `FileObject`, `FileLink` (platform assets; tenant uploads always set
    it) and `FileUploadSession` (pre-auth upload token; `businessId` is bound when the session
    completes).
  - **Tenant-known but temporarily unresolved rows:** `PaymentWebhookEvent` (a provider event may
    arrive before it is matched to a tenant attempt), `IdempotencyRecord` (platform-scoped API
    operations carry no business), `AuditEvent` (platform and pre-auth events have no tenant) and
    `SupportCase` (a case may be opened by a user with no business context; `businessId` is set
    when the case is linked to a tenant).
  - **Platform-owned event stream:** `OutboxEvent` may carry `businessId = null` for
    platform-level events.
- Four tables have no `businessId` column at all because their tenant is derived through a parent
  (`EmploymentStatusHistory`, `SyncAttempt`, `SyncCursor`, `ForecastPoint`). They are tenant-owned
  records, not platform tables; §3.3 defines the mandatory parent-join query rule.
- No table stores a tenant identity in JSON, a text prefix or a schema name.
- `branchId` is never the only tenant key: it is always paired with `businessId` in the composite
  foreign key.

## 3. Composite-key isolation

Every referenceable tenant parent has:

```prisma
@@unique([businessId, id])
```

Every tenant-scoped child relation uses the tenant key:

```prisma
branch      Branch  @relation(fields: [businessId, branchId], references: [businessId, id])
```

This is the primary database safeguard. A row cannot point at a parent in another business even if
application code passes the wrong ID. Examples enforced in the schema:

| Child                                                                             | Composite parent                | Prevents                                                 |
| --------------------------------------------------------------------------------- | ------------------------------- | -------------------------------------------------------- |
| `Sale`, `StockBalance`, `StockMovement`, `CashierShift`                           | `Branch(businessId, id)`        | Selling or stocking another tenant's branch              |
| `PurchaseOrder` → `Supplier`                                                      | `Supplier(businessId, id)`      | Ordering from another tenant's supplier                  |
| `ProductVariant` → `Product`                                                      | `Product(businessId, id)`       | Attaching a variant to another tenant's product          |
| `SaleLine` → `Sale`                                                               | `Sale(businessId, id)`          | Mixing lines across sales or tenants                     |
| `GoodsReceipt` → `PurchaseOrder`                                                  | `PurchaseOrder(businessId, id)` | Receiving another tenant's order                         |
| `SyncOperation` → `Device` / `Branch`                                             | composite                       | Syncing a device into another tenant                     |
| `PaymentAllocation` → `SupplierPayment` / `SupplierInvoice`                       | composite                       | Allocating a payment to another tenant's invoice         |
| `ProductPrice` → `PriceList`                                                      | `PriceList(businessId, id)`     | Pricing a variant from another tenant's list             |
| `SubscriptionInvoice` / `SubscriptionHistory` / `PaymentAttempt` → `Subscription` | `Subscription(businessId, id)`  | Billing against another tenant's subscription            |
| `BatchMovementAllocation` → `StockMovement`                                       | `StockMovement(businessId, id)` | Explaining a ledger entry with another tenant's movement |
| `ReconciliationException` → `SyncOperation` / `Membership`                        | composite                       | Reconciling or assigning another tenant's evidence       |
| `Customer.mergedInto` → `Customer`                                                | `Customer(businessId, id)`      | Merging a customer into another tenant's record          |

Natural-key uniqueness is always tenant-scoped: `@@unique([businessId, sku])`,
`@@unique([businessId, code])`, `@@unique([businessId, receiptNumber])`,
`@@unique([businessId, number])`. A SKU or receipt number may repeat in a different business.

### 3.1 Residual id-only references and why they remain

Nineteen relations still reference a tenant-scoped table by `id` alone. Each one exists because
the parent's `businessId` is nullable, so a composite foreign key cannot be formed without making
platform data impossible:

| Parent with nullable tenant                                       | Referencing relations                                                                                                    | Why composite is not used                                            | Mitigation                                                                                                                     |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `Role` (system role templates have `businessId = null`)           | `Membership.role`, `Invitation.role`                                                                                     | A required `Membership.businessId` cannot match a `null` role tenant | Authorization service resolves the role inside the membership's business; a role ID from another tenant fails the scope check  |
| `Unit` (platform units have `businessId = null`)                  | `Product.unit`, `ProductVariant.unit`, `AttributeDefinition.unit`, `Unit.baseUnit`, `UnitConversion.fromUnit` / `toUnit` | Same null-tenant problem                                             | Unit resolution is scoped to `(businessId IS NULL OR businessId = :tenant)`; conversions are validated before use              |
| `FileObject` / `FileLink` (platform assets)                       | media, documents, receipts, exports, reconciliation evidence                                                             | The file may be platform-owned                                       | Upload and link services check that a tenant file's `businessId` equals the caller's; platform files are read-only for tenants |
| `PaymentWebhookEvent` (provider event may arrive before matching) | `PaymentWebhookEvent.attempt`                                                                                            | `businessId` is set only after the attempt is matched                | Webhook handler derives the business from the verified attempt; unmatched events have no tenant data access                    |

These are documented service-enforced boundaries, not hidden assumptions. Each one requires a
cross-tenant integration test in the module that owns the reference. If a future change makes the
parent's tenant required, the relation must be promoted to a composite key in the same migration.

### 3.2 Nullable-`businessId` exception register

Every model with `businessId String?` is listed here. "Populated by" names the authoritative
writer; "Query rule" is the minimum filter a repository must apply. None of these exceptions is
transitional unless stated; removing one requires a migration plus this document's update.

| Model                 | Class                    | Why nullable                                           | When it must be populated                                           | Populated / validated by             | Query rule                                                                                                        |
| --------------------- | ------------------------ | ------------------------------------------------------ | ------------------------------------------------------------------- | ------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| `Role`                | Platform-or-tenant       | System role templates are platform-owned               | Always for business roles; `null` only for `isSystem` templates     | Platform seed / tenant admin service | Scope lookup to `(businessId IS NULL OR businessId = :tenant)`; authorization rejects a role of another tenant    |
| `Unit`                | Platform-or-tenant       | Platform units are shared                              | `null` for global units; tenant units always set it                 | Platform seed / catalog service      | Same resolution rule as `Role`; conversions validated before use                                                  |
| `FileObject`          | Platform-or-tenant       | Platform assets exist                                  | Tenant uploads always set it at creation                            | File service                         | Tenant queries filter `businessId = :tenant`; platform files are read-only references                             |
| `FileLink`            | Platform-or-tenant       | Follows its `FileObject`                               | Set whenever the linked entity is tenant-owned                      | File service                         | Filter on `businessId`; verify `file.businessId` matches the entity's tenant                                      |
| `FileUploadSession`   | Platform-or-tenant       | Token may be issued before tenant context is confirmed | Set at session completion from the authenticated principal's tenant | Upload service                       | Look up by `tokenHash` only inside the completing request's tenant scope; never list sessions cross-tenant        |
| `PaymentWebhookEvent` | Tenant-known, unresolved | Event arrives before attempt matching                  | Set by the webhook handler once `attemptId` resolves to a tenant    | Webhook reconciliation service       | Unmatched events (`businessId IS NULL`) are platform-queue only; tenant queries always filter `businessId`        |
| `IdempotencyRecord`   | Platform-or-tenant       | Platform-scoped operations have no business            | Set for every business-scoped API/sync/webhook record               | API gateway / sync service           | Uniqueness is `(businessId, scope, key)` for tenant rows and `(scope, key) WHERE businessId IS NULL` for platform |
| `AuditEvent`          | Platform-or-tenant       | Pre-auth and platform events have no tenant            | Set whenever the audited action has a tenant context                | Audit writer (every module)          | Tenant audit queries filter `businessId`; platform events (`null`) are Super-Admin/support-visible only           |
| `SupportCase`         | Tenant-known, unresolved | A case may be opened with no business context          | Set when the case is linked to a tenant via `SupportAccessGrant`    | Support service                      | Tenant users see only cases with `businessId = :tenant`; platform staff use the support console                   |
| `OutboxEvent`         | Platform-or-tenant       | Platform-level domain events exist                     | Set for every business-scoped event at write time                   | Owning module's outbox writer        | Relay queries partition by `businessId`; a `null` event is delivered only to platform subscribers                 |

`AuditEvent.branchId` is nullable and its composite FK `(businessId, branchId)` is skipped when
`businessId IS NULL`; a platform event must never carry a `branchId`, and services must reject one.

### 3.3 Tenant-derived children without `businessId`

Four models carry no `businessId` column. Their rows still belong to exactly one tenant through an
authoritative parent. They are **not** platform tables.

| Model                     | Parent (FK)                         | Tenant derivation          | Required query rule                                                                                        |
| ------------------------- | ----------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `EmploymentStatusHistory` | `Employee` (`employeeId`)           | `Employee.businessId`      | Resolve `employee → businessId` inside the same query/transaction; never expose the row by `id` alone      |
| `SyncAttempt`             | `SyncOperation` (`syncOperationId`) | `SyncOperation.businessId` | Join through `SyncOperation`; tenant scope comes from the operation, not the attempt                       |
| `SyncCursor`              | `Device` (`deviceId`)               | `Device.businessId`        | Resolve `device → businessId`; cursor reads/writes must validate the device belongs to the caller's tenant |
| `ForecastPoint`           | `ForecastRun` (`forecastRunId`)     | `ForecastRun.businessId`   | Join through `ForecastRun`; forecast queries are scoped by the run's tenant                                |

Mandatory rule for all four: a child record must never be fetched, updated or deleted by child ID
without first resolving the parent inside the caller's tenant scope. Composite foreign keys protect
references but do **not** protect read queries — the service layer owns this check. Branch scope is
inherited from the parent where the parent carries `branchId` (`SyncOperation`, `Device`,
`ForecastRun` do; `Employee` does not — employment history is business-scoped only). Each model
requires a negative cross-tenant test (TEN suite) proving
that a child ID from tenant B cannot be read through tenant A's scope.

## 4. Query and service rules (for later implementation)

The database prevents cross-tenant **relationships**. It cannot, by itself, prevent a query that
omits `businessId` and returns another tenant's rows. Later services must:

1. Resolve the active membership and branch from the authenticated principal, never from a
   client-supplied `businessId` alone.
2. Include `businessId` in every tenant query, including `findUnique`, counts, aggregates and raw
   SQL.
3. Prefer repository methods that take a `TenantScope` object; do not expose unscoped repositories.
4. Reject a branch ID that is not assigned to the membership, even when it belongs to the same
   business.
5. Audit denied cross-tenant attempts (`AuditEvent.outcome = DENIED`).

A Prisma client extension that injects the tenant filter is planned with the first vertical slice;
it is not implemented in Step 3.

## 5. Row-level security evaluation

PostgreSQL row-level security (RLS) was evaluated and **not adopted in Step 3**.

Reasons:

- **Connection pooling.** Prisma's pool multiplexes sessions. RLS depends on a session variable
  (`SET LOCAL app.business_id`), which requires a transaction-scoped context for every statement.
  A missed context can either expose rows or silently return none.
- **Migration and operations.** Migrations, seed scripts and background jobs need a bypass role.
  Maintaining two roles and policies increases operational risk before the application exists.
- **Debugging.** A policy bug becomes a data-visibility incident that is harder to diagnose than an
  explicit missing `where` clause.
- **Current stage.** No service code exists. Composite keys, required tenant columns, scoped unique
  constraints and a mandatory review checklist provide the structural safeguard now.

Adoption criteria for a future ADR:

1. All tenant access runs through a single repository layer with a transaction-scoped context.
2. A dedicated migration/seed role and an application role are provisioned.
3. Integration tests prove that a missing context fails closed, not open.
4. Pooling mode is documented (transaction mode compatible; no session-level state).

Until then, RLS is a documented optional hardening step, not a claim.

## 6. Threat coverage

| Threat                                       | Database safeguard                                                                                                         | Later service/test safeguard                                                   |
| -------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| Business A reads Business B's sale           | `businessId` on every row; composite FKs                                                                                   | Mandatory tenant filter; cross-tenant e2e tests                                |
| Sale references another tenant's branch      | `Sale` → `Branch(businessId, id)`                                                                                          | Branch assignment check                                                        |
| Variant attached to another tenant's product | `ProductVariant` → `Product(businessId, id)`                                                                               | Catalog service scope check                                                    |
| Supplier from another tenant on a PO         | `PurchaseOrder` → `Supplier(businessId, id)`                                                                               | Procurement scope check                                                        |
| Device syncs into the wrong branch           | `SyncOperation` composite branch/device FKs                                                                                | Device enrollment check; feed reset                                            |
| Duplicate offline sale                       | `SyncOperation @@unique([businessId, deviceId, operationId])`, `Sale @@unique([businessId, offlineDeviceId, operationId])` | Idempotent sync handler                                                        |
| Duplicate stock movement from a retry        | `StockMovement @@unique([businessId, sourceKey])`                                                                          | Source-key generation                                                          |
| Membership in an unrelated business          | `Membership @@unique([businessId, userId])` + business FK                                                                  | Role resolution scoped to the membership business; invitation and owner checks |
| Business Admin performs physical stock work  | `Permission.isPhysical` + role seed                                                                                        | Guard + permission-matrix tests                                                |
| Super Admin reads tenant data silently       | `SupportAccessGrant` expiry + `AuditEvent`                                                                                 | Support-access tests                                                           |
| Cross-tenant export                          | Report query scoped to membership                                                                                          | Export query tests                                                             |

## 7. Super Admin and support access

- Platform authority is not a `Membership`. A Super Admin has no role row inside a business.
- `SupportAccessGrant` records grantor, recipient, business, scope, start, expiry and revocation.
- Every support action writes an `AuditEvent` with `actorType = SUPER_ADMIN_SUPPORT` and the grant
  reference.
- A revoked or expired grant blocks access in the service layer; the database records the grant so
  the decision is auditable.
- Super Admin cannot grant business permissions or bypass stock/money invariants.

## 8. Review checklist for schema changes

- [ ] New tenant table has `businessId` and a business FK.
- [ ] New branch table has `branchId` and a composite branch FK.
- [ ] New referenceable parent has `@@unique([businessId, id])`.
- [ ] Natural keys are unique within `businessId`.
- [ ] No unscoped `findUnique` can be generated by a repository API.
- [ ] Cross-tenant test fixtures exist for the new relation.
- [ ] RLS assumptions are unchanged; if changed, write an ADR.
