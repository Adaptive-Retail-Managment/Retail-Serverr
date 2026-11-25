# Team Git contribution and evidence policy

**Status:** Prospective process — established 22 November 2026 under Step 3 finding C-6a.
**Scope:** All four members (M1–M4). Applies from the next commit onward; it does not and cannot
retroactively attribute historical work.
**Related:** [Team development guidelines](TEAM_DEVELOPMENT_GUIDELINES.md) (branching, PR and
review rules remain authoritative there; this policy adds identity and evidence rules),
[Contribution evidence register](TEAM_CONTRIBUTION_EVIDENCE_REGISTER.md).

## 1. Why this exists

C-6a found that the repository contains a single commit authored by one identity
(`Bruktawit <bruktawit874@gmail.com>`, foundation commit `a356aad`) and all Step 2/Step 3 work
is uncommitted. No commit, branch, pull request or review can currently be attributed to M2, M3
or M4. This policy defines how genuine, verifiable contribution evidence is produced from now on.

## 2. Individual Git identity (mandatory)

Each member configures **their own** identity — never a shared or borrowed one:

```bash
git config user.name "<Member's real name>"
git config user.email "<Member's own email>"
```

- Use a personal or member-specific email (e.g. a dedicated project email). Do not use another
  member's credentials and do not impersonate anyone.
- Verify before every session on a shared computer:

```bash
git config user.name && git config user.email && git log -1 --format='%an <%ae>'
```

- Every commit's author must be the person who actually did the work. Authorship is evidence;
  falsifying it is a research-integrity violation, not a style issue.

## 3. Branches

The guidelines mandate trunk-based development on `main` with short-lived branches. This policy
adds member attribution to branch names:

```
<m#>/<module>-<short-task>
```

Examples: `m3/inventory-stocktake-approval`, `m1/subscription-webhook-idempotency`.

- Each member works on their own branch for individually attributable tasks.
- Cross-module work: the member doing the work uses their own `m#` prefix and tags the owning
  member in the PR description. Ownership determines the **required reviewer**, not the author.
- Shared/committed-on-behalf-of work (e.g. pairing on one computer) is allowed only when the
  commit author is the person who wrote the change, or when authorship is explicitly declared in
  the PR description and register (see §6).

## 4. Commits

- Commits must be meaningful, task-related, and describe the real change (guidelines §5/§6 apply).
- No artificial or empty commits to inflate contribution counts.
- No member commits another member's work under their own identity. If a member must commit on
  a shared computer, the commit author must still be the actual author (see §7) — or the work
  is recorded honestly as collaborative in the register.
- Prefer several honest commits over one giant commit; commit early and often within a task.

## 5. Pull requests and review

Follow TEAM_DEVELOPMENT_GUIDELINES §6 (PR contents, one approval minimum, two approvals for
migrations/authorization/payment/offline-sync/shared-infra, no self-approval). Additionally:

- The PR description must name the **author member ID**, the **owning module**, the task, the
  tests run, and the affected files.
- Review comments and requested changes are part of the evidence — they are preserved in the PR
  and may be summarized in the register.
- Merge only after required approvals and green CI.

## 6. Contribution register

Every merged PR that represents member work is recorded in
[TEAM_CONTRIBUTION_EVIDENCE_REGISTER.md](TEAM_CONTRIBUTION_EVIDENCE_REGISTER.md) with:

Member ID · real name/approved identifier · module · task · branch · commit hash(es) · PR
reference · reviewer(s) · review outcome · verification evidence · date · evidence location.

Rules:

- Record **real work only**. Never invent hashes, PRs, reviews or outcomes.
- Historical rows (pre-policy) may only cite evidence that actually exists in Git (currently:
  none attributable to M1–M4 individually).
- Collaborative work is recorded once, naming all actual contributors and the split of work.

## 7. Shared-computer workflow (Computer 1: M1+M2 · Computer 2: M3+M4)

Two members share one machine but must keep separate identities:

1. **Before starting work**, the member runs the §2 verification commands and confirms their
   own name/email is active. If not, they set their own identity — never accept the previous
   user's config.
2. Each member uses their own `m#` branch; never commit on another member's branch.
3. If both members work simultaneously, use `git worktree` or separate clones so working trees
   and `git config` do not collide; at minimum, verify identity immediately before each commit.
4. Credentials: each member authenticates with their **own** GitHub account (Git Credential
   Manager / SSH key per member). Do not share credentials; sign out/in when switching members.
5. At handover, the outgoing member confirms `git status` is clean or their work is committed
   on their own branch — nothing is left for the next member to accidentally commit under the
   wrong identity.

## 8. Evidence integrity rules

- Contribution evidence must be independently verifiable: a reviewer can run
  `git log --format='%an <%ae> %h %s'` and `gh pr view` and see the same facts.
- Names in planning documents or module assignments are **not** contribution evidence.
- Retroactive or reconstructed history is prohibited. If early work cannot be attributed, the
  register says so honestly.
- The register is append-only; corrections are new rows referencing the corrected row, never
  silent edits.
