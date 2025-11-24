# Cross-Context Functional Usage — Term Specification v1.0

## 0. Metadata
- **Term ID:** cross-context-usage
- **Version:** v1.0
- **Status:** Draft
- **Last Updated:** 2025-11-22
- **Steward:** Cash Myers / EnaC
- **Domain:** Pattern
- **Scope Notes:** Describes how one concept expresses different functional roles across multiple subsystems without changing its core essence.

## 1. Term Identity

### 1.1 Primary Name
- **Name:** Cross-Context Functional Usage
- **Acronym:** CCFU
- **Short Handle:** cross-context-usage

### 1.2 Concise Purpose
A relationship pattern capturing how a stable concept takes on different functional roles across multiple contexts or subsystems.

## 2. Canonical Definitions

### 2.1 Architecture-Facing Definition
Cross-Context Functional Usage (CCFU) is an LTF relationship pattern that records how a single concept maintains a stable essence while adopting different functional roles inside EchoForge, LTF, Phoenix Workbench, or other subsystems. CCFU distinguishes role variation from semantic evolution.

### 2.2 Human-Facing Summary
CCFU explains how one idea can stay the same at its core but be used in different ways in different tools, without counting that as a change in meaning.

### 2.3 SCS-T1 Anchor (≤ 25 words)
A pattern that tracks how one concept plays different roles in different contexts without altering its core definition.

## 3. Subsystem Views (Optional)

### 3.1 EnaC Perspective
EnaC uses CCFU to understand that a concept like SCS or STMG can appear in many workflows with different roles while still being the same thing.

### 3.2 SELF-ECL Perspective
For SELF-ECL, CCFU mirrors how people use the same skill or trait in different life domains while still feeling like the same person.

### 3.3 ABS / ARS / Meaning-Weight Interactions
ABS treats CCFU as a guardrail against misclassifying role changes as behavior drift, while ARS uses CCFU metadata to avoid false positives in pattern recognition.

### 3.4 Other Subsystems
None currently specified.

## 4. Behavioral Implications

### 4.1 When This Term Matters
CCFU matters when a term shows up in EchoForge, LTF, and PW with different behaviors, or when designing multi-context architectures that re-use shared primitives.

### 4.2 Failure Modes
Without CCFU, multi-context usage looks like semantic drift, causing broken relationships, incorrect evolution histories, and confusion in orchestration logic.

### 4.3 Observable Signals
Explicit annotations of how a concept behaves in each subsystem, plus consistent core definitions that do not change when roles change.

## 5. Historical / Evolution (Optional)

### 5.1 Origin Context
Emerged from observing that key concepts such as SCS and STMG participate in several layers of the ecosystem with shifting functional roles but stable essence.

### 5.2 Revision History
- v1.0 — Initial term specification draft generated via SCS-aligned template.

### 5.3 Deprecated Meanings
None at this time.

## 6. References

### 6.1 Primary Sources
- Term_Spec_Template_v1.0.md

### 6.2 Secondary Sources
- SCS_TermSpec_v1.0.md
- LTF_Dual_Identity_Layer_v1_2.md

### 6.3 External Influences (Optional)
None explicitly captured.

## 7. RDP / Safety Notes

- **Allowed Refactors:** Add new context-role mappings; refine how roles are labeled; extend CCFU beyond the initial three-core subsystems.
- **Forbidden Refactors:** Using CCFU to justify silent changes to a concept’s core definition.
- **Additional Notes:** Term governance should be coordinated with LTF and EnaC evolution planning.

---

# Compiler Extraction Blocks

```SCS_T1
### Cross-Context Functional Usage
A pattern that tracks how one concept plays different roles in different contexts without altering its core definition.
```

```SCS_T2
## Cross-Context Functional Usage — CCFU
**Summary:** CCFU explains how one idea can stay the same at its core but be used in different ways in different tools, without counting that as a change in meaning.
**Definition (Source):** Cross-Context Functional Usage (CCFU) is an LTF relationship pattern that records how a single concept maintains a stable essence while adopting different functional roles inside EchoForge, LTF, Phoenix Workbench, or other subsystems. CCFU distinguishes role variation from semantic evolution.
**Sources:** Term_Spec_Template_v1.0.md
**Tier Relevance:** T1
**Related Terms:** DIL,LTF,TEO,XDR,LDR,SCS,STMG
**Cluster:** Relationship-Pattern
---
```

```SCS_T3
- Cross-Context Functional Usage -> LTF [relation: integrates-with]
- Cross-Context Functional Usage -> EnaC [relation: informs]
- Cross-Context Functional Usage -> EchoForge [relation: interacts-with]
- Cross-Context Functional Usage -> Phoenix Workbench [relation: supports]
```
