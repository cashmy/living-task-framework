# SCS-T2 — Term Specification v1.0

## 0. Metadata
- **Term ID:** SCS-T2
- **Version:** v1.0
- **Status:** Active
- **Last Updated:** 2025-11-16
- **Steward:** Cash Myers / EnaC System
- **Domain:** Meta-Framework / Structural Layer
- **Scope Notes:** Defines the expanded semantic reference layer summarizing each term.

## 1. Term Identity

### 1.1 Primary Name
- **Name:** Semantic Context System — Tier 2
- **Acronym:** SCS-T2
- **Short Handle:** t2-expanded

### 1.2 Concise Purpose
SCS-T2 provides expanded mid-level semantic descriptions for each term, offering richer understanding without full architectural depth.

## 2. Canonical Definitions

### 2.1 Architecture-Facing Definition
SCS-T2 is the expanded semantic layer of the Semantic Context System. It aggregates compiler-tagged T2 blocks from all term files and produces the “expanded reference glossary.” It includes summaries, canonical definitions, related terms, and contextual metadata.

### 2.2 Human-Facing Summary
T2 is the “medium-depth glossary.” It tells you what a term means, how it fits, and what it's connected to—without overwhelming detail.

### 2.3 SCS-T1 Anchor (≤ 25 words)
Expanded semantic reference layer providing medium-depth summaries and structured context for each term.

## 3. Subsystem Views (Optional)

### 3.1 EnaC Perspective
Provides EnaC with mid-level semantic anchors for contextual reasoning, enabling more consistent mapping and interpretation during collaborative work.

### 3.2 SELF-ECL Perspective
Offers a cognitively manageable layer between quick-reference and full conceptual depth, supporting clarity without overload.

### 3.3 ABS / ARS / Meaning-Weight Interactions
- **ABS:** Uses T2 summaries to derive meaning anchors.
- **ARS:** Integrates T2-linked related terms to refine recognition patterns.
- **Meaning-Weight:** Balances conceptual weight by feeding from expanded definitions.

### 3.4 Other Subsystems
None.

## 4. Behavioral Implications

### 4.1 When This Term Matters
- When creating or refining term definitions
- When interpreting conceptual structures
- When validating cross-term semantic alignment
- When generating SCS-T1 or SCS-T3 outputs

### 4.2 Failure Modes
- Missing T2 blocks cause semantic gaps
- Non-standard formatting breaks compiler output
- Overly long summaries reduce readability
- Drift between canonical definition and T2 summary

### 4.3 Observable Signals
- Clear expanded glossary
- Faster term comprehension
- Reduced ambiguity in system-wide discussions

## 5. Historical / Evolution (Optional)

### 5.1 Origin Context
Created to address the need for a mid-depth semantic layer that balances clarity, conciseness, and relational awareness.

### 5.2 Revision History
v1.0 — Foundation of the T2 semantic block definition.

### 5.3 Deprecated Meanings
None.

## 6. References

### 6.1 Primary Sources
- SCS design notes
- Term_Spec_Template_v1.0.md

### 6.2 Secondary Sources
- EnaC integration notes

### 6.3 External Influences (Optional)
None.

## 7. RDP / Safety Notes
- **Allowed Refactors:** Improve clarity and conciseness.
- **Forbidden Refactors:** Changing block structure or tag format.
- **Additional Notes:** T2 must remain compiler-compatible.

---

# Compiler Extraction Blocks

```SCS_T1
### SCS-T2
Expanded semantic reference layer providing medium-depth summaries and contextual metadata.
```

```SCS_T2
## SCS-T2 — Semantic Context System, Tier 2
**Summary:** The mid-depth semantic layer collecting term summaries, definitions, and contextual metadata for the conceptual ecosystem.
**Definition (Source):** Aggregates compiler-tagged T2 blocks from term files into an expanded reference glossary.
**Sources:** Term_Spec_Template_v1.0.md, SCS design notes
**Tier Relevance:** T2
**Related Terms:** SCS-T1,SCS-T3,EnaC,ABS,ARS
**Cluster:** Meta-Framework
---
```

```SCS_T3
- SCS-T2 -> SCS-T1 [relation: enriches]
- SCS-T2 -> SCS-T3 [relation: informs]
- SCS-T2 -> EnaC [relation: contextual-support]
- SCS-T2 -> ABS [relation: meaning-source]
- SCS-T2 -> ARS [relation: recognition-context]
```
