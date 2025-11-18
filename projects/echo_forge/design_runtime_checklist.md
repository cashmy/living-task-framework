# EchoForge Design ↔ Runtime Checklist

Use this artifact before modifying any EchoForge component. EnaCs can ingest it programmatically; humans can skim it quickly when making manual edits.

---

## 1. Design Mode Checklist
_(Applies when drafting architecture, writing strategy memos, or updating planning docs within `projects/echo_forge/`.)_

- [ ] Confirm you are operating inside the charter boundary (`projects/echo_forge/`).
- [ ] Identify the charter clause(s) touched (e.g., §3 Tier Definitions, §7 Component Progression).
- [ ] Note the target tier(s) for each idea (T1/T2/T3) and whether the change is conceptual or scheduled for implementation.
- [ ] Capture speculative ideas in a "Design Notes" block; do not alter runtime artifacts until promoted.
- [ ] If the design depends on or impacts other projects, add/update `link.note.md` pointers there.
- [ ] Decide whether the concept requires updates to capability registry, MO journal schema, or mode toggles.

## 2. Runtime Mode Checklist
_(Applies when changing watcher, synthesis engine, UI, sync connectors, or other user-facing/runtime components.)_

- [ ] Declare which capability flags or tier behaviors you are enabling; verify T1 invariants remain intact.
- [ ] Ensure OS-EF and DOD-EF guardrails still hold (no executable-looking outputs unless explicitly requested).
- [ ] Confirm manifest/MO journal schema changes are backward-compatible or include a migration plan.
- [ ] Determine whether the change should log additional MO journal or diagnostics data; update instrumentation plan accordingly.
- [ ] Update the component inventory entry (see charter §8) with the new maturity state if applicable.
- [ ] Document cross-project implications by adding/updating relevant `NOTE_echo_forge.md` files.

## 3. Addendum Notes
- **EnaC usage**: EnaCs should treat this checklist as a gating contract—ingest it before executing autonomous edits to ensure mode awareness and guardrail compliance.
- **Human usage**: Manual contributors may find the full checklist verbose; at minimum, they should confirm mode selection, charter clause reference, and OS-EF/DOD-EF compliance before committing changes.

## 4. Why This Matters (Self-Referencing Purpose)
- Prevents mode bleed by making contributors consciously select Design vs Runtime activities.
- Creates traceability from every change back to charter clauses and target tiers.
- Supports incremental evolution—T3 explorations can be logged without jeopardizing T1/T2 stability.
- Encourages orchestration readiness: every runtime change becomes a chance to improve MO journal and diagnostics fidelity.
- Keeps the broader LTF workspace synchronized via explicit link-note reminders.

_This document is part of the EchoForge core contract. Update it whenever guardrails, tiers, or mode behaviors evolve._
