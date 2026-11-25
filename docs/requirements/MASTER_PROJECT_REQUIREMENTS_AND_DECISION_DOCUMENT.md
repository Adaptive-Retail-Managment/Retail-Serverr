# Master Project Requirements & Decision Document — Adaptive Retail Intelligence Platform

> **Document control (added at incorporation — not part of the source text):**
>
> - **Status:** Owner-confirmed authoritative requirements baseline.
> - **Authority:** Explicit project-owner confirmation (incorporated 22 November 2026).
> - **Source:** `Adaptive_Retail_Platform_Master_Requirements_and_Decision_Document.docx`,
>   Version 1.0, requirements baseline as of 18 November 2026.
> - **Scope:** Project requirements and confirmed business decisions (MRDD sections 1–30,
>   decisions 1–190, grouped finalizations, supersessions).
> - **Interpretation:** Statements marked **Confirmed** are approved requirements; **Proposed**
>   and **To be finalized** items (MRDD §27) are not approved. Where a later decision supersedes
>   an earlier one, the later decision governs (MRDD §26).
> - **Precedence:** This document is the top of the source-of-truth hierarchy. Architecture,
>   database and implementation documents may explain but must not silently contradict it
>   (MRDD §28). Changes require the §29 change-control process.
> - **Note:** The text below is the verbatim source content. Tables in the source `.docx` were
>   flattened to one cell per line during extraction; wording, numbering and decisions are
>   unchanged.

---

MASTER REQUIREMENTSAND DECISION DOCUMENT
Adaptive Retail Intelligence Platform
Design and Development of an Adaptive Multi-Business Retail Managementand Intelligence Platform with AI-Based Demand Forecastingand Subscription-Based SaaS Access
Version 1.0Requirements baseline as of 18 November 2026Prepared for project supervision, implementation, testing and handover
Document Control and Authority
Field
Value
Document
Master Requirements and Decision Document (MRDD)
Product
Adaptive Retail Intelligence Platform
Version
1.0 — 18 November 2026
Status
Consolidated requirements baseline based on decisions finalized in the project decision sessions.
Primary audience
Project supervisor, product/project team, frontend and backend developers, QA/testers and future maintainers.
Authority
This document is the consolidated reference for approved functional scope and business rules. More detailed design documents may explain implementation but must not silently contradict it.
Related artifacts
Product Requirements Document (PRD), Technical Design Document (TDD), Database Design Document (DBD), API Specification, UI/UX Design Specification and Implementation Roadmap.
Interpretation rule: statements marked Confirmed are decisions selected by the user. Statements marked Proposed or To be finalized are recommendations or technical choices that have not yet been approved. Where a later decision supersedes an earlier one, the later decision governs.
Document use
Use this document to scope implementation, create test cases, review permissions and evaluate project completion.
Do not treat a screen, API, table or technology mentioned in a supporting document as approved if it is marked proposed or unresolved here.
If a requirement must change, record the change, reason, impact, approval and new version rather than silently altering behavior.
The full project scope is approved as a product vision and first-release target, but implementation must be phased. A coherent core release is more important than many unfinished modules.

1. Executive Summary
   The Adaptive Retail Intelligence Platform is an Ethiopia-first, subscription-based, multi-tenant retail management system. It provides a shared operational foundation for different types of physical retail businesses while adapting product information, inventory controls, workflows, dashboards and AI recommendations to each business type.
   The first-release business types are Grocery & Food Retail, Fashion & Clothing Retail, Pharmacy & Medicine Retail, and Cosmetics & Beauty Retail. A business registers its own workspace, branches, employees, products, suppliers, stock, sales, reports and subscription. Multiple businesses may use the same platform without sharing data.
   The platform combines retail operations with explainable, advisory AI demand forecasting and stock-management intelligence. AI may recommend replenishment or stock transfers, but it must not automatically place purchase orders, authorize transfers, change prices, adjust stock or make other operational decisions.
   The system supports web access, desktop access and responsive/mobile layouts. Offline operation is focused on cashier POS, cached product information, basic inventory visibility and safe transaction synchronization. Advanced administration and supplier/purchasing functions are online-first.
   1.1 Official project title
   Design and Development of an Adaptive Multi-Business Retail Management and Intelligence Platform with AI-Based Demand Forecasting and Subscription-Based SaaS Access.
   1.2 Product name
   Adaptive Retail Intelligence Platform.
   1.3 Problem and intended value
   Retail businesses need dependable product, variant, stock, purchasing and sales records rather than disconnected manual processes.
   Different retail industries require different product attributes and stock controls; a one-size-fits-all form is inadequate.
   Multi-branch businesses need branch-aware stock, transfers, reconciliation and consolidated reporting.
   Businesses need better visibility into demand, replenishment, supplier performance, expiry risk and slow-moving stock.
   A SaaS model should provide independent business workspaces, configurable subscription plans and controlled access.
   1.4 Product boundaries
   This is a management and intelligence platform for physical retail businesses, not an online marketplace or customer-facing e-commerce storefront.
   It does not provide medical diagnosis, prescribing or clinical decision support.
   Suppliers do not receive platform accounts in the MVP; staff record supplier communications and quotations received through external channels.
   A physical Seller role is not a required digital account. Cashier is a dedicated digital POS role.
   A Business Admin is a digital operations administrator and must not be assigned physical shop-floor responsibilities.
2. Product Scope and Business Coverage
   2.1 First-release industries
   Business type
   Required adaptive capabilities
   Grocery & Food Retail
   Product categories and brands; units, packaging and conversion; perishable products; batch/expiry where applicable; wastage/damage; replenishment and demand insights.
   Fashion & Clothing Retail
   Brand, style/model, size and color variants; variant-level stock, sales and costs; slow-moving size/color insights; returns and exchange workflow.
   Pharmacy & Medicine Retail
   Medicine identity, brand, dosage form, strength, batch and expiry; expiry alerts, quarantine and sale blocking; demand and stockout intelligence without clinical advice.
   Cosmetics & Beauty Retail
   Brand/product line, shade/color, size and variants; batch/expiry where applicable; replenishment, brand and variant performance.
   2.2 Shared platform foundation
   One unified application and shared domain foundation; industry-specific fields and workflows are configurable adaptations, not four separate products.
   Each business has isolated records and its own subscription.
   Each business starts with one default branch; additional branches are optional and subject to plan limits.
   A single login can belong to multiple businesses with different roles and branch assignments.
   A business owner can own multiple business workspaces.
   2.3 Extensibility
   The architecture and product model should be configurable and extensible for additional industries, attributes, workflows, reports and AI behavior in future versions. The first release must demonstrate the four approved business types; extensibility does not require implementing unlimited industries now.
   2.4 Platform coverage
   Surface
   Confirmed scope
   Web
   Primary access for business administration, management and platform operations.
   Desktop
   Desktop application experience; offline cashier/POS and local data protection are required.
   Responsive/mobile
   Responsive layouts for mobile access. A separate fully native mobile application is not implied.
   Offline
   Offline POS, cached product information, basic inventory visibility, local transaction queue and synchronization/review states.
   Online-first
   Advanced administration, purchasing, supplier workflows, subscriptions, advanced reports and configuration.
3. User Roles, Memberships and Authorization
   3.1 Roles
   Role
   Scope and responsibilities
   Explicit restrictions
   Owner
   One official owner per business; business-wide authority; manages subscription, business settings, branches, employees, approvals, business-wide operations and ownership transfer. May own multiple businesses.
   Must still follow audit, confirmation and workflow controls; cannot bypass stock integrity or payment verification.
   Business Admin
   Digital/software administration within assigned business permissions: product and inventory records, employee accounts, purchasing records, suppliers, reports, digital configuration and preparation of records for approval.
   Must not physically inspect/count/receive/arrange/rotate/handle/return/destroy goods; physically negotiate; approve POs or supplier payments; authorize physical stock outcomes.
   Manager
   Operational manager for assigned branches; supervises receiving, inspection, stocktaking, expiry verification, transfers, returns/exchanges, supplier negotiations and branch-level approvals within configured authority.
   Cannot manage subscriptions or business-wide settings; cannot access unassigned branches; cannot perform Owner-only actions.
   Cashier
   Dedicated POS role; initiates sales, views own sales history, opens/closes own shift as permitted, initiates refund/return requests and sees own request status.
   No management dashboard, subscription, supplier/purchasing, business-wide reports, AI administration or other branch access unless explicitly granted by a separate permission.
   Platform Super Admin
   Platform operations: plans, platform business accounts, subscription administration, support access, health, integrations, platform settings and platform audit.
   Not an ordinary shop operator; must not casually manage business inventory, sales or employee accounts.
   Physical Seller
   May physically help customers and arrange products in the shop.
   No required digital account or platform role in MVP.
   3.2 Registration and membership rules
   Public users may create a platform account and register a business. The first user registering the business becomes its Owner.
   Account identity and business workspace are separate concepts. A user can belong to multiple businesses.
   One official Owner exists per business. Ownership transfer is controlled and audited.
   Employees join through Owner/Business Admin invitation by email or phone. They cannot publicly self-register into a business.
   Invitation tokens are single-use and expire. Invitees accept and sign in or create an account.
   Employee membership can be deactivated immediately for one business while preserving history and other business memberships.
   Only Owner and Business Admin manage employee invitations, status, roles and branch assignments. Managers supervise but do not create accounts or change roles.
   Removing a user's membership from one business does not affect their account or memberships elsewhere.
   3.3 Authorization enforcement
   Backend authorization is mandatory. Hiding buttons or routes in the frontend is not sufficient.
   Every business record must be tenant-scoped. Branch-scoped actions must enforce branch membership and assigned permissions.
   Exports, search, autocomplete, reports, notifications, attachments and error messages must not leak data across tenants or unauthorized branches.
   Sensitive actions must be audited with actor, action, target, timestamp and relevant before/after values.
   Business Admin digital-only restrictions must be enforced in API authorization and workflow design, not merely described in UI text.
   3.4 Role and action boundary summary
   Action
   Owner
   Business Admin
   Manager
   Cashier
   Manage subscription/business-wide settings
   Yes
   Only if specifically permitted; no ownership control
   No
   No
   Manage employee accounts/roles/branches
   Yes
   Yes, within business permissions
   No
   No
   Create/edit digital product records
   Yes
   Yes
   View/limited as configured
   POS lookup only
   Prepare PO / supplier digital records
   Yes
   Yes
   Yes, within branch scope
   No
   Approve PO
   Yes
   No
   Yes, within authority
   No
   Physical receiving/inspection
   May supervise/authorize
   No
   Yes / supervises
   No
   Physical stocktaking
   May perform/supervise
   No
   Yes / supervises
   No
   Approve stock write-off/disposal
   Yes
   No
   Assigned branch authority
   No
   Initiate sale
   Yes if operating POS
   No by default
   Yes if authorized
   Yes
   Initiate refund request
   Yes/authorized
   Digital record only if permitted
   Yes
   Yes
   Approve/complete refund
   Yes
   Digital administration only; no physical inspection
   Yes
   No
   Conduct supplier negotiation
   Yes
   No; digital record maintenance only
   Yes within limits
   No
4. Business Registration, Branches and Subscription
   4.1 Business onboarding
   Guided registration asks for essential business information and selected business type.
   System creates one default branch automatically; further branches may be added later.
   Onboarding is progressive: product setup, opening stock, employees and POS readiness can be completed after initial registration.
   A business may start with a configurable free trial. Super Admin configures trial duration, included features and limits. One trial per business.
   4.2 Branch management
   Stock is tracked independently per branch.
   Active branch count is subject to subscription plan limits.
   Branches are deactivated rather than permanently deleted in normal workflow; history is preserved.
   Owner manages business-wide branch settings. Manager sees only assigned branches.
   4.3 Subscription plans and billing
   Requirement
   Confirmed rule
   Plans
   Multiple configurable plans; Super Admin controls plan features, prices and limits.
   Trial
   Configurable duration, features and limits; one trial per business.
   Billing cycle
   Monthly or yearly.
   Currency
   ETB only for first release.
   Renewal
   Manual renewal; no automatic recurring billing.
   Payment
   Chapa hosted checkout for subscriptions; server-side verification and webhook handling required.
   Upgrade
   Takes effect immediately after payment is verified.
   Downgrade
   Takes effect in the next billing cycle; transparent price adjustment rules and confirmation required.
   Expiry
   Operational access restricted immediately; historical read access and renewal access remain; no grace period selected; no data deletion.
   Over limit
   Block new additions that exceed a plan limit; retain existing records and operations subject to subscription status; recommend upgrade.
   Historical prices
   Preserve historical plan pricing and subscription versions.
   4.4 Plan limit counting
   Products: count each main product once; variants do not count separately.
   Employees: count active employees only.
   Products: count active products only; archived products do not consume the limit. Restoration requires available capacity.
   Branches: count active branches only.
   Deactivated branches/employees and archived products retain historical records.
   4.5 Subscription access behavior
   An expired subscription restricts operational actions immediately. The user retains access to historical information and renewal/payment routes. Expiration does not delete business data. Exceeding a plan limit blocks new additions rather than silently deleting or deactivating existing records. The exact behavior of each restricted operation must be communicated before the user encounters the block.
5. Product Catalog and Product Information Management
   5.1 Product identity
   Products support manual names and system-generated identifiers, unique SKUs and supplier product codes.
   Brand/product combinations may be separate product records where they represent distinct products.
   A main product may contain separately tracked variants.
   The product model has three levels: main product, variant and inventory record (branch, quantity, cost, batch and movements).
   Variants do not count separately toward subscription product limits.
   5.2 Product entry and bulk import
   Support guided manual industry-specific forms.
   Support CSV/Excel bulk import with field mapping, validation preview, duplicate warnings and row-level error reporting.
   AI-assisted product information entry may suggest values, but a human must confirm them.
   Do not invent critical medicine specifications, batch or expiry information.
   5.3 Attributes and variants
   Support predefined and custom attributes with required/optional flags and validation rules.
   Support manual variant creation and controlled automatic combinations; users can exclude combinations that do not exist.
   Variant-level stock, sales, purchasing cost, supplier association and history are supported where applicable.
   Variant-level pricing is supported, with parent defaults where appropriate and branch price overrides retained.
   Variant-level weighted-average cost is supported where applicable.
   5.4 Identification and barcodes
   Support system IDs, unique SKUs, supplier product codes and optional barcode values.
   SKU is unique within a business; supplier codes may differ by supplier; barcode values are stored and validated.
   Barcode scanning/generation was not selected in the earlier product-identification decision. A later POS decision selected optional barcode scanning. Reconcile by supporting barcode storage and keeping manual lookup fully functional; scanning is optional and must be confirmed against available hardware/time before being promised as a delivered capability.
   5.5 Product lifecycle
   Products are archived rather than permanently deleted in normal operations.
   Manual archiving is supported; system may suggest inactive products for archiving, but a human confirms.
   Discontinued status is supported. Archived/discontinued products are not available for new sales/purchasing until appropriately restored.
   Restore requires available product capacity. Historical transactions remain intact.
   5.6 Images, documents and categories
   Support multiple product/variant images and optional supporting documents.
   Use hierarchical predefined industry-specific categories and custom categories/subcategories.
   Keep supplier catalog scope to product association, not supplier-maintained specifications/images/catalog content.
6. Units, Pricing, Cost and Inventory Foundation
   6.1 Units and conversions
   Products have a base unit and may have configurable purchase/selling units with conversion ratios.
   Support automatic conversion between valid units and guard against invalid fractional quantities.
   Owner/Business Admin manage unit conversions digitally; Manager views; changes are audited.
   6.2 Selling prices and discounts
   Business-wide default selling price with optional branch overrides.
   Only Owner/Business Admin may change selling prices.
   Only Owner/Business Admin may apply/configure discounts; authorized cashier discount actions are bounded by configured rules.
   Discount types include percentage, fixed amount, cart/wholesale for Grocery, Fashion and Cosmetics. Pharmacy discount functionality is excluded in MVP.
   Owner/Admin configure maximum discount limits.
   6.3 Purchase cost and valuation
   Record actual purchase cost per received batch.
   Use weighted-average cost (WAC) as the main financial inventory valuation method, at branch and business-wide levels.
   Include eligible allocated transport, handling and other acquisition costs in cost calculations.
   Accepted receipts automatically recalculate WAC; authorized manual corrections require reason and audit.
   Preserve historical costs. Supplier indicative price updates and agreement changes must not silently change actual cost or selling price.
   Inventory valuation derives from accepted receipts, acquisition costs and inventory movements. A purchase order alone never increases stock.
   WAC financial valuation is distinct from FIFO physical stock rotation.
   Reports may show estimated gross profit, but gross profit is not net profit.
   6.4 Stock integrity
   Stock is independent per branch; no negative inventory.
   Block a sale when branch stock is insufficient. Backend rechecks atomically to prevent overselling.
   Stock deduction occurs only when a sale is completed; transaction and stock update must be atomic.
   All stock changes must be represented by traceable inventory movements.
   In-transit, quarantined, expired, damaged, reserved and otherwise unavailable stock must not be treated as sellable stock.
7. Batch, Expiry, FIFO and Physical Stock Operations
   7.1 Batch and expiry tracking
   Configurable batch and expiry tracking is available for applicable products across all four industries, with specialized emphasis for Pharmacy.
   FIFO is the default physical stock rotation approach.
   Physical staff arrange/rotate stock; cashier identifies the actual batch physically picked.
   Owner assigns expiry-monitoring responsibilities to employees per branch. Managers supervise; physical sellers may assist without an account.
   7.2 Expiry inspection workflow
   System schedules inspections and generates alerts; Owner configures frequency.
   Assigned employee physically inspects and records findings.
   Expired stock is reported; Manager verifies and places it in expired/quarantined state.
   Expired/quarantined stock is blocked from sale and remains separately tracked.
   Only Manager or Owner may release a quarantined batch; Business Admin cannot.
   Expired stock may be disposed of or returned to supplier only with Manager/Owner authorization.
   Track supplier compensation such as refund, replacement, credit note or pending compensation.
   7.3 POS batch selection
   POS auto-suggests the FIFO valid batch when batch tracking applies.
   Cashier selects the batch actually picked physically; backend validates that it is not expired or quarantined.
   If cashier observes a product that appears expired while system says available, cashier reports and immediately quarantines the identified batch; Manager verifies.
   If the batch is uncertain, flag the product/batch for verification without blocking unrelated batches.
   7.4 Physical stocktaking
   Support scheduled and additional/unscheduled stocktakes.
   Any operational employee may perform the physical count without formal assignment; Manager supervises.
   Business Admin cannot physically count. A physical seller without a digital account may assist, but an authorized employee records the count.
   Differences are investigated and approved by Manager/Owner before inventory adjustment.
   Sales may continue using a controlled stock snapshot and movement reconciliation during counting.
   7.5 Inventory adjustments, write-offs and losses
   Record damage/spoilage with configurable industry categories, product/batch, quantity, branch, employee and evidence.
   Manager authorizes assigned-branch losses; Owner authorizes business-wide or exceptional cases.
   Missing/stolen/unlocated stock creates an incident and investigation; optional temporary restriction is separate from final write-off.
   A report alone does not change stock. Authorized resolution is required before official stock reduction.
   Keep permanent records, cost impact, reports, branch comparisons, trends and exports.
   Workflow stages: reported incident → investigation/temporary restriction → authorized resolution.
8. Inventory Alerts, Replenishment and Transfers
   8.1 Alerts and replenishment
   Support configurable product/branch minimum stock levels and AI recommendations.
   Alert categories include low/out-of-stock, approaching/expired, unusual stock changes, slow-moving, overstock, stockout risk, supplier delivery delay and pending purchase quantities.
   Owner/Admin configure business-wide rules; Managers configure/act within assigned branch scope.
   AI suggests reorder quantities; humans decide. Authorized staff prepare POs; Owner/authorized Manager approves. AI does not place orders.
   8.2 Inventory transfers
   Support manual transfer requests and AI transfer recommendations.
   AI considers available stock, demand and pending transfers; it does not create or authorize transfers automatically.
   Transfer priority supports Normal, High and Urgent, with staff selection informed by AI recommendations; changes are recorded.
   Recurring transfer plans are supported, but every actual transfer follows the normal request, approval, dispatch and receiving process. A plan does not reserve or move stock.
   Initiators may be Owner, Business Admin or Managers. Admin's involvement is digital preparation only.
   Manager approves within assigned branches; Owner/Admin may approve across business where authorized. Initiator cannot approve own transfer. Cashier cannot approve.
   Workflow: request → approval → dispatch → in-transit → destination physical receiving → accepted quantities enter inventory.
   In-transit stock is unavailable for sale.
   Track discrepancies, delays, cancellations, costs, demand, performance, efficiency and recommendations. Export PDF/Excel.
9. Supplier Management and Supplier Intelligence
   9.1 Supplier records
   Full supplier profiles with multiple contacts and one primary supplier address.
   Flexible predefined/custom supplier categories; multiple categories per supplier.
   Supplier active/inactive status; preserve all historical records.
   Owner/Business Admin may change supplier status digitally.
   Block new POs to inactive suppliers until reactivated; preserve existing records.
   Full supplier document management: invoices, receipts, delivery notes, credit notes, return/replacement documents and related files.
   Automatically link supplier documents to related POs, receipts, payments and other records; also retain a supplier document library.
   9.2 Supplier ratings and performance
   Manual supplier ratings plus objective system/AI performance score.
   Only Owner and Manager submit ratings. Author may edit own rating with version history.
   Owner reviews business-wide; Manager reviews assigned branches; Business Admin view only.
   Historical rating trends monthly, quarterly and yearly.
   Automatic performance decline alerts notify Owner/assigned Managers; configurable thresholds; no automatic supplier deactivation.
   In-app notifications/dashboard alerts only for supplier decline alerts; Owner/Manager acknowledge only, no task-resolution workflow.
   Supplier performance score includes delivery, quality, price, complaints/disputes and recent performance, with recent data weighted more heavily.
   Insufficient history must not create a misleading score or penalize new suppliers. Show available statistics and missing-data warnings.
   Supplier comparison considers available factors, not price alone; alternative supplier recommendations exclude inactive suppliers.
   9.3 Supplier-product associations
   Support basic product association: link suppliers to products they supply; retain historical prices and performance. Do not build a full supplier-maintained catalog/specification/image system in MVP.
   Associations may be manually pre-linked by Owner/Admin and automatically added from actual purchase history.
   Support brand-specific associations.
   Statuses: Active, Temporarily unavailable, Discontinued and Inactive; Owner/Admin manage statuses.
   Purchasing conditions may include MOQ, order multiples, packaging requirements and optional minimum order value.
   Exceptions require supplier confirmation; Business Admin prepares, Owner/Manager approves, and reason/evidence is preserved. Original conditions remain unchanged.
   9.4 Supplier prices and agreements
   Manual supplier price updates preserve history; Owner/Admin manage digital records.
   Indicative prices do not change actual cost or selling price.
   Full supplier pricing agreements support normal, negotiated, bulk and promotional prices; validity dates, conditions, version history and expired agreements.
   Full agreement renewal management: reminders, discussion history, old/new terms and versions.
   Expired agreements are not applied to new POs; existing POs preserve their recorded price.
   Support business-wide agreements with branch-specific overrides.
   Owner/Admin manage digital agreements; Managers view relevant agreements. Business Admin cannot physically negotiate or authorize payment.
   Eligible negotiated prices may be applied automatically during PO preparation based on supplier, product, branch, validity and conditions; Manager/Owner approval remains mandatory.
   If agreement changes after PO preparation but before approval, preserve prepared price, warn approver and show old/current terms; no silent replacement.
   If agreement expires/changes before approval, supplier reconfirmation is required to approve original price; otherwise update PO. Preserve evidence/audit.
   9.5 Supplier delivery and invoices
   Track estimated and actual PO delivery, including partial arrival dates; calculate delay and reliability.
   Estimate delivery automatically from history with manual override; preserve calculated and manual values. Owner override only.
   Automatic overdue alerts and manual early delay reporting; record reason and affected quantities; do not auto-cancel PO.
   Configurable overdue escalation to Owner; partial orders remain monitored until completion or closure.
   Supplier invoices track unpaid, partial, paid, overdue and outstanding balance.
   Compare PO, invoice and actual receipt; Manager/Owner resolves discrepancies. Admin maintains digital records only.
   Support supplier statement upload/reconciliation; flag differences, no silent adjustment. Admin may prepare, Manager/Owner approves financial adjustments.
   Full supplier dispute management: Open, Under Review, Awaiting Supplier Response, Resolved and Closed. Business Admin records digitally; Owner/Manager handles operational/financial resolution.
   Complaints are integrated into dispute management, not a separate complaint system.
   9.6 Supplier communications and contracts
   General supplier notes/communication history is not a full CRM.
   Contracts are stored; no contract lifecycle monitoring was selected. Negotiated terms are recorded separately.
   Full negotiation history records original/revised prices, counteroffers, responses, terms, dates, employees, attachments and final terms.
   Supplier portal is excluded from MVP. Suppliers have no platform accounts; staff enter quotations received through external channels.
10. RFQ, Quotation, Negotiation and Purchase Orders
    10.1 RFQ management
    Support internal RFQ preparation/tracking; staff manually record external supplier responses.
    Support one shared RFQ sent to multiple suppliers and separate supplier-specific RFQs.
    Optional response deadline.
    When deadline passes, staff decide to keep waiting, close as No Response or extend. Late responses may be recorded while RFQ remains open. Closing one supplier response does not close the shared RFQ.
    Automatic email reminders to suppliers; reminder timing configurable; record attempts/status where provider supports.
    Suppliers reply through normal email; staff manually record quotation and attach email/PDF. No automatic inbox processing.
    Direct email sending plus WhatsApp-ready message preparation for manual sharing; no WhatsApp API integration in MVP.
    Full RFQ communication history: system emails auto-recorded; staff log phone/WhatsApp/other interactions with date, channel, employee, notes and evidence.
    Professional business-branded RFQ PDF includes business contacts, reference/date, products/brands/quantities/units, delivery requirements, optional deadline and notes.
    Support general RFQ PDFs and supplier-specific personalized PDFs.
    Full RFQ version history with supplier-specific tracking; preserve every revision and record which version each supplier received and acknowledgement.
    After RFQ revision, staff decide per supplier whether old quotations remain valid, are marked based on outdated version or require revision. Preserve version relationship and decision.
    10.2 Quotation management
    Full quotation records include products, quantities, units, prices, dates, validity, documents, revisions, comparisons and conversion to PO preparation.
    Expired quotations are not automatically applied.
    AI recommends quotations with explanation using price, cost, availability, quality, delivery, MOQ, packaging, complaints and negotiated discounts.
    AI does not create a PO automatically.
    Owner/authorized Manager may override AI recommendation with mandatory reason/history; Business Admin view only.
    Basic quotation-to-PO tracking records selected quotation, links PO and tracks pending/partial/completed; detailed automatic promised-versus-actual comparison is not required.
    Retain rejected quotation history with reason, person and date for future supplier analysis.
    Compare quotation against RFQ: products/brands, quantities/units, prices/totals, delivery, missing info, shortages/excess/alternatives and version match. A mismatch does not automatically reject a quote.
    Cost comparison includes product cost and optional transport, delivery, handling and other charges. Distinguish supplier-provided from staff-entered charges; unknown charges are not assumed.
    Support multiple quote currencies with manual conversion into ETB; preserve original amount/currency/rate.
    Allow updated manual exchange rate before PO approval; show original and updated rates. Owner/Manager chooses and records the rate; approved PO locks selected rate.
    10.3 Supplier negotiations
    Owner and Manager conduct/record supplier negotiations. Owner scope is business-wide; Manager scope is assigned branches.
    Business Admin maintains digital negotiation records only and cannot physically negotiate.
    Owner configures Manager negotiation limits. Limits may be supplier-specific and product/category-specific.
    Negotiation outside configured limits requires Owner approval and a recorded reason.
    Negotiated terms become official only after Owner or authorized Manager confirms final terms.
    Evidence includes negotiation notes, dates, participants, quotations/confirmations and attachments; supplier confirmation and formal agreement are retained where available.
    Eligible terms may feed PO preparation; normal PO approval remains mandatory.
    10.4 Purchase order management
    Business Admin prepares digital POs; Owner or authorized Manager approves.
    Approved PO revisions use formal revision, preserve original and require reapproval.
    Only Owner can cancel an approved PO; mandatory reason.
    Record supplier delivery confirmations and automatically send email requests for confirmation.
    Supplier confirmation does not increase inventory; actual accepted receiving does.
    PO is complete only when all ordered quantities are received and accepted or formally resolved.
    Partial receiving is supported with multiple receipt records; accepted quantities increase stock, outstanding quantities remain tracked.
    Excess goods require Manager approval before entering inventory; rejected excess is tracked separately.
    Damaged delivery may be rejected before acceptance or recorded as separate damaged stock; it is excluded from sales and reviewed by Manager.
    Manager/Owner authorizes damaged-goods resolution; Admin records digitally only.
    If PO is partially received and later cancelled, preserve accepted stock and receiving history.
11. Goods Receiving and Inventory Reconciliation
    11.1 Receiving
    Operational employee physically checks actual quantity and condition, records batch/expiry where applicable and attaches evidence.
    Manager supervises; Business Admin cannot physically receive or inspect.
    Partial receipts are supported; each receipt records actual quantities and condition.
    Only accepted quantities enter sellable inventory. Rejected, damaged and excess quantities remain separately tracked until authorized resolution.
    Accepted receipt updates inventory movements and WAC; PO creation/approval/supplier confirmation alone does not.
    11.2 Reconciliation and stocktaking
    Scheduled and extra stocktakes are supported.
    Any operational employee may perform physical count without formal assignment. Manager supervises. Admin remains digital-only.
    Difference investigation and Manager/Owner approval are required before official adjustment.
    Sales continue using a controlled stock snapshot and movement reconciliation.
    Physical count records, expected quantities, counted quantities, variance, investigation, approval and final ledger movement are retained.
12. POS, Sales, Cashier Shifts and Payments
    12.1 POS product selection
    Product lookup by name, SKU, system ID, category, favorites and frequently sold products.
    Optional barcode scanning may be supported where hardware/time permits; manual lookup remains available.
    Variant selection must identify exact size/color/shade/strength or other configured variant.
    Batch selection follows FIFO suggestion but cashier confirms the physical batch picked.
    12.2 Checkout and sale integrity
    Cashier interface is dedicated and focused.
    Payment methods: cash, bank transfer and configurable additional methods such as card/mobile money; split payments supported.
    A payment method does not imply direct bank/mobile-money API integration.
    Sale completion and stock deduction are atomic; no negative inventory.
    Backend rechecks branch stock and batch eligibility.
    Cashier may apply only authorized discounts within configured limits.
    12.3 Receipts
    Provide digital receipt, printing, PDF download and optional SMS/email when contact is supplied.
    Receipt preserves sale identity and payment breakdown.
    For offline sales, clearly label local queue status; do not represent a queued sale as server-confirmed.
    12.4 Shift and cash reconciliation
    Support shift opening/closing cash declarations, expected cash, discrepancy reporting and Manager review/approval.
    Expected cash = opening cash + cash sales − cash refunds + other authorized cash movements. Non-cash payments are excluded.
    Cashier cannot approve own reconciliation.
    12.5 Sales management
    Advanced sales search by receipt, date, cashier, product, customer, branch and payment method; filters and exports.
    Completed sale cancellation requires Owner/Manager approval, mandatory reason and restrictions where linked returns/exchanges/transactions exist.
    Completed sale corrections use adjustment records, preserve original sale and require authorized Owner/Manager, reason and audit.
    Cancelled sales remain in historical reports.
    Stock reversals occur through controlled inventory movements.
    Returns and exchanges remain separate records linked to original sale; exchange is not counted as a new sale.
13. Customers, Returns, Refunds and Exchanges
    13.1 Customer records
    Staff manually create customer records; no customer self-registration or bulk import in confirmed MVP.
    Customer profile contains name and phone only.
    Customer details are optional for walk-in sales; anonymous sales are allowed.
    Authorized employee may later associate an anonymous sale with an existing verified customer; audit the association.
    Avoid duplicates and support phone lookup.
    Customer history includes purchases, returns, exchanges, payment history, product preferences, spending summaries and trends, derived from transaction data.
    13.2 Returns and refunds
    Cashier initiates return/refund request; Manager/Owner authorizes. Business Admin may maintain digital records within permissions but cannot physically inspect goods.
    Cashier searches original sale by receipt/transaction/date or verified customer contact, selects items/quantities/reason and submits.
    Only eligible purchased quantities may be returned; multiple partial returns are allowed but total returned cannot exceed purchased quantity less previous returns.
    Refund methods are cash or bank transfer. No store credit.
    Ordinary return refund uses original payment method: cash sale → cash refund; bank-transfer sale → bank-transfer refund.
    Partial/full returns are supported.
    Approving Manager may also complete refund; Owner/Admin may act across business within permissions. Approval and payment completion are separate.
    Record cash/bank evidence and prevent duplicate payment.
    Cashier sees only own refund requests; Manager sees assigned branches; Owner/Admin see business-wide requests within permission.
    Offline request may be prepared if original sale is locally available; approval/refund requires online.
    Returned goods are inspected. Sellable items may return to sellable stock; damaged/unsuitable goods are separately recorded.
    13.3 Exchanges
    Exchanges are supported only for Fashion & Clothing and Cosmetics & Beauty in MVP. Grocery and Pharmacy exchange workflows are excluded.
    Physical inspection is required. Fashion checks include worn/washed/damage/tags; Cosmetics checks include opened/used/seals/contamination.
    Default exchange period is 7 calendar days; Owner/Admin may configure. After deadline, Owner or Manager may authorize exception with reason; Business Admin cannot.
    Exchange may be same-product variant or different product. Multiple products may be combined or handled separately.
    Customer may provide phone or email; no customer account is required.
    Customer history is searchable by phone/email.
    Exchange occurs at original purchasing branch. If original branch permanently closes, Owner may authorize another branch with reason/audit.
    No physical receipt is mandatory if staff locate original sale by phone/email and verify it.
    Preserve original receipt and generate separate exchange receipt with unique exchange number linked to original sale.
    Each purchased item/quantity unit can be exchanged only once. Rejected request does not count as completed. Refunded item cannot also be exchanged.
    Before final approval, initiating Cashier or authorized Manager/Owner may cancel with reason/audit. After approval but before replacement handover, Owner/Manager may cancel with reason. After handover, normal cancellation is not allowed.
    Only products passing inspection as sellable qualify for exchange; approved returned product re-enters sellable stock upon exchange completion.
    13.4 Exchange price differences
    More expensive replacement: customer pays difference in cash only.
    Less expensive replacement: cash refund for difference only.
    Multi-item exchange difference is based on total returned versus replacement value; individual prices remain visible.
    One returned product may be exchanged for multiple replacements; multi-to-multi exchanges are supported with individual inspection/records.
    Customer may complete all replacements together or in multiple steps; stock changes only at handover.
    Difference may be settled per step or final delivery; cash only.
    13.5 Unavailable replacement and collection
    If replacement is unavailable, customer chooses another available product or waits for restock.
    Owner/Admin configure waiting period; after deadline flag for follow-up.
    Notify customer when replacement restocks; customer confirms interest; authorized staff then reserve.
    Owner/Admin configure reservation duration; reservation expires and releases stock if not collected.
    Rejected exchange customer chooses immediate or later collection; awaiting collection is a separate state and does not return item to sellable stock.
    Owner/Admin configure collection deadline/reminders; overdue items require management follow-up, not automatic disposal.
    Customer exchange notifications by SMS/email.
    Multiple completed steps and incomplete exchange history are preserved. If remaining steps pass deadline, notify customer; Owner/Manager may close remaining with reason and release uncollected reservations.
    13.6 Exchange reporting
    Dedicated exchange reports plus exchange summaries in general sales reports.
    Exchange is not counted as a new sale.
    Exchange reports export PDF and Excel.
14. Reporting, Dashboards and Business Analytics
    14.1 Owner dashboard
    Business-wide and branch dashboards; multi-business overview and business selector.
    Customizable widgets, branch comparisons, historical trends and alerts.
    Show sales, stock health, low stock, expiry, purchasing, supplier performance, pending approvals, AI insights and operational indicators.
    14.2 Manager dashboard
    Full operational dashboard for assigned branches with configurable widgets and alerts.
    No subscription management or business-wide settings.
    14.3 Business Admin dashboard
    Digital administrative information only, based on permissions. Do not assign physical operational tasks.
    14.4 Cashier dashboard
    No management dashboard. Show POS-relevant information only.
    14.5 Reporting requirements
    Sales reports: revenue, products, cashiers, branches, categories, customers, payment methods, trends, comparisons and estimated gross profit.
    Inventory reports: valuation, movement, low stock, expiry, damage/loss, transfers, reconciliation and branch comparison.
    Supplier reports: comparisons, price history, performance, delivery, quotations, disputes and agreements.
    Exchange/refund reports: dedicated details and summary inclusion.
    Exports include PDF and Excel where specified; CSV/Excel import/export supported generally.
    Reports must identify business, branch scope, date range, filters and whether figures are actual, estimated or forecast.
15. AI Demand Forecasting and Intelligence
    15.1 Forecasting
    Support multiple forecasting methods adapted to business type and available data.
    Consider sales, inventory, seasonality, product trends, promotions, holidays, supplier delays and industry-specific factors when data exists.
    Provide daily, weekly and monthly predictions with confidence/uncertainty, explanations and historical comparison.
    Warn when history is insufficient; avoid false precision.
    Synthetic demo data must not be represented as real-world accuracy or production model validation.
    15.2 Industry-specific intelligence
    Industry
    AI focus
    Grocery
    Perishables, seasonality, replenishment, waste and stockout risk.
    Fashion
    Size/color variant demand, slow-moving variants and assortment gaps.
    Pharmacy
    Medicine demand, expiry and stockout risk; no diagnosis, prescription or clinical recommendation.
    Cosmetics
    Brand/shade/size demand, slow-moving products and expiry where applicable.
    15.3 Recommendations and controls
    Prioritized, explainable recommendations include reorder quantities and transfer suggestions.
    Every recommendation is advisory and requires human review.
    AI cannot automatically create/approve POs, transfer stock, change prices, adjust inventory or authorize other operations.
    Authorized users may accept, edit or reject recommendations; decisions and overrides should be recorded where required.
16. Notifications and Alerts
    General notifications use in-app and email. General SMS notifications are not selected.
    SMS is reserved for essential messages explicitly selected in the integrations scope, including exchange/customer notifications and other specifically approved essential messages.
    Priorities: Low, Medium, High and Critical; configurable escalation for unresolved critical alerts.
    Support read/unread, history, dismissal, acknowledgement, assignment and tracking.
    Owner configures thresholds, branch-specific rules, quiet hours and frequency controls.
    Role/branch permissions apply. Cashier sees POS-relevant notifications only.
    Dismissal does not resolve the underlying issue.
    Critical security/payment/operational alerts cannot be silently discarded.
    Escalation and acknowledgement history is preserved. Email delivery failure does not erase in-app notification.
    Supplier performance decline alerts are in-app/dashboard only, acknowledged by Owner/Manager; no task resolution workflow.
17. Security, Privacy and Reliability
    17.1 Authentication
    Strong passwords, email/phone verification and password recovery.
    Optional two-factor authentication and advanced session/device management were not selected as MVP requirements.
    Passwords and tokens must never be stored in plain text.
    17.2 Audit and access control
    Comprehensive audit logs for login/failed login, permission changes, financial records, inventory and admin actions.
    Record actor, action, target, timestamp and relevant before/after values.
    Enforce business and branch isolation at backend/API level.
    Configurable permissions, sensitive-action confirmation and periodic access reviews.
    17.3 Data protection
    Encrypted backups, recovery procedures and tested restoration.
    Secure local desktop/offline data protection.
    Provider credentials and secrets are stored securely on backend, never in client code or repository.
    Support access to private business data is restricted to authorized purpose and audited.
    17.4 Reliability and testing
    Full testing pyramid: unit, integration, end-to-end and user acceptance testing.
    Load, stress and scalability testing with performance monitoring.
    Scheduled backups, periodic restoration tests, defined recovery objectives and documented disaster-recovery verification.
    Testing/staging/release checklist, automated build/test checks, versioned releases, rollback planning and post-deployment monitoring.
    Test tenant isolation, role permissions, inventory transaction integrity, offline sync idempotency, payment webhook duplication, refund/exchange history and AI limitations.
18. Desktop, Offline Operation and Synchronization
    18.1 Offline scope
    Offline POS, cached product information, basic inventory visibility and local sale queue.
    Advanced administration remains online-first.
    No real-time stock consistency across disconnected branches is promised.
    18.2 Offline transaction requirements
    Durable local save must occur before the interface reports an offline transaction as safely queued.
    Each transaction uses a unique identifier and idempotent synchronization.
    Backend validation occurs when syncing; conflicting/invalid transactions are flagged for review and never silently discarded.
    Automatic safe resolution is allowed for predefined cases; sensitive conflicts require manual review.
    Show sync status/history, queue count, last sync time and error details.
    Cached prices show last sync time.
    Offline data is protected on device.
    18.3 Offline restrictions
    Purchasing, suppliers, subscriptions, advanced reports and configuration are online-first.
    Offline returns/refund requests may be prepared only when original sale is locally available; approval/refund requires online.
    Local queued transaction must not be represented as server-confirmed until backend accepts it.
19. Integrations and External Services
    Integration
    Confirmed requirements / exclusions
    Chapa subscriptions
    Hosted checkout; server-side payment verification; references and webhooks; duplicate event protection. Redirect alone does not activate subscription.
    Retail POS payments
    Payment methods may be recorded in POS; no direct bank/mobile-money integration is implied.
    Email
    Automated emails, reusable templates, delivery tracking where provider supports, business branding. Invitations, password recovery, subscription updates, RFQs, supplier delivery confirmation and business notifications.
    SMS
    Essential notifications only; provider integration, delivery tracking where available, secure credentials and cost/limit controls.
    WhatsApp
    Prepare WhatsApp-ready messages for manual sharing. No WhatsApp API integration in MVP.
    Data import/export
    CSV/Excel import/export and PDF reporting.
    Printing
    Receipt printing and supported printer integration.
    Future integrations
    Extensible future accounting/payment integrations; not automatically included in first release.
    19.1 Supplier email behavior
    RFQ email sends and reminders are recorded in communication history.
    Supplier replies are received through normal email and manually recorded by staff; no automatic inbox parsing.
    Email/SMS failure does not undo a business transaction.
20. Platform Super Administration
    Support multiple Super Admins with separate permissions, privileged-access logging and protected actions.
    Manage business accounts, subscriptions and platform support with suspension reasons/history and controlled investigation.
    Monitor server/database, errors, payment status, background jobs, performance, security and integration health.
    Configure plans, prices, features and platform settings with version history, audit logs and safe rollback.
    Super Admin is a platform operator, not a normal business operator.
    Support access to private business data is limited to authorized purposes and audited.
21. Documentation, Deployment, Maintenance and Handover
    21.1 Documentation
    Provide user/admin manuals, API documentation, architecture and database diagrams, setup/configuration, deployment, troubleshooting and release/change notes.
    Keep documentation versioned alongside source code.
    21.2 Deployment
    Repeatable automated deployment process (CI/CD) with environment separation.
    Secure secrets/configuration, controlled database migrations and health checks.
    Use staging before production, rollback plan and post-deployment verification.
    21.3 Maintenance
    Scheduled maintenance, monitoring, dependency/security updates, backup checks, issue tracking, bug fixes and controlled feature releases.
    21.4 Handover
    Provide repository, environment/configuration guide, secure credential transfer, backup/restore guide, known limitations and demo/training.
    Clearly distinguish implemented, partially implemented, simulated and future capabilities.
    Handover ownership of code, data, hosting and integrations to the appropriate project/business owner.
22. Testing and Acceptance Framework
    22.1 Test levels
    Test level
    Coverage
    Unit
    Validation, calculations, permission rules, pricing, unit conversion, cost calculations and domain services.
    Integration
    API/database transactions, inventory ledger, payment events, email/SMS provider behavior and sync endpoints.
    End-to-end
    Registration, invitation, product setup, purchasing, receiving, POS, returns/exchanges, reports and subscriptions.
    User acceptance
    Realistic workflows for Owner, Business Admin, Manager and Cashier across all four demo business types.
    22.2 Performance and resilience
    Load/stress/scalability tests should measure response time, concurrency, database query performance and offline synchronization.
    Define and test recovery point objective (RPO) and recovery time objective (RTO); do not invent values without project approval.
    Test backup restoration rather than assuming backup creation proves recoverability.
    22.3 Core acceptance outcomes
    Owner can register a business, select an industry and access a workspace.
    All four business types demonstrate appropriate adaptive product fields and independent demo data.
    Owner can invite employees and users receive the correct role/branch experience.
    Business Admin can manage digital records but cannot perform physical or approval actions prohibited by role.
    Manager can perform assigned branch operational workflows and approvals within configured limits.
    Cashier can complete a sale, issue a receipt and track own refund requests without management access.
    Accepted receiving changes stock; PO approval and supplier confirmation alone do not.
    Stock cannot go negative; expired/quarantined batches cannot be sold.
    Returns/refunds/exchanges preserve original transaction history and enforce role/quantity/payment rules.
    Offline sales are durably queued, synchronized idempotently and sent to review when conflicting.
    AI forecasts explain uncertainty and recommendations remain human-controlled.
    Subscription checkout is verified server-side; Chapa Test Mode is used for demonstration where appropriate.
    Tenant/branch isolation and audit controls pass security tests.
    Documentation, deployment, backups, restoration, rollback and handover evidence are available.
23. Delivery Strategy and Scope Control
    The approved scope is broad. The implementation must be phased around a demonstrable end-to-end core, not a collection of disconnected screens. All four industries must be represented in the first-release demonstration through configurable templates and independent workspaces, while advanced modules can be staged.
    Delivery stage
    Priority modules
    Expected proof
    Stage A — Foundation (P0)
    Authentication, business registration, tenant membership, branches, role-aware navigation, audit foundation.
    Owner creates business, invites employees and users see correct workspace.
    Stage B — Product and inventory core (P0)
    Adaptive product/variant forms, categories, units, stock balances, batches/expiry where applicable, inventory movements.
    Four industry demos create products and view correct stock fields.
    Stage C — Sales/POS (P0)
    Cashier POS, payments, receipts, shift basics, sales history and stock deduction.
    Complete sale updates inventory safely.
    Stage D — Receiving and control (P0)
    PO preparation/approval baseline, receiving, stocktake, incidents and approval history.
    Accepted physical receipt changes stock; differences require approval.
    Stage E — Returns/refunds (P0)
    Cashier request, original sale lookup, Manager/Owner authorization, refund completion.
    Full refund workflow with audit and duplicate-payment prevention.
    Stage F — Expanded operations (P1)
    Supplier intelligence, RFQs, quotations, negotiation, transfers, exchanges, reports, notifications and email.
    Demonstrable multi-branch retail operations.
    Stage G — Intelligence/platform (P1/P2)
    AI forecasting, Chapa subscription flow, Super Admin, desktop packaging and offline hardening.
    AI is advisory; Chapa Test Mode demonstrates verified subscription payment; offline queue is tested.
    23.1 Project team constraints
    Plan around four team members but only two reliable developers for core engineering capacity.
    Assign bounded real responsibilities; additional members may contribute QA, test data, documentation, design assets, demo preparation and verified tasks.
    Do not claim work that a team member did not actually perform.
    Freeze the core technology stack before parallel implementation to avoid incompatible modules.
    23.2 Definition of done
    Feature behavior matches the approved requirement and role boundaries.
    Frontend and backend validation are implemented; tenant/branch authorization is tested.
    Relevant unit/integration/E2E tests pass.
    Errors, empty/loading states and audit behavior are handled.
    Documentation and API contracts are updated.
    Feature is demonstrated with real implementation, or clearly labeled as simulated/partial.
24. Confirmed Decisions Register — Numbered Decisions 1–190
    This register consolidates the numbered Stage 1 decisions. The detailed requirements in Sections 3–23 are the normative explanation. Number references are retained to support traceability to the original decision sessions.
    Decisions 1–31: registration, tenancy, roles, subscriptions and limits
    1 Public self-registration; first business creator becomes Owner; account and workspace separate; multiple businesses allowed; trial/onboarding may start.
    2 Owner landing combines overview of all owned businesses, business selector and independent workspaces.
    3 Employee registration is invitation-based.
    4 Physical Seller has no required digital role/account; Cashier is the digital POS role.
    5 One default branch automatically; optional additional branches.
    6 Business Admin handles broad digital operations, subject to strict physical-action boundary.
    7 One official Owner per business.
    8 Manager is branch-level.
    9 Only Owner/Business Admin manage employee accounts, roles and branch assignments.
    10 One platform login may have multiple business memberships and separate roles/branches.
    11 Invitations by email and phone.
    12 Leaving a business deactivates membership immediately while preserving history and other memberships.
    13 Only Owner/Business Admin change roles and branch assignments.
    14 Guided registration with essential information first and later onboarding.
    15 Configurable free trial; Super Admin controls duration/features/limits; one trial per business.
    16 Expired subscription restricts operations immediately; historical read and renewal access remain; no grace period; no data deletion.
    17 Super Admin controls plans/prices/features/limits; historical pricing preserved.
    18 Each business has independent subscription.
    19 Monthly and yearly billing.
    20 Manual renewal; no automatic recurring billing.
    21 Upgrade immediately after verified payment; downgrade next cycle; transparent adjustment rules and confirmation.
    22 Plan overage blocks new additions; retain existing records; suggest upgrade.
    23 ETB-only subscription billing in first release.
    24 Plan limits: branches, employees and products.
    25 Product limit counts each main product once; variants excluded.
    26 Only active employees count.
    27 Only active products count; archived products excluded; restore requires capacity.
    28 Only active branches count.
    29 Branches deactivated rather than normally deleted.
    30 Products archived rather than deleted; preserve historical transactions.
    31 Employees deactivated; preserve history.
    Decisions 32–80: inventory, prices, sales, returns and exchanges
    32 Stock is independent per branch.
    33 Transfers follow request, dispatch and destination receiving confirmation; track in-transit, discrepancies and history.
    34 Owner, Business Admin and Managers may initiate transfers; Admin's role is digital preparation only.
    35 Manager approves assigned-branch transfers; Owner/Admin may approve business-wide as authorized; initiator cannot approve own; Cashier cannot.
    36 Block sale if branch stock insufficient; no negative inventory; backend rechecks.
    37 Business-wide default selling price with optional branch overrides.
    38 Only Owner/Business Admin change selling prices.
    39 Only Owner/Business Admin apply discounts.
    40 Percentage, fixed, cart/wholesale discounts for Grocery/Fashion/Cosmetics; Pharmacy discount excluded from MVP.
    41 Owner/Admin configure maximum discount limits.
    42 Cashier initiates returns; Manager/Owner/Admin authorization subject to Admin physical boundary; inspect goods and separate sellable/damaged stock.
    43 Refund methods cash or bank transfer; no store credit.
    44 Ordinary refund follows original payment method.
    45 Partial/full and multiple returns allowed; total cannot exceed purchased quantity less prior returns; Cashier Refunds & Returns page and approval workflow.
    46 Cashier sees own requests; Managers assigned branches; Owner/Admin business-wide within permission.
    47 Approving Manager may complete refund; Owner/Admin across business; approval and payment completion separate; record evidence and prevent duplicate payment.
    48 Exchanges only Fashion and Cosmetics; deep physical inspection; configurable deadline.
    49 Default exchange period 7 calendar days; Owner/Admin may configure.
    50 Rejected exchange: immediate or later collection; awaiting collection is not sellable stock.
    51 Configurable collection deadline/reminders; overdue requires management follow-up, no auto-disposal.
    52 Customer exchange notifications by SMS/email; no customer account.
    53 Exchange requires phone or email.
    54 Same-product variant and different-product exchange; price difference cash only.
    55 Multiple products may be combined or separate exchange requests.
    56 If replacement unavailable, choose another available item or wait for restock.
    57 Owner/Admin configure waiting period; flag after deadline.
    58 Notify on restock; customer confirms interest; authorized staff then reserve.
    59 Owner/Admin configure reservation duration; expire and release if uncollected.
    60 Customer exchange history searchable by phone/email.
    61 Each purchased item/quantity unit can be exchanged only once; rejected request does not count as completed.
    62 Refunded item cannot also be exchanged.
    63 After deadline, Owner/Manager may authorize exception with reason; Business Admin cannot.
    64 Physical receipt not mandatory if sale can be located by phone/email and verified.
    65 Exchange at original purchasing branch.
    66 If original branch permanently closed, Owner may authorize another branch with reason/audit.
    67 Preserve original receipt and generate separate exchange receipt.
    68 Unique exchange number linked to original sale number.
    69 Before final approval, initiating Cashier or authorized Manager/Owner may cancel with reason/audit.
    70 After approval but before handover, Owner/Manager may cancel with reason; after handover no normal cancellation.
    71 Only products passing inspection as sellable qualify for exchange; returned sellable stock re-enters at exchange completion.
    72 More expensive replacement: cash payment of difference.
    73 Less expensive replacement: cash refund of difference.
    74 One returned product may map to multiple replacements; multi-to-multi supported with individual records/inspection.
    75 Multi-item difference based on total returned and replacement values; show individual prices.
    76 Complete all replacements together or in steps; stock changes only at handover.
    77 Settle price difference per step or final delivery; cash only.
    78 Incomplete multi-step exchange after deadline: notify; Owner/Manager may close remaining with reason; completed steps remain; release uncollected reservations.
    79 Dedicated exchange report plus summaries in sales reports; exchange is not a new sale.
    80 Exchange reports export PDF and Excel.
    Decisions 81–120: products, batches, inventory, suppliers and purchasing
    81 Manual names and system IDs; no scanning/generation initially; later barcode decision supports optional barcode storage. See barcode reconciliation in Section 5.4.
    82 Brand/product combinations may be separate records.
    83 One main product with separately tracked variants and variant IDs/stock; variants do not count separately.
    84 Business-wide default price with optional branch overrides.
    85 Actual purchase cost per received batch and weighted-average cost.
    86 Branch-level and business-wide weighted-average costs.
    87 Multiple units with conversion; base unit and configurable purchase/selling units; guard invalid fractions.
    88 Owner/Business Admin manage conversions digitally; Manager view only; audit.
    89 Configurable batch/expiry for applicable products across all four industries; Pharmacy specialized.
    90 FIFO default physical stock rotation; physical staff rotate stock; cashier identifies actual batch.
    91 Owner assigns expiry-monitoring responsibility per branch; Managers supervise; physical Seller may assist without account.
    92 Scheduled inspections and automatic alerts; Owner configures frequency; assigned employee records findings.
    93 Expired discovery: report, Manager verifies, quarantine/expired state, block sale, preserve history.
    94 POS suggests FIFO valid batch; cashier selects physical batch; validate expiry/quarantine; deduct exact batch.
    95 If cashier finds apparent expiry mismatch, report and quarantine identified batch; Manager verifies; uncertain batch does not block unrelated batches.
    96 Only Manager/Owner release quarantined batch; Admin cannot.
    97 Expired stock separately tracked with disposal/supplier return, cost and outcomes.
    98 Manager/Owner authorizes disposal or supplier return of expired stock.
    99 Track supplier compensation: refund, replacement, credit note or pending.
    100 Business Admin may prepare digital adjustment; Manager/Owner approves; Admin cannot physically count/verify.
    101 Admin fully manages digital supplier records; no physical negotiation/receiving/return.
    102 Admin prepares POs; Manager/Owner approves.
    103 Operational employee physically checks delivery and records quantity/condition/batch; Manager oversight; Admin cannot physically receive/inspect.
    104 Partial receiving; multiple receipts; accepted quantities increase stock; outstanding tracked.
    105 Excess goods require Manager approval before inventory; rejected excess separately tracked.
    106 Damaged delivery rejected before acceptance or recorded separately as damaged stock, excluded from sales; Manager reviews.
    107 Manager/Owner authorizes damaged-goods resolution; Admin records digitally only.
    108 Supplier-specific purchase price history; preserve actual costs; show prior prices; no automatic selling-price change.
    109 Full supplier intelligence; AI advisory only.
    110 Detailed supplier stats and explained overall score; insufficient data not penalized.
    111 Supplier scores branch-specific and consolidated.
    112 Full supplier payment management: partial/immediate payments, balances, due dates, reminders and reports.
    113 Owner/Manager authorize supplier payment; Admin prepares/maintains digital records only.
    114 Configurable supplier payment methods cash, bank transfer, cheque and other; no bank API implied.
    115 Full supplier document management with attachments.
    116 Automatically link documents to POs, receipts, payments and supplier library.
    117 Supplier invoice statuses unpaid, partial, paid, overdue and balance.
    118 Compare PO, invoice and actual receipt; Manager/Owner resolve; Admin records digitally.
    119 Supplier statement upload/reconciliation; flag differences; no silent adjustment; Admin prepares, Manager/Owner approves financial adjustment.
    120 Supplier disputes with Open, Under Review, Awaiting Supplier Response, Resolved and Closed; Admin records digitally; Owner/Manager resolves.
    Decisions 121–160: supplier records, pricing, delivery, RFQ and quotation foundations
    121 General supplier communication notes only, not full CRM; RFQ communications later finalized as full history.
    122 Store supplier contracts; no lifecycle monitoring; negotiated terms recorded separately.
    123 Multiple supplier contacts.
    124 One primary supplier address.
    125 Flexible supplier categories, predefined/custom and multiple per supplier.
    126 Supplier active/inactive; preserve history.
    127 Owner/Business Admin change supplier status digitally.
    128 Block new POs to inactive supplier; existing history remains.
    129 Manual supplier ratings plus objective AI/system score.
    130 Only Owner/Manager submit ratings.
    131 Rating author edits own rating with version history; Owner business-wide, Manager assigned branches; Admin view only.
    132 Rating trends monthly/quarterly/yearly.
    133 Automatic supplier performance decline alerts; notify Owner/assigned Managers; no auto-deactivation.
    134 Supplier decline alerts in-app/dashboard only.
    135 Owner/Manager acknowledge alerts; no task resolution workflow.
    136 Owner configures alert thresholds.
    137 Business-wide defaults plus supplier-specific overrides.
    138 Supplier comparison reports filter product/category/branch/date; export and explanation.
    139 Product-specific comparisons at product/brand/category level.
    140 Alternative supplier recommendations; no auto-select or PO; inactive suppliers excluded.
    141 Basic supplier-product association, not full supplier-maintained catalog.
    142 Manual supplier price updates with history; Owner/Admin manage; indicative price does not change actual or selling price.
    143 Supplier-product associations manually pre-linked and auto-updated from actual purchase history.
    144 Brand-specific supplier-product association.
    145 Association statuses Active, Temporarily unavailable, Discontinued, Inactive; Owner/Admin manage.
    146 Flexible purchasing conditions: MOQ, order multiples, packaging, optional minimum order value.
    147 Exceptions require supplier confirmation; Admin prepares; Owner/Manager approves; reason/evidence; original conditions unchanged.
    148 Track supplier-product delivery estimate and actual PO delivery; partial arrival dates; delay/reliability.
    149 Automatic estimate from history with manual override; preserve both; Owner override only.
    150 Automatic overdue alerts and manual delay reporting; reasons/affected quantities; no auto-cancel.
    151 Configurable overdue escalation to Owner; partial orders monitored until completion/closure.
    152 Complaints integrated into dispute management.
    153 Complaints/disputes included in supplier performance score.
    154 Recent supplier performance weighted more heavily; retain older history.
    155 New supplier insufficient history: show stats but no misleading score.
    156 Compare new suppliers using available data, flag unknowns; no price-only ranking.
    157 Full supplier pricing agreements: normal/negotiated/bulk/promo prices, validity, versions and conditions.
    158 Full agreement renewal management; reminders, discussions, versions; expired agreements not applied to new POs; existing POs preserve price.
    159 Business-wide agreements with branch overrides.
    160 Owner/Admin manage digital agreements; Managers view; Admin cannot physically negotiate or authorize payments; PO approval remains Owner/Manager.
    Decisions 161–190: PO pricing, RFQs, quotations and negotiations
    161 Automatically apply eligible negotiated prices in PO preparation; Manager/Owner approval remains mandatory.
    162 Agreement changes after PO preparation preserve prepared price, warn approver and show old/current; no silent replacement.
    163 If agreement expires/changes before approval, supplier reconfirmation required to approve original price; otherwise update PO; preserve evidence/audit.
    164 Full supplier quotation management: items, quantities, units, prices, dates, validity, docs, revisions, comparison and PO preparation; expired quotes not auto-applied.
    165 Owner/Admin manage quotations; Manager views relevant branch; quotation is not authorization.
    166 AI recommends quotations with explanations across price, cost, availability, quality, delivery, MOQ, packaging, complaints and negotiated discounts; no auto-PO.
    167 Owner/authorized Manager override AI recommendation with reason/history; Admin view only.
    168 Basic quote-to-PO tracking: selected quote link and pending/partial/completed; no detailed automatic promised-vs-actual comparison.
    169 Retain rejected quotation history with reason, person and date.
    170 No supplier portal in MVP; suppliers have no platform accounts; staff enter externally received quotes.
    171 Internal RFQ preparation/tracking; manually record external supplier responses.
    172 Shared RFQ to multiple suppliers and separate RFQs supported.
    173 Optional response deadline.
    174 Staff decide overdue response handling; late response allowed while open; one supplier close does not close shared RFQ.
    175 Automatic supplier email reminders; configurable timing and attempt/status tracking where supported.
    176 Supplier replies by normal email; staff manually record quotation and attach email/PDF; no automatic inbox processing.
    177 Direct email and WhatsApp-ready manual message; no WhatsApp API.
    178 Full RFQ communication history; system emails auto-recorded; staff log phone/WhatsApp/other with date/channel/employee/notes/evidence.
    179 Professional business-branded RFQ PDF with business contact, ref/date, requested products/brands/quantities/units, delivery requirements, optional deadline and notes.
    180 General and supplier-specific personalized RFQ PDFs.
    181 Full RFQ version history and supplier-specific version receipt/acknowledgement.
    182 Staff decide per supplier whether old quote remains valid, is marked outdated or revised; preserve relationship.
    183 Full automatic quotation vs RFQ comparison; mismatches do not auto-reject.
    184 Product cost plus optional additional charges; separate supplier-provided vs staff-entered; unknown charges not assumed.
    185 Multiple quote currencies with manual conversion into ETB; preserve original amount/currency/rate.
    186 Allow updated manual rate before PO approval; show both; Owner/Manager chooses; lock approved rate in PO.
    187 Full supplier negotiation history: prices, counteroffers, responses, terms, dates, employees, attachments and final terms.
    188 Owner and Manager negotiate/record; Owner business-wide, Manager assigned branches; Admin digital record only.
    189 Owner-configured Manager negotiation limits; outside limit requires Owner approval and recorded reason.
    190 Negotiation limits configurable by supplier and product/category.
25. Later Grouped Finalization Decisions
    The following grouped decisions were finalized after the numbered Stage 1 register. They are binding clarifications and should be read together with the relevant sections above.
    Supplier Negotiations finalization — Q1=A, Q2=A, Q3=A, Q4=B
    Only Owner approves negotiations exceeding Manager's configured limits.
    Negotiation exceptions require Owner approval with recorded reason.
    Negotiated terms become official after Owner or authorized Manager confirms final terms.
    Evidence includes negotiation notes, dates, participants, quotations/confirmations and attachments; supplier confirmation and formal agreement where available.
    Business Admin maintains digital records only; cannot negotiate, approve exceptions or independently authorize purchasing commitments.
    Purchase Order Management — Q1=A, Q2=B, Q3=B, Q4=A
    Approved PO revisions use formal revision, preserve original and require reapproval.
    Only Owner cancels an approved PO; mandatory reason.
    Record supplier delivery confirmations and automatically send email confirmation requests.
    PO complete only when all ordered quantities are accepted or formally resolved. Supplier confirmation alone never increases stock.
    Inventory Reconciliation and Physical Stocktaking — Q1=A, Q2=C, Q3=A, Q4=A
    Scheduled and extra stocktakes.
    Any operational employee may physically count without formal assignment; Manager supervises. Business Admin remains digital-only; physical Seller may assist but authorized employee records count.
    Discrepancies investigated and approved by Manager/Owner before adjustment.
    Sales continue using controlled stock snapshot and movement reconciliation.
    Inventory Alerts and Replenishment — Q1=D, Q2=D, Q3=A, Q4=A
    Configurable product/branch minimum stock levels plus AI recommendations.
    Alerts cover low/out-of-stock, approaching/expired, unusual changes, slow-moving, overstock, stockout risk, supplier delays and pending purchase quantities.
    Owner/Admin business-wide; Managers branch-specific.
    AI suggests reorder quantities; humans decide; normal PO preparation and approval required.
    Inventory Valuation and Cost Management — Q1=A, Q2=A, Q3=D, Q4=D
    WAC is the main valuation method.
    Include eligible allocated transport/handling/other acquisition costs.
    Preserve historical costs; automatically recalculate WAC on accepted receipts; authorized corrections require reason/audit.
    Current/historical valuation, costs, sales value, estimated gross profit, trends and branch/business comparisons.
    Branch and business-wide WAC; FIFO physical rotation remains distinct.
    PO alone does not increase stock; gross profit is not net profit.
    Inventory Adjustments, Write-offs and Loss Management — Q1=D, Q2=A, Q3=D, Q4=D
    Detailed damage/spoilage records with configurable industry categories, product/batch/quantity/branch/employee/evidence.
    Manager authorizes assigned-branch losses; Owner business-wide or exceptional cases; Admin digital-only.
    Missing/stolen/unlocated stock creates incident and investigation; optional temporary restriction; report alone does not reduce stock.
    Detailed permanent records, cost impact, reports, branch comparisons, trends and exports.
    Three stages: reported incident → investigation/temporary restriction → authorized resolution.
    Inventory Transfers and Multi-Branch Stock Distribution — Q1=D, Q2=C, Q3=A, Q4=D
    Both AI transfer recommendations and manual transfer requests; AI considers available stock, demand and pending transfers; no auto-creation/authorization.
    Priority Normal/High/Urgent combines staff selection and AI recommendation; changes recorded.
    Recurring transfer plans supported; each actual transfer requires normal authorization, dispatch and receiving; plan does not reserve/move stock.
    Full reports include history, branches, delays, discrepancies, cancellations, costs, demand, performance, efficiency and AI recommendations; PDF/Excel.
    Product Catalog and Product Information Management — Q1=D, Q2=D, Q3=D, Q4=D
    Guided industry-specific forms, CSV/Excel bulk import and AI-assisted entry; validate and preview errors; human confirms AI suggestions.
    Multiple product/variant images and optional documents.
    Hierarchical predefined industry-specific and custom categories/subcategories.
    Manual archive; automatic inactivity suggestions require human confirmation; discontinued status; preserve history and plan-limit behavior.
    Shared product core with industry-specific attributes; not separate product systems.
    Product Variants, Attributes and Identification — Q1=D, Q2=D, Q3=D, Q4=D
    Predefined/custom attributes with required/optional flags and validation.
    Manual variant creation and controlled automatic combinations; user can exclude nonexistent combinations.
    Variant-level pricing, costs, supplier associations and history; parent defaults where appropriate; branch price overrides remain.
    System IDs, unique SKUs, supplier product codes and optional barcode storage; SKU unique within business; supplier codes vary by supplier.
    Variant-level WAC/cost where applicable. Barcode storage confirmed; scanning/generation must be treated according to the reconciliation in Section 5.4.
    POS and Cashier Operations — Q1=D, Q2=D, Q3=D, Q4=D
    Product selection by name, SKU, system ID, category, optional barcode scanning, favorites and frequently sold products.
    Payments cash, bank transfer, configurable additional methods and split payments.
    Digital/printed/PDF receipts; optional SMS/email when contact supplied.
    Shift opening/closing cash declarations, expected cash and discrepancy reporting with Manager review; cashier cannot approve own reconciliation.
    Expected cash formula: opening cash + cash sales − cash refunds + other authorized cash movements; noncash excluded.
    Offline sale queue with idempotency; stock deducts only on completed sale; no negative stock; batch selection validates physical batch.
    Customer Management and Customer Purchase History — answers B, A, D, D
    Staff manually create customer records; no self-registration or bulk import in confirmed MVP.
    Profile fields: name and phone.
    Full purchase history, returns, exchanges, payment history, preferences, spending summaries and trends.
    Anonymous sales allowed; authorized employee may later associate sale with verified existing customer; audit. Customer information optional for walk-in; avoid duplicates and support phone search.
    Sales Management and Reporting — Q1=D, Q2=D, Q3=D, Q4=D
    Advanced sales search by receipt, date, cashier, product, customer, branch and payment method.
    Completed sale cancellation only Owner/Manager approval, mandatory reason and restrictions for linked returns/exchanges/transactions.
    Completed sale corrections through adjustment records; preserve original; authorized Owner/Manager, reason and audit.
    Comprehensive reports for revenue, product/cashier/branch/category/customer/payment, trends, comparisons, estimated gross profit and PDF/Excel.
    Cancelled sales remain in reports; stock reversals use controlled movements; returns/exchanges separate and linked.
    Dashboard and Business Analytics — Q1=D, Q2=D, Q3=D, Q4=D
    Owner business-wide/branch dashboards, multi-business overview and customizable widgets.
    Manager full operational dashboard for assigned branches and configurable widgets/alerts.
    Comparisons across branches, periods, products, categories and business performance.
    Historical trends, automatic insights and explainable AI recommendations.
    Business Admin sees digital administration information only; Cashier has no management dashboard.
    Respect tenant/branch isolation and distinguish actuals, forecasts and estimates.
    AI Demand Forecasting and Intelligence — Q1=D, Q2=D, Q3=D, Q4=D
    Multiple forecasting methods adapted to business type/data.
    Use sales, inventory, seasonality, product trends, promotions, holidays, supplier delays and industry factors when available.
    Daily/weekly/monthly predictions, confidence, explanations, historical comparison and uncertainty warnings.
    Prioritized explainable recommendations; human approval for every operational action.
    Industry-specific Grocery/Fashion/Pharmacy/Cosmetics intelligence; no clinical advice for Pharmacy.
    Insufficient-history warnings; no false precision or unsupported claims from synthetic data.
    Notifications and Alerts — Q1=B, Q2=D, Q3=D, Q4=D
    In-app and email general notifications; no general SMS channel.
    Priority Low/Medium/High/Critical; configurable escalation for unresolved critical alerts.
    Read/unread, history, dismissal, acknowledgement, assignment and tracking.
    Owner-configured thresholds, branch rules, quiet hours and frequency controls.
    Role/branch enforcement; Cashier sees POS-relevant notifications only.
    Dismissal does not resolve; critical alerts cannot be silently discarded; escalation/acknowledgement history retained; email failure does not erase in-app notification.
    Security, Privacy and Access Control — Q1=C, Q2=D, Q3=D, Q4=D
    Strong passwords, email/phone verification and password recovery; optional 2FA and advanced session/device management not selected for MVP.
    Comprehensive audit logs for login, failed login, permissions, financial, inventory and admin actions.
    Business and branch isolation, encrypted backups, recovery procedures and tested restoration.
    Backend role/branch permission enforcement, configurable permissions, sensitive-action confirmation and access reviews.
    Passwords/tokens never stored in plain text.
    Desktop Application and Offline Operation — Q1=D, Q2=D, Q3=D, Q4=D
    Web, desktop and responsive/mobile access.
    Offline POS, cached product information, local transaction storage and sync queue.
    Automatic safe resolution for predefined cases; manual review for sensitive conflicts; full sync history.
    Offline POS, cached products/prices and basic inventory; advanced administration online-first.
    Durable local save before success, unique transaction IDs, idempotency, backend validation and no silent discard.
    Cached prices show last sync time; no real-time cross-branch consistency while disconnected; desktop local data protected.
    System Integrations and External Services — Q1=D, Q2=D, Q3=B, Q4=D
    Chapa hosted checkout for subscriptions plus extensible future gateways; server verification, references, webhooks and duplicate-event protection.
    Email automation, reusable templates, branding and delivery tracking where provider supports.
    SMS for essential notifications only; provider integration, delivery tracking where available, secure credentials and cost/limit controls.
    CSV/Excel import/export, PDF, printer support and extensible future integrations.
    Provider credentials secure on backend; redirect alone does not activate subscription; failed email/SMS does not undo transaction.
    System Administration and Platform Super Admin — Q1=D, Q2=D, Q3=D, Q4=D
    Multiple Super Admins with separate permissions, privileged access logging and protected actions.
    Manage business accounts, subscriptions and support with controlled investigation, reasons, history and restricted access.
    Monitor server/database, errors, payment status, background jobs, performance, security and integration health.
    Configure plans/prices/features/platform settings with version history, audit and safe rollback.
    Super Admin is platform operator, not ordinary business operator; private-data support access is restricted and audited.
    Subscription Plans and SaaS Monetization — Q1=D, Q2=D, Q3=D, Q4=D
    Multiple configurable plans; Super Admin controls features, limits and prices.
    Configurable trial duration/features/limits; one trial per business.
    Immediate upgrades; next-cycle downgrades; transparent price adjustment/proration rules and confirmation.
    Business sees plan, expiry, usage/remaining limits, payment/subscription history, warnings and upgrade recommendations.
    ETB-only first release; monthly/yearly; manual renewal; no auto recurring.
    Chapa hosted checkout with server verification.
    Expiry restricts operations immediately but preserves historical read/renewal; no data deletion.
    Over-limit blocks new additions but retains existing records; limits count active employees/products/branches and main products only.
26. Conflicts, Supersessions and Clarifications
    Topic
    Clarification / governing interpretation
    Barcode scanning
    Earlier product identification excluded scanning/generation; later POS decision selected optional barcode scanning. Barcode storage and validation are confirmed. Manual lookup is mandatory fallback; scanning remains optional and hardware/time dependent.
    Business Admin scope
    Early broad Admin permissions are narrowed by the later strict boundary: Admin is digital-only and cannot perform physical tasks, physical supplier negotiation, PO approval, supplier payment approval or physical stock authorization.
    Stocktaking
    Earlier answer for the second stocktake question was later corrected from A to C. Governing rule: any operational employee may physically count; Manager supervises; Admin cannot physically count; physical Seller may assist but authorized employee records count.
    Supplier communications
    General supplier communication is notes/history, not a full CRM. RFQ communication history is separately full and detailed.
    Supplier catalog
    Only supplier-product association and historical price/performance, not a full supplier-maintained catalog with specs/images.
    POS retail payments vs subscription
    POS records cash/bank transfer/configurable methods; Chapa is specifically for SaaS subscription checkout. Do not assume retail payment gateway integration.
    General notifications vs SMS
    General notifications are in-app/email. SMS is reserved for explicitly essential use cases such as customer exchange notifications and other selected essential messages.
    Offline consistency
    Offline POS is supported, but disconnected branches cannot have real-time shared stock consistency. Sync validation and manual review are required for sensitive conflicts.
    Scope vs delivery
    The complete approved functional scope is the target, but delivery is phased. A demo must clearly distinguish implemented, partial, simulated and future functionality.
27. Unresolved Technical Decisions — Not Yet Approved
    The following items are intentionally not presented as confirmed product decisions. The team must review and freeze them before implementation details are treated as final.
    Decision area
    Current status / action required
    Backend framework
    NestJS/TypeScript and FastAPI/Python have both appeared in earlier design discussions. Choose a primary backend and define whether AI needs a separate service.
    Database
    PostgreSQL was proposed in TDD/DBD; MySQL was previously considered. Select one production database.
    ORM/data access
    Prisma was proposed with PostgreSQL; alternatives were discussed earlier. Freeze ORM/migration approach.
    Frontend
    React + TypeScript + Vite is a proposal; confirm final frontend architecture and state/data-fetching approach.
    Desktop
    Electron was proposed; confirm packaging, update and local storage strategy.
    Offline database
    SQLite was proposed for local POS; finalize schema, encryption, sync queue and conflict resolution.
    AI service/model
    Choose forecasting baseline, evaluation approach, retraining/update strategy and service boundary.
    Hosting/deployment
    Select hosting, database hosting, object storage, monitoring and CI/CD provider.
    Email/SMS providers
    Choose providers, templates, delivery tracking and cost controls.
    Chapa
    Confirm current integration requirements, webhook verification and Test Mode demonstration configuration.
    Printer/scanner hardware
    Confirm devices available for receipt printing and optional barcode scanning.
    RPO/RTO
    Set measurable recovery point and recovery time objectives; test actual restoration.
    Performance targets
    Define measurable API/page response, concurrency and sync performance targets.
    Customer uniqueness
    Confirm duplicate customer matching/phone normalization rules.
    Inventory ledger projection
    Finalize authoritative movement ledger and derived stock-balance strategy.
    Landed cost allocation
    Define exact allocation rules for transport/handling and other acquisition costs.
    Detailed state machines
    Freeze allowed transitions for PO, receipt, supplier dispute, refund, exchange, transfer, stocktake and subscription.
    Currency exchange
    Define supported quote currencies, rate source (manual), precision and rounding rules.
    Data retention
    Define retention periods for audit logs, uploaded supplier documents and offline transaction records.
    27.1 Proposed technology baseline from supporting TDD
    A previous TDD proposed a modular monolith using NestJS + TypeScript REST API, PostgreSQL + Prisma, React + TypeScript + Vite, Electron + React, SQLite offline storage, optional Python/FastAPI AI service and Docker. This is a candidate architecture only. It is not approved until the team explicitly freezes the stack.
    27.2 Technical design rule
    The implementation must use one consistent technology decision across backend, database, frontend, desktop, migrations and deployment. Do not start parallel modules against competing stacks.
28. Traceability to Supporting Documents
    Supporting document
    Purpose and relationship to this MRDD
    PRD
    Explains product goals, users, features, scope and acceptance intent.
    TDD
    Explains proposed architecture, technology options, modules, security, offline strategy and deployment design; proposals remain subject to technical freeze.
    DBD
    Translates requirements into logical entities, relationships, constraints, indexes and transaction boundaries; physical schema needs final review.
    API Specification
    Defines proposed REST endpoints, DTOs, authorization expectations, errors and sync contracts; API contracts need team review/freeze.
    UI/UX Design Specification
    Defines role-based navigation, screens, industry adaptations, interaction patterns, responsive/offline UX and screen priorities.
    Implementation Roadmap
    Converts scope into phases, milestones, dependencies and team tasks.
    When a supporting document conflicts with this MRDD, the approved business requirement in this MRDD governs until a formal change is approved. Supporting technical designs may propose a way to implement a requirement but cannot remove or weaken it.
29. Change Control and Decision Governance
    Record each proposed change with a unique change ID, date, requester and reason.
    Identify affected requirements, roles, screens, database entities, APIs, tests, schedule and team workload.
    Classify the change as clarification, correction, scope addition, scope reduction or technical implementation choice.
    Obtain supervisor/project-owner approval where required before treating it as baseline.
    Update this MRDD and all affected supporting documents together.
    Retain a revision history so the team can trace what changed and why.
    29.1 Revision history
    Version
    Date
    Change
    1.0
    18 November 2026
    Initial consolidated baseline of confirmed decisions and grouped finalizations through final scope verification.
30. Final Project Baseline
    The approved product is one adaptive, multi-tenant retail SaaS platform for Grocery & Food, Fashion & Clothing, Pharmacy & Medicine, and Cosmetics & Beauty businesses. It has role-separated Owner, Business Admin, Manager and Cashier experiences, with a platform Super Admin role. It supports branch-aware inventory, purchasing, POS, returns/refunds/exchanges where applicable, supplier intelligence, reporting, advisory AI demand forecasting, subscription-based access and offline cashier operation.
    The strict Business Admin digital-only boundary, Manager branch scope, Cashier POS-only boundary, tenant isolation, stock integrity, approval requirements and human control over AI recommendations are core architectural requirements. They must be reflected in the database, APIs, UI and tests.
    The first release should be delivered in coherent phases and demonstrated across all four business types, all main roles, independent workspaces, offline POS, AI advisory functionality and Chapa Test Mode. Features that are not fully implemented must be labeled honestly as partial, simulated or future.
    Technology stack, detailed state machines, hosting/provider selections, exact performance targets and RPO/RTO remain technical decisions to be finalized. This document does not silently approve those choices.
    END OF MASTER REQUIREMENTS AND DECISION DOCUMENT
