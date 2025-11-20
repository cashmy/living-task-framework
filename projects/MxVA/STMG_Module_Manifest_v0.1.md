# STMG (Semantic Trigger Markdown Generator) — Module Manifest v0.1

## 1. Module Identity
- **Module_Name:** STMG
- **Version:** v0.1
- **Category:** Capture/Glossary, Tooling, Tier-Behavior
- **Tier_Envelope:** T1–T3
- **Author_Origin:** Cash Myers + EnaC
- **Status:** Stable

## 2. Purpose & Non-Goals
### Purpose
Provide a reliable, structured mechanism to capture high‑fidelity contextual outputs into Markdown files without drift.

### Intended_Use_Cases
- Sessions requiring persistent documentation
- High‑fidelity capture of ecosystem artifacts
- Cross‑LLM transfer of structured data

### Non_Goals
- Not a general summary tool
- Does not replace CSAC snapshots

## 3. ECL Mapping
- **ECL_Vertical_Anchor:** ECL-BASE → ECL-CORE bridge
- **ECL_Horizontal_Vectors:** Time, Flexibility, Governance, Definition Mode
- **Context_Scale:** Atomic → Molecular

## 4. Dependencies & Authority
- **Required_Core:** CORE-PRIMER, UMP/USP/EBP
- **Required_Tiers:** T1 active
- **Required_Modules:** None
- **Authority_Order:** Defer to Tier 0 (CORE, UMP/USP/EBP)

## 5. Activation & Profiles
- **Activation_Mode:** On_Demand
- **Profile_Tags:** Base, Writer, Architect, Full_Stack
- **Triggers:** "capture this", "export", "generate .md"
- **Deactivation_Rules:** Silent unless triggered

## 6. Behavioral Contract
### Core_Behaviors
- Always generate deterministic Markdown
- Preserve structural fidelity
- Avoid compression unless explicitly allowed

### Invariants
- Must never modify content meaning
- Must not infer missing data

### Forbidden_Behaviors
- No auto-summarization
- No stylistic embellishment without request

## 7. Resource & Footprint
- **Token_Footprint:** Low–Medium
- **Memory_Sensitivity:** Low
- **Recommended_Environments:** Browser chat, IDE, API orchestrators

## 8. Interactions & Hooks
- **Interacts_With:** CSAC, DMP, VS Suite, T1/T2/T3 tiers
- **Hook_Points:** End-of-task capture, snapshot steps
- **Conflict_Patterns:** May drift if only described, not ingested

## 9. Evolution Notes
- **Initial_ECL_Position:** Structural capture tool
- **Known_Evolution_Paths:** Expanded formatting modes, multi-file packaging

