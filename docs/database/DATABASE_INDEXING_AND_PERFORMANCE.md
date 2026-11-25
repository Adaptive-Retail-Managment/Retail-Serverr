# Database indexing and performance

**Status:** Step 3 design. Indexes are declared in the Prisma schema; no query plan has been
measured because no application queries or live database exist yet. Do not present these as
"tuned".

## 1. Principles

1. **Tenant first.** Tenant queries start with `businessId`; branch queries add `branchId`.
   Composite indexes follow that order.
2. **Uniqueness before performance.** Natural keys and idempotency keys get unique constraints, not
   just non-unique indexes.
3. **Cover the real path.** Indexes target the known read paths: POS lookup, stock availability,
   batch/expiry, sales history, procurement status, sync replay and reconciliation worklists.
4. **Avoid speculative indexes.** Reporting aggregates use fact tables; do not add indexes to
   operational tables for every hypothetical report.
5. **Write cost matters.** Sales and movements are write-heavy; keep their indexes narrow and
   purposeful.
6. **Measure later.** At Step 4+, use `EXPLAIN (ANALYZE, BUFFERS)` on representative data before
   adding or removing an index.

The schema declares **187 `@@index` entries**, **274 `@@unique` declarations** and **27 scalar
`@unique` fields** (301 unique declarations in total, including composite tenant keys). The
counts are current as of this document; the schema is authoritative.

## 2. Key index groups

### 2.1 Identity, tenancy and authorization

| Index                                                                                                                         | Purpose                                                           |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| `User.email` (unique), `User.phone` (unique)                                                                                  | Login and duplicate-account detection                             |
| `UserSession(refreshHash)` unique; `(userId, revokedAt)`; `(familyId)`; `(expiresAt)`                                         | Refresh rotation, revocation, cleanup                             |
| `Membership @@unique([businessId, userId])`; `(userId, status)`; `(businessId, roleId)`                                       | Resolve membership, list a user's businesses, role administration |
| `Branch @@unique([businessId, code])`; `(businessId, isActive)`                                                               | Branch lookup and active-branch lists                             |
| `Invitation(tokenHash)` unique; `(businessId, status)`                                                                        | Accept invitation; pending list                                   |
| `Permission.code` unique; `(resource, subject)`                                                                               | Permission registry lookup                                        |
| `Role @@unique([businessId, code])`                                                                                           | Role by code within a tenant                                      |
| `Employee @@unique([businessId, employeeCode])`; `(businessId, status)`                                                       | Employee lookup and roster                                        |
| `AuditEvent(businessId, branchId, occurredAt)`; `(actorUserId, occurredAt)`; `(targetType, targetId)`; `(action, occurredAt)` | Audit timeline and entity history                                 |

### 2.2 Subscription and payment

| Index                                                                                                                  | Purpose                                        |
| ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `Plan @@unique([code])`; `PlanPrice(planId, billingCycle, currency)`                                                   | Plan catalogue and checkout                    |
| `Subscription.businessId` unique                                                                                       | One current subscription per business          |
| `SubscriptionInvoice @@unique([businessId, number])`; `(businessId, status, dueAt)`                                    | Invoice lookup and dunning                     |
| `PaymentAttempt.txRef` unique; `@@unique([provider, providerReference])`; `(businessId, status, createdAt)`; `(txRef)` | Provider reconciliation and duplicate attempts |
| `PaymentWebhookEvent @@unique([provider, providerEventId])`; `(txRef, receivedAt)`                                     | Webhook dedupe and retry sweep                 |
| `UsageCounter @@unique([businessId, featureKey, periodStart])`                                                         | Limit checks                                   |
| `TrialGrant.businessId` unique                                                                                         | One trial per business                         |

### 2.3 Catalog, pricing and files

| Index                                                                                                              | Purpose                               |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------- |
| `Product @@unique([businessId, sku])`; `(businessId, status)`; `(businessId, categoryId)`; `(businessId, brandId)` | Product search and list filters       |
| `ProductVariant @@unique([businessId, sku])`; `(businessId, productId)`; `(businessId, status)`                    | Variant resolution and product detail |
| `Barcode @@unique([businessId, barcode])`                                                                          | Scan lookup                           |
| `Category @@unique([businessId, slug])`; `(businessId, parentId, sortOrder)`                                       | Tree navigation                       |
| `ProductPrice @@unique([priceListId, variantId, effectiveFrom])`; `(businessId, variantId, effectiveFrom)`         | Effective price resolution            |
| `BranchPriceOverride @@unique([branchId, variantId, effectiveFrom])`                                               | Branch price lookup                   |
| `FileObject.storageKey` unique; `(businessId, status)`                                                             | Upload confirmation and file listing  |
| `FileLink @@unique([fileId, entityType, entityId, role])`; `(businessId, entityType, entityId)`                    | Attachment lookup                     |

### 2.4 Inventory

| Index                                                                                                                                                                               | Purpose                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| `StockBalance @@unique([branchId, variantId])`; `(businessId, branchId, quantityOnHand)`                                                                                            | The authoritative availability read and low-stock scans                   |
| `StockMovement @@unique([businessId, sourceKey])`; `(businessId, branchId, variantId, occurredAt)`; `(businessId, referenceType, referenceId)`; `(businessId, batchId, recordedAt)` | Ledger history and duplicate prevention                                   |
| `InventoryBatch @@unique([branchId, variantId, batchNumber])`; `(businessId, branchId, expiryDate)`; `(businessId, variantId, status)`                                              | FIFO allocation, expiry worklists, quarantine                             |
| `StocktakeSession @@unique([businessId, number])`; `(businessId, branchId, status)`                                                                                                 | Count worklist                                                            |
| `InventoryAdjustment @@unique([businessId, number])`; `(businessId, branchId, status)`                                                                                              | Approval queue                                                            |
| `StockTransfer @@unique([businessId, number])`; `(businessId, status)`                                                                                                              | Transfer tracking                                                         |
| `InventoryAlert(businessId, branchId, status)`; `(businessId, variantId, type)`                                                                                                     | Alert inbox                                                               |
| `StockReservation @@unique([sourceType, sourceId, variantId])`; `(businessId, branchId, status)`                                                                                    | Reservation expiry (expiry scan is application-level; no dedicated index) |
| `InventoryValuationSnapshot @@unique([branchId, variantId, asOfDate])`                                                                                                              | Valuation history                                                         |

### 2.5 Suppliers and procurement

| Index                                                                                                                                                              | Purpose                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------- |
| `Supplier @@unique([businessId, code])`; `(businessId, status)`; `(businessId, name)`                                                                              | Supplier picker and list                 |
| `SupplierProduct @@unique([supplierId, variantId])`; `(businessId, variantId)`; `(businessId, supplierSku)`                                                        | Supplier product lookup                  |
| `SupplierPricingAgreement @@unique([businessId, reference])`; `(businessId, supplierId, status)`                                                                   | Active agreement lookup                  |
| `Rfq @@unique([businessId, number])`; `(businessId, branchId, status)`                                                                                             | RFQ worklist                             |
| `SupplierQuotation @@unique([rfqVersionId, supplierId, revision])`                                                                                                 | Quote revisions                          |
| `PurchaseOrder @@unique([businessId, number])`; `(businessId, supplierId, status)`; `(businessId, branchId, status)`                                               | PO tracking and approval queue           |
| `GoodsReceipt @@unique([businessId, number])`; `(businessId, purchaseOrderId)`                                                                                     | Receiving history                        |
| `SupplierInvoice @@unique([businessId, number])`; `@@unique([businessId, supplierInvoiceNumber])`; `(businessId, supplierId, status, dueDate)`                     | Invoice matching and duplicate detection |
| `SupplierPayment(businessId, supplierId, status, paidAt)`; `PaymentAllocation @@unique([supplierPaymentId, supplierInvoiceId])`; `(businessId, supplierInvoiceId)` | Payment history and allocation           |

### 2.6 POS, sales and after-sales

| Index                                                                                                                                                                                | Purpose                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------- |
| `PosTerminal @@unique([branchId, code])`                                                                                                                                             | Terminal registration                                                   |
| `CashierShift(businessId, terminalId, openedAt)`; `(businessId, branchId, status)`                                                                                                   | Open shift lookup                                                       |
| `Sale @@unique([businessId, receiptNumber])`; `@@unique([businessId, offlineDeviceId, operationId])`; `(businessId, branchId, completedAt)`; `(businessId, customerId, completedAt)` | Receipt lookup, offline idempotency, sales history and customer history |
| `SaleLine(businessId, variantId, saleId)`                                                                                                                                            | Sale detail and variant sales                                           |
| `SalePayment(businessId, saleId)`; `(businessId, reference)`                                                                                                                         | Payment detail and method reporting                                     |
| `Receipt.saleId` unique; `(businessId, receiptNumber)`                                                                                                                               | One receipt per sale; reprint                                           |
| `ReceiptBlock @@unique([deviceId, prefix, startNumber])`                                                                                                                             | Offline number allocation                                               |
| `ReturnRequest @@unique([businessId, number])`; `(businessId, branchId, status)`; `(businessId, saleId)`                                                                             | Return lookup and worklist                                              |
| `Refund @@unique([businessId, number])`; `@@unique([businessId, idempotencyKey])`                                                                                                    | Refund idempotency                                                      |
| `Exchange(businessId, branchId, status)`; `ExchangeReservation(businessId, variantId, status)`                                                                                       | Exchange and stock hold                                                 |

### 2.7 Synchronization and reconciliation

| Index                                                                                                                               | Purpose                         |
| ----------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| `Device @@unique([businessId, deviceFingerprint])`; `(businessId, branchId, status)`                                                | Device enrolment and revocation |
| `SyncSession(businessId, deviceId, startedAt)`; `(status)`                                                                          | Sync history and cleanup        |
| `SyncOperation @@unique([businessId, deviceId, operationId])`; `(businessId, status, receivedAt)`; `(businessId, branchId, status)` | Idempotent replay and worklists |
| `SyncAttempt @@unique([syncOperationId, attemptNumber])`                                                                            | Attempt history                 |
| `ReconciliationException(businessId, branchId, status, receivedAt)`; `(businessId, deviceId, status)`                               | Reconciliation worklist         |
| `ConflictRecord(businessId, branchId, status)`; `(businessId, deviceId, createdAt)`                                                 | Conflict worklist               |
| `SyncCursor @@unique([deviceId, feedType])`                                                                                         | Resume feed                     |
| `FeedEvent(businessId, branchId, feedType, occurredAt, id)`                                                                         | Ordered feed read               |

### 2.8 Notifications, analytics and intelligence

| Index                                                                                                          | Purpose                 |
| -------------------------------------------------------------------------------------------------------------- | ----------------------- |
| `Notification(recipientUserId, status, createdAt)`; `(businessId, category, createdAt)`                        | Inbox and dedupe        |
| `NotificationDelivery(businessId, status, lastAttemptAt)`                                                      | Retry queue             |
| `NotificationTemplate @@unique([businessId, code, channel, locale, version])`                                  | Template resolution     |
| `ExportJob(businessId, status, requestedAt)`                                                                   | Export queue            |
| `SalesDailyFact @@unique([branchId, businessDate])`; `(businessId, businessDate)`                              | Dashboard range scans   |
| `ProductSalesDailyFact @@unique([branchId, variantId, businessDate])`; `(businessId, variantId, businessDate)` | Product trend queries   |
| `InventoryDailyFact @@unique([branchId, variantId, businessDate])`; `(businessId, businessDate)`               | Inventory trend queries |
| `StockoutEvent(businessId, branchId, variantId, detectedAt)`; `(businessId, endedAt)`                          | Open stockout list      |
| `ExpiryRiskFact(businessId, branchId, asOfDate)`                                                               | Expiry worklist         |
| `ForecastRun(businessId, status, createdAt)`; `(businessId, branchId, scope)`                                  | Forecast history        |
| `Recommendation(businessId, status, createdAt)`; `(businessId, variantId)`                                     | Review queue            |
| `ModelMetric(businessId, modelId, recordedAt)`                                                                 | Model quality history   |

## 3. Index review rules

- An index that starts with a low-cardinality column other than `businessId` is suspect unless the
  query is genuinely global.
- Avoid duplicate prefixes: `(businessId, branchId, status)` already serves `businessId` and
  `(businessId, branchId)` lookups.
- Keep `Sale` and `StockMovement` indexes to the paths used by POS, receipts and reporting.
- Partial indexes are added in SQL for open shifts and owner membership; Prisma cannot express
  predicates.
- Revisit after the first load test. No index is "proven" until a plan is measured.

## 4. Performance-sensitive future queries

| Query                 | Expected path                                                                         |
| --------------------- | ------------------------------------------------------------------------------------- |
| Scan a barcode at POS | `Barcode(businessId, barcode)` → variant → `ProductPrice` → `StockBalance`            |
| Check availability    | `StockBalance(branchId, variantId)`                                                   |
| List low stock        | `StockBalance(businessId, branchId, quantityOnHand)` filtered on available expression |
| Sales for a day       | `Sale(businessId, branchId, completedAt)`                                             |
| Receipt reprint       | `Sale(businessId, receiptNumber)`                                                     |
| Sync replay           | `SyncOperation(businessId, deviceId, operationId)`                                    |
| Reconciliation inbox  | `ReconciliationException(businessId, branchId, status, receivedAt)`                   |
| Expiring stock        | `InventoryBatch(businessId, branchId, expiryDate)`                                    |
| Supplier payables     | `SupplierInvoice(businessId, supplierId, status)` → `SupplierPayment`                 |
| Dashboard range       | `SalesDailyFact(businessId, businessDate)`                                            |

These paths assume the tenant values come from the authenticated scope, never from a client-only
parameter.
