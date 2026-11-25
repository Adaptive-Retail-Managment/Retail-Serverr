# Team Git contribution policy — amendment proposal

**Status:** PROPOSAL — not approved. Presented for owner review alongside
`TEAM_GIT_CONTRIBUTION_AND_EVIDENCE_POLICY_AMENDED_DRAFT.md`.
**Date:** 22 November 2026

## Existing policy issues found on review

| #   | Issue in `TEAM_GIT_CONTRIBUTION_AND_EVIDENCE_POLICY.md`                                                                                                    | Amendment                                                                                                                                                                                 |
| --- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | No member identifiers defined — "M1–M4" are module labels, not confirmed personal identifiers                                                              | Add an identifier-confirmation step: owner/member confirms the real name or approved project identifier behind each M# before the policy activates                                        |
| 2   | Git identity section assumes members already have emails; no verification-of-ownership step                                                                | Require each member to prove control of their Git email (e.g. commit + GitHub account linkage) before first policy commit; record the verified email in the register                      |
| 3   | Shared-computer section offers `git worktree` "or separate clones" without guidance on when each applies — could be over-engineered for a four-person team | Simplify: sequential use with verify-before-commit as the default; `git worktree` only when two members must work simultaneously on the same machine                                      |
| 4   | No explicit category system for attribution types — "collaborative" is mentioned but not defined                                                           | Add five attribution categories (individual, joint, reviewed, integration, unverifiable-historical) with register notation                                                                |
| 5   | PR rules defer entirely to TEAM_DEVELOPMENT_GUIDELINES without stating the lightweight path for trivial changes                                            | Add a narrow exception: typo/docs-only fixes may merge with one review and a register note; everything else follows §6 guidelines                                                         |
| 6   | No explicit academic-integrity clause                                                                                                                      | Add an integrity section prohibiting manufactured commits, impersonation, backdating, or misrepresentation                                                                                |
| 7   | Register lacks fields for attribution category and task reference                                                                                          | Extend register columns: Attribution type, Task/issue ref                                                                                                                                 |
| 8   | Policy does not state what happens to the existing uncommitted Step 2/3 work                                                                               | Add transitional rule: uncommitted work is committed under truthful authorship going forward; work that cannot be attributed is recorded as unverifiable-historical, never retro-assigned |

## Practical impact

Low overhead: one-time identity setup per member, one extra register row per merged PR,
verify-before-commit habit on shared computers. No new tooling required beyond existing
Git/GitHub flow.
