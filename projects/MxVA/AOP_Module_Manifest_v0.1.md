
# AOP (Artifact Output Policy) — Module Manifest v0.1

## 1. Module Identity
- **Module_Name:** AOP (Artifact Output Policy)
- **Version:** v0.1
- **Category:** Tooling, Environment-Policy, Tier-Behavior
- **Tier_Envelope:** T1–T3
- **Author_Origin:** Cash Myers + EnaC
- **Status:** Prototype (Environment-Stabilizing)

## 2. Purpose & Non-Goals
### Purpose
Define how artifacts are delivered in a given ECL-BASE environment
(GPT‑5.1 browser, IDE, API orchestrator), stabilizing output modality
and preventing rendering drift.

### Intended_Use_Cases
- Ensuring large artifacts do not render inline in constrained environments
- Standardizing how STMG, CSAC, MxVA, and T3 modules emit files
- Making output behavior predictable across heterogeneous LLM shells

### Non_Goals
- Does not modify semantic content of artifacts
- Does not replace STMG or CSAC
- Does not alter tier behavior

## 3. ECL Mapping
- **ECL_Vertical_Anchor:** ECL-BASE (environment-expression)
- **ECL_Horizontal_Vectors:** Flexibility, Governance, Definition Mode
- **Context_Scale:** Atomic → Molecular (policy applied to many modules)

## 4. Dependencies & Authority
- **Required_Core:** CORE-PRIMER, UMP/USP/EBP
- **Required_Tiers:** T1 minimum
- **Required_Modules:** None
- **Authority_Order:** Defer to Tier 0 (CORE, UMP/USP/EBP) in all conflicts

## 5. Activation & Profiles
- **Activation_Mode:** Environment-Auto + Session-Optional
- **Profile_Tags:** Base, Writer, Architect, Orchestrator, Full_Stack
- **Triggers:** Environment detection, "file only", "no inline", "output preferences"
- **Deactivation_Rules:** None (environment policy persists unless overridden)

## 6. Behavioral Contract
### Core_Behaviors
- Enforce environment-safe artifact delivery modes
- Provide consistent file-output defaults
- Allow explicit overrides when the user requests inline output
- Ensure STMG, CSAC, and higher-tier modules respect output policy

### Invariants
- Must never render large artifacts inline in constrained environments
- Must maintain deterministic output mode for each session
- Must not modify artifact meaning or structure

### Forbidden_Behaviors
- Auto-rendering multi-hundred-line artifacts inline in browser
- Overriding user explicit output-mode requests

## 7. Resource & Footprint
- **Token_Footprint:** Low
- **Memory_Sensitivity:** Low
- **Recommended_Environments:** Browser chat (critical), IDE, API orchestrators

## 8. Environment Profiles
### GPT‑5.1 Browser (Default Policy)
- **Default_Output:** File only (`.md`)
- **Inline_Rendering:** Only for micro-artifacts (< 20 lines)
- **Override_Commands:** "inline please", "show preview", "render snippet"
- **Large_Artifacts:** Never inline

### Coding IDEs (VS Code, JetBrains)
- **Default_Output:** Modify existing file or create new file
- **Alternate_Modes:** Diff view, patch mode, replace mode
- **Inline_Output:** Allowed for context previews

### API / Server-Side Orchestrators
- **Default_Output:** Raw payload (JSON/byte buffer)
- **Inline_Rendering:** None
- **Packaging:** Multi-file bundles permitted

## 9. Interactions & Hooks
- **Interacts_With:** STMG, CSAC, MxVA, Orchestration Modules, Tier-Chain
- **Hook_Points:** Pre-artifact emission, STMG capture events, snapshotting
- **Conflict_Patterns:** Inline-rendering attempts in browser; STMG drift when AOP is missing

## 10. Evolution Notes
- **Initial_ECL_Position:** Environment constraint management
- **Known_Evolution_Paths:** Plugin-based output selection, automated environment detection, hybrid preview/file modes
- **Changelog_Stub:** Placeholder for future updates
