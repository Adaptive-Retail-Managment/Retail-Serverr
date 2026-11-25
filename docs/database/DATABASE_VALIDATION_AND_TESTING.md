# Database validation and testing

**Status:** validation strategy and test specifications. Static schema checks were executed in
Step 3. **No database was created, no migration was applied, and no integration test was executed.**
This document separates what was actually verified from what is specified for the first migration.

Related: [Migration and seed strategy](DATABASE_MIGRATION_AND_SEED_STRATEGY.md),
[Inventory and financial integrity](INVENTORY_AND_FINANCIAL_DATA_INTEGRITY.md),
[Offline and reconciliation model](OFFLINE_AND_RECONCILIATION_DATA_MODEL.md),
[Testing architecture](../testing/TESTING_ARCHITECTURE.md).

## 1. Validation layers

| Layer                     | Question answered                                                             | Runs where                  | Step 3 status                              |
| ------------------------- | ----------------------------------------------------------------------------- | --------------------------- | ------------------------------------------ |
| L1 — Schema static        | Is the Prisma schema syntactically and relationally valid?                    | Local/CI, no database       | **Executed**                               |
| L2 — Schema conventions   | Does it follow the agreed naming, tenancy, money and deletion rules?          | Local/CI script             | **Executed** (audit script, results in §2) |
| L3 — Migration            | Does the schema plus companion SQL apply to PostgreSQL 17?                    | Ephemeral PostgreSQL        | **Not executed**                           |
| L4 — Database constraints | Do CHECKs, partial indexes and unique rules reject invalid data?              | Ephemeral PostgreSQL        | **Not executed**                           |
| L5 — Integration          | Do tenant isolation, stock, history and idempotency hold across repositories? | Test database               | **Not executed**                           |
| L6 — Performance smoke    | Do the planned query paths use the intended indexes?                          | Test database with fixtures | **Not executed**                           |
| L7 — Documentation        | Do diagrams render, links resolve and formatting pass?                        | Local/CI                    | **Executed before the completion report**  |

A passing L1/L2 result is **not** evidence that the database enforces anything. Until L3 and L4
run, the CHECK constraints and partial indexes exist only in this documentation and in the planned
migration SQL.

## 2. Static checks executed in Step 3

| Check                      | Method                                                   | Result                                                                           |
| -------------------------- | -------------------------------------------------------- | -------------------------------------------------------------------------------- |
| Prisma validation          | `prisma validate --schema apps/api/prisma/schema.prisma` | Passed: "The schema ... is valid"                                                |
| Prisma formatting          | `prisma format --schema apps/api/prisma/schema.prisma`   | Passed: "Formatted ... in 354ms"                                                 |
| Prisma client generation   | `prisma generate --schema apps/api/prisma/schema.prisma` | Passed: Prisma Client v6.19.3 generated                                          |
| Model count                | Parse `^model` declarations                              | 159                                                                              |
| Enum count                 | Parse `^enum` declarations                               | 94                                                                               |
| Tenant columns             | Count models with `businessId` / `branchId`              | 141 / 52                                                                         |
| Composite tenant key       | Count models with `@@unique([businessId, id])`           | 138                                                                              |
| Unique / index inventory   | Count `@@unique` / `@@index`                             | 274 / 187                                                                        |
| Money and quantity types   | Search `@db.Decimal` and `Float`/`Double`                | 59 money, 59 quantity, 15 cost; **0 floats**                                     |
| Delete behaviour           | Count `onDelete` modes                                   | 302 Restrict, 57 Cascade, 8 SetNull                                              |
| JSON usage                 | Count `Json` columns and review each                     | 27, each justified in the schema guide                                           |
| Tenant relation audit      | Script: tenant parent referenced without `businessId`    | 19 remaining; all are nullable-owner exceptions documented in the tenancy design |
| Business reverse relations | Prisma validation                                        | No missing opposite relation                                                     |

The audit scripts were temporary and were deleted after use. Their rules are restated below so a
future CI script can reproduce them:

1. Every model has an `id` primary key, except `RolePermission` which has the documented composite
   primary key.
2. Every `id` is `String @id @default(uuid(7)) @db.Uuid`.
3. Every model with `businessId` has a business relation.
4. Every model with `businessId` that can be a parent has `@@unique([businessId, id])`.
5. No `Float` or `Double` exists anywhere in the schema.
6. Every `Decimal` money column uses `(18, 2)` and every money-bearing table carries `currency`.
7. Every relation to a tenant-scoped parent either includes `businessId` in `fields` or is in the
   documented exception list.
8. `onDelete: SetNull` never appears on a composite relation with a required `businessId`.

## 3. Migration and constraint tests (L3/L4)

These tests run after the baseline migration exists. They use the committed migration, not
`db push`.

### 3.1 Migration application

| ID     | GIVEN                            | WHEN                                                                       | THEN                                                                           |
| ------ | -------------------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| MIG-01 | Empty PostgreSQL 17 database     | `migrate deploy` runs all migrations                                       | Exit code 0; `_prisma_migrations` has one applied baseline                     |
| MIG-02 | Migrated database                | `migrate diff --from-migrations ... --to-schema-datamodel ... --exit-code` | Exit code 0, no drift                                                          |
| MIG-03 | Migrated database                | Inspect `pg_constraint`                                                    | All CHECK constraints from the migration strategy exist                        |
| MIG-04 | Migrated database                | Inspect `pg_indexes`                                                       | All eight partial unique indexes in §3.1a exist with the documented predicates |
| MIG-05 | Migrated database                | Re-run `migrate deploy`                                                    | No-op, exit code 0                                                             |
| MIG-06 | Database with one tenant fixture | Apply the next additive migration                                          | Existing rows unchanged; no table rewrite that loses data                      |

### 3.1a Partial unique index inventory

Eight partial unique indexes are specified in the companion SQL of
[`DATABASE_MIGRATION_AND_SEED_STRATEGY.md`](DATABASE_MIGRATION_AND_SEED_STRATEGY.md) §2.1. None
exists in PostgreSQL yet — the baseline migration has not been generated or applied. Prisma
cannot express partial indexes, so **all eight require companion SQL**; none is represented in
`schema.prisma`.

| Index name                                   | Table                        | Columns                            | Predicate               | Reason it must be partial                                                                                                     |
| -------------------------------------------- | ---------------------------- | ---------------------------------- | ----------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `membership_one_owner_per_business`          | `Membership`                 | `(businessId)`                     | `"isOwner" = true`      | Only one Owner per business; non-owner rows are unrestricted                                                                  |
| `cashier_shift_one_open_per_terminal`        | `CashierShift`               | `(businessId, terminalId)`         | `"status" = 'OPEN'`     | One open shift per terminal; closed shifts accumulate as history                                                              |
| `role_system_code_unique`                    | `Role`                       | `(code)`                           | `"businessId" IS NULL`  | `@@unique([businessId, code])` cannot dedupe global codes because NULLs are distinct                                          |
| `unit_global_code_unique`                    | `Unit`                       | `(code)`                           | `"businessId" IS NULL`  | Same NULL-distinct problem for platform units                                                                                 |
| `stocktake_line_unbatched_unique`            | `StocktakeLine`              | `(sessionId, variantId)`           | `"batchId" IS NULL`     | `@@unique([sessionId, variantId, batchId])` ignores NULL batch rows (F-003)                                                   |
| `idempotency_record_platform_unique`         | `IdempotencyRecord`          | `(scope, key)`                     | `"businessId" IS NULL`  | Platform-scoped keys need uniqueness; `@@unique([businessId, scope, key])` skips NULLs (F-003)                                |
| `goods_receipt_line_unbatched_unique`        | `GoodsReceiptLine`           | `(receiptId, purchaseOrderLineId)` | `"batchNumber" IS NULL` | Batched duplicates are covered by `@@unique([receiptId, purchaseOrderLineId, batchNumber])`; unbatched rows need this (F-005) |
| `membership_branch_assignment_active_unique` | `MembershipBranchAssignment` | `(membershipId, branchId)`         | `"revokedAt" IS NULL`   | Replaces the removed unconditional unique: revoked rows are history, only one active assignment allowed (F-010)               |

### 3.2 Constraint rejection matrix

Every row is an `INSERT` or `UPDATE` that must fail. The test asserts the PostgreSQL error is a
constraint violation, not an application error.

| ID     | Invalid operation                                                                         | Expected rejection                                                                                                                                                                          |
| ------ | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CON-01 | `StockBalance.quantityOnHand = -1`                                                        | `stock_balance_quantities_nonnegative`                                                                                                                                                      |
| CON-02 | `StockBalance.quantityReserved > quantityOnHand`                                          | `stock_balance_reserved_within_on_hand`                                                                                                                                                     |
| CON-03 | `StockBalance.quantityInTransit = -0.001`                                                 | `stock_balance_quantities_nonnegative`                                                                                                                                                      |
| CON-04 | `InventoryBatch.quantityRemaining > quantityReceived`                                     | `inventory_batch_quantities_valid`                                                                                                                                                          |
| CON-05 | `InventoryValuationSnapshot.totalValue = -1`                                              | `inventory_valuation_nonnegative`                                                                                                                                                           |
| CON-06 | `StockLossRecord.quantity = 0`                                                            | `stock_loss_quantity_positive`                                                                                                                                                              |
| CON-07 | `StockTransferLine.requestedQuantity = 0`                                                 | `stock_transfer_quantities_valid`                                                                                                                                                           |
| CON-08 | `Sale.total = -0.01`                                                                      | `sale_totals_nonnegative`                                                                                                                                                                   |
| CON-09 | `SaleLine.quantity = 0`                                                                   | `sale_line_values_valid`                                                                                                                                                                    |
| CON-10 | `SalePayment.amount = 0`                                                                  | `sale_payment_amount_positive`                                                                                                                                                              |
| CON-11 | `Refund.amount = -1`                                                                      | `refund_amount_positive`                                                                                                                                                                    |
| CON-12 | `GoodsReceiptLine` accepted + rejected + damaged > received                               | `goods_receipt_line_quantities_valid`                                                                                                                                                       |
| CON-13 | `PurchaseOrderLine.orderedQuantity = 0`                                                   | `purchase_order_line_values_valid`                                                                                                                                                          |
| CON-14 | `ReturnLine.quantityRequested = 0`                                                        | `return_line_values_valid`                                                                                                                                                                  |
| CON-15 | Second `Membership` with `isOwner = true` in one business                                 | `membership_one_owner_per_business`                                                                                                                                                         |
| CON-16 | Second `CashierShift` with `status = 'OPEN'` on one terminal                              | `cashier_shift_one_open_per_terminal`                                                                                                                                                       |
| CON-17 | Second system `Role` with the same `code` and `businessId = null`                         | `role_system_code_unique`                                                                                                                                                                   |
| CON-18 | Second global `Unit` with the same `code` and `businessId = null`                         | `unit_global_code_unique`                                                                                                                                                                   |
| CON-19 | Duplicate `StockMovement (businessId, sourceKey)`                                         | Prisma unique constraint                                                                                                                                                                    |
| CON-20 | Duplicate `Sale (offlineDeviceId, operationId)`                                           | Prisma unique constraint                                                                                                                                                                    |
| CON-21 | Duplicate `SyncOperation (deviceId, operationId)`                                         | Prisma unique constraint                                                                                                                                                                    |
| CON-22 | Duplicate `PaymentWebhookEvent (provider, providerEventId)`                               | Prisma unique constraint                                                                                                                                                                    |
| CON-23 | Duplicate `Refund (businessId, idempotencyKey)`                                           | Prisma unique constraint                                                                                                                                                                    |
| CON-24 | Two rows for one `(branchId, variantId)` in `StockBalance`                                | Prisma unique constraint                                                                                                                                                                    |
| CON-25 | Second unbatched `StocktakeLine` for one `(sessionId, variantId)`                         | `stocktake_line_unbatched_unique`                                                                                                                                                           |
| CON-26 | `ProductAttributeValue` with neither `productId` nor `variantId`                          | `product_attribute_value_exactly_one_owner`                                                                                                                                                 |
| CON-27 | `ProductAttributeValue` with both `productId` and `variantId`                             | `product_attribute_value_exactly_one_owner`                                                                                                                                                 |
| CON-28 | Second platform `IdempotencyRecord` with same `(scope, key)`                              | `idempotency_record_platform_unique`                                                                                                                                                        |
| CON-29 | Second unbatched `GoodsReceiptLine` for one `(receiptId, purchaseOrderLineId)`            | `goods_receipt_line_unbatched_unique`                                                                                                                                                       |
| CON-30 | `StockTransfer` with `fromBranchId = toBranchId`                                          | `stock_transfer_distinct_branches`                                                                                                                                                          |
| CON-31 | `SupplierInvoiceLine` with `purchaseOrderId` set but `purchaseOrderLineId` null           | `supplier_invoice_line_po_link_complete`                                                                                                                                                    |
| CON-32 | PO-linked `SupplierInvoiceLine` with `variantId` null                                     | `supplier_invoice_line_po_link_complete`                                                                                                                                                    |
| CON-33 | Second `SupplierInvoiceLine` for one `(supplierInvoiceId, purchaseOrderLineId)`           | Prisma unique constraint                                                                                                                                                                    |
| CON-34 | Second active `MembershipBranchAssignment` for one `(membershipId, branchId)`             | `membership_branch_assignment_active_unique`                                                                                                                                                |
| CON-35 | `Sale` referencing a `CashierShift` of another branch in same business                    | FK violation on `(businessId, branchId, shiftId)`                                                                                                                                           |
| CON-36 | `Sale` referencing a `PosTerminal` of another branch in same business                     | FK violation on `(businessId, branchId, terminalId)`                                                                                                                                        |
| CON-37 | `CashierShift` on a `PosTerminal` of another branch in same business                      | FK violation on `(businessId, branchId, terminalId)`                                                                                                                                        |
| CON-38 | `SupplierInvoiceLine` PO link to a `PurchaseOrderLine` of a different variant             | FK violation on composite `(businessId, purchaseOrderId, id, variantId)`                                                                                                                    |
| CON-39 | `SupplierInvoiceLine` PO binding to an invoice whose header `purchaseOrderId` differs     | FK violation on `SupplierInvoicePoBinding`                                                                                                                                                  |
| CON-40 | `GoodsReceipt` whose `branchId` differs from its `PurchaseOrder.branchId` (same business) | FK violation on `(businessId, purchaseOrderId, branchId)` → `PurchaseOrder(businessId, id, branchId)`                                                                                       |
| CON-41 | `GoodsReceipt` in business A against a PO of business B                                   | FK violation (tenant isolation preserved)                                                                                                                                                   |
| CON-42 | `UPDATE PurchaseOrder.branchId` after a `GoodsReceipt` exists for that PO                 | FK violation (`onUpdate: NoAction`) — the update is rejected and every existing `GoodsReceipt.branchId` remains unchanged (verified by re-reading the receipt rows after the failed update) |

### 3.3 Cross-tenant relationship matrix

Fixtures create two complete tenants, A and B, with business, branch, membership, product,
variant, supplier and sale. Each test attempts a relationship that mixes them and expects a
foreign-key violation.

| ID     | Cross-tenant attempt                                                                                                                                        | Expected result                                                                                 |
| ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| TEN-01 | Sale in A with a branch of B                                                                                                                                | FK violation on `(businessId, branchId)`                                                        |
| TEN-02 | Sale line in A with a variant of B                                                                                                                          | FK violation on `(businessId, variantId)`                                                       |
| TEN-03 | Stock balance in A for a branch of B                                                                                                                        | FK violation                                                                                    |
| TEN-04 | Stock movement in A for a variant of B                                                                                                                      | FK violation                                                                                    |
| TEN-05 | Purchase order in A for a supplier of B                                                                                                                     | FK violation on `(businessId, supplierId)`                                                      |
| TEN-06 | Goods receipt in A against a PO of B                                                                                                                        | FK violation                                                                                    |
| TEN-07 | Product variant in A attached to a product of B                                                                                                             | FK violation                                                                                    |
| TEN-08 | Product in A linked to a brand or category of B                                                                                                             | FK violation (composite relation)                                                               |
| TEN-09 | Product price in A in a price list of B                                                                                                                     | FK violation (composite relation)                                                               |
| TEN-10 | Payment allocation from a supplier payment in A to an invoice of B                                                                                          | FK violation                                                                                    |
| TEN-11 | Batch allocation in A against a movement of B                                                                                                               | FK violation                                                                                    |
| TEN-12 | Transfer receipt line in A against a transfer line of B                                                                                                     | FK violation                                                                                    |
| TEN-13 | Reconciliation exception in A against a sync operation of B                                                                                                 | FK violation                                                                                    |
| TEN-14 | Reconciliation exception in A assigned to a membership of B                                                                                                 | FK violation                                                                                    |
| TEN-15 | Subscription invoice in A for a subscription of B                                                                                                           | FK violation                                                                                    |
| TEN-16 | Membership role pointing at another business's custom role                                                                                                  | **Not enforced by FK**; authorization service must reject. Test at service layer                |
| TEN-17 | Product in A linked to a unit owned by B                                                                                                                    | **Not enforced by FK** (unit tenant nullable); unit resolver must reject. Test at service layer |
| TEN-18 | File link in A to a file owned by B                                                                                                                         | **Not enforced by FK** (file tenant nullable); file service must reject. Test at service layer  |
| TEN-19 | Webhook event resolved to an attempt of another tenant                                                                                                      | **Not enforced by FK**; webhook handler must verify attempt scope                               |
| TEN-20 | Tenant-derived child read by child ID across tenants (`EmploymentStatusHistory`, `SyncAttempt`, `SyncCursor`, `ForecastPoint`)                              | **Not enforced by FK**; parent-join scope check must reject. Test at service layer              |
| TEN-21 | Platform/null-`businessId` exception row (`AuditEvent`, `IdempotencyRecord`, `SupportCase`, `OutboxEvent`, `FileUploadSession`) read through a tenant scope | Must return no rows or a forbidden result; platform rows are never tenant-visible               |

TEN-16 to TEN-19 are the documented residual exceptions. They must fail with a not-found or
forbidden result, never by returning the other tenant's row.

### 3.4 Positive constraint tests

Constraints must not reject valid data. Each rejection matrix has a paired valid case: a zero
quantity balance, an accepted receipt exactly equal to received, two owners in two different
businesses, two open shifts on different terminals, two roles with the same code in two different
businesses, and a global unit and a tenant unit with the same code. The C-3 additions also require
positive cases: two `StocktakeLine` rows for the same variant with different non-null `batchId`
values; a `ProductAttributeValue` owned by a product and another owned by a variant for the same
attribute definition; the same idempotency `key` in two different businesses and a different `key`
in the platform scope; two `GoodsReceiptLine` rows for one PO line with different `batchNumber`
values; a revoked-then-recreated `MembershipBranchAssignment` for the same pair; a `Sale` whose
`shiftId`/`terminalId` belong to the same branch; and a `SupplierInvoiceLine` whose PO link matches
the invoice header's purchase order, supplier and variant.

### 3.5 Goods-receipt branch consistency (approved U-1 rule)

Rule: a PO-backed `GoodsReceipt` must use `PurchaseOrder.branchId` — the PO's current authorized
destination. Partial and multiple receipts all use that branch. A destination change requires a
`PurchaseOrderRevision` (previous and new branch in the snapshot, `reason`, `createdByUserId`)
plus the existing `PurchaseOrderApproval` workflow, and must complete **before** the first
receipt; the composite FK makes a post-receipt destination change impossible.

CON-40 to CON-42 cover the database-level rejections. The service-layer contract (application
integration tests, not yet implemented) requires:

| ID        | Scenario                                                                                       | Expected result                                                                                               | Layer           |
| --------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | --------------- |
| U1-APP-01 | Receipt created with `branchId = PO.branchId`                                                  | Accept                                                                                                        | App integration |
| U1-APP-02 | Receipt created with `branchId ≠ PO.branchId` (same business)                                  | Reject with branch-mismatch validation error; receipt branch is never silently rewritten                      | App integration |
| U1-APP-03 | Partial receipt at PO destination branch                                                       | Accept                                                                                                        | App integration |
| U1-APP-04 | Second partial receipt at the same PO destination branch                                       | Accept                                                                                                        | App integration |
| U1-APP-05 | Second partial receipt at a different branch                                                   | Reject                                                                                                        | App integration |
| U1-APP-06 | Receipt against a PO of another business                                                       | Reject (tenant scope)                                                                                         | App integration |
| U1-APP-07 | Unauthorized user (e.g. Business Admin without approval rights) attempts PO destination change | Reject — approval requires existing Owner/Manager boundaries                                                  | App integration |
| U1-APP-08 | Authorized destination revision before any receipt                                             | Accept only via revision + approval records                                                                   | App integration |
| U1-APP-09 | Receipt created after an authorized destination revision                                       | Accept when `branchId` equals the revised destination                                                         | App integration |
| U1-APP-10 | Attempt to rewrite history: change PO destination after receipts exist                         | Reject at DB level (CON-42) and at service level                                                              | App + DB        |
| U1-APP-11 | Concurrent destination revision and receipt creation                                           | Transaction locking (`SELECT ... FOR UPDATE` on the PO) must serialize them; no mismatched receipt may commit | App integration |
| U1-APP-12 | Receipt eligibility: PO status not receivable (e.g. DRAFT/CANCELLED)                           | Reject                                                                                                        | App integration |

## 4. Stock and financial integration tests (L5)

The detailed scenarios are owned by
[`INVENTORY_AND_FINANCIAL_DATA_INTEGRITY.md`](INVENTORY_AND_FINANCIAL_DATA_INTEGRITY.md) §8. The
execution matrix is:

| ID     | Scenario                                      | Key assertion                                                                                      |
| ------ | --------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| STK-01 | Sale of available stock                       | On-hand decreases by quantity; movement recorded; available never negative                         |
| STK-02 | Sale with insufficient stock                  | Whole transaction rolls back; no sale, no movement, balance unchanged                              |
| STK-03 | Concurrent sales for the last unit            | Exactly one succeeds; no negative balance; loser gets a deterministic conflict                     |
| STK-04 | Purchase order approved or supplier confirmed | Stock unchanged                                                                                    |
| STK-05 | Goods receipt accepted                        | Stock increases by accepted quantity only; rejected/damaged do not                                 |
| STK-06 | Partial receiving                             | Balance equals cumulative accepted quantity; PO status reflects partial                            |
| STK-07 | Transfer dispatch                             | Source on-hand decreases; in-transit increases; destination available does not change              |
| STK-08 | Transfer receive                              | In-transit decreases; destination on-hand and available increase by accepted quantity              |
| STK-09 | Stocktake variance approval                   | Adjustment movement matches variance; balance equals counted quantity                              |
| STK-10 | Damage/wastage                                | Negative movement with reason; balance reduced; no sale impact                                     |
| STK-11 | FIFO batch consumption                        | Oldest eligible batch consumed first; allocations sum to movement quantity                         |
| STK-12 | WAC valuation                                 | Unit cost recomputed from eligible costs; valuation snapshot preserved; historical costs unchanged |
| FIN-01 | Partial refund                                | Refund cannot exceed paid amount; original sale unchanged; compensating record written             |
| FIN-02 | Exchange with price difference                | Separate exchange and payment/refund records; original sale intact                                 |
| FIN-03 | Duplicate payment submission                  | One payment recorded; duplicate detected by idempotency key                                        |
| FIN-04 | Void                                          | Original sale and lines remain; void record and status change only                                 |
| FIN-05 | Price change                                  | Existing sale line snapshots unchanged; history row appended                                       |

These tests require repository and transaction code that does not exist yet. They are
specifications for Step 4, not Step 3 results.

## 5. Offline and reconciliation tests (L5)

The full state machine and ten scenarios are specified in
[`OFFLINE_AND_RECONCILIATION_DATA_MODEL.md`](OFFLINE_AND_RECONCILIATION_DATA_MODEL.md). The
minimum acceptance set:

| ID     | Scenario                                    | Key assertion                                                                               |
| ------ | ------------------------------------------- | ------------------------------------------------------------------------------------------- |
| OFF-01 | Offline sale with sufficient stock          | Accepted once; sale, payment and stock movement commit atomically                           |
| OFF-02 | Offline sale with insufficient stock        | No sale, no movement; `ReconciliationException` stores original payload and shortfall lines |
| OFF-03 | Replay of the same operation ID             | Returns the stored outcome; no second sale or movement                                      |
| OFF-04 | Duplicate delivery of the same sync session | Idempotent; no duplicate accepted operations                                                |
| OFF-05 | Resolution by Manager/Owner                 | Corrective adjustment/stocktake and one audited revalidation; `revalidationCount <= 1`      |
| OFF-06 | Resolution by Business Admin                | Rejected; view-only for physical reconciliation                                             |
| OFF-07 | Retry after resolution                      | No second revalidation; no silent overwrite of the original payload                         |
| OFF-08 | Conflict not caused by stock                | `ConflictRecord` created; original preserved; no automatic overwrite                        |
| OFF-09 | Expired device token                        | Sync rejected; device status audited; no operation accepted                                 |
| OFF-10 | Feed replay from an old cursor              | Events after the cursor delivered in order; no duplicate application                        |

`ReconciliationException.revalidationCount` should also gain a database CHECK
(`BETWEEN 0 AND 1`) in the baseline migration; the service enforces the state machine.

## 6. Subscription and tenancy service tests (L5)

| ID     | Scenario                                      | Key assertion                                                                  |
| ------ | --------------------------------------------- | ------------------------------------------------------------------------------ |
| SUB-01 | One trial per business                        | Second `TrialGrant` for the same business fails the unique rule                |
| SUB-02 | Webhook replay                                | `PaymentWebhookEvent (provider, providerEventId)` deduplicates; one activation |
| SUB-03 | Expired subscription                          | Operational access restricted per policy; all business data retained           |
| SUB-04 | Plan upgrade/downgrade                        | History row appended; current subscription updated; invoice preserved          |
| SUB-05 | Usage limit                                   | `UsageCounter` records consumption per period; limit check is server-side      |
| TEN-20 | User is Owner in A and Cashier in B           | Separate membership and role resolution; no role leakage                       |
| TEN-21 | Business Admin attempts physical stock action | Denied by permission check; no movement or adjustment row                      |
| TEN-22 | Manager/Owner physical action                 | Allowed; audit event written                                                   |
| TEN-23 | Super Admin without a grant                   | Denied; no tenant row returned                                                 |
| TEN-24 | Expired support grant                         | Denied; attempt audited                                                        |

## 7. Seed tests (L5)

| ID      | Scenario                          | Key assertion                                                        |
| ------- | --------------------------------- | -------------------------------------------------------------------- |
| SEED-01 | Run reference seed twice          | Second run creates nothing; counts unchanged                         |
| SEED-02 | Permission catalogue completeness | Every permission referenced by system roles exists                   |
| SEED-03 | Physical permission boundary      | Owner and Manager have physical permissions; Business Admin does not |
| SEED-04 | Global unit uniqueness            | Re-seeding does not duplicate a global unit code                     |
| SEED-05 | Plan idempotency                  | A plan is not duplicated; an existing price is not overwritten       |
| SEED-06 | Demo guard                        | Demo seed refuses to run with `NODE_ENV=production`                  |
| SEED-07 | Failure atomicity                 | A failing seed leaves no partial permission or role set              |

## 8. Performance smoke tests (L6)

These are not load tests. They confirm that the planned access paths use the declared indexes on a
representative fixture (for example 100 branches, 10,000 variants, 1,000,000 movements).

| ID      | Query path                              | Expected plan                                                                                    |
| ------- | --------------------------------------- | ------------------------------------------------------------------------------------------------ |
| PERF-01 | Branch stock list for a business/branch | Index scan on `StockBalance (businessId, branchId, quantityOnHand)` or the branch/variant unique |
| PERF-02 | Sales for a branch and date range       | Index on `Sale (businessId, branchId, completedAt)`                                              |
| PERF-03 | Variant sales history                   | Index on `SaleLine (businessId, variantId, saleId)`                                              |
| PERF-04 | Open movements by reference             | Index on `StockMovement (businessId, referenceType, referenceId)`                                |
| PERF-05 | Sync replay by device and operation     | Unique `(deviceId, operationId)`                                                                 |
| PERF-06 | Audit lookup by branch and time         | Index on `AuditEvent (businessId, branchId, occurredAt)`                                         |
| PERF-07 | Feed delivery after a cursor            | Index on `FeedEvent (businessId, branchId, feedType, occurredAt, id)`                            |

The test records `EXPLAIN (ANALYZE, BUFFERS)` output and rejects sequential scans on the large
tables for these paths. No such test was run in Step 3 because no database or fixtures exist.

## 9. Documentation validation (L7)

| Check                        | Method                                                                 | Status                                                    |
| ---------------------------- | ---------------------------------------------------------------------- | --------------------------------------------------------- |
| Mermaid syntax and rendering | Render every diagram in Mermaid 11 (browser preview)                   | Executed before completion report; results recorded there |
| Markdown links               | Resolve every relative link to an existing file and heading            | Executed before completion report                         |
| Formatting                   | `prettier --check docs/database` with the repository configuration     | Executed before completion report                         |
| Diagram coverage             | Cross-check the 12 required diagram areas against the created diagrams | Executed before completion report                         |
| Ownership consistency        | Module list and counts match the entity catalog and schema             | Executed before completion report                         |

If a diagram fails to render, it is not "good enough because the source looks right"; the source is
fixed and re-rendered.

## 10. Test database and fixtures

When implementation begins:

- Use a dedicated `adaptive_retail_test` database, never the developer database.
- Apply `migrate deploy`, then the reference seed. Do not use `migrate reset` on a shared instance.
- Give each parallel worker its own schema or database, derived from the migrated template.
- Build fixtures through explicit builder functions, not ad hoc SQL. Every tenant test starts with
  at least two businesses.
- Run each test in a transaction that rolls back, or truncate only the tables the test touched;
  never truncate the whole database while another worker runs.
- Use a fixed clock abstraction for expiry, trial, forecast date and shift tests.
- Do not use production data or production credentials.
- Integration tests are tagged and run separately from unit tests; a unit test must not require
  PostgreSQL.

## 11. CI plan

| Job                  | Command                                                                       | Gate                                        |
| -------------------- | ----------------------------------------------------------------------------- | ------------------------------------------- |
| Schema static        | `prisma validate`, `prisma format` with a clean-diff check, `prisma generate` | Every pull request                          |
| Migration drift      | `migrate diff ... --exit-code`                                                | Every pull request that touches `prisma/**` |
| Database integration | `migrate deploy` + seed + `test:integration` against PostgreSQL 17 service    | Every pull request, required for merge      |
| Documentation        | Prettier check, link check, Mermaid render check                              | Every pull request that touches docs        |
| Performance smoke    | `EXPLAIN` assertions on a seeded fixture                                      | Nightly or before a release, not every PR   |

The jobs do not exist yet. They are defined here so the first migration PR can add them without
redesigning the validation approach.

## 12. Acceptance mapping

| Acceptance area | Evidence                                                                                                                                                                                           |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Completeness    | 159 models, 94 enums, 21 modules, four business types, roles, subscriptions, offline, AI, audit — entity catalog and coverage checks                                                               |
| Integrity       | Primary keys, foreign keys, 274 `@@unique` declarations (+27 scalar `@unique` = 301 combined unique declarations), tenant columns, decimal money, no floats, deletion policy, migration CHECK plan |
| Architecture    | One schema, one location, one migration strategy, one ownership map, no per-member database                                                                                                        |
| Validation      | Prisma validate/format/generate passed; diagrams and links checked before report; live database checks explicitly listed as not executed                                                           |

The honest summary: the schema is structurally complete and machine-validated. The database is not
yet proven to enforce the CHECK and partial-index rules until the baseline migration runs against
PostgreSQL.
