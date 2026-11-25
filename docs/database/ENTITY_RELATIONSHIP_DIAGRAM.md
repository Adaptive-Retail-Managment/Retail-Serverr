# Entity relationship diagrams

**Status:** Step 3 baseline. Diagrams are derived from the canonical
[Prisma schema](../../apps/api/prisma/schema.prisma); when they disagree, the schema and
migrations win and the diagram is a defect.

The overall platform overview is in [Conceptual data model](CONCEPTUAL_DATA_MODEL.md). This page
holds the domain ERDs: identity and tenancy, configuration and catalog, inventory and batches,
suppliers and procurement, POS and sales, and returns and exchanges.

## 1. Identity and tenancy

```mermaid
erDiagram
    User ||--o| UserCredential : has
    User ||--o{ UserSession : opens
    User ||--o{ EmailVerificationToken : verifies
    User ||--o{ PasswordResetToken : resets
    User ||--o{ Membership : joins
    Business ||--o{ Membership : contains
    Business ||--o{ Branch : operates
    Business ||--o| Membership : owned_by
    Business ||--o{ Invitation : invites
    Business ||--o{ Role : defines
    Role ||--o{ RolePermission : includes
    Permission ||--o{ RolePermission : granted_as
    Membership ||--o{ MembershipBranchAssignment : scoped_to
    Branch ||--o{ MembershipBranchAssignment : grants
    Employee }o--|| Business : employed_by
    Employee ||--o{ EmployeeBranchAssignment : posted_to
    Branch ||--o{ EmployeeBranchAssignment : hosts
    Employee ||--o{ EmploymentStatusHistory : transitions

    User {
        uuid id PK
        string email UK
        string phone UK
        string status
    }
    Business {
        uuid id PK
        string slug UK
        string type
        string defaultCurrency
        uuid ownerMembershipId FK
    }
    Branch {
        uuid id PK
        uuid businessId FK
        string code
        boolean isActive
    }
    Membership {
        uuid id PK
        uuid businessId FK
        uuid userId FK
        uuid roleId FK
        boolean isOwner
        int authorizationVersion
    }
    Permission {
        uuid id PK
        string code UK
        boolean isPhysical
    }
    Role {
        uuid id PK
        uuid businessId FK
        string code
        boolean isSystem
    }
    Employee {
        uuid id PK
        uuid businessId FK
        uuid userId FK
        string employeeCode
        string status
    }
```

Rules:

- `Membership` is unique per `(businessId, userId)`; a user can hold different roles in different
  businesses.
- `Business.ownerMembershipId` is unique and nullable only during creation; a business has one
  official Owner.
- `Permission.isPhysical` distinguishes physical operational permissions from digital ones. The
  seed grants physical stock operations to Owner/Manager roles, never to Business Admin.
- Super Admin has no `Membership` row; platform authority lives in the same `User` identity with a
  platform-level authorization scope.

## 2. Business configuration and catalog

```mermaid
erDiagram
    Business ||--o| BusinessConfiguration : configures
    Business ||--o{ BusinessSetting : settings
    Branch ||--o{ BranchSetting : overrides
    Business ||--o{ AttributeDefinition : defines
    Business ||--o{ Unit : defines
    Unit ||--o{ UnitConversion : converts
    Business ||--o{ CapabilityFlag : enables
    Business ||--o{ Brand : owns
    Business ||--o{ Category : owns
    Category ||--o{ Category : parent_of
    Product ||--o{ ProductVariant : sells_as
    Business ||--o{ Product : owns
    Brand ||--o{ Product : brands
    Category ||--o{ Product : groups
    ProductVariant ||--o{ ProductAttributeValue : valued_by
    AttributeDefinition ||--o{ ProductAttributeValue : defines
    ProductVariant ||--o{ Barcode : identified_by
    ProductVariant ||--o{ ProductMedia : illustrated_by
    Product ||--o{ ProductImportJob : imported_in
    Business ||--o{ PriceList : prices
    PriceList ||--o{ ProductPrice : contains
    ProductVariant ||--o{ ProductPrice : priced
    ProductVariant ||--o{ BranchPriceOverride : overridden
    Branch ||--o{ BranchPriceOverride : applies
    ProductVariant ||--o{ PriceChangeHistory : changed
    Business ||--o{ Discount : offers
    Business ||--o{ FileObject : stores
    FileObject ||--o{ FileLink : linked_as

    Product {
        uuid id PK
        uuid businessId FK
        string sku UK
        string type
        string status
    }
    ProductVariant {
        uuid id PK
        uuid businessId FK
        uuid productId FK
        string sku UK
        string size
        string color
        string shade
    }
    PriceList {
        uuid id PK
        uuid businessId FK
        string name UK
        string status
    }
    ProductPrice {
        uuid id PK
        uuid priceListId FK
        uuid variantId FK
        decimal amount
        string currency
        timestamptz effectiveFrom
    }
    AttributeDefinition {
        uuid id PK
        uuid businessId FK
        string entityType
        string key
        string dataType
    }
```

Industry support:

- **Grocery:** `Unit`, `UnitConversion`, `InventoryBatch.expiryDate`, `MinStockSetting`,
  `StockLossRecord`.
- **Fashion:** variant `size` and `color`; variant-level stock and sales.
- **Pharmacy:** variant `shade` unused; batch number, expiry and quarantine status are mandatory
  where the pharmacy configuration enables them.
- **Cosmetics:** variant `shade`, `color`, `size`; batch/expiry where applicable.

One product model serves all four. No per-industry product table exists.

## 3. Inventory, batches and valuation

```mermaid
erDiagram
    Branch ||--o{ StockLocation : contains
    Branch ||--o{ StockBalance : holds
    ProductVariant ||--o{ StockBalance : counted
    Branch ||--o{ StockMovement : records
    ProductVariant ||--o{ StockMovement : moves
    InventoryBatch ||--o{ StockMovement : sources
    InventoryBatch ||--o{ BatchMovementAllocation : allocated_by
    StockMovement ||--o{ BatchMovementAllocation : consumes
    Branch ||--o{ StocktakeSession : counts
    StocktakeSession ||--o{ StocktakeLine : lines
    InventoryAdjustment ||--o{ InventoryAdjustmentLine : lines
    StocktakeSession ||--o| InventoryAdjustment : produces
    Branch ||--o{ StockTransfer : sends
    Branch ||--o{ StockTransfer : receives
    StockTransfer ||--o{ StockTransferLine : lines
    StockTransfer ||--o| TransferReceipt : received_as
    TransferReceipt ||--o{ TransferReceiptLine : lines
    Branch ||--o{ InventoryAlert : alerts
    StockReservation }o--|| ProductVariant : reserves
    Branch ||--o{ MinStockSetting : configures
    Branch ||--o{ StockLossRecord : loses
    Branch ||--o{ InventoryValuationSnapshot : valued_on

    StockBalance {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid variantId FK
        decimal quantityOnHand
        decimal quantityReserved
        decimal quantityInTransit
        int version
    }
    StockMovement {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid variantId FK
        uuid batchId FK
        string type
        decimal quantityDelta
        string referenceType
        uuid referenceId
        string sourceKey
        timestamptz occurredAt
    }
    InventoryBatch {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid variantId FK
        string batchNumber
        date expiryDate
        string status
        decimal unitCost
    }
    InventoryValuationSnapshot {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid variantId FK
        date asOfDate
        decimal quantity
        decimal unitCost
        decimal totalValue
        string method
    }
```

`StockBalance` is the only authoritative quantity. `StockMovement` is append-only and signed;
`quantityDelta` may be negative, while the resulting **available** balance may not. In-transit is
reported separately and is not available for sale. `InventoryValuationSnapshot` records WAC
history; it never rewrites past costs.

## 4. Suppliers and procurement

```mermaid
erDiagram
    Business ||--o{ Supplier : registers
    Supplier ||--o{ SupplierContact : contacts
    Supplier ||--o{ SupplierDocument : documents
    Supplier ||--o{ SupplierProduct : supplies
    ProductVariant ||--o{ SupplierProduct : supplied_as
    Supplier ||--o{ SupplierPriceHistory : quotes
    Supplier ||--o{ SupplierPricingAgreement : agrees
    SupplierPricingAgreement ||--o{ SupplierAgreementLine : terms
    Supplier ||--o{ SupplierRating : rated
    Supplier ||--o{ SupplierDispute : disputes
    Supplier ||--o{ SupplierStatement : statements
    Supplier ||--o{ SupplierPerformanceSnapshot : performance
    Branch ||--o{ PurchaseRequest : requests
    PurchaseRequest ||--o{ PurchaseRequestLine : lines
    Rfq ||--o{ RfqVersion : versions
    RfqVersion ||--o{ RfqLine : lines
    RfqVersion ||--o{ SupplierQuotation : quotes
    SupplierQuotation ||--o{ QuotationLine : lines
    RfqVersion ||--o| QuotationComparison : compared
    RfqVersion ||--o{ NegotiationRecord : negotiates
    Supplier ||--o{ PurchaseOrder : receives
    PurchaseOrder ||--o{ PurchaseOrderRevision : revised
    PurchaseOrder ||--o{ PurchaseOrderLine : lines
    PurchaseOrder ||--o{ PurchaseOrderApproval : approved
    PurchaseOrder ||--o| SupplierConfirmation : confirmed
    PurchaseOrder ||--o{ GoodsReceipt : receipts
    GoodsReceipt ||--o{ GoodsReceiptLine : lines
    Supplier ||--o{ SupplierInvoice : invoices
    SupplierInvoice ||--o{ SupplierInvoiceLine : lines
    Supplier ||--o{ SupplierPayment : paid
    SupplierPayment ||--o{ PaymentAllocation : allocates

    PurchaseOrder {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid supplierId FK
        string number UK
        string status
        decimal total
        string currency
    }
    GoodsReceipt {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid purchaseOrderId FK
        string number UK
        string status
        timestamptz receivedAt
    }
    GoodsReceiptLine {
        uuid id PK
        uuid receiptId FK
        uuid purchaseOrderLineId FK
        uuid variantId FK
        decimal receivedQuantity
        decimal acceptedQuantity
        decimal rejectedQuantity
        decimal damagedQuantity
    }
    SupplierConfirmation {
        uuid id PK
        uuid purchaseOrderId FK
        timestamptz confirmedAt
    }
```

The critical procurement rule is structural: a confirmation or approval row has no relation to
`StockMovement`. Only an accepted `GoodsReceiptLine` can produce a stock movement and batch.
`GoodsReceipt.branchId` is bound to `PurchaseOrder.branchId` by a composite foreign key
`(businessId, purchaseOrderId, branchId)` → `PurchaseOrder(businessId, id, branchId)` (approved
U-1 rule): every receipt, partial or full, must use the PO's current destination branch. The
relation declares `onUpdate: NoAction`, so a PO destination change after the first receipt is
rejected by the database and existing `GoodsReceipt.branchId` values are never cascaded or
rewritten.

## 5. POS and sales

```mermaid
erDiagram
    Branch ||--o{ PosTerminal : hosts
    Device }o--|| Business : enrolled_to
    Device ||--o{ ReceiptBlock : allocates
    PosTerminal ||--o{ CashierShift : runs
    Membership ||--o{ CashierShift : operates
    CashierShift ||--o{ ShiftCashMovement : moves_cash
    Branch ||--o{ Sale : sells
    CashierShift ||--o{ Sale : includes
    Membership ||--o{ Sale : rings
    Sale ||--o{ SaleLine : lines
    ProductVariant ||--o{ SaleLine : sold_as
    Sale ||--o{ SalePayment : paid_by
    Sale ||--o{ SaleDiscount : discounted
    Sale ||--o| SaleVoid : voided_by
    Sale ||--o| Receipt : receipt_for
    Sale ||--o{ SaleCustomerAssociation : later_linked
    Customer ||--o{ SaleCustomerAssociation : associated

    Sale {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid terminalId FK
        string receiptNumber UK
        string status
        string origin
        decimal subtotal
        decimal discountTotal
        decimal total
        string currency
        uuid offlineDeviceId FK
        uuid operationId
    }
    SaleLine {
        uuid id PK
        uuid saleId FK
        uuid variantId FK
        decimal quantity
        decimal unitPrice
        decimal lineTotal
        string productNameSnapshot
        string skuSnapshot
    }
    SalePayment {
        uuid id PK
        uuid saleId FK
        string method
        decimal amount
        string currency
        string status
        string reference
    }
    Receipt {
        uuid id PK
        uuid saleId UK
        string receiptNumber
        string templateVersion
        uuid fileId FK
    }
    SaleVoid {
        uuid id PK
        uuid saleId UK
        string reason
        timestamptz voidedAt
    }
```

Sales keep price, name and cost snapshots, so later catalog or price changes cannot rewrite
history. `SaleVoid`, `ReturnRequest`, `Refund` and `Exchange` are separate records.

## 6. Returns, refunds and exchanges

```mermaid
erDiagram
    Sale ||--o{ ReturnRequest : returned
    Branch ||--o{ ReturnRequest : processes
    ReturnRequest ||--o{ ReturnLine : lines
    SaleLine ||--o{ ReturnLine : references
    ReturnRequest ||--o| ReturnInspection : inspected
    ReturnRequest ||--o{ Refund : refunded
    Refund ||--o{ RefundAllocation : allocated
    Sale ||--o{ Refund : compensates
    Sale ||--o{ Exchange : exchanged
    Exchange ||--o{ ExchangeLine : lines
    Exchange ||--o{ ExchangeReservation : reserves
    ProductVariant ||--o{ ExchangeReservation : held
    Customer ||--o{ CollectionFollowUp : followed_up
    Sale ||--o{ CollectionFollowUp : concerns
    ReturnRequest ||--o{ CollectionFollowUp : concerns

    ReturnRequest {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        uuid saleId FK
        string number UK
        string status
    }
    ReturnLine {
        uuid id PK
        uuid returnId FK
        uuid saleLineId FK
        decimal quantityRequested
        decimal quantityApproved
        string inspectionResult
        decimal restockQuantity
    }
    Refund {
        uuid id PK
        uuid businessId FK
        uuid saleId FK
        uuid returnId FK
        string number UK
        decimal amount
        string currency
        string status
        string idempotencyKey
    }
    Exchange {
        uuid id PK
        uuid businessId FK
        uuid saleId FK
        string status
        decimal priceDifference
        string currency
    }
    ExchangeReservation {
        uuid id PK
        uuid exchangeId FK
        uuid variantId FK
        decimal quantity
        string status
    }
```

Refunds cannot exceed the paid amount; that is an application rule backed by stored payment and
refund rows. Restocking on an approved return creates a normal inventory movement. The original
sale is never mutated.

## 7. Rendering and maintenance

All diagrams use Mermaid `erDiagram` syntax and are validated with Mermaid 11. When an entity or
relation changes, update the schema, migration, this page and the
[entity catalog](DATABASE_REQUIREMENTS_AND_ENTITY_CATALOG.md) in the same pull request.
