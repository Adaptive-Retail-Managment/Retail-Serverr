# Scope and phases

## Product shape

One platform, four business-type configurations: grocery & food, fashion & clothing,
pharmacy & medicine, cosmetics & beauty. Differences (product fields, variants, batch/expiry
rules, dashboard widgets, labels) belong in configuration and industry-profile modules, not in
duplicated applications.

## Phase 0 — Foundation (current)

Implemented:

- pnpm workspace, shared TypeScript/ESLint/Prettier configuration
- NestJS API shell with validated environment, Prisma client bootstrap, liveness and readiness
- React/Vite web shell with a status page consuming the probes
- Electron shell that loads the same web app through a hardened, allowlisted preload
- Development PostgreSQL service, initial GitHub Actions workflow
- Unit, HTTP e2e and real-database integration tests for the foundation

Not implemented in Phase 0: domain schema, migrations, identity, authorization, tenancy,
inventory, procurement, POS, after-sales, analytics, AI recommendations, offline sync,
subscription/billing, packaging/installers.

## Next phases (order to be confirmed against the approved requirements)

Proposed vertical slices, each end-to-end and independently reviewable:

1. Identity and membership: account, session, business membership, branch assignment.
2. Authorization: permission catalog, roles, backend enforcement, Business Admin boundaries.
3. Tenancy and branches: business and branch CRUD with isolation enforcement.
4. Catalog with the first business-type configuration (one slice proves the pattern).
5. Inventory ledger and stock balances (append-only movements, no negative stock).
6. Procurement: suppliers, RFQ → quotation → purchase order → receiving → supplier invoice.
7. POS sale, payment, receipt, cashier shift.
8. Returns, refunds and exchanges.
9. Reporting, then advisory intelligence, then offline synchronization.

The phases above are sequencing proposals, not approved requirements. The authoritative approved
requirements baseline is the owner-confirmed
[`../requirements/MASTER_PROJECT_REQUIREMENTS_AND_DECISION_DOCUMENT.md`](../requirements/MASTER_PROJECT_REQUIREMENTS_AND_DECISION_DOCUMENT.md)
(MRDD v1.0, §23 delivery strategy); legacy binding constraints are in
[`../requirements/master-requirements.md`](../requirements/master-requirements.md).
