# Team development guidelines

**Status:** Step 2 working agreement. It applies from the first domain module onward. Ownership and
dependency rules are defined in [`../architecture/MODULE_DEPENDENCY_MAP.md`](../architecture/MODULE_DEPENDENCY_MAP.md);
this document covers how four people work without breaking them.

## 1. Ownership

### 1.1 Approved baseline (D-034)

The product owner approved this allocation. It replaces the earlier ten/three/three/five split.
One accountable owner per module; the owner covers the full lifecycle described in §1.3.

| Member | Scope                                      | Owned modules                                                                          | Shared responsibility                                                                             |
| ------ | ------------------------------------------ | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| M1     | Platform and SaaS                          | identity, tenancy, authorization, employees, subscriptions, super-admin, audit         | Shared backend kernel, CI health, auth/Z conventions, Chapa, release integration, dependency lint |
| M2     | Business configuration, products and files | business-configuration, catalog, pricing, files                                        | Shared frontend platform, business-type profiles, import/export tooling                           |
| M3     | Inventory and procurement                  | inventory, suppliers, procurement                                                      | Stock invariants, receiving workflow, test infrastructure, hardware/packaging support             |
| M4     | Sales, intelligence and synchronization    | customers, sales, after-sales, analytics, intelligence, synchronization, notifications | POS behavior, offline and reconciliation contract, reports                                        |

Rules:

- One owner per module. The owner designs its tables, implements its backend and frontend surface,
  writes its tests and documentation, and is the reviewer for every contract change touching it.
- Ownership is not exclusivity: another member may open a PR in an owned module, but the owner
  reviews and approves it. Supporting contributions are recorded in the PR.
- Shared backend kernel, root configuration and pipeline definition are owned by M1; the shared
  frontend platform by M2; test infrastructure and fixtures by M3. Changes there need the relevant
  owner's review and, for architectural impact, an ADR.
- Cross-module contracts are changed by the provider's owner after notifying every consumer listed
  in the registry.
- Moving a module between members requires a concrete dependency or workload reason and a new or
  amended ADR; one owner always remains accountable.

### 1.2 Workload balance by estimated effort, not module count

Equal module counts would not mean equal work: `sales`, `inventory`, `identity` and `tenancy` are far
heavier than `files` or `notifications`. The matrix uses relative effort points per module covering
backend, frontend, database/migrations, API and integrations, validation and permissions, unit and
integration tests, documentation and acceptance. One point is a small slice; ten points is a
phase-spanning module. These are judgment-based estimates, not measurements; they are re-checked at
every phase gate and may move by roughly ±2 points.

| Member | Module effort                                                                                         | Module total |
| ------ | ----------------------------------------------------------------------------------------------------- | ------------ |
| M1     | identity 8, tenancy 8, authorization 7, employees 3, subscriptions 5, super-admin 3, audit 3          | 37           |
| M2     | business-configuration 5, catalog 8, pricing 4, files 3                                               | 20           |
| M3     | inventory 10, suppliers 3, procurement 8                                                              | 21           |
| M4     | customers 3, sales 10, after-sales 6, analytics 6, intelligence 5, synchronization 8, notifications 3 | 41           |

Supporting packages are shared work that no single module owns but every phase needs:

| Package                                                                                            | Points | Owner |
| -------------------------------------------------------------------------------------------------- | ------ | ----- |
| Shared frontend platform: shell, design system, API client, form/error patterns, accessibility     | 8      | M2    |
| Business-type UI registry and import/export tooling                                                | 5      | M2    |
| Test infrastructure: Vitest/Jest config, Playwright harness, seed factories, isolation scaffolding | 6      | M3    |
| Hardware abstraction (scanners, printers, cash drawer, labels) and packaging verification          | 4      | M3    |
| Dependency lint and contract-test harness                                                          | 2      | M1    |
| Observability, environment runbooks and restore drills                                             | 2      | M3    |

Peer support moves effort without moving ownership; the module owner stays accountable and approves
the change:

| Shift                                                           | Points | From | To  |
| --------------------------------------------------------------- | ------ | ---- | --- |
| Analytics dashboard presentation (M4 accountable)               | 2      | M4   | M2  |
| Sales/offline and reconciliation test fixtures (M4 accountable) | 2      | M4   | M3  |
| Audit viewer UI shell (M1 accountable)                          | 1      | M1   | M2  |

| Member | Module total | Support | Peer shift | Adjusted total | Share of 146 |
| ------ | ------------ | ------- | ---------- | -------------- | ------------ |
| M1     | 37           | 2       | −1         | 38             | ≈26.0%       |
| M2     | 20           | 13      | +3         | 36             | ≈24.7%       |
| M3     | 21           | 12      | +2         | 35             | ≈24.0%       |
| M4     | 41           | 0       | −4         | 37             | ≈25.3%       |

The residual spread is about two points, or roughly half a small module. It is not treated as
achieved equality: M4 still carries the heaviest domain set, and its support shifts are real work
that M2 and M3 must schedule. If measured velocity shows a wider gap at a phase gate, redistribute
supporting tasks first; do not move a module unless its contract boundary stays intact.

### 1.3 Full-lifecycle ownership per module

Acceptance criteria are the module's exit gate; documentation means its backend, API, data and event
entries in the canonical documents. "Collaborates with" names the owners whose contracts cross the
module; the module owner still approves contract changes.

#### Member 1 — platform and SaaS

| Module        | Backend                                           | Database & migrations                       | Frontend                                       | API & integrations                            | Validation & permissions                                      | Tests                                            | Documentation                 | Acceptance criteria                                                          | Collaborates with                                       |
| ------------- | ------------------------------------------------- | ------------------------------------------- | ---------------------------------------------- | --------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------ | ----------------------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------- |
| identity      | Credentials, sessions, refresh rotation, recovery | users, credentials, sessions, reset tokens  | Login, reset, active sessions                  | Auth endpoints, device credential issuance    | Password policy, lockout, revocation                          | Hashing, rotation/reuse, enumeration, rate limit | Identity, security, auth API  | Login→refresh→logout; reuse revokes family; no enumeration                   | M4 (device credentials)                                 |
| tenancy       | Businesses, memberships, invitations, branches    | Tenant tables with composite keys           | Onboarding, switcher, members, branch settings | Business create/switch, branches, invitations | URL scope, membership, branch ownership                       | Isolation, invite expiry, ownership transfer     | Tenancy, API, switching rules | Register→create business→branch→invite; non-member 404; switch resets caches | All owners (scope), M4 (switching)                      |
| authorization | Catalogue, role templates, assignments, evaluator | Permissions, roles, assignments             | Role and permission administration             | Role CRUD and assignment endpoints            | Deny-by-default, grant-only-what-you-hold, Admin exclusion    | Matrix per role, branch scope, revocation        | Permission matrix, security   | Every endpoint declares a permission; Admin denied physical actions          | All owners (permission declarations)                    |
| employees     | Records, status, assignments                      | Employee and assignment tables              | Employee directory and assignment              | Employee CRUD and assignment                  | Branch scope, deactivation effects                            | Assignment boundaries, history preservation      | Employee section, API         | Deactivated employee loses access; history preserved                         | M1 (identity), M4 (cashier shifts)                      |
| subscriptions | Plans, trials, invoices, entitlements, webhook    | Subscription, billing, entitlement tables   | Billing, plans, invoices, notices              | Checkout, webhook, subscription read          | Signature, amount/currency/plan match, server-only activation | Webhook replay, grace, entitlement matrix        | Integration, billing, API     | Sandbox activation once; expiry restricts without deleting data              | M1 (super-admin), all entitlement consumers, Chapa edge |
| super-admin   | Support grants, platform settings, monitoring     | Grants, settings, platform audit references | Platform support console                       | Grant/revoke access, settings                 | Time-boxed, reason-bound, no standing permissions             | Expiry, denied without grant, audit completeness | Operations, security          | Grant expires; every support access audited                                  | All owners (support procedures)                         |
| audit         | Append-only writer and query                      | Audit events, indexes, retention metadata   | Audit viewer and filters                       | Audit query and authorized export             | No update/delete; branch scope                                | Append-only, attribution, export authorization   | Audit section                 | Every state change produces an attributed event                              | All owners                                              |

#### Member 2 — business configuration, products and files

| Module                 | Backend                                                      | Database & migrations             | Frontend                                   | API & integrations          | Validation & permissions                             | Tests                                            | Documentation              | Acceptance criteria                                   | Collaborates with                            |
| ---------------------- | ------------------------------------------------------------ | --------------------------------- | ------------------------------------------ | --------------------------- | ---------------------------------------------------- | ------------------------------------------------ | -------------------------- | ----------------------------------------------------- | -------------------------------------------- |
| business-configuration | Type profiles, capabilities, settings                        | Versioned configuration tables    | Type selection, settings, feature registry | Config read/write           | Immutable type after transactions, capability gating | One profile per type, gating                     | Configuration, UI registry | Four business types run from one core                 | M1 (tenancy), M3, M4 (UI registry)           |
| catalog                | Products, variants, categories, brands, units, media, import | Product/unit/media tables         | Catalog list, editor, import wizard        | CRUD and import             | Variant uniqueness, unit conversion, archive         | CRUD, import idempotency, archive                | Catalog, API, data         | Product with type attributes and units is price-ready | M3 (units), M4 (sales); files is same member |
| pricing                | Lists, overrides, discounts, history                         | Price rows and history            | Price editor and history                   | Price CRUD and resolution   | Precedence, time windows, branch scope               | Precedence, history, offline snapshot            | Pricing, API               | Deterministic effective price; history immutable      | M4 (sales)                                   |
| files                  | Metadata, upload sessions, signed URLs, quarantine           | File metadata and ownership links | Upload, dropzone, preview                  | Upload session and download | MIME/size/checksum, tenant scope                     | Traversal, MIME spoofing, oversize, cross-tenant | Files section              | No execution; signed URLs tenant-scoped               | Catalog, suppliers, procurement, analytics   |

#### Member 3 — inventory and procurement

| Module      | Backend                                                 | Database & migrations                               | Frontend                            | API & integrations                    | Validation & permissions                                     | Tests                                                  | Documentation          | Acceptance criteria                                      | Collaborates with                                          |
| ----------- | ------------------------------------------------------- | --------------------------------------------------- | ----------------------------------- | ------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------ | ---------------------- | -------------------------------------------------------- | ---------------------------------------------------------- |
| inventory   | Ledger, balances, batches, counts, transfers, valuation | Append-only movements, balances, batches, transfers | Stock, stocktake, transfers, alerts | Adjustments, counts, transfers, reads | No-negative atomic guard, branch scope, role separation      | Every movement, no-negative incl. sync, concurrency    | Inventory ledger, data | Every quantity change is a movement; no negative balance | M4 (sales, sync, after-sales, analytics), M3 (procurement) |
| suppliers   | Master, contacts, links, statements                     | Supplier and history tables                         | Directory and detail                | CRUD and statements                   | Isolation, archive-only                                      | Isolation, statement arithmetic                        | Supplier section       | Historical references survive archival                   | Procurement, catalog                                       |
| procurement | RFQ, PO, receiving, invoices, payments                  | Procurement tables and state machines               | Purchasing and receiving screens    | PO, receiving, invoice, payment       | Separation of duties, PO never changes stock, receiving only | PO stock unchanged, partial receiving, three-way match | Procurement, API       | Only accepted receiving increases stock                  | Inventory, suppliers, subscriptions, notifications         |

#### Member 4 — sales, intelligence and synchronization

| Module          | Backend                                                 | Database & migrations                                | Frontend                                        | API & integrations                  | Validation & permissions                                         | Tests                                        | Documentation                  | Acceptance criteria                                      | Collaborates with                             |
| --------------- | ------------------------------------------------------- | ---------------------------------------------------- | ----------------------------------------------- | ----------------------------------- | ---------------------------------------------------------------- | -------------------------------------------- | ------------------------------ | -------------------------------------------------------- | --------------------------------------------- |
| customers       | Profiles, consent, history projections, insights        | Customer tables and projections                      | Customer lookup and profile                     | CRUD and lookup                     | Deduplication, consent                                           | Dedupe, consent, history after archive       | Customer section               | No unauthorized merge; history survives archival         | Sales, after-sales (same owner)               |
| sales           | Sales, payments, receipts, shifts, offline ingest       | Sale, line, payment, receipt, shift tables           | POS, shift, receipt, offline indicators         | Sale, void, return handoff, receipt | Server-resolved prices, no-negative, branch scope                | Atomicity, idempotency, shortfall refusal    | Sales, API, offline            | Sale + stock + payment atomic; no duplicate; no negative | M3 (inventory), M2 (pricing), M4 (sync)       |
| after-sales     | Returns, refunds, exchanges, follow-ups                 | Return, refund, exchange tables                      | Return flow and inspection                      | Create, inspect, approve            | Refund ceiling, inspection-before-restock, branch scope          | Ceiling, inspection, original immutability   | After-sales, API               | Original sale immutable; compensating records only       | Sales, inventory                              |
| analytics       | Read models, reports, exports                           | Read models and report metadata                      | Dashboards, reports, exports                    | Query and export                    | Role/branch scope, export authorization                          | Aggregation, scope, pagination               | Reporting                      | No write access; reports match source                    | All data owners; M2 (dashboard UI)            |
| intelligence    | Forecast runs, proposals, explanations                  | Forecast and recommendation tables                   | Advisory views and review                       | Forecast, recommendation, review    | Proposal-only, no operational writes                             | Fixtures, proposal-only, review attribution  | Intelligence                   | Forecast never mutates stock or price                    | Analytics, inventory, procurement             |
| synchronization | Devices, ingest, idempotency, conflicts, reconciliation | Sync metadata and exception tables; no domain writes | Sync status, conflict and reconciliation queues | Sync envelope, feed, resolution     | Device binding, idempotency, resolution permission, branch scope | Duplicate, shortfall, resolution, revocation | Offline architecture, sync API | Once-only; no loss; no negative; exception visible       | Sales, inventory, desktop; M3 (test fixtures) |
| notifications   | Preferences, templates, delivery, retry                 | Preferences and delivery attempts                    | Inbox and preferences                           | Inbox and preferences               | Recipient scope and preferences                                  | Preference enforcement, retry, independence  | Notifications                  | Delivery failure never rolls back a business transaction | All event publishers                          |

## 2. Shared conventions

| Area         | Convention                                                                                           |
| ------------ | ---------------------------------------------------------------------------------------------------- |
| Language     | TypeScript strict; no `any` without a comment justifying it; no non-null assertions on external data |
| Formatting   | Prettier via the shared config; `pnpm format` before pushing                                         |
| Linting      | ESLint flat configs in `packages/config`; warnings are not ignored in CI                             |
| Commits      | Imperative subject, scoped: `feat(catalog): add variant creation`; body explains why                 |
| Branch names | `feat/<member>-<area>-<short>`, `fix/...`, `chore/...`, `docs/...`                                   |
| API naming   | REST nouns, kebab-case paths, camelCase JSON, stable error codes (API architecture)                  |
| Money        | integer minor units + currency; never floats                                                         |
| Quantities   | decimal strings; never floats                                                                        |
| Time         | UTC ISO 8601 in transport; inject a clock in services for tests                                      |
| IDs          | opaque UUID strings; never parsed by clients                                                         |
| Permissions  | `resource:subject:action`, declared on every endpoint                                                |
| Errors       | problem details with a stable `code`; no stack traces or SQL in responses                            |
| Comments     | explain why, not what; no commented-out code                                                         |
| Docs         | a behaviour change updates the owning architecture/API document in the same PR                       |

No member invents a second convention locally. If the convention is wrong, change it once, in the
shared config or the architecture document, with review.

## 3. API contract workflow

1. The provider owner drafts the contract in the module's DTOs and documents it in the API
   architecture (or the generated OpenAPI once it exists).
2. Consumers are notified in the PR description, even when the change is additive.
3. Additive changes ship in `v1`. Breaking changes require a new version and a deprecation window.
4. Every contract has a test in the provider's module and a consumer test in each consumer's module.
5. Client code is generated or hand-written against the documented shape; it never guesses fields.
6. Contract changes never ride silently inside an unrelated feature PR.

A consumer may not reach around a public contract by importing another module's repository, Prisma
model or private DTO. If the contract is missing something, the provider adds it.

## 4. Database change coordination

The database is shared by all four members even though tables are owned.

- **One migration per PR.** A PR that needs two unrelated schema changes is split.
- **Migrations are append-only.** Never edit or delete a migration that has been merged. Fix forward
  with a new migration.
- **Announce before merge.** Post the table(s), columns, constraints and backfill in the PR; tag the
  owners of any module that reads those tables.
- **Schema owner reviews.** The module that owns the table approves the migration; a migration
  touching two modules needs both owners.
- **Rebase before merging.** A migration created before another merged migration must be regenerated
  or rebased so timestamps stay ordered; never reorder by editing history.
- **No destructive changes without a plan.** Dropping a column/table or rewriting data needs a
  backfill/rollback note and an ADR if it affects financial or audit history.
- **Backfills are separate.** Large data changes run as idempotent jobs with a progress record, not
  inside a blocking migration.
- **Seed data is idempotent.** `database/` seeds can run repeatedly without duplicating rows.
- **Composite tenant keys.** New business-owned tables include `businessId`; branch-scoped tables
  include `branchId`; foreign keys use composite `(businessId, id)` where a cross-tenant reference is
  possible.
- **Prisma schema conflicts.** Resolve by rebasing and regenerating; never hand-merge generated
  output. Run `pnpm prisma:validate` and `pnpm prisma:generate` after conflict resolution.
- **Production is not a development database.** No member runs ad-hoc destructive SQL against shared
  or production data.

Migrations run in CI against a fresh PostgreSQL service before any merge that contains one.

## 5. Branching and integration

- Trunk-based: `main` is always releasable; branches live hours to a few days, not weeks.
- Rebase on `main` before opening or updating a PR. Do not merge `main` into a feature branch just to
  "catch up" if a rebase is clean.
- One logical change per PR. A PR over roughly 400 changed lines (excluding generated files and
  tests) needs a reason in the description.
- Incomplete work stays on the branch; do not merge half a vertical slice behind a hidden flag.
  Ship a complete, tested slice or keep it unmerged.
- Shared branches (`main`) are never force-pushed. A member's own unshared branch may be rebased
  freely.
- Deployment tags are cut from `main` after CI passes; no release from a member's branch.

## 6. Pull request rules

Every PR includes:

1. What changed and why, in the description — not only a title.
2. The commands run and their results (format, lint, typecheck, tests, build) with any not-run items
   stated.
3. Tests added or a reason none are needed.
4. Screenshots or a short recording for UI changes, taken from a real render.
5. Migration and contract notes when applicable.
6. Linked issue/task and the owning member.

Review requirements:

- At least one approval; the module owner's approval is required for their module.
- Two approvals for: migrations, authorization/tenant scope changes, payment logic, offline sync,
  shared infrastructure, and any new dependency.
- The author does not approve their own PR. A rubber-stamp review is a process violation.
- Reviewers check behaviour and evidence, not only style; CI style checks are automated.
- Draft PRs are welcome for early feedback; they are not merged.

## 7. Review checklist

| Check          | Question                                                                        |
| -------------- | ------------------------------------------------------------------------------- |
| Boundary       | Does every import follow the dependency map? Any private module access?         |
| Authorization  | Is every endpoint permission-declared? Is the branch scope checked?             |
| Tenant scope   | Does every query include `businessId`? Is there a cross-tenant test?            |
| Business Admin | Could this grant a physical operation to Admin?                                 |
| Transactions   | Are stock/money changes atomic? Is an idempotency key used where needed?        |
| Client trust   | Does the server recompute prices, totals and permissions?                       |
| Errors         | Problem details with a stable code? No internal leakage?                        |
| Tests          | Do they prove the rule, not the mock? Would they fail if the rule were removed? |
| Migration      | Is it additive, reviewed by the owner, and coordinated?                         |
| Docs           | Is the owning document updated in the same PR?                                  |
| Scope          | Does the PR stay inside its stated slice? No unrelated refactors.               |

## 8. Integration responsibilities

- The provider of a contract owns its correctness; the consumer owns its integration test.
- When a workflow spans members (for example procurement → inventory, or sales → inventory), the
  consumer writes the cross-module integration test and the provider reviews it.
- M1 owns the pipeline definition, backend shared kernel and release integration; M2 owns the shared
  frontend platform; M3 owns test infrastructure, fixtures and hardware/packaging support. A red
  `main` is fixed before new feature work, by the member whose change broke it or, if unclear, the
  last merge author.
- Each phase has an integration checkpoint: the four members run the phase's cross-module scenario
  together against a fresh database before starting the next phase. The checkpoint record names who
  wrote each slice and who reviewed it.
- A member may not mark a module complete while a consumer's integration test against it fails.

## 9. Conflict prevention

| Risk                           | Control                                                                    |
| ------------------------------ | -------------------------------------------------------------------------- |
| Two people editing one module  | Ownership; announce work in the PR/task before starting                    |
| Migration timestamp collisions | Rebase and regenerate; one migration per PR                                |
| Lockfile churn                 | One dependency change per PR; regenerate with the pinned pnpm; announce it |
| Generated files                | Never hand-edit `dist`, Prisma client or OpenAPI output; regenerate        |
| Shared config edits            | M1 review; changes are separate from feature PRs                           |
| Formatting noise               | `pnpm format` before push; no reformat-only commits mixed with logic       |
| Contract drift                 | Contract tests on both sides; OpenAPI diff in review when it exists        |
| Duplicate implementations      | Shared code goes to `shared`/`lib` only after a second real use            |
| Long-lived divergence          | Short branches, rebase daily, small PRs                                    |
| Unclear ownership              | The map is authoritative; ask before editing another module                |

## 10. Two-computer collaboration

The team has four members and two shared computers. The arrangement below is part of the approved
baseline (D-034); it is not a recommendation to buy two more machines.

| Computer   | Members | Usual pairing                                                            |
| ---------- | ------- | ------------------------------------------------------------------------ |
| Computer 1 | M1, M2  | Platform/tenancy work with configuration, catalog, pricing or files work |
| Computer 2 | M3, M4  | Inventory/procurement work with sales, sync or reporting work            |

### 10.1 Identity and attribution

- Each member signs in with their own OS account, GitHub account, Git identity and credentials. No
  shared tokens, SSH keys, password managers or API keys; nothing credential-like is committed.
- Each member authors their own commits. If two members genuinely pair on a change, the person who
  typed it commits and the other can be named as co-author; attribution is accurate, never cosmetic.
- A PR names its real author and the member who reviewed it. Reviewing without reading is prohibited.
- Contributions are measured by merged, tested slices and the review record, not by commit counts or
  hours logged.

### 10.2 Working on a shared machine

- Work on your own branch named with your member label: `feat/m1-...`, `feat/m2-...`, and so on.
  Never work directly on another member's branch.
- Agree on the session order before starting. The member not typing is the reviewer or driver's
  second pair of eyes; rotate the keyboard between sessions so both members do real implementation,
  not only review.
- Pull and rebase before your session. Push your branch before handing the machine over so the other
  member can review it from their own session.
- Do not run two interactive dev servers against the same local database at once. Each member keeps
  their own `.env` and database name (`arp_dev_<name>`); switch configuration between sessions
  rather than sharing one.
- Never leave uncommitted work in the shared working tree. Stash or commit with a clear message
  before handing over; the next member must not need to guess whose changes are present.
- Do not force-push a branch another member is reviewing. Coordinate history changes first.

### 10.3 Shared contracts, migrations and evidence

- Contract changes follow §3: the provider owner updates the contract and notifies every consumer,
  including the member on the other computer. A cross-computer consumer test is still required.
- One migration per PR; announce the tables before merge. Migrations are serialized: pull and apply
  before generating a new one, and never edit a merged migration.
- A migration touching two owners needs both approvals, regardless of which computer produced it.
- Database dumps are not passed between machines when they contain customer or supplier PII. Share
  idempotent seeds and factories instead.
- CI is the shared truth. "Works on my machine" without a CI run or a stated reproduction is not
  evidence.
- Pairing or screen-sharing is encouraged for offline sync, payments, reconciliation and migrations;
  the reviewer still reviews the actual diff, not the demonstration.

## 11. No fake contributions, no shared identities

- Every commit is authored by the person who wrote it. No commits under another person's name, no
  fabricated co-authors, no bot commits pretending to be a member.
- Reviews are real. Approving without reading, or approving to unblock a deadline, is not allowed.
- Credentials, API keys and payment sandbox secrets belong to a person or to CI, never to a shared
  document.
- Contributions are measured by merged, tested work, not by commit count or lines changed.

## 12. Definition of done

A slice is done only when all of these are true:

1. The vertical flow works end to end for the intended role and scope.
2. Authorization, tenant and branch tests exist and pass.
3. The module's contract tests pass; consumers' integration tests pass.
4. Migration (if any) is reviewed and CI-green.
5. Errors use the problem-details contract and leak nothing.
6. Audit records are written for state changes.
7. The owning document and event registry are updated.
8. Format, lint, typecheck, tests and build were run and their results reported.
9. Anything not run is stated as not run.
10. The module owner has approved.

## 13. Cadence

| Ritual                   | Purpose                                                                  |
| ------------------------ | ------------------------------------------------------------------------ |
| Daily async update       | What moved, what is blocked, what needs review; no status theatre        |
| Weekly integration check | Run the phase scenario on a fresh database; fix cross-module drift early |
| Pre-merge review         | Checklist in §7; two approvals where required                            |
| Phase gate               | Dependency-map exit criteria met before the next phase starts            |
| Decision log update      | Any boundary or stack change gets an ADR before implementation           |

## 14. Escalation

- A disagreement inside a module is resolved by its owner.
- A cross-module disagreement is resolved with the affected owners and recorded as an ADR if it
  changes a boundary.
- A security, tenant-isolation or financial-integrity concern stops the merge until resolved; it is
  never overridden by a delivery date.
- If a decision is still blocked after a phase gate, it is escalated to the product owner with the
  options and consequences written down.
