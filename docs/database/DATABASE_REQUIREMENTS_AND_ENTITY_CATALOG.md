# Database requirements and entity catalog

**Status:** Step 3 baseline. This catalogue covers the whole platform, not one member's modules.
**Canonical schema:** [`apps/api/prisma/schema.prisma`](../../apps/api/prisma/schema.prisma).
**Related:** [Conceptual data model](CONCEPTUAL_DATA_MODEL.md), [Logical design](LOGICAL_DATABASE_DESIGN.md),
[Module ownership](DATABASE_MODULE_OWNERSHIP.md).

## 1. Purpose and method

Every confirmed requirement in the authoritative
[Master Project Requirements & Decision Document](../requirements/MASTER_PROJECT_REQUIREMENTS_AND_DECISION_DOCUMENT.md)
(MRDD v1.0), Step 2 architecture and the four business types was mapped to entities before the
Prisma schema was written. Section references in §2 cite MRDD section numbers; later owner
confirmations (e.g. U-1 Option A, D-025) are labelled as such. The schema is the canonical
logical implementation; this document records why each entity exists, which module and member
own it, and which isolation, audit and uniqueness rules apply.

Scope labels mean:

- **Platform** — not tenant-owned (users, plans, platform settings).
- **Business** — carries `businessId` and a business-level FK.
- **Business + branch** — carries `businessId` and `branchId`, and references the branch through
  the composite key `(businessId, id)`.

Counts: **159 models**, **94 enums**, **21 modules**, **4 business types**, **four accountable
members** (each module has exactly one owner; see D-034).

## 2. Requirements-to-entity traceability

| Requirement area                                                                             | Entities (primary)                                                                                                                                                                                                                                                                                                                                                                                                                                      | Module(s)                                                  | Owner   |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | ------- |
| MRDD §3–4 Registration, roles, businesses, branches, memberships, invitations, subscriptions | User, Business, Branch, Membership, MembershipBranchAssignment, Invitation, Permission, Role, RolePermission, Employee, Plan, PlanFeature, PlanPrice, Subscription, SubscriptionHistory, SubscriptionInvoice, PaymentAttempt, PaymentWebhookEvent, TrialGrant, UsageCounter                                                                                                                                                                             | identity, tenancy, authorization, employees, subscriptions | M1      |
| MRDD §5 Catalog, variants, industry attributes, imports, files                               | Product, ProductVariant, ProductAttributeValue, Barcode, ProductMedia, Brand, Category, ProductImportJob, FileObject, FileLink, FileUploadSession, BusinessConfiguration, BusinessSetting, BranchSetting, AttributeDefinition, Unit, UnitConversion, CapabilityFlag                                                                                                                                                                                     | catalog, files, business-configuration                     | M2      |
| MRDD §6 Units, pricing, cost and inventory foundation                                        | PriceList, ProductPrice, BranchPriceOverride, PriceChangeHistory, Discount, StockBalance, StockMovement, InventoryBatch, BatchMovementAllocation, InventoryValuationSnapshot                                                                                                                                                                                                                                                                            | pricing, inventory                                         | M2 / M3 |
| MRDD §7–8 Batches, expiry, stocktaking, adjustments, alerts, transfers                       | StocktakeSession, StocktakeLine, InventoryAdjustment, InventoryAdjustmentLine, StockTransfer, StockTransferLine, TransferReceipt, TransferReceiptLine, InventoryAlert, StockReservation, MinStockSetting, StockLossRecord                                                                                                                                                                                                                               | inventory                                                  | M3      |
| MRDD §9–11 Suppliers, RFQs, quotations, negotiations, POs, receiving, invoices               | Supplier, SupplierContact, SupplierDocument, SupplierProduct, SupplierPriceHistory, SupplierPricingAgreement, SupplierAgreementLine, Rfq, RfqVersion, RfqLine, SupplierQuotation, QuotationLine, QuotationComparison, NegotiationRecord, PurchaseOrder, PurchaseOrderRevision, PurchaseOrderLine, PurchaseOrderApproval, SupplierConfirmation, GoodsReceipt, GoodsReceiptLine, SupplierInvoice, SupplierInvoiceLine, SupplierPayment, PaymentAllocation | suppliers, procurement                                     | M3      |
| MRDD §12 POS, sales, payments, shifts, receipts                                              | PosTerminal, CashierShift, ShiftCashMovement, Sale, SaleLine, SalePayment, SaleDiscount, SaleVoid, Receipt, ReceiptBlock, SaleCustomerAssociation                                                                                                                                                                                                                                                                                                       | sales                                                      | M4      |
| MRDD §13 Customers, returns, refunds, exchanges                                              | Customer, CustomerContact, CustomerConsent, CustomerMergeRequest, CustomerBusinessSummary, ReturnRequest, ReturnLine, ReturnInspection, Refund, RefundAllocation, Exchange, ExchangeLine, ExchangeReservation, CollectionFollowUp                                                                                                                                                                                                                       | customers, after-sales                                     | M4      |
| MRDD §18 + owner decision D-025 Offline sync and strict reconciliation                       | Device, SyncSession, SyncOperation, SyncAttempt, ReconciliationException, ReconciliationShortfallLine, ReconciliationEvent, ConflictRecord, SyncCursor, FeedEvent                                                                                                                                                                                                                                                                                       | synchronization                                            | M4      |
| MRDD §14–15 Reporting, dashboards, forecasting, advisory recommendations                     | ReportDefinition, ExportJob, SalesDailyFact, ProductSalesDailyFact, InventoryDailyFact, StockoutEvent, ExpiryRiskFact, SupplierPerformanceFact, ForecastModel, ForecastRun, ForecastPoint, Recommendation, FeatureSnapshot, ModelMetric                                                                                                                                                                                                                 | analytics, intelligence                                    | M4      |
| MRDD §16–17 Notifications, delivery, audit, security                                         | NotificationTemplate, Notification, NotificationDelivery, NotificationPreference, NotificationEscalation, AuditEvent                                                                                                                                                                                                                                                                                                                                    | notifications, audit                                       | M4 / M1 |
| Cross-cutting delivery and replay (technical decision)                                       | OutboxEvent, IdempotencyRecord                                                                                                                                                                                                                                                                                                                                                                                                                          | platform infrastructure                                    | M1      |

No approved workflow is represented only by a JSON blob. JSON is used for preserved external
payloads (`SyncOperation.payload`, `ReconciliationException.originalPayload`), flexible
configuration parameters and forecast inputs; money, quantities, identities and relationships are
structured columns.

## 3. Entity inventory by module

### identity (M1)

| Entity                   | Purpose                                   | Scope    | Financial / sensitive | History      | Key uniqueness |
| ------------------------ | ----------------------------------------- | -------- | --------------------- | ------------ | -------------- |
| `User`                   | Person account shared across businesses   | Platform | Sensitive             | Status trail | email; phone   |
| `UserCredential`         | Password verifier and hashing metadata    | Platform | Sensitive             | Append-only  | userId         |
| `UserSession`            | Refresh-token family and revocation state | Platform | Sensitive             | Append-only  | refreshHash    |
| `EmailVerificationToken` | One-time email verification token         | Platform | Sensitive             | Append-only  | tokenHash      |
| `PasswordResetToken`     | One-time password reset token             | Platform | Sensitive             | Append-only  | tokenHash      |

### tenancy (M1)

| Entity                       | Purpose                                       | Scope             | Financial / sensitive | History      | Key uniqueness                                         |
| ---------------------------- | --------------------------------------------- | ----------------- | --------------------- | ------------ | ------------------------------------------------------ |
| `Business`                   | Tenant root with type, currency and time zone | Platform          | Yes                   | Archive      | slug; ownerMembershipId                                |
| `Branch`                     | Operating location inside one business        | Business          | Yes, Sensitive        | Archive      | (businessId, code); (businessId, id)                   |
| `Membership`                 | User role inside one business                 | Business          | -                     | Status trail | (businessId, userId); (businessId, id)                 |
| `MembershipBranchAssignment` | Membership access to specific branches        | Business + branch | -                     | Append-only  | (businessId, id); active-only (membershipId, branchId) |
| `Invitation`                 | Employee invitation and token lifecycle       | Business          | Sensitive             | Status trail | (businessId, id); tokenHash                            |

### authorization (M1)

| Entity           | Purpose                                              | Scope    | Financial / sensitive | History            | Key uniqueness                       |
| ---------------- | ---------------------------------------------------- | -------- | --------------------- | ------------------ | ------------------------------------ |
| `Permission`     | Permission catalogue entry and physical/digital flag | Platform | -                     | Append-only        | code                                 |
| `Role`           | Business or system role grouping permissions         | Business | -                     | Mutable timestamps | (businessId, code); (businessId, id) |
| `RolePermission` | Role to permission assignment                        | Platform | -                     | Append-only        | -                                    |

### employees (M1)

| Entity                     | Purpose                                      | Scope              | Financial / sensitive | History      | Key uniqueness                                    |
| -------------------------- | -------------------------------------------- | ------------------ | --------------------- | ------------ | ------------------------------------------------- |
| `Employee`                 | Employee profile separate from login account | Business           | Sensitive             | Status trail | (businessId, employeeCode); (businessId, id)      |
| `EmployeeBranchAssignment` | Employee posting to a branch over time       | Business + branch  | -                     | Append-only  | (employeeId, branchId, startAt); (businessId, id) |
| `EmploymentStatusHistory`  | Employment status change history             | Business (derived) | -                     | Status trail | -                                                 |

### subscriptions (M1)

| Entity                      | Purpose                                   | Scope    | Financial / sensitive | History      | Key uniqueness                                              |
| --------------------------- | ----------------------------------------- | -------- | --------------------- | ------------ | ----------------------------------------------------------- |
| `Plan`                      | Subscription plan definition              | Platform | Yes                   | Status trail | code                                                        |
| `PlanFeature`               | Feature entitlement of a plan             | Platform | Yes                   | Append-only  | (planId, featureKey)                                        |
| `PlanPrice`                 | Plan price per billing cycle and currency | Platform | Yes                   | Append-only  | (planId, billingCycle, currency)                            |
| `Subscription`              | Current subscription per business         | Business | -                     | Status trail | businessId                                                  |
| `SubscriptionHistory`       | Lifecycle events of a subscription        | Business | -                     | Append-only  | (businessId, id)                                            |
| `SubscriptionInvoice`       | Issued subscription invoice               | Business | Yes                   | Status trail | (businessId, number); (businessId, id)                      |
| `PaymentAttempt`            | Checkout attempt with provider reference  | Business | Yes                   | Status trail | (businessId, idempotencyKey); (provider, providerReference) |
| `PaymentWebhookEvent`       | Deduplicated provider webhook record      | Business | -                     | Status trail | (provider, providerEventId); (businessId, id)               |
| `TrialGrant`                | Single free trial per business            | Business | -                     | Append-only  | businessId                                                  |
| `UsageCounter`              | Plan limit consumption per period         | Business | Yes                   | Append-only  | (businessId, featureKey, periodStart); (businessId, id)     |
| `PaymentReconciliationTask` | Unverified payment follow-up task         | Business | -                     | Status trail | (businessId, id); attemptId                                 |

### super-admin (M1)

| Entity               | Purpose                           | Scope    | Financial / sensitive | History            | Key uniqueness              |
| -------------------- | --------------------------------- | -------- | --------------------- | ------------------ | --------------------------- |
| `PlatformSetting`    | Platform-wide configuration value | Platform | Yes                   | Mutable timestamps | key                         |
| `SupportCase`        | Super Admin support case          | Business | -                     | Status trail       | (businessId, id); reference |
| `SupportAccessGrant` | Time-bound support access grant   | Business | -                     | Status trail       | (businessId, id)            |

### audit (M1)

| Entity       | Purpose                                       | Scope             | Financial / sensitive | History     | Key uniqueness   |
| ------------ | --------------------------------------------- | ----------------- | --------------------- | ----------- | ---------------- |
| `AuditEvent` | Append-only security and business audit trail | Business + branch | Sensitive             | Append-only | (businessId, id) |

### platform infrastructure (M1)

| Entity              | Purpose                             | Scope               | Financial / sensitive | History      | Key uniqueness                                  |
| ------------------- | ----------------------------------- | ------------------- | --------------------- | ------------ | ----------------------------------------------- |
| `OutboxEvent`       | Durable side-effect dispatch record | Business / platform | -                     | Status trail | (businessId, id)                                |
| `IdempotencyRecord` | Stored API idempotency outcome      | Platform            | Sensitive             | Append-only  | (businessId, scope, key); platform (scope, key) |

### business-configuration (M2)

| Entity                  | Purpose                                  | Scope             | Financial / sensitive | History            | Key uniqueness                                       |
| ----------------------- | ---------------------------------------- | ----------------- | --------------------- | ------------------ | ---------------------------------------------------- |
| `BusinessConfiguration` | Industry profile and setup state         | Business          | Yes                   | Mutable timestamps | businessId                                           |
| `BusinessSetting`       | Business-level key/value setting         | Business          | Yes                   | Mutable timestamps | (businessId, key); (businessId, id)                  |
| `BranchSetting`         | Branch-level override setting            | Business + branch | Yes                   | Mutable timestamps | (branchId, key); (businessId, id)                    |
| `AttributeDefinition`   | Configurable product/customer attribute  | Business          | Yes                   | Archive            | (businessId, entityType, key); (businessId, id)      |
| `Unit`                  | Unit of measure and base unit link       | Business          | Yes                   | Append-only        | (businessId, code); (businessId, id)                 |
| `UnitConversion`        | Conversion factor between units          | Business          | Yes                   | Append-only        | (businessId, fromUnitId, toUnitId); (businessId, id) |
| `CapabilityFlag`        | Enabled platform capability per business | Business          | -                     | Mutable timestamps | (businessId, capability); (businessId, id)           |

### catalog (M2)

| Entity                  | Purpose                                     | Scope    | Financial / sensitive | History      | Key uniqueness                                                                    |
| ----------------------- | ------------------------------------------- | -------- | --------------------- | ------------ | --------------------------------------------------------------------------------- |
| `Brand`                 | Product brand                               | Business | -                     | Archive      | (businessId, code); (businessId, id)                                              |
| `Category`              | Hierarchical product category               | Business | -                     | Archive      | (businessId, slug); (businessId, id)                                              |
| `Product`               | Product master shared by all business types | Business | Yes                   | Archive      | (businessId, sku); (businessId, id)                                               |
| `ProductVariant`        | Sellable variant with SKU and attributes    | Business | Yes                   | Archive      | (businessId, sku); (businessId, id)                                               |
| `ProductAttributeValue` | Attribute value on product or variant       | Business | Yes                   | Append-only  | (productId, attributeDefinitionId); (variantId, attributeDefinitionId); owner XOR |
| `Barcode`               | Scannable code for a variant or product     | Business | -                     | Append-only  | (businessId, barcode); (businessId, id)                                           |
| `ProductMedia`          | Image or document attached to a product     | Business | -                     | Append-only  | (businessId, id)                                                                  |
| `ProductImportJob`      | Catalog import run and validation report    | Business | Yes                   | Status trail | (businessId, id)                                                                  |

### pricing (M2)

| Entity                | Purpose                                 | Scope             | Financial / sensitive | History            | Key uniqueness                                            |
| --------------------- | --------------------------------------- | ----------------- | --------------------- | ------------------ | --------------------------------------------------------- |
| `PriceList`           | Named price list with lifecycle         | Business          | Yes                   | Status trail       | (businessId, name); (businessId, id)                      |
| `ProductPrice`        | Effective variant price in a price list | Business          | Yes                   | Mutable timestamps | (priceListId, variantId, effectiveFrom); (businessId, id) |
| `BranchPriceOverride` | Branch-specific price override          | Business + branch | Yes                   | Mutable timestamps | (branchId, variantId, effectiveFrom); (businessId, id)    |
| `PriceChangeHistory`  | Immutable record of price changes       | Business + branch | Yes                   | Append-only        | (businessId, id)                                          |
| `Discount`            | Configurable discount definition        | Business + branch | Yes                   | Mutable timestamps | (businessId, code); (businessId, id)                      |

### files (M2)

| Entity              | Purpose                                | Scope    | Financial / sensitive | History     | Key uniqueness                                         |
| ------------------- | -------------------------------------- | -------- | --------------------- | ----------- | ------------------------------------------------------ |
| `FileObject`        | Stored file metadata and checksum      | Business | -                     | Archive     | (businessId, id); storageKey                           |
| `FileLink`          | File attachment to any business entity | Business | -                     | Append-only | (fileId, entityType, entityId, role); (businessId, id) |
| `FileUploadSession` | Short-lived direct upload session      | Business | Sensitive             | Append-only | (businessId, id); tokenHash                            |

### inventory (M3)

| Entity                       | Purpose                                                 | Scope             | Financial / sensitive | History            | Key uniqueness                                                       |
| ---------------------------- | ------------------------------------------------------- | ----------------- | --------------------- | ------------------ | -------------------------------------------------------------------- |
| `StockLocation`              | Sellable or non-sellable location in a branch           | Business + branch | -                     | Archive            | (branchId, code); (businessId, id)                                   |
| `StockBalance`               | Authoritative on-hand, reserved and in-transit quantity | Business + branch | Yes                   | Mutable timestamps | (branchId, variantId); (businessId, id)                              |
| `StockMovement`              | Append-only signed stock ledger entry                   | Business + branch | Yes                   | Append-only        | (businessId, id); (businessId, sourceKey)                            |
| `InventoryBatch`             | Batch or lot with expiry and cost                       | Business + branch | Yes                   | Status trail       | (businessId, id); (branchId, variantId, batchNumber)                 |
| `BatchMovementAllocation`    | Movement to batch quantity allocation                   | Business          | Yes                   | Append-only        | (movementId, batchId); (businessId, id)                              |
| `StocktakeSession`           | Physical count session                                  | Business + branch | -                     | Status trail       | (businessId, number); (businessId, id)                               |
| `StocktakeLine`              | Counted quantity and variance per variant/location      | Business          | Yes                   | Append-only        | (sessionId, variantId, batchId); unbatched partial; (businessId, id) |
| `InventoryAdjustment`        | Approved stock adjustment header                        | Business + branch | -                     | Status trail       | (businessId, number); (businessId, id)                               |
| `InventoryAdjustmentLine`    | Per-variant adjustment line                             | Business          | Yes                   | Append-only        | (businessId, id)                                                     |
| `StockTransfer`              | Inter-branch transfer header                            | Business          | -                     | Status trail       | (businessId, number); (businessId, id); distinct branches            |
| `StockTransferLine`          | Requested and dispatched transfer quantity              | Business          | Yes                   | Append-only        | (transferId, variantId); (businessId, id)                            |
| `TransferReceipt`            | Destination receiving of a transfer                     | Business + branch | -                     | Append-only        | (businessId, number); (businessId, id)                               |
| `TransferReceiptLine`        | Accepted/rejected transfer quantity per line            | Business          | Yes                   | Append-only        | (receiptId, transferLineId); (businessId, id)                        |
| `InventoryAlert`             | Low, out-of-stock or expiry alert                       | Business + branch | Yes                   | Status trail       | (businessId, id)                                                     |
| `StockReservation`           | Quantity reserved for a sale or exchange                | Business + branch | Yes                   | Status trail       | (sourceType, sourceId, variantId); (businessId, id)                  |
| `MinStockSetting`            | Minimum stock threshold per branch/variant              | Business + branch | Yes                   | Mutable timestamps | (branchId, variantId); (businessId, id)                              |
| `StockLossRecord`            | Damage, expiry or wastage record                        | Business + branch | Yes                   | Status trail       | (businessId, number); (businessId, id)                               |
| `InventoryValuationSnapshot` | Daily WAC valuation history                             | Business + branch | Yes                   | Append-only        | (branchId, variantId, asOfDate); (businessId, id)                    |

### suppliers (M3)

| Entity                        | Purpose                                  | Scope    | Financial / sensitive | History            | Key uniqueness                                         |
| ----------------------------- | ---------------------------------------- | -------- | --------------------- | ------------------ | ------------------------------------------------------ |
| `Supplier`                    | Supplier master record                   | Business | Yes, Sensitive        | Archive            | (businessId, code); (businessId, id)                   |
| `SupplierContact`             | Supplier contact person                  | Business | Sensitive             | Append-only        | (businessId, id)                                       |
| `SupplierDocument`            | Supplier contract or certificate         | Business | -                     | Append-only        | (supplierId, fileId, type); (businessId, id)           |
| `SupplierProduct`             | Supplier-specific product code and terms | Business | Yes                   | Mutable timestamps | (supplierId, variantId); (businessId, id)              |
| `SupplierPriceHistory`        | Historical supplier price points         | Business | Yes                   | Append-only        | (businessId, id)                                       |
| `SupplierPricingAgreement`    | Versioned supplier pricing agreement     | Business | -                     | Status trail       | (businessId, reference); (businessId, id)              |
| `SupplierAgreementLine`       | Agreement term per variant               | Business | Yes                   | Append-only        | (agreementId, variantId); (businessId, id)             |
| `SupplierRating`              | Supplier performance rating              | Business | Yes                   | Append-only        | (supplierId, periodStart, periodEnd); (businessId, id) |
| `SupplierDispute`             | Supplier dispute and resolution          | Business | Yes                   | Status trail       | (businessId, reference); (businessId, id)              |
| `SupplierStatement`           | Supplier account statement               | Business | Yes                   | Append-only        | (supplierId, periodStart, periodEnd); (businessId, id) |
| `SupplierPerformanceSnapshot` | Period supplier performance history      | Business | Yes                   | Append-only        | (supplierId, periodStart, periodEnd); (businessId, id) |

### procurement (M3)

| Entity                  | Purpose                                          | Scope             | Financial / sensitive | History      | Key uniqueness                                                                                           |
| ----------------------- | ------------------------------------------------ | ----------------- | --------------------- | ------------ | -------------------------------------------------------------------------------------------------------- |
| `PurchaseRequest`       | Internal purchase request header                 | Business + branch | -                     | Status trail | (businessId, number); (businessId, id)                                                                   |
| `PurchaseRequestLine`   | Requested variant and quantity                   | Business          | Yes                   | Append-only  | (businessId, id)                                                                                         |
| `Rfq`                   | Request for quotation header                     | Business + branch | -                     | Status trail | (businessId, number); (businessId, id)                                                                   |
| `RfqVersion`            | Issued RFQ version                               | Business          | -                     | Append-only  | (rfqId, versionNumber); (businessId, id)                                                                 |
| `RfqLine`               | RFQ line per variant                             | Business          | Yes                   | Append-only  | (businessId, id)                                                                                         |
| `SupplierQuotation`     | Supplier quote revision against an RFQ           | Business          | Yes                   | Status trail | (rfqVersionId, supplierId, revision); (businessId, id)                                                   |
| `QuotationLine`         | Quoted price and lead time per variant           | Business          | Yes                   | Append-only  | (businessId, id)                                                                                         |
| `QuotationComparison`   | Comparison result across quotations              | Business          | -                     | Append-only  | (businessId, id)                                                                                         |
| `NegotiationRecord`     | Negotiation event and evidence                   | Business          | -                     | Append-only  | (businessId, id)                                                                                         |
| `PurchaseOrder`         | Purchase order header                            | Business + branch | Yes                   | Status trail | (businessId, number); (businessId, id); (businessId, id, branchId)                                       |
| `PurchaseOrderRevision` | Immutable snapshot of a PO revision              | Business          | -                     | Append-only  | (purchaseOrderId, revisionNumber); (businessId, id)                                                      |
| `PurchaseOrderLine`     | Ordered variant quantity and price               | Business          | Yes                   | Append-only  | (purchaseOrderId, variantId, revisionNumber); (businessId, id)                                           |
| `PurchaseOrderApproval` | Approval decision on a PO                        | Business          | -                     | Append-only  | (businessId, id)                                                                                         |
| `SupplierConfirmation`  | Supplier confirmation; never increases stock     | Business          | -                     | Append-only  | (businessId, id)                                                                                         |
| `GoodsReceipt`          | Physical receiving header                        | Business + branch | -                     | Status trail | (businessId, number); (businessId, id); branch = PO destination (composite FK)                           |
| `GoodsReceiptLine`      | Accepted, rejected and damaged received quantity | Business          | Yes                   | Append-only  | (receiptId, purchaseOrderLineId, batchNumber); unbatched partial; (businessId, id)                       |
| `SupplierInvoice`       | Supplier invoice header                          | Business          | Yes                   | Status trail | (businessId, number); (businessId, supplierInvoiceNumber); (businessId, supplierId, id, purchaseOrderId) |
| `SupplierInvoiceLine`   | Invoice line matched to receipt or PO line       | Business          | Yes                   | Append-only  | (supplierInvoiceId, purchaseOrderLineId); PO-bound composite FKs; (businessId, id)                       |
| `SupplierPayment`       | Payment to a supplier                            | Business          | Yes                   | Status trail | (businessId, number); (businessId, id)                                                                   |
| `PaymentAllocation`     | Allocation of a payment to invoices              | Business          | Yes                   | Append-only  | (supplierPaymentId, supplierInvoiceId); (businessId, id)                                                 |

### customers (M4)

| Entity                    | Purpose                                 | Scope    | Financial / sensitive | History            | Key uniqueness                              |
| ------------------------- | --------------------------------------- | -------- | --------------------- | ------------------ | ------------------------------------------- |
| `Customer`                | Customer master and merge state         | Business | Sensitive             | Archive            | (businessId, code); (businessId, id)        |
| `CustomerContact`         | Customer phone, email or address        | Business | Yes                   | Append-only        | (customerId, type, value); (businessId, id) |
| `CustomerConsent`         | Channel consent and timestamp           | Business | -                     | Append-only        | (businessId, id)                            |
| `CustomerMergeRequest`    | Request to merge duplicate customers    | Business | -                     | Status trail       | (businessId, id)                            |
| `CustomerBusinessSummary` | Aggregated purchase and payment summary | Business | Yes                   | Mutable timestamps | (businessId, id); (businessId, customerId)  |

### synchronization (M4)

| Entity                        | Purpose                                           | Scope              | Financial / sensitive | History            | Key uniqueness                                    |
| ----------------------------- | ------------------------------------------------- | ------------------ | --------------------- | ------------------ | ------------------------------------------------- |
| `Device`                      | Enrolled desktop device and credential            | Business + branch  | Sensitive             | Status trail       | (businessId, id); (businessId, deviceFingerprint) |
| `SyncSession`                 | One sync batch from a device                      | Business + branch  | -                     | Status trail       | (businessId, id)                                  |
| `SyncOperation`               | Idempotent offline operation envelope             | Business + branch  | Sensitive             | Status trail       | (businessId, id); (businessId, saleId)            |
| `SyncAttempt`                 | Per-attempt sync outcome history                  | Business (derived) | -                     | Append-only        | (syncOperationId, attemptNumber)                  |
| `ReconciliationException`     | Server-side D-025 stock shortfall record          | Business + branch  | Yes, Sensitive        | Status trail       | (businessId, id); syncOperationId                 |
| `ReconciliationShortfallLine` | Original shortfall quantity per variant           | Business           | Yes                   | Append-only        | (businessId, id)                                  |
| `ReconciliationEvent`         | Append-only reconciliation resolution history     | Business           | -                     | Append-only        | (businessId, id)                                  |
| `ConflictRecord`              | Non-stock sync conflict needing resolution        | Business + branch  | -                     | Status trail       | (businessId, id)                                  |
| `SyncCursor`                  | Last delivered feed position per device           | Business (derived) | -                     | Mutable timestamps | (deviceId, feedType)                              |
| `FeedEvent`                   | Ordered configuration, price and stock feed event | Business + branch  | -                     | Append-only        | (businessId, id)                                  |

### sales (M4)

| Entity                    | Purpose                                     | Scope             | Financial / sensitive | History      | Key uniqueness                                                 |
| ------------------------- | ------------------------------------------- | ----------------- | --------------------- | ------------ | -------------------------------------------------------------- |
| `PosTerminal`             | POS terminal inside a branch                | Business + branch | -                     | Archive      | (branchId, code); (businessId, branchId, id); (businessId, id) |
| `CashierShift`            | Cashier shift with opening and closing cash | Business + branch | Yes                   | Status trail | (businessId, branchId, id); (businessId, id)                   |
| `ShiftCashMovement`       | Cash in/out during a shift                  | Business          | Yes                   | Append-only  | (businessId, id)                                               |
| `Sale`                    | Sale header with immutable financial totals | Business + branch | Yes                   | Status trail | (businessId, id); (businessId, receiptNumber)                  |
| `SaleLine`                | Sale line with price and cost snapshots     | Business          | Yes                   | Append-only  | (businessId, id)                                               |
| `SalePayment`             | Payment or split-payment row                | Business          | Yes                   | Status trail | (businessId, id)                                               |
| `SaleDiscount`            | Discount applied to a sale or line          | Business          | Yes                   | Append-only  | (businessId, id)                                               |
| `SaleVoid`                | Void record preserving the original sale    | Business          | -                     | Append-only  | (businessId, id); (businessId, saleId)                         |
| `Receipt`                 | Canonical receipt metadata and file link    | Business          | -                     | Append-only  | (businessId, saleId); (businessId, id)                         |
| `ReceiptBlock`            | Offline receipt-number block for a device   | Business + branch | -                     | Status trail | (deviceId, prefix, startNumber); (businessId, id)              |
| `SaleCustomerAssociation` | Later association of a customer to a sale   | Business          | -                     | Append-only  | (saleId, customerId); (businessId, id)                         |

### after-sales (M4)

| Entity                | Purpose                                  | Scope             | Financial / sensitive | History      | Key uniqueness                              |
| --------------------- | ---------------------------------------- | ----------------- | --------------------- | ------------ | ------------------------------------------- |
| `ReturnRequest`       | Customer return request header           | Business + branch | -                     | Status trail | (businessId, number); (businessId, id)      |
| `ReturnLine`          | Returned sale line and approved quantity | Business          | Yes                   | Append-only  | (returnId, saleLineId); (businessId, id)    |
| `ReturnInspection`    | Physical inspection outcome              | Business          | -                     | Append-only  | (businessId, id); (businessId, returnId)    |
| `Refund`              | Refund header with idempotency key       | Business + branch | Yes                   | Status trail | (businessId, number); (businessId, id)      |
| `RefundAllocation`    | Refund split by payment method           | Business          | Yes                   | Append-only  | (refundId, salePaymentId); (businessId, id) |
| `Exchange`            | Exchange header linked to original sale  | Business + branch | Yes                   | Status trail | (businessId, number); (businessId, id)      |
| `ExchangeLine`        | Outgoing or incoming exchange item       | Business          | Yes                   | Append-only  | (businessId, id)                            |
| `ExchangeReservation` | Temporary stock hold for an exchange     | Business          | Yes                   | Status trail | (exchangeId, variantId); (businessId, id)   |
| `CollectionFollowUp`  | Post-sale customer follow-up task        | Business + branch | -                     | Status trail | (businessId, id)                            |

### notifications (M4)

| Entity                   | Purpose                                     | Scope             | Financial / sensitive | History            | Key uniqueness                                                 |
| ------------------------ | ------------------------------------------- | ----------------- | --------------------- | ------------------ | -------------------------------------------------------------- |
| `NotificationTemplate`   | Versioned notification template             | Business          | -                     | Append-only        | (businessId, code, channel, locale, version); (businessId, id) |
| `Notification`           | Recipient notification and read state       | Business + branch | -                     | Status trail       | (businessId, dedupeKey); (businessId, id)                      |
| `NotificationDelivery`   | Per-channel delivery attempt state          | Business          | -                     | Status trail       | (notificationId, channel); (businessId, id)                    |
| `NotificationPreference` | Per-user channel preference                 | Platform          | -                     | Mutable timestamps | (userId, channel, category)                                    |
| `NotificationEscalation` | Escalation trail for critical notifications | Business          | -                     | Status trail       | (notificationId, level); (businessId, id)                      |

### analytics (M4)

| Entity                    | Purpose                               | Scope             | Financial / sensitive | History            | Key uniqueness                                         |
| ------------------------- | ------------------------------------- | ----------------- | --------------------- | ------------------ | ------------------------------------------------------ |
| `ReportDefinition`        | Server-defined report catalogue entry | Business          | -                     | Mutable timestamps | (businessId, code); (businessId, id)                   |
| `ExportJob`               | Asynchronous export job and artefact  | Business + branch | Sensitive             | Status trail       | (businessId, id)                                       |
| `SalesDailyFact`          | Daily branch sales aggregate          | Business + branch | Yes                   | Append-only        | (branchId, businessDate); (businessId, id)             |
| `ProductSalesDailyFact`   | Daily variant sales aggregate         | Business + branch | Yes                   | Append-only        | (branchId, variantId, businessDate); (businessId, id)  |
| `InventoryDailyFact`      | Daily branch/variant stock aggregate  | Business + branch | Yes                   | Append-only        | (branchId, variantId, businessDate); (businessId, id)  |
| `StockoutEvent`           | Stockout interval history             | Business + branch | Yes                   | Append-only        | (businessId, id)                                       |
| `ExpiryRiskFact`          | Daily expiry-risk analysis row        | Business + branch | Yes                   | Append-only        | (businessId, id)                                       |
| `SupplierPerformanceFact` | Period supplier performance metrics   | Business          | Yes                   | Append-only        | (supplierId, periodStart, periodEnd); (businessId, id) |

### intelligence (M4)

| Entity            | Purpose                                     | Scope              | Financial / sensitive | History      | Key uniqueness             |
| ----------------- | ------------------------------------------- | ------------------ | --------------------- | ------------ | -------------------------- |
| `ForecastModel`   | Versioned platform forecast model           | Platform           | -                     | Status trail | (name, version)            |
| `ForecastRun`     | Forecast execution with input snapshot      | Business + branch  | Yes                   | Status trail | (businessId, id)           |
| `ForecastPoint`   | Forecast value and confidence interval      | Business (derived) | Yes                   | Append-only  | (forecastRunId, pointDate) |
| `Recommendation`  | Advisory proposal awaiting human decision   | Business + branch  | -                     | Status trail | (businessId, id)           |
| `FeatureSnapshot` | Feature vector snapshot for reproducibility | Business           | -                     | Append-only  | (businessId, id)           |
| `ModelMetric`     | Append-only model quality measurement       | Business           | Yes                   | Append-only  | (businessId, id)           |

## 4. Coverage checks

- **All 21 modules:** identity, tenancy, authorization, employees, subscriptions, super-admin,
  audit, business-configuration, catalog, pricing, files, inventory, suppliers, procurement,
  customers, sales, after-sales, analytics, intelligence, synchronization, notifications.
- **All four business types:** one shared catalog and inventory model; grocery units/batches,
  fashion size/color variants, pharmacy batch/expiry/quarantine and cosmetics shade/size variants
  are attribute, batch and configuration records, not separate product tables.
- **Roles:** Owner and membership roles are per business; Business Admin holds digital permissions
  only (`Permission.isPhysical = false` on its grants); Manager/Owner hold physical operations;
  Super Admin is platform-level and has no business membership row.
- **Offline:** every offline sale reaches the server through `SyncOperation`; conflicts and
  shortfalls create `ReconciliationException` rows, never an accepted sale with negative stock.
- **History:** sale originals are never overwritten; void, return, refund and exchange are separate
  records. PO revisions, price history, supplier price history, valuation snapshots and audit
  events are append-only or status-versioned.

## 5. Deliberate exclusions

- No tax engine, e-invoicing or Ethiopian regulatory tables: approved requirements define no tax
  rules. Sale totals carry explicit money columns only.
- No clinical/pharmacy prescribing data: the platform does not perform diagnosis or prescribing.
- No executable AI: `Recommendation` stores a proposal and human decision fields only.
- No local SQLite schema here: the desktop database is a separate, later deliverable (D-022).
