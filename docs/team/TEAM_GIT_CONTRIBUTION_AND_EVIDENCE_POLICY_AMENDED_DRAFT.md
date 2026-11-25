# Team Git contribution and evidence policy — AMENDED DRAFT

> **STATUS: DRAFT — NOT YET OWNER-APPROVED.**
> This document amends `TEAM_GIT_CONTRIBUTION_AND_EVIDENCE_POLICY.md` per
> `TEAM_GIT_CONTRIBUTION_POLICY_AMENDMENT_PROPOSAL.md`. It becomes binding only after explicit
> project-owner approval recorded in `C6A_OWNER_DECISION_RECORD.md`. Until then the original
> policy remains the reference and neither document has been activated retroactively.

**Scope:** All four members (M1–M4). Applies prospectively from the first policy-compliant
commit after owner approval; it does not retroactively attribute historical work.

## 1. Purpose and integrity basis

This policy exists to produce **verifiable, honest** contribution evidence for the four-member
project. It is an academic-integrity instrument:

- Members must **not** manufacture Git activity, create artificial/empty commits, impersonate
  another member, backdate work, or misrepresent anyone's contribution.
- A member must not commit another member's work under their own identity.
- Evidence must be independently checkable (`git log`, `gh pr view`, register rows).
- Where evidence cannot be established honestly, the register says "unverifiable" — that is a
  valid, acceptable record.

## 2. Member identifiers (to be confirmed by owner)

| ID  | Module ownership (unchanged)               | Real name / approved identifier | Verified Git email | Status      |
| --- | ------------------------------------------ | ------------------------------- | ------------------ | ----------- |
| M1  | Platform and SaaS                          | _PENDING owner confirmation_    | _PENDING_          | Unconfirmed |
| M2  | Business Configuration and Product Catalog | _PENDING_                       | _PENDING_          | Unconfirmed |
| M3  | Inventory and Procurement                  | _PENDING_                       | _PENDING_          | Unconfirmed |
| M4  | Sales and Intelligence                     | _PENDING_                       | _PENDING_          | Unconfirmed |

Rules:

- Each member uses their **own genuine Git author identity** (`user.name`, `user.email`).
- Before the first policy commit, each member verifies identity and proves email control
  (commit author email matches their GitHub account email).
- No credential sharing, no impersonation, no shared `git config` left active for the next user.

## 3. Branching and commits

Convention (retained): `m#/<module>-<short-task>` — e.g. `m3/inventory-stocktake-approval`.

- Trunk-based on `main`; short-lived branches; rebase before PR (TEAM_DEVELOPMENT_GUIDELINES §5).
- One member = one branch prefix. The `m#` identifies the **author**, not the module owner.
- **Collaborative task:** if two members genuinely co-author a change, either (a) each commits
  their own portion on the same branch with truthful authorship, or (b) work is recorded as
  joint in the register with both named. The branch keeps the primary author's `m#` prefix and
  the PR names all contributors.
- **Cross-module integration:** the author uses their own `m#`; the owning module's member is
  the required reviewer per MODULE_DEPENDENCY_MAP. Integration-only work (wiring two modules)
  is recorded under attribution type **integration**.
- Commits must be meaningful and describe real work. No empty/artistic commits.

## 4. Pull requests and review

Standard path (TEAM_DEVELOPMENT_GUIDELINES §6 remains authoritative):

- PR description states: author member ID, owning module, task, what/why, commands run and
  results, tests added, affected files, migration/contract notes, linked task.
- At least one approval; module owner approval required for their module; two approvals for
  migrations, authorization/tenant-scope, payment, offline-sync, shared-infrastructure and new
  dependencies. Author never approves own PR.
- Review comments and change requests are evidence — preserved in the PR and summarized in the
  register.

**Narrow exception:** typo fixes, comment-only edits and single-file doc corrections may merge
with one review and a register row noting the exception. Anything touching code, schema,
authorization, money or sync follows the full path. Emergency merges require a written
justification in the PR and register.

## 5. Attribution categories (register notation)

| Category                | Meaning                                          | Register notation       |
| ----------------------- | ------------------------------------------------ | ----------------------- |
| Individual              | One member authored the work                     | `IND`                   |
| Joint                   | Two or more members co-authored                  | `JNT` + all member IDs  |
| Reviewed                | Member reviewed but did not author               | `REV` (reviewer column) |
| Integration             | Cross-module wiring/integration work             | `INT`                   |
| Unverifiable historical | Work exists but authorship cannot be established | `UNV`                   |

Shared-computer use is **not** a justification for false attribution: the author is always the
person who wrote the change, verified at commit time (§6).

## 6. Shared-computer workflow

Computers: **Computer 1** = M1 + M2; **Computer 2** = M3 + M4.

Default (sequential use — simplest, preferred):

1. Before starting, run `git config user.name && git config user.email` and confirm they are
   **your own**. If not, set your own before any commit.
2. Work on your own `m#` branch only.
3. Before handing over: commit or stash your work on your branch; confirm `git status` is clean
   or intentionally parked; never leave uncommitted work for the next member to commit under
   the wrong identity.

Simultaneous use (only when needed):

- Use `git worktree` (or a separate clone) per member so working trees and config do not
  collide. Each worktree/clone still uses the member's own identity — `git config` is
  per-repository, so set `user.name`/`user.email` inside each worktree.
- Credentials: each member authenticates with their own GitHub account (OS credential manager
  or SSH key). Sign out/in when switching members.

## 7. Contribution register

`TEAM_CONTRIBUTION_EVIDENCE_REGISTER.md` is **append-only**. Corrections are new rows that
reference the corrected row — never silent edits or deletions.

Each entry records: Member ID · real name/identifier · module · task · attribution type
(§5) · branch · commit hash(es) · PR reference · reviewer(s) · review outcome · verification
evidence · date · evidence location.

- Record real merged work only; no invented hashes/PRs/reviews.
- Historical rows may cite only evidence that verifiably exists; otherwise `UNV`.

## 8. Transitional rule for existing uncommitted work

All Step 2/Step 3 work currently in the working tree is uncommitted. Going forward:

- Each member commits their own attributable portion on their own `m#` branch with truthful
  authorship.
- Work that cannot be honestly attributed to an individual is recorded as `UNV`
  (unverifiable historical) or `JNT` only where the team can genuinely confirm joint work.
- No retroactive assignment of authorship to balance contribution counts.

## 9. Ongoing compliance

- Module owners review PRs in their modules per existing rules; reviewers verify authorship
  matches the claimed member ID.
- The register is reviewed at each phase checkpoint (TEAM_DEVELOPMENT_GUIDELINES §8).
- Violations (impersonation, fabricated commits, misattributed authorship) are escalated to the
  project owner and recorded; they are not corrected by rewriting history.
