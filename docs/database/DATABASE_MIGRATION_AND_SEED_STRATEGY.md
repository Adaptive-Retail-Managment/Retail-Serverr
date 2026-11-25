# Database migration and seed strategy

**Status:** strategy defined; **no migration has been generated or applied, and no seed script
exists yet**. Step 3 produced the schema only. This document defines how the baseline is created,
how later changes are delivered, and what may and may not be seeded.

Related: [Prisma schema guide](PRISMA_SCHEMA_GUIDE.md),
[Inventory and financial integrity](INVENTORY_AND_FINANCIAL_DATA_INTEGRITY.md),
[Validation and testing](DATABASE_VALIDATION_AND_TESTING.md).

## 1. Current state

| Item                                                 | State                                                                       |
| ---------------------------------------------------- | --------------------------------------------------------------------------- |
| `apps/api/prisma/schema.prisma`                      | Present, formatted, validated, client generated                             |
| `apps/api/prisma/migrations/`                        | **Does not exist**                                                          |
| Prisma seed configuration in `apps/api/package.json` | **Not present**                                                             |
| Development PostgreSQL container                     | Defined in `infra/docker/compose.dev.yml`; not started as part of this step |
| Database schema created in PostgreSQL                | **No**                                                                      |
| Live integration test executed                       | **No**                                                                      |

The absence of migrations is deliberate. The first migration installs the whole shared schema and
the hand-written integrity SQL together, so the database never exists in a state that violates the
approved stock, tenancy or history rules.

## 2. Baseline migration

The baseline is created once, after the Step 3 schema review, from a clean development database.

```bash
# 1. Start PostgreSQL 17
pnpm db:up

# 2. Create the migration without applying it, so integrity SQL can be added
node apps/api/node_modules/prisma/build/index.js migrate dev \
  --schema apps/api/prisma/schema.prisma \
  --name init_shared_schema \
  --create-only

# 3. Append the companion SQL in Section 3 to the generated migration.sql

# 4. Apply and verify
node apps/api/node_modules/prisma/build/index.js migrate dev \
  --schema apps/api/prisma/schema.prisma
```

`migrate dev` creates a temporary shadow database to detect drift. The local `arp` role in the
development container can create databases. If a restricted role is used later, set
`SHADOW_DATABASE_URL` to a disposable database and add `shadowDatabaseUrl` to the datasource; that
change is a deployment decision, not part of Step 3.

Rules for the baseline:

- The migration directory is committed with `migration.sql` and `migration_lock.toml`.
- The generated SQL is reviewed before it is applied. Prisma output is a draft, not an authority.
- The companion SQL is appended in the same migration; a separate "fix" migration for constraints
  that should have existed from day one is not acceptable.
- `prisma db push` is forbidden outside a throwaway local database. It bypasses migration history
  and would create environments with different constraints.
- `prisma migrate reset` is forbidden on any database that contains data not created by that same
  test run. Resetting a shared or user database requires explicit authorization and is not a
  debugging shortcut.

### 2.1 Companion SQL in the baseline

These constraints cannot be expressed in Prisma schema. They are appended to the baseline
`migration.sql` after the generated DDL.

Stock and inventory:

```sql
ALTER TABLE "StockBalance"
  ADD CONSTRAINT "stock_balance_quantities_nonnegative"
  CHECK ("quantityOnHand" >= 0 AND "quantityReserved" >= 0 AND "quantityInTransit" >= 0);

ALTER TABLE "StockBalance"
  ADD CONSTRAINT "stock_balance_reserved_within_on_hand"
  CHECK ("quantityReserved" <= "quantityOnHand");

ALTER TABLE "InventoryBatch"
  ADD CONSTRAINT "inventory_batch_quantities_valid"
  CHECK ("quantityReceived" >= 0 AND "quantityRemaining" >= 0 AND "quantityRemaining" <= "quantityReceived");

ALTER TABLE "InventoryValuationSnapshot"
  ADD CONSTRAINT "inventory_valuation_nonnegative"
  CHECK ("quantity" >= 0 AND "unitCost" >= 0 AND "totalValue" >= 0);

ALTER TABLE "StockLossRecord"
  ADD CONSTRAINT "stock_loss_quantity_positive"
  CHECK ("quantity" > 0);

ALTER TABLE "StocktakeLine"
  ADD CONSTRAINT "stocktake_quantities_nonnegative"
  CHECK ("systemQuantity" >= 0 AND ("countedQuantity" IS NULL OR "countedQuantity" >= 0));

ALTER TABLE "StockTransferLine"
  ADD CONSTRAINT "stock_transfer_quantities_valid"
  CHECK (
    "requestedQuantity" > 0 AND
    "dispatchedQuantity" >= 0 AND
    "receivedQuantity" >= 0 AND
    "acceptedQuantity" >= 0 AND
    "rejectedQuantity" >= 0
  );
```

Sales, purchasing and money:

```sql
ALTER TABLE "Sale"
  ADD CONSTRAINT "sale_totals_nonnegative"
  CHECK (
    "subtotal" >= 0 AND "discountTotal" >= 0 AND "total" >= 0 AND
    "paidTotal" >= 0 AND "changeTotal" >= 0
  );

ALTER TABLE "SaleLine"
  ADD CONSTRAINT "sale_line_values_valid"
  CHECK ("quantity" > 0 AND "unitPrice" >= 0 AND "discountAmount" >= 0 AND "lineTotal" >= 0);

ALTER TABLE "SalePayment"
  ADD CONSTRAINT "sale_payment_amount_positive"
  CHECK ("amount" > 0);

ALTER TABLE "Refund"
  ADD CONSTRAINT "refund_amount_positive"
  CHECK ("amount" > 0);

ALTER TABLE "ProductPrice"
  ADD CONSTRAINT "product_price_nonnegative"
  CHECK ("amount" >= 0);

ALTER TABLE "PurchaseOrderLine"
  ADD CONSTRAINT "purchase_order_line_values_valid"
  CHECK ("orderedQuantity" > 0 AND "unitCost" >= 0 AND "lineTotal" >= 0);

ALTER TABLE "GoodsReceiptLine"
  ADD CONSTRAINT "goods_receipt_line_quantities_valid"
  CHECK (
    "receivedQuantity" >= 0 AND "acceptedQuantity" >= 0 AND
    "rejectedQuantity" >= 0 AND "damagedQuantity" >= 0 AND
    "acceptedQuantity" + "rejectedQuantity" + "damagedQuantity" <= "receivedQuantity"
  );

ALTER TABLE "ReturnLine"
  ADD CONSTRAINT "return_line_values_valid"
  CHECK (
    "quantityRequested" > 0 AND
    ("quantityApproved" IS NULL OR "quantityApproved" >= 0) AND
    "restockQuantity" >= 0 AND "unitPrice" >= 0
  );
```

Offline reconciliation limit:

```sql
ALTER TABLE "ReconciliationException"
  ADD CONSTRAINT "reconciliation_revalidation_once"
  CHECK ("revalidationCount" BETWEEN 0 AND 1);
```

One-owner and one-open-shift rules:

```sql
CREATE UNIQUE INDEX "membership_one_owner_per_business"
  ON "Membership" ("businessId")
  WHERE "isOwner" = true;

CREATE UNIQUE INDEX "cashier_shift_one_open_per_terminal"
  ON "CashierShift" ("businessId", "terminalId")
  WHERE "status" = 'OPEN';
```

System-role and global-unit uniqueness (PostgreSQL treats nulls as distinct, so the Prisma
`@@unique([businessId, code])` does not make global codes unique):

```sql
CREATE UNIQUE INDEX "role_system_code_unique"
  ON "Role" ("code")
  WHERE "businessId" IS NULL;

CREATE UNIQUE INDEX "unit_global_code_unique"
  ON "Unit" ("code")
  WHERE "businessId" IS NULL;
```

Nullable-uniqueness, line-uniqueness and branch-consistency companions added during the C-3
integrity resolution. Each rule states where it is enforced; none of these are runtime-verified
yet because no migration has been generated or applied.

```sql
-- StocktakeLine: one unbatched count per (session, variant). The Prisma
-- @@unique([sessionId, variantId, batchId]) covers batched rows only, because
-- PostgreSQL treats NULL batchId values as distinct.
CREATE UNIQUE INDEX "stocktake_line_unbatched_unique"
  ON "StocktakeLine" ("sessionId", "variantId")
  WHERE "batchId" IS NULL;

-- IdempotencyRecord: business-scoped keys are enforced by the Prisma
-- @@unique([businessId, scope, key]). Platform-scoped rows (businessId IS NULL)
-- need this partial index because NULL businessId values are distinct.
CREATE UNIQUE INDEX "idempotency_record_platform_unique"
  ON "IdempotencyRecord" ("scope", "key")
  WHERE "businessId" IS NULL;

-- ProductAttributeValue: exactly one owner (product XOR variant). The existing
-- @@unique pairs already prevent duplicate (owner, definition) values per owner.
ALTER TABLE "ProductAttributeValue"
  ADD CONSTRAINT "product_attribute_value_exactly_one_owner"
  CHECK (("productId" IS NOT NULL) <> ("variantId" IS NOT NULL));

-- GoodsReceiptLine: the Prisma @@unique([receiptId, purchaseOrderLineId,
-- batchNumber]) prevents duplicate batched lines; this partial index prevents a
-- second unbatched line for the same PO line in one receipt.
CREATE UNIQUE INDEX "goods_receipt_line_unbatched_unique"
  ON "GoodsReceiptLine" ("receiptId", "purchaseOrderLineId")
  WHERE "batchNumber" IS NULL;

-- StockTransfer: a transfer between identical branches is meaningless and would
-- create a self-referential stock movement.
ALTER TABLE "StockTransfer"
  ADD CONSTRAINT "stock_transfer_distinct_branches"
  CHECK ("fromBranchId" <> "toBranchId");

-- SupplierInvoiceLine: a PO-linked invoice line must carry both halves of the
-- PO link and the variant, so the composite foreign keys can verify it. Lines
-- without a PO link (free-text invoice lines) are unaffected.
ALTER TABLE "SupplierInvoiceLine"
  ADD CONSTRAINT "supplier_invoice_line_po_link_complete"
  CHECK (
    ("purchaseOrderId" IS NULL) = ("purchaseOrderLineId" IS NULL) AND
    ("purchaseOrderLineId" IS NULL OR "variantId" IS NOT NULL)
  );

-- MembershipBranchAssignment: only one ACTIVE assignment per (membership,
-- branch). Revoked rows are history and must not block reassignment. This
-- replaces the removed Prisma @@unique([membershipId, branchId]).
CREATE UNIQUE INDEX "membership_branch_assignment_active_unique"
  ON "MembershipBranchAssignment" ("membershipId", "branchId")
  WHERE "revokedAt" IS NULL;
```

Notes:

- The `GoodsReceiptLine` check uses `<=` rather than `=`. Inspection may record a quantity that is
  received but not yet classified; the service must still refuse to accept more than was received.
- Cross-table rules (refund not exceeding paid amount, accepted receiving not exceeding ordered
  quantity, reservation not exceeding available stock) cannot be expressed as a `CHECK`. They are
  transaction-level service rules, specified in
  [`INVENTORY_AND_FINANCIAL_DATA_INTEGRITY.md`](INVENTORY_AND_FINANCIAL_DATA_INTEGRITY.md).
- `StockMovement` is append-only by policy. Enforcing it with a trigger or by revoking `UPDATE` and
  `DELETE` from the application role is deferred until the runtime database roles exist. Until
  then, code review and integration tests protect it; this limitation is repeated in the
  completion report.
- `ProductPrice` effective ranges can overlap. A future `EXCLUDE USING gist` constraint (requiring
  `btree_gist`) is documented as an option, not installed now; the pricing service must reject
  overlaps.
- `SupplierInvoiceLine` database enforcement covers PO-linked lines: the composite foreign key to
  `PurchaseOrderLine(businessId, purchaseOrderId, id, variantId)` binds business, PO and variant,
  and `SupplierInvoicePoBinding` binds the line's `purchaseOrderId` to the invoice header's PO.
  Two rules remain application-enforced inside the invoice transaction: (a) when the invoice
  header has a `purchaseOrderId`, every line must carry that same `purchaseOrderId` (a line with
  `purchaseOrderId IS NULL` bypasses the binding foreign key); (b) invoiced quantities per PO
  line must not exceed ordered quantities. Both require `SELECT ... FOR UPDATE` on the PO lines
  and are specified in `DATABASE_VALIDATION_AND_TESTING.md`.
- `GoodsReceipt.branchId = PurchaseOrder.branchId` (approved U-1, same-branch-only) is fully
  Prisma-enforced through `GoodsReceipt.purchaseOrder` →
  `PurchaseOrder(businessId, id, branchId)`; no companion SQL is needed. A side effect is
  deliberate: because receipts reference the PO's `(businessId, id, branchId)` key, PostgreSQL
  the relation declares `onUpdate: NoAction`, so PostgreSQL rejects any
  `PurchaseOrder.branchId` update while receipts exist and never cascades or rewrites
  `GoodsReceipt.branchId` — destination changes are only possible before the first receipt and
  must go through `PurchaseOrderRevision` + `PurchaseOrderApproval`.
- `Membership.scopedRole` / `Invitation.scopedRole` cannot be bound to `membership.businessId` at
  database level without breaking global system roles (`Role.businessId IS NULL`). The service
  must set `roleBusinessId` equal to the membership/invitation `businessId` for business-scoped
  roles, or leave the scoped relation empty for global roles; authorization must never trust a
  `roleId` whose `Role.businessId` differs from the tenant.

### 2.2 Verification after applying the baseline

Run against the development database, not merely against the schema file:

```sql
-- constraints exist
SELECT conname FROM pg_constraint
WHERE conrelid IN ('"StockBalance"'::regclass, '"Sale"'::regclass)
  AND contype = 'c'
ORDER BY conname;

-- partial indexes exist
SELECT indexname, indexdef FROM pg_indexes
WHERE indexname IN (
  'membership_one_owner_per_business',
  'cashier_shift_one_open_per_terminal',
  'role_system_code_unique',
  'unit_global_code_unique',
  'stocktake_line_unbatched_unique',
  'idempotency_record_platform_unique',
  'goods_receipt_line_unbatched_unique',
  'membership_branch_assignment_active_unique'
);

-- negative stock is rejected
INSERT INTO "StockBalance" (...) VALUES (...); -- expected to fail for a negative quantity
```

The insert test requires a valid business, branch and variant fixture. It belongs to the
integration suite described in
[`DATABASE_VALIDATION_AND_TESTING.md`](DATABASE_VALIDATION_AND_TESTING.md), not to a manual
production check.

## 3. Migration lifecycle by environment

| Environment       | Command          | Rules                                                                         |
| ----------------- | ---------------- | ----------------------------------------------------------------------------- |
| Local development | `migrate dev`    | Creates migrations and a shadow database; one developer database per member   |
| CI                | `migrate deploy` | Ephemeral PostgreSQL 17 service; migrations only, no shadow, no reset         |
| Staging           | `migrate deploy` | Runs the exact migration set that will go to production; backup before deploy |
| Production        | `migrate deploy` | Maintenance window, verified backup/PITR, migration reviewed and announced    |

`migrate deploy` only applies committed migrations; it never generates or edits files. CI must fail
if the committed migrations and the schema disagree:

```bash
node apps/api/node_modules/prisma/build/index.js migrate diff \
  --from-migrations apps/api/prisma/migrations \
  --to-schema-datamodel apps/api/prisma/schema.prisma \
  --shadow-database-url "$SHADOW_DATABASE_URL" \
  --exit-code
```

A non-zero exit means someone changed `schema.prisma` without a migration, or edited a migration
after it was applied. Both are release blockers.

### 3.1 Connection pooling and migrations

Prisma's `DATABASE_URL` is currently the only datasource URL. If production puts PgBouncer or a
provider pooler in front of PostgreSQL:

- Runtime queries use the pooled URL.
- Migrations use a **direct** connection, because advisory locks, DDL and the migration history
  table do not behave correctly through transaction-mode pooling.
- The datasource gains `directUrl = env("DIRECT_URL")` in a reviewed change; migrations run with
  `DIRECT_URL` set, runtime keeps `DATABASE_URL` pooled.
- Pooling mode must be transaction mode; session-level state is not used (this also keeps a future
  RLS decision possible).

This is a deployment design, not a Step 3 change.

### 3.2 Migration authoring rules

1. **One logical change per migration**, with a descriptive name: `add_stock_reservation_expiry`,
   not `updates`.
2. **Forward-only.** Prisma does not generate down migrations. Recovery is a new forward migration,
   a restore, or point-in-time recovery.
3. **No destructive change without an approved plan.** Dropping a column or table, narrowing a
   type, renaming an enum value, or rewriting history requires a written expand/contract plan and
   the owning member's review.
4. **Expand, then contract.** Add the new column/table, backfill in batches, switch reads and
   writes, keep both for a compatibility window, then remove the old structure in a later release.
5. **No long locks on hot tables.** Adding a non-null column with a default, validating a large
   `CHECK`, or building an index on `StockMovement`, `Sale` or `AuditEvent` needs an operational
   plan. Prefer `CREATE INDEX CONCURRENTLY` in a separate, non-transactional step and add the
   constraint as `NOT VALID` followed by `VALIDATE CONSTRAINT`.
6. **Backfills are separate, idempotent and batched.** A migration that rewrites millions of rows
   is not a deploy-time migration.
7. **Enum changes are additive.** `ALTER TYPE ... ADD VALUE` is the only routine enum migration.
   Renaming or deleting a value is destructive.
8. **Never edit an applied migration.** Fix forward. If a migration is broken before it reaches a
   shared environment, correct it locally and regenerate; once it is in `main` or applied in
   staging, it is immutable.
9. **Migrations are announced before merge.** See Section 5.

### 3.3 Rollback and recovery

- Application rollback does not roll back a database migration. A release that includes a
  destructive migration must be paired with a tested restore procedure.
- Staging and production take a backup or verify PITR before `migrate deploy`.
- If a migration fails halfway, do not reset. Inspect `_prisma_migrations`, determine which
  statements committed, and write a corrective migration from the observed state.
- A failed `migrate dev` on a disposable local database may be reset; a failed migration on any
  shared database may not.

## 4. Seed strategy

Seeding has two distinct purposes and they must never be mixed:

| Seed class              | Purpose                                                                                                        | Allowed environments           |
| ----------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------ |
| Platform reference seed | Permissions, system role templates, global units, plans and prices, forecast model registry, platform settings | Local, CI, staging, production |
| Demonstration seed      | Sample businesses, branches, products, suppliers, sales                                                        | Local and ephemeral CI only    |

A production seed must be idempotent, deterministic and free of business data. A demo seed must
never run against a database that contains real tenant data.

### 4.1 What is seeded

1. **Permission catalogue** (`Permission`): every permission code, module, human description and
   `isPhysical` flag. This is the security vocabulary; a missing code is a broken deployment.
2. **System role templates** (`Role` with `businessId = null`) and their `RolePermission` grants:
   Owner, Business Admin, Manager, Cashier. Physical permissions are granted only to Owner and
   Manager; Business Admin receives digital permissions only. A business-level role is cloned from
   the template when the business is created, not when the platform is seeded.
3. **Global units** (`Unit` with `businessId = null`) and their conversions, for grocery and
   pharmacy measures that every business needs.
4. **Plans, features and prices** (`Plan`, `PlanFeature`, `PlanPrice`): code, name, feature keys,
   monthly/yearly prices in ETB, trial eligibility. Commercial values are configuration; they are
   seeded as initial defaults and changed through approved operations, never hard-coded in code.
5. **Forecast model registry** (`ForecastModel`): model name, version, advisory flag. No model
   implementation and no forecast data are seeded.
6. **Platform settings** (`PlatformSetting`): non-secret operational defaults with a documented key
   namespace. Secrets are never seeded.
7. **Notification defaults**: templates are tenant data (`NotificationTemplate.businessId` is
   required). They are provisioned per business at creation or by an approved onboarding process,
   not inserted by the platform seed.

Tax rules, clinical data, AI output, demo sales, supplier invoices and subscription payments are
never seeded into production.

### 4.2 Seed implementation shape (proposed)

No seed script exists today. When it is implemented, it should follow this shape:

```text
apps/api/prisma/
  seed.ts                     # orchestrator, one transaction, explicit order
  seeds/
    permissions.ts
    system-roles.ts
    units.ts
    plans.ts
    forecast-models.ts
    platform-settings.ts
    demo/                     # guarded by SEED_DEMO and NODE_ENV !== production
      businesses.ts
      catalog.ts
      operations.ts
```

Requirements for the implementation:

- **Idempotent by natural key.** Use `upsert` on `Permission.code`, `Plan.code`,
  `ForecastModel(name, version)`, `Unit(businessId, code)` and `Role(businessId, code)`. For rows
  with `businessId = null`, the partial unique indexes from Section 2.1 make the upsert
  deterministic; use a raw `INSERT ... ON CONFLICT` or a find-then-create helper because Prisma's
  compound `where` does not match null fields reliably.
- **One transaction.** A failed seed leaves no half-configured permission catalogue.
- **No random business data in the reference seed.** IDs may be generated by UUID v7, but the
  natural key determines identity across re-runs.
- **No secrets.** Development passwords come from environment variables and are never committed.
- **Explicit guard for demo data.** Refuse to run when `NODE_ENV=production`, regardless of
  `SEED_DEMO`.
- **Report a diff.** Log created, updated and unchanged counts per entity, so drift is visible.

Prisma needs a seed command configured in `apps/api/package.json` (`"prisma": { "seed": ... }`).
That configuration and a TypeScript runner (for example `tsx`) are **not installed**. Adding a
runner is a dependency decision for Step 4, not a Step 3 change. Until then, `prisma db seed`
will fail by design; do not claim it works.

### 4.3 Seed order

```text
permissions
  → system roles + role permissions
  → global units + conversions
  → plans + plan features + plan prices
  → forecast models
  → platform settings
  → (demo only) business → branch → membership → configuration → catalog → inventory fixtures
```

The order follows foreign keys. Role permissions require permissions; business roles require the
system templates; catalog fixtures require units and configuration.

### 4.4 Re-seeding and drift

- Re-running the reference seed must change nothing on a configured platform.
- A removed permission is **not** deleted automatically: existing role grants may reference it.
  Removal requires a migration and a review of every role.
- A price change is a new `PlanPrice` row or a status transition, not an in-place overwrite of a
  historical price. The seed inserts the initial price only when the plan has none.
- Seed changes that alter authorization are reviewed by Member 1 and by the affected module owners.

## 5. Coordination across the four members

One migration history means one shared release train. The rules:

1. **Announce before authoring.** Post the intended tables, columns and constraints in the team
   channel so another member does not create a conflicting migration.
2. **One migration owner per pull request.** A PR may contain several migrations only when they
   are one logical change; unrelated schema changes are separate PRs.
3. **Rebase and regenerate.** Rebase on `main` before requesting review. If the schema changed,
   regenerate the migration; never hand-merge two migration folders with the same timestamp.
4. **Review by affected owners.** The owning member approves the change to their tables; any member
   whose module reads the changed table reviews the contract impact. Hotspots (`Business`,
   `Branch`, `Membership`, `ProductVariant`, `StockBalance`, `StockMovement`, `Sale`) require all
   affected owners.
5. **CI drift check is mandatory.** A red migration-diff job blocks merge.
6. **No personal database is authoritative.** Local experiments use `db push` only on a disposable
   database; anything that matters becomes a reviewed migration.
7. **Documentation travels with the migration.** Entity catalog, ER diagram, ownership table,
   integrity doc and test specification are updated in the same PR.

## 6. Prohibited operations

- `prisma migrate reset` on a shared, staging or production database.
- `prisma db push` against any shared database.
- Editing or deleting an applied migration.
- Dropping a table or column that holds financial, stock or audit history without an approved
  archival and restore plan.
- Seeding demo sales, invoices or customers into production.
- Storing credentials or provider secrets in seed files or migration SQL.
- Running an untested migration directly in production because "it is only an index".

## 7. Readiness checklist for the first migration

- [ ] Schema review completed by all four owners.
- [ ] Baseline generated with `--create-only` and reviewed.
- [ ] Companion SQL from Section 2.1 appended.
- [ ] Partial unique indexes for owner, open shift, system role and global unit present.
- [ ] `migrate deploy` tested on an empty PostgreSQL 17 database.
- [ ] `migrate diff` returns no difference between migrations and schema.
- [ ] Integration suite from the validation document runs against the migrated database.
- [ ] Seed script and `prisma db seed` configuration implemented and tested (Step 4).
- [ ] Backup/PITR procedure confirmed for staging and production.
- [ ] Migration announced to all four members.
