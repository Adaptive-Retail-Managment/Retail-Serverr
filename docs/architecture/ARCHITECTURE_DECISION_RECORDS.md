# Architecture decision records

This file is the single decision log for the platform. It preserves every decision recorded during
the foundation phase (D-001 to D-015), including the ones that were later constrained by the brief,
and adds the decisions made while establishing the Step 2 architecture. A decision is never silently
replaced: a change adds a new record or marks the old one **Superseded** and points to its successor.

**Status vocabulary**

| Status      | Meaning                                                                      |
| ----------- | ---------------------------------------------------------------------------- |
| Constrained | Fixed by the project brief or an external requirement; not open for revision |
| Accepted    | Chosen and current; implementation may still be pending                      |
| Provisional | Chosen as the working answer; must be revisited at the stated point          |
| Superseded  | Replaced by a later record; kept for history                                 |

**Implementation state** is separate from status. `not started` means the decision is design only and
must not be reported as working.

| ID    | Title                                                                | Status      | In code     |
| ----- | -------------------------------------------------------------------- | ----------- | ----------- |
| D-001 | Modular monolith with one deployable API                             | Constrained | partial     |
| D-002 | pnpm workspace monorepo                                              | Constrained | implemented |
| D-003 | pnpm 11.28.13                                                        | Accepted    | implemented |
| D-004 | NestJS 11.2.11, not 12                                               | Provisional | implemented |
| D-005 | Prisma 6.19.3                                                        | Provisional | implemented |
| D-006 | TypeScript 5.9.3                                                     | Accepted    | implemented |
| D-007 | Jest for the API; Vitest for web and desktop                         | Accepted    | implemented |
| D-008 | React 19 + Vite 7                                                    | Accepted    | implemented |
| D-009 | Electron 45 desktop shell                                            | Provisional | partial     |
| D-010 | Stable probes; business API under `/api`                             | Accepted    | implemented |
| D-011 | API boots without PostgreSQL and reports degraded readiness          | Accepted    | implemented |
| D-012 | Single development DB role                                           | Provisional | implemented |
| D-013 | Business-type differences through configuration                      | Constrained | not started |
| D-014 | AI remains advisory                                                  | Constrained | not started |
| D-015 | Prisma schema lives in `apps/api/prisma`                             | Accepted    | implemented |
| D-016 | PostgreSQL as the central system of record                           | Constrained | partial     |
| D-017 | SQLite as the local offline store                                    | Provisional | not started |
| D-018 | REST + OpenAPI instead of GraphQL                                    | Constrained | partial     |
| D-019 | Shared-schema multi-tenancy with backend scope                       | Accepted    | not started |
| D-020 | Feature-based frontend modules                                       | Accepted    | partial     |
| D-021 | Domain-oriented backend modules, not layer-first packages            | Constrained | not started |
| D-022 | Durable offline outbox with client-generated operation IDs           | Constrained | not started |
| D-023 | Backend-enforced, deny-by-default authorization                      | Constrained | not started |
| D-024 | URL versioning `/api/v1` and problem-details errors                  | Accepted    | partial     |
| D-025 | Strict stock protection for offline transactions                     | Approved    | not started |
| D-026 | In-process events plus a transactional outbox, no broker             | Accepted    | not started |
| D-027 | Four business roles plus platform Super Admin; Admin is digital-only | Constrained | not started |
| D-028 | Super Admin support access is time-boxed, reason-bound and audited   | Accepted    | not started |
| D-029 | One shared React renderer for web and desktop                        | Constrained | implemented |
| D-030 | Documentation by concern under `docs/`                               | Accepted    | implemented |
| D-031 | Secrets live only in the backend environment                         | Constrained | partial     |
| D-032 | Chapa hosted checkout with verified webhooks                         | Provisional | not started |
| D-033 | Forecasting runs as a scheduled batch and writes proposals           | Provisional | not started |
| D-034 | Four-member ownership rebalanced by estimated effort                 | Accepted    | n/a         |

---

## D-001 — Modular monolith with one deployable API

**Status:** Constrained · **In code:** partial (one Nest application; no domain modules)

**Context.** The platform serves four retail business types, must keep stock and money correct, and
is built by four developers. A distributed system would multiply operational and consistency work
that the team cannot support.

**Decision.** One NestJS application, one PostgreSQL database, one deployable API. Modules own their
tables and expose application interfaces. Cross-module calls are in-process public service calls or
internal events. No network boundary exists between modules.

**Alternatives.** Microservices per domain (rejected: distributes transactions, adds a broker and
deployment surface); a single unstructured codebase (rejected: loses enforced boundaries); serverless
functions (rejected: cold-start and local transaction complexity).

**Consequences.** Transactions can span modules, which makes stock and payment invariants tractable.
Boundaries must be enforced by review and lint rather than the network. Scaling is vertical plus
replicas of the same API. See [`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md) and
[`MODULE_DEPENDENCY_MAP.md`](MODULE_DEPENDENCY_MAP.md).

## D-002 — pnpm workspace monorepo

**Status:** Constrained · **In code:** implemented

**Context.** Web, desktop, API and shared config must stay on one toolchain without publishing
packages, and `PROJECT_STRUCTURE.md` assumes pnpm.

**Decision.** A pnpm workspace with `apps/*` and `packages/*`. Workspace packages share ESLint,
Prettier and TypeScript configuration. No package is published externally.

**Alternatives.** Separate repositories (rejected: version skew and duplicated config); npm/yarn
workspaces (rejected: weaker workspace linking and the structure document assumes pnpm).

**Consequences.** One install and one lockfile. CI must run from the workspace root. Package
boundaries are imported as `@arp/*`. See [`../operations/local-development.md`](../operations/local-development.md).

## D-003 — pnpm 11.28.13

**Status:** Accepted · **In code:** implemented

**Context.** pnpm 12 ships as a Rust-native binary whose layout corepack as bundled with Node 22
cannot launch (`bin/pnpm.cjs` missing).

**Decision.** Pin pnpm 11.28.13 in the root `package.json` and use it in CI.

**Alternatives.** pnpm 12 through a workaround (rejected: fragile install path); npm (rejected: does
not match the brief).

**Consequences.** The toolchain is reproducible today. Revisit when corepack supports pnpm 12; that
is an upgrade record, not an edit to this one.

**Related:** [`../operations/local-development.md`](../operations/local-development.md), README commands.

## D-004 — NestJS 11.2.11, not 12

**Status:** Provisional · **In code:** implemented

**Context.** NestJS 12 is ESM-only. The API is a CommonJS build tested with ts-jest and Jest 30,
which cannot `require()` ESM packages on the project's Node 22 baseline (Node 24.9+ is required).

**Decision.** Pin NestJS, `@nestjs/config`, `@nestjs/testing` and the CLI to the 11.x line.

**Alternatives.** Nest 12 with an ESM API build and a different test runner (deferred: a whole-module
migration, not a foundation change); downgrading Node (rejected: loses toolchain compatibility).

**Consequences.** Decorator metadata and ts-jest work unchanged. Revisit only together with an
API-wide ESM migration (`nodenext`, Jest ESM or a different runner) instead of mixing module systems.

**Related:** [`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md), [`../testing/TESTING_ARCHITECTURE.md`](../testing/TESTING_ARCHITECTURE.md).

## D-005 — Prisma 6.19.3

**Status:** Provisional · **In code:** implemented

**Context.** The npm `latest` tag pointed at an 8.0.0 release candidate; Prisma 7 changes the
generator and configuration model. The CommonJS Nest + Jest combination was only verified on 6.19.

**Decision.** Pin `prisma` and `@prisma/client` to 6.19.3.

**Alternatives.** Prisma 8 RC (rejected: unverified generator); Prisma 7 (rejected before the first
domain migration); another ORM (rejected by the brief).

**Consequences.** The generated client is known to work with the API build. Re-evaluate before the
first domain migration; a schema migration and an ORM upgrade must not land together.

**Related:** D-015, [`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md), [`../team/TEAM_DEVELOPMENT_GUIDELINES.md`](../team/TEAM_DEVELOPMENT_GUIDELINES.md).

## D-006 — TypeScript 5.9.3

**Status:** Accepted · **In code:** implemented

**Context.** ts-jest 29 and typescript-eslint 8 support TypeScript `<6.1`. TypeScript 7 (native
compiler) is not supported by this test toolchain.

**Decision.** Pin TypeScript 5.9.3 across workspace packages.

**Alternatives.** Latest TypeScript (rejected: breaks the current test toolchain); per-package
versions (rejected: inconsistent decorators and typings).

**Consequences.** Upgrades are deliberate and apply to the whole workspace at once.

**Related:** [`../testing/TESTING_ARCHITECTURE.md`](../testing/TESTING_ARCHITECTURE.md), [`../team/TEAM_DEVELOPMENT_GUIDELINES.md`](../team/TEAM_DEVELOPMENT_GUIDELINES.md).

## D-007 — Jest for the API; Vitest for web and desktop

**Status:** Accepted · **In code:** implemented

**Context.** Nest relies on decorator metadata that Jest + ts-jest handles directly. The React apps
are built by Vite, and Vitest shares that transform pipeline.

**Decision.** Jest 30 with ts-jest for API unit, e2e and integration tests; Vitest with Testing
Library and jsdom for web and desktop renderer tests.

**Alternatives.** Vitest for the API (rejected: Nest decorator metadata needs extra configuration);
Jest for React (rejected: duplicate transform setup).

**Consequences.** Two runners, both wired in CI. Integration tests use a real PostgreSQL service,
never a mocked database. See [`../testing/TESTING_ARCHITECTURE.md`](../testing/TESTING_ARCHITECTURE.md).

## D-008 — React 19 + Vite 7

**Status:** Accepted · **In code:** implemented

**Context.** `@vitejs/plugin-react` 6 requires Vite 8; Vite 7 is the newest line whose React plugin
is stable with the rest of the toolchain.

**Decision.** React 19.3, Vite 7.3, `@vitejs/plugin-react` 5, `react-router-dom` 7.

**Alternatives.** Vite 8 (rejected: plugin not stable at decision time); Next.js (rejected: the
product is a desktop/SPA client with no SSR requirement).

**Consequences.** The renderer is a client-side SPA served statically and loaded by Electron.

**Related:** [`../web/FRONTEND_ARCHITECTURE.md`](../web/FRONTEND_ARCHITECTURE.md), [`../desktop/DESKTOP_ARCHITECTURE.md`](../desktop/DESKTOP_ARCHITECTURE.md).

## D-009 — Electron 45 desktop shell

**Status:** Provisional · **In code:** partial (shell built; launch unverified here)

**Context.** Branches need an installable POS that works offline. Electron provides a Chromium
renderer plus a Node-capable main process without a second UI codebase.

**Decision.** Electron 45 hosts the same React renderer. Security defaults: `contextIsolation`,
`sandbox`, no `nodeIntegration`, an allowlisted preload bridge, denied window-open, navigation and
webview, and all permissions denied until explicitly granted.

**Alternatives.** Tauri (rejected: Rust toolchain and a different webview model); browser-only
(rejected: no durable offline store or device binding); native per-OS apps (rejected: four codepaths).

**Consequences.** Packaging, code signing, auto-update and SQLite driver choice remain open. The
renderer never receives raw `ipcRenderer` or filesystem access. See
[`../desktop/DESKTOP_ARCHITECTURE.md`](../desktop/DESKTOP_ARCHITECTURE.md).

## D-010 — Stable probes; business API under `/api`

**Status:** Accepted · **In code:** implemented

**Context.** Orchestrators need probe paths that never change. Business routes need a versioned
public contract.

**Decision.** `/health` (liveness, 200) and `/ready` (readiness, 200 or 503) sit outside the global
prefix and are never versioned. The Nest global prefix is `api`; business controllers mount `v1`, so
the public business contract is `/api/v1/...`.

**Alternatives.** Versioned probes (rejected: probe churn on every release); no prefix (rejected:
collides with static hosting and proxies).

**Consequences.** Today only the probes exist. The version segment is a controller rule, not a
middleware rewrite. See [`../api/API_ARCHITECTURE.md`](../api/API_ARCHITECTURE.md).

## D-011 — API boots without PostgreSQL and reports degraded readiness

**Status:** Accepted · **In code:** implemented

**Context.** A boot-time database crash hides the failure from orchestration and makes the API
restart-loop.

**Decision.** Prisma connects lazily. `/ready` runs a bounded `SELECT 1` and returns 503 with a JSON
body when the database is unavailable. `/health` never touches the database.

**Alternatives.** Crash on start (rejected: no diagnostic surface); retry forever before listening
(rejected: readiness could never report the cause).

**Consequences.** SQL errors surface per request until the database recovers; readiness decides
traffic eligibility. Verified in Phase 0 by stopping PostgreSQL.

**Related:** D-010, [`../api/API_ARCHITECTURE.md`](../api/API_ARCHITECTURE.md), [`SYSTEM_ARCHITECTURE.md`](SYSTEM_ARCHITECTURE.md).

## D-012 — Single development database role

**Status:** Provisional · **In code:** implemented (development only)

**Context.** Development uses one PostgreSQL owner role; least-privilege migration and runtime roles
are an operations concern.

**Decision.** Use one role for development and CI. Production needs a migration role and a
least-privilege application role before deployment.

**Alternatives.** Building the two-role setup now (deferred: blocks foundation work without a
deployment target).

**Consequences.** No production migration strategy exists yet; this must be resolved before the
first production deployment, not before the first schema.

**Related:** [`../operations/local-development.md`](../operations/local-development.md), D-016.

## D-013 — Business-type differences through configuration

**Status:** Constrained · **In code:** not started

**Context.** Grocery, fashion, pharmacy and cosmetics differ in attributes, units, batches, expiry,
variants and terminology, but share catalog, inventory, procurement, sales and reporting.

**Decision.** One platform with a configuration registry: business type, industry profile,
capability flags, attribute definitions, unit rules and labels are data. Behaviour differences are
validated against those definitions, not forked into separate modules or applications.

**Alternatives.** Four applications (rejected: four maintenance streams); plugin modules per type
(rejected: deployment and test matrix explosion).

**Consequences.** Services must accept profile-driven definitions; a business-type change is
restricted once operational records exist. See
[`../product/scope-and-phases.md`](../product/scope-and-phases.md) and `business-configuration` in
[`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md).

## D-014 — AI remains advisory

**Status:** Constrained · **In code:** not started

**Context.** Forecasting and recommendations can inform purchasing and pricing, but an autonomous
write to stock, prices or purchase orders is unacceptable for financial and operational control.

**Decision.** Every AI output is a proposal record with inputs, confidence and explanation. A human
with the owning permission reviews it; approval creates a normal workflow command in the owning
module. No AI path can approve receiving, change stock, set prices or issue refunds.

**Alternatives.** Automated reordering (rejected: the brief forbids it); AI as a hidden scoring
service without stored proposals (rejected: not auditable).

**Consequences.** Recommendations need review queues, actor attribution and audit. Model failure
degrades advice only, never operations. See `intelligence` in
[`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md).

## D-015 — Prisma schema lives in `apps/api/prisma`

**Status:** Accepted · **In code:** implemented

**Context.** `PROJECT_STRUCTURE.md` placed the schema under `database/prisma`. Prisma resolves the
`prisma`/`@prisma/client` packages relative to the **schema directory**; from `database/prisma` it
auto-installed packages at the repository root and generated a different pnpm copy than the one
`apps/api` imports, so the API would ship an ungenerated client.

**Decision.** Keep the schema at `apps/api/prisma/schema.prisma`. `database/` holds seeds and
diagrams only.

**Alternatives.** Keeping the original path with a postinstall workaround (rejected: fragile and
already failed); generating the client into a shared package (rejected: adds a build step without
removing the resolution problem).

**Consequences.** Deviation from `PROJECT_STRUCTURE.md` is intentional and documented. The schema is
still model-less; Step 3 owns its content.

**Related:** [`../../database/README.md`](../../database/README.md), D-005, [`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md).

## D-016 — PostgreSQL as the central system of record

**Status:** Constrained · **In code:** partial (development container only)

**Context.** The platform needs transactions across stock, sales, payments and audit, plus reliable
constraints and reporting queries.

**Decision.** PostgreSQL 17 is the single central database behind the API. All business state,
access data, audit and sync metadata live there. Only the API connects to it.

**Alternatives.** MySQL (rejected: weaker JSON/partial-index ergonomics for this design); MongoDB
(rejected: cross-document invariants for stock and money); one database per business (rejected:
migration and cost overhead for a small team).

**Consequences.** Backups, PITR and migration roles become deployment requirements. The desktop main
process and renderer never connect to PostgreSQL. See
[`../operations/local-development.md`](../operations/local-development.md).

## D-017 — SQLite as the local offline store

**Status:** Provisional · **In code:** not started

**Context.** A branch must keep selling when the network is down. Data needs to survive app restart
and power loss, and the renderer must not receive filesystem access.

**Decision.** The Electron main process owns a local SQLite database containing the offline catalog
subset, prices, branch stock cache, configuration, the sale outbox and sync metadata. Renderer
access is through narrow IPC commands only.

**Alternatives.** IndexedDB in the renderer (rejected: weaker durability and no main-process
transaction control); files with JSON snapshots (rejected: no atomic multi-row commits); a remote
cache only (rejected: no offline sales).

**Consequences.** Driver selection (native module vs Node's built-in SQLite) is decided in the
desktop implementation plan; encryption and device binding are required. See
[`../desktop/DESKTOP_ARCHITECTURE.md`](../desktop/DESKTOP_ARCHITECTURE.md) and
[`OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md`](OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md).

## D-018 — REST + OpenAPI instead of GraphQL

**Status:** Constrained · **In code:** partial (HTTP shell; no OpenAPI document yet)

**Context.** Four developers, three clients (web, desktop, future integrations) and a strong need for
predictable authorization per endpoint and simple offline replay.

**Decision.** Resource-oriented REST with Swagger/OpenAPI documentation generated from the API.
Commands that are not pure CRUD use explicit action sub-resources.

**Alternatives.** GraphQL (rejected: per-field authorization and query-cost control add work; offline
replay of mutations is less direct); tRPC (rejected: couples clients to TypeScript internals and
weakens the public contract).

**Consequences.** Each endpoint declares method, permission and scope. Idempotency keys are part of
the contract. See [`../api/API_ARCHITECTURE.md`](../api/API_ARCHITECTURE.md).

## D-019 — Shared-schema multi-tenancy with backend scope

**Status:** Accepted · **In code:** not started

**Context.** Many businesses share one deployment. Isolation must be provable and cheap to operate.

**Decision.** One schema; every business-owned row carries `businessId`, and branch-scoped rows carry
`branchId`. Business scope comes from the URL (`/api/v1/businesses/:businessId/...`), is validated
against membership by a guard, and is passed explicitly to services. Queries always include the
scope; composite foreign keys prevent cross-business references.

**Alternatives.** Schema per tenant (rejected: migrations and connection management multiply);
database per tenant (rejected: cost and backup sprawl); implicit tenant from the token only
(rejected: multi-business users need an explicit switch).

**Consequences.** Every query and mutation is scope-checked, and isolation tests are mandatory.
Background jobs carry `businessId`; audit records attribute business and branch. See
[`MULTI_TENANT_SECURITY_ARCHITECTURE.md`](MULTI_TENANT_SECURITY_ARCHITECTURE.md).

## D-020 — Feature-based frontend modules

**Status:** Accepted · **In code:** partial (single page, no feature folders)

**Context.** Screens map to business areas (POS, catalog, stock, purchasing, reports), and four
developers work in parallel on different areas.

**Decision.** Organize the React app by feature under `src/features/<feature>` with route, API hooks,
components, state and tests collocated; shared UI and infrastructure live in `src/shared` and
`src/lib`. Route configuration is composed from feature route exports.

**Alternatives.** Layer-first folders (`components/`, `hooks/`, `pages/` globally) (rejected: changes
scatter and ownership blurs); one folder per business type (rejected: duplicates screens).

**Consequences.** A feature owns its route subtree and server-state hooks. Cross-feature reuse moves
to `shared` only when proven. See [`../web/FRONTEND_ARCHITECTURE.md`](../web/FRONTEND_ARCHITECTURE.md).

## D-021 — Domain-oriented backend modules, not layer-first packages

**Status:** Constrained · **In code:** not started

**Context.** Layer-first packages (`controllers/`, `services/`, `repositories/`) let a change touch
every folder and make ownership and dependency direction unreadable.

**Decision.** Each business capability is a module folder containing its API, application, domain and
infrastructure slices, with one public entry file. Modules own their tables. Dependencies follow the
map in [`MODULE_DEPENDENCY_MAP.md`](MODULE_DEPENDENCY_MAP.md).

**Alternatives.** Nest CLI default flat structure (rejected: no boundary); one module per controller
(rejected: no ownership); full DDD for every module (rejected: ceremony without invariants).

**Consequences.** Heavy DDD is reserved for stock, money, permissions and history. Controllers stay
thin. Review rejects imports of another module's internals.

## D-022 — Durable offline outbox with client-generated operation IDs

**Status:** Constrained · **In code:** not started

**Context.** A completed sale must survive a crash and must never be duplicated when the network
returns or a retry replays.

**Decision.** The sale commits to local SQLite before the UI reports success, together with an outbox
row carrying a client-generated `operationId`. Sync sends operations in order, the server deduplicates
by device + operation ID, and a conflict creates a visible record instead of deleting the sale. A
stock shortfall is a conflict: no sale or stock movement is committed, and the transaction is
preserved as a reconciliation exception under [D-025](#d-025--strict-stock-protection-for-offline-transactions).

**Alternatives.** Server acknowledgement before success (rejected: loses sales offline); fire-and-forget
sync (rejected: silent loss); last-write-wins without records (rejected: destroys financial facts).

**Consequences.** Server ingest must be idempotent; the queue must be durable and recoverable; failed
operations stay visible until resolved. See
[`OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md`](OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md).

## D-023 — Backend-enforced, deny-by-default authorization

**Status:** Constrained · **In code:** not started

**Context.** Hiding UI is not security. Roles differ by business and branch, and Business Admin must
not inherit physical-operation rights.

**Decision.** The backend owns a permission catalogue and evaluates every protected route with a
deny-by-default policy. The request pipeline resolves principal, membership, branch and permission;
domain services re-check state-transition permissions. The client's role only shapes navigation.

**Alternatives.** Client-side route guards (rejected: trivially bypassed); per-endpoint role strings
(rejected: cannot express branch scope or granular permissions); database row-level security only
(rejected: does not cover application workflow rules).

**Consequences.** Every endpoint declares a permission and a scope. Tests must cover each role on
restricted operations and cross-tenant attempts. See
[`MULTI_TENANT_SECURITY_ARCHITECTURE.md`](MULTI_TENANT_SECURITY_ARCHITECTURE.md).

## D-024 — URL versioning `/api/v1` and problem-details errors

**Status:** Accepted · **In code:** partial (prefix exists; version segment and error format pending)

**Context.** Clients update at different speeds, and the desktop app may lag behind the API. Error
responses today are the Nest default envelope.

**Decision.** Business endpoints live under `/api/v1`. Probes stay unversioned. Errors use an
RFC 9457-style problem document with `type`, `title`, `status`, `detail`, `code` and `correlationId`;
validation failures add field errors. Breaking changes require a new version, not a silent change.

**Alternatives.** Header versioning (rejected: invisible in logs and proxies); unversioned API
(rejected: no safe evolution); custom error envelope (rejected: reinventing a standard).

**Consequences.** The frontend and desktop clients parse one error shape. Swagger documents both
success and problem responses. See [`../api/API_ARCHITECTURE.md`](../api/API_ARCHITECTURE.md).

## D-025 — Strict stock protection for offline transactions

**Status:** Approved · **In code:** not started

**Context.** The platform must never create negative inventory, and it must never discard a completed
offline transaction. If two offline devices sell the same shared unit, the later synchronization
cannot commit that sale without violating stock.

**Decision.** Strict stock protection applies to offline transactions exactly as to online ones.

**Rule.** An offline transaction is a locally recorded transaction awaiting server validation. It is
not permission to bypass authoritative inventory constraints.

**Invariant.** No accepted stock movement may result in negative available inventory.

**Insufficient stock behavior.** The server rejects the inventory commit and creates or retains a
reconciliation exception without committing the sale or any stock movement. The exception records
the branch, cashier, device, operation ID, products, quantities, recorded prices, payments and
timestamps captured by the device, plus the rejection reason. It stays visible until an authorized
resolution is recorded.

**Idempotency.** Repeated submissions of the same `(deviceId, operationId)` must not create duplicate
sales, duplicate stock movements or duplicate reconciliation exceptions.

**Auditability.** The original transaction, the validation outcome, the reconciliation record and
the full resolution history remain traceable. There is no automatic approval and no automatic
inventory adjustment.

**Resolution.** Resolution requires an authorized human — Owner or Manager with the reconciliation
permission, never Business Admin for a physical stock outcome — and physical verification wherever a
stock discrepancy must be investigated. Any corrective adjustment or stocktake is recorded
separately with its own audit history. If the business decides to fulfil the held transaction after
the stock position is corrected, the operation is explicitly released and revalidated once; it can
never be committed twice. Any customer or financial remedy not defined by the approved business
requirements is an authorized business decision, not an automatic rule.

**Alternatives.** Accepting the offline sale and allowing a flagged negative balance (the earlier
provisional policy; rejected by the product owner: the system must never create negative inventory);
clamping stock at zero (rejected: hides the shortage and corrupts the ledger); silently reducing
quantities or editing prices (rejected: alters financial history); blocking all offline sales
(rejected: defeats offline POS).

**Consequences.** Offline POS remains available; a locally recorded sale may later require
reconciliation. Synchronization must return a distinct, non-retryable-until-resolved outcome for a
stock shortfall. Resolution is manual, role-bounded and audited. Inventory guards remain the last
line of defence for every accepted movement. See
[`OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md`](OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md),
[`MULTI_TENANT_SECURITY_ARCHITECTURE.md`](MULTI_TENANT_SECURITY_ARCHITECTURE.md) and
[`../testing/TESTING_ARCHITECTURE.md`](../testing/TESTING_ARCHITECTURE.md).

## D-026 — In-process events plus a transactional outbox, no broker

**Status:** Accepted · **In code:** not started

**Context.** Modules need to react to each other without turning every side effect into a synchronous
coupling, and external calls must survive a crash after commit. A broker adds infrastructure the
team cannot operate yet.

**Decision.** Publish internal events in-process after the transaction commits. When an external or
retriable side effect is needed, write an outbox row in the same transaction; an in-process worker
claims rows with database locks and retries with backoff. Handlers are idempotent.

**Alternatives.** RabbitMQ or Kafka (rejected: operational cost exceeds the benefit at this scale);
synchronous calls for everything (rejected: coupling and latency); BullMQ/Redis (rejected: another
stateful service).

**Consequences.** Events are not durable unless they are part of an outbox workflow; the registry is
explicit; multiple API replicas must lock jobs. See the communication rules in
[`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md) and the deployment view in
[`SYSTEM_ARCHITECTURE.md`](SYSTEM_ARCHITECTURE.md).

## D-027 — Four business roles plus platform Super Admin; Admin is digital-only

**Status:** Constrained · **In code:** not started

**Context.** The brief defines Owner, Business Admin, Manager and Cashier and states that Business
Admin is a software administrator who must not receive physical-operation permissions.

**Decision.** Business roles: Owner (all business rights, billing, ownership transfer), Business
Admin (configuration, catalog, users, master data, digital documents), Manager (physical and
operational execution within assigned branches), Cashier (POS, own sales, own shift). Super Admin is
a platform role outside every business, usable only through D-028. Business Admin never receives
receiving, stock count/adjustment, transfer execution, refund execution, cash handling or POS
permissions.

**Alternatives.** A single configurable role with all permissions (rejected: violates the brief);
custom roles per business now (deferred: permission catalogue first); Manager inheriting Admin
(rejected: blurs the separation).

**Consequences.** Permission assignments are role templates, not free text. Tests must prove Admin is
denied physical operations. See
[`MULTI_TENANT_SECURITY_ARCHITECTURE.md`](MULTI_TENANT_SECURITY_ARCHITECTURE.md).

## D-028 — Super Admin support access is time-boxed, reason-bound and audited

**Status:** Accepted · **In code:** not started

**Context.** Platform operators need to diagnose tenant problems without becoming silent tenants.

**Decision.** Super Admin has no standing business permissions. Support access requires a documented
reason and an explicit grant for one business and a time window. Every use is audited, the grant is
visible to the business Owner, and it expires automatically.

**Alternatives.** Permanent global admin (rejected: unbounded blast radius); impersonation without
records (rejected: unauditable); no support access (rejected: cannot operate the platform).

**Consequences.** Support sessions are separate from business sessions and cannot approve money
movements. See `super-admin` in [`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md).

## D-029 — One shared React renderer for web and desktop

**Status:** Constrained · **In code:** implemented (shell loads the built web app)

**Context.** Maintaining a browser UI and an Electron UI would double every screen and drift.

**Decision.** `apps/web` builds the renderer; Electron loads the built output (or the Vite dev server)
and adds desktop-only capabilities through preload IPC. Features detect capabilities rather than
forking screens.

**Alternatives.** Separate Electron UI (rejected: duplication); web only (rejected: no offline POS);
desktop only (rejected: owners and admins need browser access).

**Consequences.** Desktop-only behaviour is explicit and capability-gated. Security hardening applies
to the single renderer. See [`../desktop/DESKTOP_ARCHITECTURE.md`](../desktop/DESKTOP_ARCHITECTURE.md).

## D-030 — Documentation by concern under `docs/`

**Status:** Accepted · **In code:** implemented

**Context.** Twelve architecture topics and existing operational/product docs would be unreadable as
one file and would duplicate each other.

**Decision.** Keep one authoritative document per concern under `docs/architecture`, `docs/api`,
`docs/web`, `docs/desktop`, `docs/integrations`, `docs/testing`, `docs/team`, `docs/operations`,
`docs/product` and `docs/requirements`. `SYSTEM_ARCHITECTURE.md` is the index and ownership table.
Superseded documents are deleted, not left as parallel truths.

**Alternatives.** One monolithic architecture file (rejected: merge conflicts and poor navigation);
a wiki outside the repository (rejected: drifts from code review); per-module docs now (deferred:
modules do not exist).

**Consequences.** Links are relative and checked; the decision log is this file. See
[`SYSTEM_ARCHITECTURE.md`](SYSTEM_ARCHITECTURE.md).

## D-031 — Secrets live only in the backend environment

**Status:** Constrained · **In code:** partial (validated environment; no secrets exist yet)

**Context.** The renderer is shipped to users and `VITE_` variables are embedded in the bundle.
Leaking a payment secret or service credential would be unrecoverable.

**Decision.** Secrets (database URL, Chapa secret, webhook secret, email/SMS credentials, storage
keys) live in server environment variables validated at boot. The renderer receives only public
configuration (API base URL, public keys explicitly intended for clients). Nothing secret is committed.

**Alternatives.** Secrets in the renderer (rejected: public by construction); a client-side proxy key
(rejected: still extractable); committing a `.env` for convenience (rejected).

**Consequences.** Webhook verification and provider calls happen only in the API. Rotation is an
operations procedure. See [`../operations/environment-configuration.md`](../operations/environment-configuration.md)
and [`../integrations/INTEGRATION_ARCHITECTURE.md`](../integrations/INTEGRATION_ARCHITECTURE.md).

## D-032 — Chapa hosted checkout with verified webhooks

**Status:** Provisional · **In code:** not started

**Context.** Subscription payments need card and mobile-money support without putting the platform in
PCI scope. Chapa is the chosen provider.

**Decision.** The API creates a payment attempt server-side, redirects the Owner to Chapa's hosted
checkout, verifies the webhook signature, deduplicates by provider reference, and reconciles by
querying the provider before activating an entitlement. Activation is idempotent and recorded in
audit.

**Alternatives.** Collecting card data directly (rejected: PCI scope); trusting the redirect callback
alone (rejected: forgeable); manual activation (rejected: does not scale).

**Consequences.** Webhook endpoint is public but signature-verified, rate-limited and not
user-authenticated. No integration is claimed to work until tested against the sandbox. See
[`../integrations/INTEGRATION_ARCHITECTURE.md`](../integrations/INTEGRATION_ARCHITECTURE.md).

## D-033 — Forecasting runs as a scheduled batch and writes proposals

**Status:** Provisional · **In code:** not started

**Context.** Demand forecasting needs history and must not compete with OLTP requests or mutate
operations.

**Decision.** Forecast runs read from analytics read models and sales/inventory history on a schedule,
store inputs, model metadata, points, confidence and explanations, and emit a proposal. Review and
execution happen through normal module commands under human permissions.

**Alternatives.** Real-time inference inside POS requests (rejected: latency and coupling); external
SaaS forecasting (deferred: data residency and cost); no stored run metadata (rejected: unexplainable
advice).

**Consequences.** Model choice and hosting remain open; any provider runs behind an adapter. Forecast
failure never blocks sales, purchasing or stock. See D-014 and
[`BACKEND_ARCHITECTURE.md`](BACKEND_ARCHITECTURE.md).

## D-034 — Four-member ownership rebalanced by estimated effort

**Status:** Accepted (product-owner approved) · **In code:** n/a (working agreement)

**Context.** The earlier allocation gave M1 ten modules and M4 five, while M1's extra modules
(notifications, synchronization, files) were not the lightest. Equal module counts would still be
unequal work, because sales, inventory, identity and tenancy dominate effort. The team has four
members and two shared computers, and each member must make independently attributable,
full-lifecycle contributions.

**Decision.** Use the approved allocation: M1 identity, tenancy, authorization, employees,
subscriptions, super-admin, audit; M2 business-configuration, catalog, pricing, files; M3 inventory,
suppliers, procurement; M4 customers, sales, after-sales, analytics, intelligence, synchronization,
notifications. One accountable owner per module. Balance workload with relative effort points over
the full lifecycle, supporting packages (shared frontend platform to M2; test infrastructure,
hardware and packaging support to M3; dependency lint to M1; observability to M3) and peer support
shifts (analytics UI to M2; sales/offline test fixtures to M3; audit UI to M2) without moving
ownership. Work from two computers with the pairing M1+M2 and M3+M4, each member using their own
identity, branch and PR attribution, and rotating the keyboard.

**Alternatives.** Equal module counts per member (rejected: ignores complexity); moving analytics or
synchronization away from M4 (rejected: splits the POS–sync–reporting contract and its offline
testing); four separate computers (not available); one member owning all documentation or testing
(rejected: violates full-lifecycle contribution).

**Consequences.** The baseline is approximately 24–26% estimated effort per member with a residual
M4 load carried by explicit peer support. Estimates are revisited at each phase gate; a rebalance
prefers redistributing supporting tasks, and any module move needs a new ADR. See
[`MODULE_DEPENDENCY_MAP.md`](MODULE_DEPENDENCY_MAP.md),
[`../team/TEAM_DEVELOPMENT_GUIDELINES.md`](../team/TEAM_DEVELOPMENT_GUIDELINES.md) and
[`../testing/TESTING_ARCHITECTURE.md`](../testing/TESTING_ARCHITECTURE.md).
