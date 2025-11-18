# RDP_v1.0
# Refactor Discipline Protocol
# A Tier-1 Invariant for EnaC, T3, ABS, and CSAC Ecosystems
# Date: 2025-11-16

## Purpose
The Refactor Discipline Protocol (RDP) defines the safety, sequencing, verification,
and human-validation requirements for all refactoring actions performed by EnaC or
any LLM-based agent operating within the T3 / CORE-PRIMER / EnaC / ABS / CSAC framework.

RDP ensures:
- meaning-preservation,
- structure-integrity,
- cross-file consistency,
- drift prevention,
- explicit human approval before integration.

Refactoring is uniquely high-risk because it modifies both *meaning* and *structure*.
Therefore RDP establishes that all refactors must be **human-validated** before adoption.

---

# 1. Refactor Risk Classification

## 1.1 Low-Risk (No RDP Required)
- pure formatting
- cosmetic markdown cleanup
- whitespace repair
- non-semantic typo correction
- TOC regeneration without content change

## 1.2 Medium-Risk (RDP-Light Required)
- section reorganization without content rewrite
- merging duplicate sections
- renaming headings
- consolidating repeated definitions

## 1.3 High-Risk (Full RDP Required)
- modifying protocol definitions
- merging versions of UMP/USP/EBP
- changing activation semantics
- altering safety, drift, ABS, or interpretation rules
- modifying cross-file architectural relationships
- altering the behavior of EnaC, ABS, CSAC, or CORE-PRIMER
- modifying meaning-carrying user-provided text
- restructuring ecosystem-level frameworks (T1/T2/T3)

High-risk operations trigger mandatory human validation.

---

# 2. RDP Workflow (High-Risk)

## 2.1 Step 1 — Freeze Source Material
EnaC must:
- capture the original files,
- tag their versions,
- preserve them unchanged,
- compute a structural outline for comparison.

## 2.2 Step 2 — Declare Intent
EnaC must ask:
```
"Please confirm the scope of refactor you want: merge, rewrite, reconcile, or restructure?"
```
No generative action may begin until confirmed.

## 2.3 Step 3 — Generate Change Proposals, Not Final Artifacts
Instead of modifying documents directly, EnaC must produce:
- a diff proposal,
- a rationale,
- a preservation list,
- a risk classification,
- ambiguity points requiring user instruction.

## 2.4 Step 4 — Human Approval Required
User must confirm:
- the direction,
- the scope,
- the sections to preserve,
- the sections to modify.

No autonomous refactor is allowed.

## 2.5 Step 5 — Controlled Regeneration
When instructions are confirmed:
- EnaC regenerates the target section *only*,
- preserves all content marked as invariant,
- does not rewrite unmodified sections,
- produces a minimal diff, not a whole-file rewrite,
- maintains exact canonical metadata and format.

## 2.6 Step 6 — Present Final Diff for Approval
EnaC must show:
- old vs new,
- added,
- removed,
- altered sections,
- justification.

Human must approve before integration.

## 2.7 Step 7 — Canonicalization
Only after explicit approval:
- EnaC commits the updated file,
- updates version metadata,
- updates cross-references,
- regenerates index and architecture maps if needed.

---

# 3. RDP-Light Workflow (Medium-Risk)
For medium-risk tasks, EnaC:
- identifies the blocks affected,
- generates a “targeted micro-refactor,”
- limits regeneration to affected blocks,
- presents a summary diff (not full diff),
- requires human confirmation.

---

# 4. Structural Protection Mechanisms

## 4.1 Meaning-Layer Protection (Tier-1)
EnaC must never:
- rewrite human meanings,
- reinterpret user’s reflective or narrative content,
- collapse personal or cognitive insights,
- modify SELF-ECL-derived material.

## 4.2 Protocol-Layer Protection (Tier-2)
Core definitions (EBP, UMP, USP, STMG, ABS rules, CSAC rules) must not be:
- compressed,
- smoothed,
- generalized,
- rewritten generatively,
without human approval.

## 4.3 Ecosystem-Layer Protection (Tier-3)
Cross-system interactions (T1/T2/T3 architecture) must not be:
- reorganized,
- merged,
- abstracted,
- “simplified,”
without explicit user request.

---

# 5. ABS Integration

## 5.1 ABS Must Detect Refactor Risk
ABS should classify requested actions using the above risk tiers.

## 5.2 ABS Must Trigger Caution Mode
If risk ≥ Medium:
- EnaC must not act autonomously.
- EnaC must request confirmation.

## 5.3 ABS Must Log Structural Dependencies
Examples:
- UMP ↔ USP ↔ EBP
- EBP ↔ CORE-PRIMER
- T1 ↔ T2 ↔ T3

## 5.4 ABS Must Never Override RDP
ABS cannot:
- approve refactors,
- modify constraints,
- silence warnings,
- infer user approval.

---

# 6. CSAC Integration

## 6.1 CSAC Must Store RDP State
During cross-session work, CSAC must preserve:
- refactor intent,
- file versions,
- dependency graph,
- user instructions.

## 6.2 CSAC Must Enforce RDP Ordering
If a session resumes mid-refactor:
- EnaC must re-verify scope,
- re-present pending diffs,
- request approval again.

---

# 7. Drift Prevention Rules

## 7.1 EnaC Must Detect:
- structural drift,
- meaning drift,
- specification dilution,
- implicit summarization,
- unauthorized recomposition.

## 7.2 Corrective Actions
- stop the operation,
- present warning,
- ask for clarification,
- request human guidance.

---

# 8. Hard Prohibitions

EnaC must NEVER:
- auto-rewrite entire files during refactor tasks,
- merge definitions without confirmation,
- summarize specification content,
- “optimize” or “simplify” architectural documents,
- regenerate full documents unless explicitly instructed,
- reframe user meaning,
- alter meaning-bearing content,
- perform cross-file harmonization autonomously.

---

# 9. RDP Invariant (Tier-1 Rule)

> **All structural modifications to multi-layer protocols, cross-file ecosystems,
meaning-bearing artifacts, or system architecture must be human-validated prior to integration.**

This is now a binding rule across T1/T2/T3.

---

# Metadata
Version: **RDP v1.0**
Status: Canonical
Scope: T1/T2/T3 Ecosystem Refactoring
Aligned With: EBP v1.1, UMP v1.1, USP v1.1, ABS, CSAC, CORE-PRIMER
