# Prisma schema guide

**Status:** Step 3 database foundation. The schema is complete and validated; no migration has been
applied and no business service imports the generated client yet.

This guide explains how the single canonical Prisma schema is organised, which conventions every
member must follow, and how a change moves from proposal to reviewed schema. It is the working
reference for all four database owners. The design rationale lives in
[`LOGICAL_DATABASE_DESIGN.md`](LOGICAL_DATABASE_DESIGN.md); the table-by-table inventory lives in
[`DATABASE_REQUIREMENTS_AND_ENTITY_CATALOG.md`](DATABASE_REQUIREMENTS_AND_ENTITY_CATALOG.md).

## 1. Canonical location and toolchain

| Item                | Value                                                          |
| ------------------- | -------------------------------------------------------------- |
| Schema file         | `apps/api/prisma/schema.prisma`                                |
| Client generator    | `prisma-client-js`                                             |
| Datasource          | `postgresql`, URL from `DATABASE_URL`                          |
| PostgreSQL          | 17 (`postgres:17-alpine` in `infra/docker/compose.dev.yml`)    |
| Prisma CLI          | 6.19.3 (API workspace dev dependency)                          |
| Package scripts     | `prisma:validate`, `prisma:generate` (root and `@arp/api`)     |
| Migration directory | `apps/api/prisma/migrations` (created with the first baseline) |

There is one schema. No module owns a private schema file or a separate database. A member who
needs a table adds it here, in the owning module's section, after the review described in Section 12.

Commands used in this step (run from the repository root):

```bash
node apps/api/node_modules/prisma/build/index.js validate --schema apps/api/prisma/schema.prisma
node apps/api/node_modules/prisma/build/index.js format   --schema apps/api/prisma/schema.prisma
node apps/api/node_modules/prisma/build/index.js generate --schema apps/api/prisma/schema.prisma
```

The package-script equivalents are `pnpm prisma:validate` and `pnpm prisma:generate`. Migration
commands are documented in
[`DATABASE_MIGRATION_AND_SEED_STRATEGY.md`](DATABASE_MIGRATION_AND_SEED_STRATEGY.md); they are not
run in Step 3.

## 2. Schema anatomy

The file is ordered as follows:

1. Header comment stating scope, tenancy, money precision, stock authority and history policy.
2. `generator` and `datasource` blocks.
3. `// enums` section, alphabetical by domain grouping.
4. `// models` section, grouped in module order: platform infrastructure, identity, tenancy,
   authorization, employees, subscriptions, super admin, audit, business configuration, catalog,
   pricing, files, inventory, suppliers, procurement, customers, synchronization, sales,
   after-sales, notifications, analytics, intelligence.
5. Platform-level models that carry no `businessId` (`Plan`, `Permission`, `ForecastModel`,
   `ForecastPoint`, `NotificationPreference`, `IdempotencyRecord`) live with their owning module,
   not in a separate file.

Inventory at the end of Step 3:

| Measure                                  | Count |
| ---------------------------------------- | ----- |
| Models                                   | 159   |
| Enums                                    | 94    |
| Models carrying `businessId`             | 141   |
| Models carrying `branchId`               | 52    |
| Models with `@@unique([businessId, id])` | 138   |
| `@@unique` declarations                  | 274   |
| Scalar `@unique` fields                  | 27    |
| Combined unique declarations             | 301   |
| `@@index` declarations                   | 187   |
| `onDelete: Restrict` relations           | 302   |
| `onDelete: Cascade` relations            | 57    |
| `onDelete: SetNull` relations            | 8     |
| `Float` / `Double` columns               | 0     |

`@@unique([businessId, id])` is absent from two one-per-business tables because their
`businessId` is itself `@unique`: `TrialGrant` and `BusinessConfiguration`. `Subscription` keeps
both `businessId @unique` and the composite key because payment and invoice rows reference it
through the tenant pair. The constraint is also absent from `RolePermission`, which uses the
composite primary key `@@id([roleId, permissionId])`.

## 3. Naming conventions

| Element           | Convention                               | Example                                      |
| ----------------- | ---------------------------------------- | -------------------------------------------- |
| Model             | PascalCase, singular                     | `PurchaseOrder`, `StockMovement`             |
| Field             | camelCase                                | `quantityOnHand`, `receiptNumber`            |
| Enum              | PascalCase, singular                     | `StockMovementType`, `ReconciliationStatus`  |
| Enum value        | SCREAMING_SNAKE_CASE                     | `PARTIALLY_RECEIVED`, `INSUFFICIENT_STOCK`   |
| Relation field    | camelCase, plural for lists              | `lines`, `payments`, `business`              |
| Foreign-key field | `<target>Id`                             | `branchId`, `variantId`, `membershipId`      |
| Timestamp         | `<event>At`                              | `completedAt`, `archivedAt`, `deactivatedAt` |
| Boolean           | `is` / `has` prefix or a clear adjective | `isPhysical`, `isOwner`, `cancelAtPeriodEnd` |
| Money             | `<purpose>` plus explicit `currency`     | `subtotal`, `total`, `currency`              |
| Snapshot          | suffix `Snapshot` or `...History`        | `FeatureSnapshot`, `PriceChangeHistory`      |

No `@@map` is used: model and field names are the physical table and column names. Migration SQL
must therefore quote camelCase identifiers, for example `"quantityOnHand"`.

## 4. Type conventions

| Concern             | Prisma type                       | PostgreSQL type  | Rule                                                            |
| ------------------- | --------------------------------- | ---------------- | --------------------------------------------------------------- |
| Identifier          | `String @db.Uuid`                 | `uuid`           | every model; `@default(uuid(7))` except join tables             |
| Money               | `Decimal @db.Decimal(18, 2)`      | `numeric(18,2)`  | 59 columns; always paired with `currency`                       |
| Quantity            | `Decimal @db.Decimal(18, 3)`      | `numeric(18,3)`  | stock, counts, conversions                                      |
| Unit cost           | `Decimal @db.Decimal(18, 4)`      | `numeric(18,4)`  | 15 columns; valuation precision                                 |
| Timestamp           | `DateTime @db.Timestamptz(6)`     | `timestamptz(6)` | all operational timestamps                                      |
| Business date       | `DateTime @db.Date`               | `date`           | daily facts, invoice periods                                    |
| Currency            | `String @db.VarChar(3)`           | `varchar(3)`     | ISO-4217, default `"ETB"` where the business default is implied |
| Short code / number | `String @db.VarChar(n)`           | `varchar(n)`     | bounded; do not use unbounded `String` for codes                |
| Long text           | `String`                          | `text`           | descriptions, notes, reasons                                    |
| Flexible payload    | `Json`                            | `jsonb`          | see Section 8                                                   |
| Optimistic lock     | `Int @default(1)` named `version` | `integer`        | headers and balances that are updated in place                  |

Floating point is prohibited for money, quantities and costs. If a new numeric field is needed,
choose `Decimal` precision deliberately and record it in the review.

## 5. Identity and timestamps

- Every row uses a UUID primary key. UUID v7 (`@default(uuid(7))`) is time-ordered and avoids the
  index fragmentation of random v4 IDs. The few join tables (`RolePermission`,
  `MembershipBranchAssignment`, `EmployeeBranchAssignment`) use a composite primary key or a UUID
  where the row is a first-class assignment.
- `createdAt` and `updatedAt` are `Timestamptz(6)`. `updatedAt` uses `@updatedAt`.
- Business dates that must not shift with a time zone (daily facts, invoice periods) use `@db.Date`.
- Event time and record time are separate where backdating is possible: `occurredAt` is when the
  business event happened, `recordedAt` is when the server stored it. Offline operations must set
  both.

## 6. Tenant and branch isolation in the schema

Every business-owned row carries `businessId`. Every branch-owned row carries `businessId` and
`branchId`, and its branch relation uses the composite candidate key rather than the branch's UUID
alone:

```prisma
model StockBalance {
  businessId String @db.Uuid
  branchId   String @db.Uuid
  variantId  String @db.Uuid

  branch  Branch         @relation(fields: [businessId, branchId], references: [businessId, id], onDelete: Restrict)
  variant ProductVariant @relation(fields: [businessId, variantId], references: [businessId, id], onDelete: Restrict)

  @@unique([branchId, variantId])
  @@unique([businessId, id])
}
```

The parent must expose the matching candidate key:

```prisma
model Branch {
  id         String @id @default(uuid(7)) @db.Uuid
  businessId String @db.Uuid

  @@unique([businessId, id])
}
```

Consequences every member must respect:

1. A child cannot reference a parent in another business: the two-column foreign key would not
   match, so PostgreSQL rejects the insert even if application code forgets the tenant filter.
2. The composite unique is also a valid index prefix for `businessId`, so it doubles as a tenant
   index. Additional `@@index([businessId, ...])` declarations cover the real query paths.
3. A relation that references a tenant-scoped parent by `id` alone is only allowed for
   platform-level parents (`Plan`, `Permission`, `ForecastModel`, `User`) or for the documented
   residual cases where the parent's `businessId` is nullable (system `Role`, global `Unit`,
   platform `FileObject`/`FileLink`, unmatched `PaymentWebhookEvent`). Those 19 relations and
   their service-level mitigations are listed in
   [`MULTI_TENANT_DATABASE_DESIGN.md`](MULTI_TENANT_DATABASE_DESIGN.md#31-residual-id-only-references-and-why-they-remain).
4. Optional cross-tenant links are not possible. If an optional relation uses composite fields,
   both fields are nullable or the relation is `Restrict`; Prisma cannot set a required
   `businessId` to null, so `SetNull` is not used on those relations.
5. Services must still pass `businessId` into every query. The schema prevents cross-tenant
   references, not cross-tenant reads of an ID guessed by a caller. The service rules are in
   [`MULTI_TENANT_DATABASE_DESIGN.md`](MULTI_TENANT_DATABASE_DESIGN.md).

The `Business` model is the tenant root and declares the reverse relation for every business-owned
model. Adding a `businessId` model without adding its `Business` list entry fails validation; this
is intentional, because it forces an explicit ownership decision.

## 7. Uniqueness, idempotency and one-to-one relations

Natural keys are unique inside a tenant, never globally, except platform catalogue keys:

| Concern                | Constraint                                                      |
| ---------------------- | --------------------------------------------------------------- |
| Product                | `@@unique([businessId, sku])`                                   |
| Variant                | `@@unique([businessId, sku])`                                   |
| Branch                 | `@@unique([businessId, code])`                                  |
| Supplier               | `@@unique([businessId, code])`                                  |
| Sale receipt           | `@@unique([businessId, receiptNumber])`                         |
| Purchase order         | `@@unique([businessId, number])`                                |
| API idempotency        | `IdempotencyRecord @@unique([businessId, scope, key])`          |
| Offline operation      | `SyncOperation @@unique([businessId, deviceId, operationId])`   |
| Offline sale replay    | `Sale @@unique([businessId, offlineDeviceId, operationId])`     |
| Provider webhook       | `PaymentWebhookEvent @@unique([provider, providerEventId])`     |
| Stock movement dedupe  | `StockMovement @@unique([businessId, sourceKey])`               |
| Refund idempotency     | `Refund @@unique([businessId, idempotencyKey])`                 |
| One trial per business | `TrialGrant.businessId @unique`                                 |
| One owner per business | `Business.ownerMembershipId @unique` (plus a partial SQL index) |
| One open shift         | partial unique SQL index on `CashierShift` (see migration)      |

One-to-one relations are modelled with a unique foreign key on the dependent side, for example
`Receipt.saleId @unique` and `@@unique([businessId, saleId])`. If a relation is 1:1 but the child
must remain optional, the referencing column stays nullable and unique.

Nullable columns in a unique constraint behave as distinct values in PostgreSQL; where "one row
per tenant with a null variant" matters, add a partial unique index in migration SQL rather than
relying on `@@unique`. The C-3 audit applied this rule to `StocktakeLine` (unbatched lines),
`GoodsReceiptLine` (unbatched receipt lines), `IdempotencyRecord` (platform-scoped keys),
`Role`/`Unit` (global codes) and `MembershipBranchAssignment` (active assignments only; revoked
rows are history). Cases where `NULL` legitimately means "not deduplicated" — for example
`Notification.dedupeKey`, `PaymentAttempt.providerReference`, `Refund.idempotencyKey` and the
offline-only columns on `Sale`/`SyncOperation` — keep their nullable uniqueness unchanged.

Two further conventions were fixed by the C-3/C-5 resolution:

- **Branch-consistent POS references.** `Sale`, `CashierShift` and the shift's terminal are bound
  by composite foreign keys on `(businessId, branchId, id)`, so a sale or shift cannot point at a
  terminal or shift of a different branch inside the same business.
- **Actor references.** `*UserId`/`actorUserId` scalar columns (for example `AuditEvent.actorUserId`,
  `StockLossRecord.requestedByUserId`, `ReconciliationException.cashierMembershipId` targets) are
  deliberate UUID snapshots, not foreign keys. Actors may be platform staff, system processes or
  deactivated users, and audit history must survive any user lifecycle change. Services resolve
  them against `User.id`; relational enforcement is added only where the actor is a required
  operational participant (for example `Sale.cashierMembershipId`).
- **Business type.** `Business.type` is the single authoritative classification. The
  `BusinessConfiguration.businessType` column is a synchronized convenience copy for configuration
  reads; the provisioning service must write both in one transaction and reject any update that
  would diverge. No other source of truth may be introduced.

## 8. JSON policy

`Json` is used only for data whose shape is genuinely open or externally owned. The 27 JSON
columns fall into four groups:

1. **External payloads preserved verbatim:** `OutboxEvent.payload`, `PaymentAttempt.rawPayload`,
   `PaymentWebhookEvent.payload`, `SyncOperation.payload`,
   `ReconciliationException.originalPayload`, `FeedEvent.payload`, `IdempotencyRecord.responseBody`.
2. **Flexible configuration or metadata:** `PlatformSetting.value`, `BusinessSetting.value`,
   `BranchSetting.value`, `AttributeDefinition.options`, `CapabilityFlag.config`,
   `SubscriptionHistory.metadata`, `ProductImportJob.issues`, `ProductImportJob.summary`,
   `Customer.preferences`, `ReportDefinition.parameters`, `ExportJob.parameters`.
3. **Audit and conflict evidence:** `AuditEvent.before`, `AuditEvent.after`,
   `AuditEvent.metadata`, `ConflictRecord.details`.
4. **Quotation and AI evidence:** `QuotationComparison.comparison`,
   `PurchaseOrderRevision.snapshot`, `ForecastRun.inputsSnapshot`,
   `Recommendation.proposedAction`, `FeatureSnapshot.features`.

Rules:

- Never store a value in JSON when it is queried, constrained or joined. Money, quantities,
  statuses, dates and identifiers belong in typed columns.
- An external payload is stored only after its hash is stored in a typed column, so duplicates and
  tampering are detectable (`ReconciliationException.payloadHash`).
- JSON is not an escape hatch for schema disagreement. If two modules need the same field, model it
  relationally.
- JSON columns are not indexed in this foundation. A future query that needs one requires an
  explicit expression index and review.

## 9. Relations and deletion behaviour

- `onDelete: Restrict` is the default for anything with history or financial meaning. It is used
  on 302 relations.
- `Cascade` is limited to owned child rows whose lifetime is inseparable from a header that is
  itself never deleted in normal operation (sale lines, purchase order lines, transfer lines,
  membership assignments), and to transient user-owned records (sessions, tokens, preferences).
  It never enables a tenant-wide delete: `Business` is referenced with `Restrict` from the
  operational roots, so `DELETE FROM "Business"` fails while any real data exists.
- `SetNull` is used only for optional lookups where the parent can be platform-owned or where the
  reference is non-historical and the column is nullable (for example `Product.unitId` and
  `FileObject` links). It is never used on a composite tenant relation; those use `Restrict`
  because PostgreSQL cannot null a required `businessId` as part of the same action.
- Named relations (`@relation("...")`) are required when two models have more than one relation
  between them, for example `Business.memberships` / `Business.ownerMembership`,
  `Sale.committedReconciliations` / `ReconciliationException.committedSale`, and header/line
  relations with more than one path.

Archival is modelled, not assumed:

| Master data                       | Archive signal                             |
| --------------------------------- | ------------------------------------------ |
| Business, Branch                  | `archivedAt`, branch `isActive`            |
| Product, Variant, Brand, Category | `archivedAt` or `ARCHIVED` status          |
| Supplier, Customer, Device        | status (`INACTIVE`, `ARCHIVED`, `REVOKED`) |
| Employee, Membership              | `deactivatedAt` plus history rows          |
| Document/file                     | archive flag and retained metadata         |

Operational and financial headers are never deleted. Their lifecycle is a status transition plus a
separate compensating record (void, return, refund, exchange, revision).

## 10. Enums

- Enums are used for closed state machines that the database must constrain: statuses, movement
  types, channels, actor types, failure codes.
- Enums are not used for user-configurable values. Configurable categories, units, payment methods
  and attributes are rows, because a business can add them without a migration.
- Adding an enum value is additive and safe. Removing or renaming a value is a destructive
  migration: it requires an approved plan, a data-mapping step and a compatibility window.
- The database enum is the source of truth for the state names; API DTOs may expose a different
  wire representation, but it must map deterministically.

## 11. Index conventions

Indexes exist for three reasons only: tenant filtering, declared foreign-key joins that are not
covered by a composite unique, and documented query paths. The full inventory and rationale are in
[`DATABASE_INDEXING_AND_PERFORMANCE.md`](DATABASE_INDEXING_AND_PERFORMANCE.md). Rules for a new
model:

1. Add `@@unique([businessId, id])` if the model is tenant-scoped and can be a parent.
2. Add a composite unique for the natural key inside the tenant.
3. Add `@@index([businessId, <status>])` when the module lists by status.
4. Add `@@index([businessId, <parentId>])` when children are loaded by parent and the parent index
   does not already cover it.
5. Add a time-ordered index for ledgers and histories: `@@index([businessId, branchId, <time>])`.
6. Do not add an index "just in case". Every index costs write throughput, and this platform is
   write-heavy at the POS.

## 12. Changing the schema

The four members share one schema, so a change is a small, reviewed contract:

1. **Propose.** State the module, the model, the reason, the tenant scope, the uniqueness rule, the
   deletion behaviour and the migration impact. If the change adds a table that another module
   reads, name the consumer.
2. **Check ownership.** The owning member authors the change. A change to a shared hotspot
   (`Business`, `Branch`, `Membership`, `ProductVariant`, `StockBalance`, `StockMovement`, `Sale`)
   requires review from every module that references it.
3. **Edit the owning section only.** Keep module grouping; do not reorder unrelated models.
4. **Validate and format.** `prisma validate` must pass before the change is committed. `prisma
format` keeps the diff mechanical.
5. **Generate.** `prisma generate` must succeed; a client that cannot be generated is a broken
   schema even if validation passed.
6. **Pair with migration SQL.** A schema change that needs a CHECK, partial unique index,
   `CONCURRENTLY` index, or data backfill includes the migration file described in
   [`DATABASE_MIGRATION_AND_SEED_STRATEGY.md`](DATABASE_MIGRATION_AND_SEED_STRATEGY.md).
7. **Update documentation in the same pull request.** Entity catalog, ER diagram, ownership table,
   index table and validation matrix are part of the change, not a follow-up.
8. **Do not edit applied migrations.** Fix forward with a new migration.

A pull request that changes the schema without a migration note, or adds a table without an owner
and student-facing documentation, is rejected.

## 13. What Prisma does not express

The schema is necessary but not sufficient. The following are deliberately implemented in
migration SQL or in the service layer, and must not be assumed to exist because the schema
validates:

| Rule                                               | Where it belongs                                      |
| -------------------------------------------------- | ----------------------------------------------------- |
| `quantityOnHand >= 0`, `quantityReserved >= 0`     | migration `CHECK` constraints                         |
| `quantityReserved <= quantityOnHand`               | migration `CHECK` constraint                          |
| Money non-negative where the domain requires it    | migration `CHECK` constraints                         |
| One owner membership per business                  | partial unique index                                  |
| One open cashier shift per terminal                | partial unique index                                  |
| Movement immutability / append-only ledger         | service rule plus DB privileges or trigger (deferred) |
| Row-level security                                 | evaluated and deferred, see the tenancy doc           |
| Cross-row transaction and locking order            | service layer, specified in the integrity doc         |
| Idempotent replay and reconciliation state machine | service layer, specified in the offline doc           |

Until those migrations exist, a database created directly from the Prisma schema can accept values
the platform intends to reject. This is why Step 3 does not claim that negative stock is already
prevented at runtime; the constraint is designed and specified, and will be installed with the
baseline migration.

## 14. Generated client boundary

- The generated client is a build artefact and is not committed.
- Only the owning module's repository may use a model's delegate. Cross-module reads go through a
  published contract, never through another module's tables (see
  [`../architecture/MODULE_DEPENDENCY_MAP.md`](../architecture/MODULE_DEPENDENCY_MAP.md) §4).
- Transactions that span modules are coordinated by the module that owns the invariant, and the
  provider's command is called inside that transaction. For stock, that provider is `inventory`.
- No business service is written in Step 3. The schema exists so Step 4 can write those services
  without redesigning tables.

## 15. Quick checklist for a schema review

- [ ] Model is in the owning module's section and has exactly one owner.
- [ ] `id` is `uuid(7)`; join table exception is justified.
- [ ] `businessId` present for tenant data, `branchId` present for branch data.
- [ ] Composite relation used for every tenant-scoped parent.
- [ ] `@@unique([businessId, id])` present when the model can be a parent.
- [ ] Natural key unique inside the tenant; not global by accident.
- [ ] Money and quantities use Decimal with the documented precision.
- [ ] Timestamps use `Timestamptz(6)`; business dates use `Date`.
- [ ] Deletion behaviour is Restrict unless the row is an owned child or transient.
- [ ] History is append-only or status-versioned; no destructive update of a financial fact.
- [ ] Indexes match a documented query path.
- [ ] JSON is justified and not used for constrained values.
- [ ] Enum change is additive, or a destructive-migration plan exists.
- [ ] Validation, format, generate and migration notes are included.
- [ ] Entity catalog, diagrams and ownership table are updated.
