# Conceptual data model

**Status:** Step 3 baseline. One platform, one shared database.
**Schema:** [`apps/api/prisma/schema.prisma`](../../apps/api/prisma/schema.prisma).
**Related:** [Entity catalog](DATABASE_REQUIREMENTS_AND_ENTITY_CATALOG.md),
[ER diagrams](ENTITY_RELATIONSHIP_DIAGRAM.md), [Multi-tenant design](MULTI_TENANT_DATABASE_DESIGN.md).

## 1. Modelling approach

The platform is a shared-schema, multi-tenant modular monolith. A single PostgreSQL 17 database
holds all modules, all four business types and all tenants. Tenant ownership is a column, not a
separate database.

Four conceptual layers:

1. **Platform layer** — users, plans, platform settings, support grants, audit and outbox. Not
   owned by any business.
2. **Tenant layer** — business, branches, memberships, roles and configuration. Every operational
   row hangs from this layer.
3. **Operational layer** — catalog, pricing, inventory, procurement, sales, after-sales,
   synchronization and notifications.
4. **Analytical layer** — fact tables, forecasts, recommendations and model metrics. Derived from
   operational history; never authoritative for stock, price or money.

A business membership is the unit of authorization, not a user account. One account can be an
Owner in one business and a Cashier in another; each membership has its own role and branch
assignments. Super Admin is a platform-level role and has no business membership.

## 2. Core entity groups

| Group           | Representative entities                                              | Nature                           |
| --------------- | -------------------------------------------------------------------- | -------------------------------- |
| Identity        | User, UserCredential, UserSession, tokens                            | Global, security-sensitive       |
| Tenancy         | Business, Branch, Membership, Invitation, Role, Permission           | Tenant root, authorization       |
| Employment      | Employee, EmployeeBranchAssignment, EmploymentStatusHistory          | Organizational, historical       |
| Subscription    | Plan, PlanFeature, PlanPrice, Subscription, PaymentAttempt, webhooks | SaaS, financial                  |
| Configuration   | BusinessConfiguration, settings, AttributeDefinition, Unit           | Tenant-defined definitions       |
| Catalog         | Product, ProductVariant, Brand, Category, Barcode, Media             | Shared across business types     |
| Pricing         | PriceList, ProductPrice, BranchPriceOverride, PriceChangeHistory     | Effective-price history          |
| Inventory       | StockBalance, StockMovement, InventoryBatch, stocktakes, transfers   | Branch stock, append-only ledger |
| Procurement     | Supplier, SupplierPricingAgreement, Rfq, PurchaseOrder, GoodsReceipt | Order-to-receipt history         |
| Sales           | PosTerminal, CashierShift, Sale, SaleLine, SalePayment, Receipt      | Financial, immutable originals   |
| After-sales     | ReturnRequest, ReturnInspection, Refund, Exchange                    | Compensating records             |
| Synchronization | Device, SyncOperation, ReconciliationException, ConflictRecord       | Offline idempotency and D-025    |
| Notifications   | Notification, NotificationDelivery, preferences                      | Delivery side effects            |
| Analytics       | Daily fact tables, StockoutEvent, ExpiryRiskFact                     | Derived read models              |
| Intelligence    | ForecastModel, ForecastRun, ForecastPoint, Recommendation            | Advisory only                    |

## 3. Overall platform ERD

```mermaid
erDiagram
    User ||--o{ Membership : holds
    User ||--o{ UserSession : authenticates
    User ||--o| UserCredential : has
    Business ||--o{ Branch : operates
    Business ||--o{ Membership : contains
    Business ||--o{ Role : defines
    Business ||--o| BusinessConfiguration : configures
    Business ||--o| Subscription : subscribes
    Business ||--o{ Product : owns
    Business ||--o{ Supplier : buys_from
    Business ||--o{ Customer : serves
    Business ||--o{ Device : enrolls
    Business ||--o{ Notification : sends
    Role ||--o{ RolePermission : grants
    Permission ||--o{ RolePermission : in
    Branch ||--o{ MembershipBranchAssignment : assigned
    Membership ||--o{ MembershipBranchAssignment : accesses
    Employee }o--|| Business : works_for
    Product ||--o{ ProductVariant : has
    ProductVariant ||--o{ StockBalance : stocked_as
    Branch ||--o{ StockBalance : holds
    ProductVariant ||--o{ StockMovement : moves
    ProductVariant ||--o{ InventoryBatch : batched_as
    Supplier ||--o{ PurchaseOrder : receives
    PurchaseOrder ||--o{ GoodsReceipt : received_by
    GoodsReceipt ||--o{ InventoryBatch : creates
    Branch ||--o{ Sale : sells
    Sale ||--o{ SaleLine : contains
    Sale ||--o{ SalePayment : paid_by
    Sale ||--o| Receipt : issues
    Sale ||--o{ ReturnRequest : returned_in
    Sale ||--o{ Exchange : exchanged_in
    Customer ||--o{ Sale : optionally_buys
    Device ||--o{ SyncOperation : submits
    SyncOperation ||--o| Sale : originates
    SyncOperation ||--o| ReconciliationException : conflicts
    ForecastRun ||--o{ ForecastPoint : produces
    ForecastRun ||--o{ Recommendation : informs
    Business ||--o{ AuditEvent : audited_by
```

The diagram is a relationship overview. Every entity and its scope is listed in the
[entity catalog](DATABASE_REQUIREMENTS_AND_ENTITY_CATALOG.md); domain diagrams are in
[ER diagrams](ENTITY_RELATIONSHIP_DIAGRAM.md).

## 4. Audit and notification data

```mermaid
erDiagram
    Business ||--o{ AuditEvent : scopes
    Branch ||--o{ AuditEvent : locates
    User ||--o{ Notification : receives
    Business ||--o{ Notification : owns
    NotificationTemplate ||--o{ Notification : renders
    Notification ||--o{ NotificationDelivery : attempts
    Notification ||--o{ NotificationEscalation : escalates
    User ||--o{ NotificationPreference : prefers
    Business ||--o{ OutboxEvent : queues
    OutboxEvent ||--o| NotificationDelivery : triggers

    AuditEvent {
        uuid id PK
        uuid businessId FK
        uuid branchId FK
        string actorType
        uuid actorUserId
        string action
        string targetType
        uuid targetId
        string outcome
        json before
        json after
        timestamptz occurredAt
    }
    Notification {
        uuid id PK
        uuid businessId FK
        uuid recipientUserId FK
        string channel
        string severity
        string status
        string dedupeKey
        timestamptz readAt
    }
    NotificationDelivery {
        uuid id PK
        uuid notificationId FK
        string channel
        string status
        int attemptCount
        string lastError
    }
```

Audit events are append-only. A dismissed notification is **not** a resolved business problem:
`Notification.status = DISMISSED` and `NotificationEscalation.status = OPEN` remain distinct.

## 5. AI and analytics data

```mermaid
erDiagram
    Business ||--o{ SalesDailyFact : aggregates
    Branch ||--o{ SalesDailyFact : breaks_down
    Branch ||--o{ ProductSalesDailyFact : sells
    ProductVariant ||--o{ ProductSalesDailyFact : counted
    Branch ||--o{ InventoryDailyFact : stocks
    ProductVariant ||--o{ InventoryDailyFact : counted
    ProductVariant ||--o{ StockoutEvent : stocked_out
    ProductVariant ||--o{ ExpiryRiskFact : expires
    Supplier ||--o{ SupplierPerformanceFact : measured
    ForecastModel ||--o{ ForecastRun : executes
    Business ||--o{ ForecastRun : requests
    ForecastRun ||--o{ ForecastPoint : yields
    ForecastRun ||--o{ Recommendation : proposes
    Business ||--o{ Recommendation : reviews
    Business ||--o{ FeatureSnapshot : captures
    ForecastModel ||--o{ ModelMetric : measured_by

    Recommendation {
        uuid id PK
        uuid businessId FK
        uuid variantId FK
        string type
        string status
        json proposedAction
        uuid reviewedByMembershipId
        timestamptz reviewedAt
        string decisionNote
    }
    ForecastRun {
        uuid id PK
        uuid businessId FK
        uuid modelId FK
        string status
        int horizonDays
        json inputsSnapshot
        string confidence
    }
```

**Advisory boundary.** Fact tables are derived from operational records and can be rebuilt.
`ForecastRun`, `ForecastPoint` and `Recommendation` are analytical outputs with no foreign key or
command path that can change stock, price, payment or a purchase order. Accepting a recommendation
only writes `status`, reviewer and note; the resulting action is a normal command in the owning
module (D-014, D-033).

## 6. Relationship rules that prevent contradictions

1. **One stock authority.** `StockBalance` is unique per `(branchId, variantId)`; batches and
   movements explain it but never replace it.
2. **No PO stock.** `PurchaseOrder` and `SupplierConfirmation` have no stock side effect. Only
   `GoodsReceipt` + `GoodsReceiptLine` accepted quantity creates stock and a `StockMovement`.
3. **No negative stock.** Available stock is a database-checked invariant, including offline
   origin; an offline shortfall becomes a `ReconciliationException`, not a sale.
4. **Immutable money history.** `Sale`, `SaleLine`, `SalePayment`, `Refund`, `SupplierInvoice`
   and `PaymentAttempt` carry explicit money and status records. Corrections are new records.
5. **Tenant-safe links.** Tenant-scoped parent/child relations use composite keys so a child cannot
   reference a parent from another business.
6. **History over deletion.** Operational rows carry status, archive timestamp or an append-only
   history table; hard deletes are reserved for transient rows such as expired upload sessions.

## 7. Deliberate non-goals

- Four separate product schemas: rejected in favour of one product/variant model with attributes,
  units and batches.
- A general-purpose JSON document store for money, stock or identity: rejected.
- Row-level security at this stage: evaluated and deferred in
  [Multi-tenant design](MULTI_TENANT_DATABASE_DESIGN.md).
- Application workflows, endpoints and background jobs: out of scope for Step 3.
