# Inventory and financial data integrity

**Status:** Step 3 design baseline. Constraints are specified; the migration has **not** been
applied because no PostgreSQL instance was used in this step. No application transaction code
exists yet.

## 1. One authoritative stock source

| Data                         | Responsibility                                                                        |
| ---------------------------- | ------------------------------------------------------------------------------------- |
| `StockBalance`               | The only authoritative on-hand, reserved and in-transit quantity per branch + variant |
| `StockMovement`              | Append-only signed ledger explaining every quantity change                            |
| `InventoryBatch`             | Batch/lot identity, expiry, quarantine and unit cost                                  |
| `BatchMovementAllocation`    | Which batch a movement consumed or produced                                           |
| `InventoryValuationSnapshot` | Historical WAC valuation; never a second live balance                                 |
| `StockReservation`           | Holds quantity for an open sale or exchange                                           |
| `InventoryDailyFact`         | Rebuildable reporting snapshot; never used to sell                                    |

`StockBalance` is unique on `(branchId, variantId)`. No table stores a second live balance that
could disagree with it. Batches and movements are evidence; the balance is the current truth.

Available quantity is:

```text
available = quantityOnHand - quantityReserved
```

In-transit is separate and is **not** available for sale. A transfer in transit appears as
`quantityInTransit` at the destination only when the dispatch is recorded; it does not increase
sellable stock until the destination accepts it.

## 2. Movement rules

1. Every quantity change writes exactly one `StockMovement` with a signed `quantityDelta`, a
   `type`, a `referenceType` and a `referenceId`.
2. `quantityDelta` may be negative; the resulting available balance may not be negative.
3. Every movement has a stable `sourceKey` unique per business. Replaying a sync or a receiving
   request cannot post the same movement twice.
4. Movements are never updated or deleted. A correction is a new movement with its own reference
   and audit event.
5. A movement from a sale, return, adjustment, transfer, stocktake or loss must reference the
   document that authorized it.
6. In-transit movements change `quantityInTransit`, not `quantityOnHand`, until receipt.

Movement sources:

| Movement type         | Created by                     | Affects available stock                  |
| --------------------- | ------------------------------ | ---------------------------------------- |
| `RECEIPT`             | Accepted `GoodsReceiptLine`    | Yes, increases                           |
| `SALE`                | Committed `Sale`               | Yes, decreases                           |
| `RETURN`              | Approved restock on a return   | Yes, increases                           |
| `ADJUSTMENT`          | Approved `InventoryAdjustment` | Yes                                      |
| `STOCKTAKE`           | Approved stocktake variance    | Yes                                      |
| `TRANSFER_OUT`        | Dispatched transfer            | Yes at source; in-transit at destination |
| `TRANSFER_IN`         | Accepted destination receipt   | Yes at destination; in-transit decreases |
| `LOSS`                | `StockLossRecord`              | Yes, decreases                           |
| `RECONCILIATION`      | Authorized D-025 outcome       | Only through a separate adjustment       |
| `RESERVATION_RELEASE` | Expired/released reservation   | Releases reserved quantity               |

## 3. Database constraints (initial migration SQL)

These are PostgreSQL checks that Prisma does not express. They are added in the initial migration
and must remain in every environment.

```sql
ALTER TABLE "StockBalance"
  ADD CONSTRAINT "stock_balance_on_hand_non_negative"
    CHECK ("quantityOnHand" >= 0),
  ADD CONSTRAINT "stock_balance_reserved_non_negative"
    CHECK ("quantityReserved" >= 0),
  ADD CONSTRAINT "stock_balance_reserved_not_above_on_hand"
    CHECK ("quantityReserved" <= "quantityOnHand"),
  ADD CONSTRAINT "stock_balance_in_transit_non_negative"
    CHECK ("quantityInTransit" >= 0);

ALTER TABLE "StockMovement"
  ADD CONSTRAINT "stock_movement_delta_non_zero"
    CHECK ("quantityDelta" <> 0);

CREATE UNIQUE INDEX "cashier_shift_one_open_per_terminal"
  ON "CashierShift" ("terminalId")
  WHERE "status" = 'OPEN';

CREATE UNIQUE INDEX "membership_one_owner_per_business"
  ON "Membership" ("businessId")
  WHERE "isOwner" = true;
```

A movement that would make available stock negative must be rejected by the transaction that would
write it; the check is a second line of defence, not the business rule.

## 4. Transaction and locking requirements (for later implementation)

The following is a design requirement for Step 4+, not implemented code:

1. **Sale commit.** In one `SERIALIZABLE` transaction (or `READ COMMITTED` with explicit row locks):
   lock each `StockBalance` row with `SELECT ... FOR UPDATE`, re-read the authoritative price,
   verify `quantityOnHand - quantityReserved >= requested`, insert the sale and lines, insert
   payments, write one movement per line with a unique source key, and update balances. A failure
   rolls back everything.
2. **Conditional update.** Prefer
   `UPDATE "StockBalance" SET "quantityOnHand" = "quantityOnHand" - $1, "version" = "version" + 1 WHERE "branchId" = $2 AND "variantId" = $3 AND "quantityOnHand" - "quantityReserved" >= $1 RETURNING ...`
   and treat zero rows as an insufficient-stock outcome. The `version` column supports optimistic
   checks and conflict diagnostics.
3. **Ordering.** Lock balance rows in a deterministic order (by variant ID) to avoid deadlocks when
   a sale contains several variants.
4. **Receiving.** A goods receipt commits accepted quantities, creates batches and movements, and
   updates balances in one transaction. Rejected/damaged quantities may produce quarantine or loss
   records, not sellable stock.
5. **Transfer.** Dispatch decreases source on-hand and increases destination in-transit atomically.
   Receipt decreases in-transit and increases destination on-hand atomically. A partial receipt
   keeps the remainder in transit.
6. **Adjustment.** An approved adjustment is applied once; `sourceKey` and the adjustment status
   prevent a double application.
7. **Offline sale.** The same sale transaction is used after authoritative revalidation; a shortfall
   commits no sale and no movement and creates a `ReconciliationException`.

## 5. Batch, expiry and valuation

- `InventoryBatch` is unique per `(branchId, variantId, batchNumber)`; batch number may be absent
  for non-batch businesses but the row still anchors cost and expiry when used.
- Expiry and quarantine are batch state, not stock state. A quarantined batch is not sellable even
  if `quantityOnHand` is positive; the service excludes it when allocating.
- FIFO is a physical allocation rule over batches. WAC is a financial valuation method over
  quantity and cost. They are separate concepts and produce separate records.
- `InventoryValuationSnapshot` stores quantity, unit cost, total value and method per branch,
  variant and date. A new snapshot is inserted; old snapshots are never recalculated in place.
- Additional eligible costs (freight, handling) can be included in a receipt's unit cost at receiving
  time. Historical sale cost snapshots are not rewritten.

## 6. Money and financial history

| Rule               | Implementation                                                                                     |
| ------------------ | -------------------------------------------------------------------------------------------------- |
| Exact money        | `Decimal(18,2)`; no `Float`/`Double`                                                               |
| Explicit currency  | `currency char(3)` on every monetary row; default `ETB`                                            |
| Sale immutability  | `Sale`, `SaleLine`, `SalePayment` are inserted once; corrections are new records                   |
| Void               | `SaleVoid` + `Sale.status = VOIDED`; original totals remain                                        |
| Returns            | `ReturnRequest`/`ReturnLine`/`Refund`; no edit to the original sale                                |
| Exchanges          | `Exchange`/`ExchangeLine`; separate from refunds                                                   |
| Refund ceiling     | Application rule from stored paid and refunded amounts; `RefundAllocation` records the split       |
| PO history         | `PurchaseOrderRevision` snapshots each revision; approval is a separate row                        |
| Supplier money     | `SupplierInvoice`, `SupplierInvoiceLine`, `SupplierPayment`, `PaymentAllocation`                   |
| Subscription money | `PaymentAttempt` (attempt) vs `SubscriptionInvoice` (invoice) vs `SubscriptionHistory` (lifecycle) |
| Prices             | `PriceChangeHistory` is append-only; current price rows are effective-dated                        |
| Valuation          | Snapshots preserve historical WAC; no retroactive rewrite                                          |
| Audit              | Every approval, void, refund, adjustment and reconciliation writes `AuditEvent`                    |

Rounding: line totals are stored in minor-unit-compatible decimals; the service defines rounding
per currency. The database stores the result; it does not recompute historical totals.

## 7. Duplicate prevention

| Operation      | Key                                                                                      |
| -------------- | ---------------------------------------------------------------------------------------- |
| API command    | `Idempotency-Key` → `IdempotencyRecord(scope, key)`                                      |
| Offline sale   | `(deviceId, operationId)` on `SyncOperation`; `(offlineDeviceId, operationId)` on `Sale` |
| Refund         | `(businessId, idempotencyKey)` on `Refund`                                               |
| Stock movement | `(businessId, sourceKey)` on `StockMovement`                                             |
| Webhook        | `(provider, providerEventId)` on `PaymentWebhookEvent`                                   |
| Receipt        | `(businessId, receiptNumber)`; one receipt per sale                                      |
| Shift          | One open shift per terminal (partial unique index)                                       |

## 8. Integrity test specifications

These are **specifications**, not executed tests. They belong to the database and module test
suites in later stages.

1. `StockBalance` rejects a negative `quantityOnHand` and a reservation above on-hand.
2. Two concurrent sales of the last unit: one commits, one receives insufficient stock; balance
   never goes below zero.
3. Replaying the same `sourceKey` stock movement fails; replica does not double-decrease.
4. PO confirmation alone changes no stock and creates no movement.
5. Accepted receipt increases on-hand; rejected/damaged quantity does not become sellable.
6. Transfer dispatch decreases source and increases in-transit; receipt moves in-transit to
   destination on-hand; partial receipt preserves the remainder.
7. Refund cannot exceed paid amount; original sale totals are unchanged after a refund.
8. Voiding a sale keeps the sale row and creates a `SaleVoid`.
9. Re-running a stocktake adjustment with the same reference does not double-apply.
10. WAC snapshot history is insert-only; past rows are unchanged after a new receipt.
11. A cross-tenant product/variant cannot be used on a sale line.
12. A sync operation that would oversell creates a `ReconciliationException` and no sale/movement.
