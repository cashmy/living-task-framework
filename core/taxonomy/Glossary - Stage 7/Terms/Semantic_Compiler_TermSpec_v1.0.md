# Semantic Compiler — Term Specification v1.0

## 0. Metadata
- **Term ID:** semantic-compiler
- **Version:** v1.0
- **Status:** Active
- **Last Updated:** 2025-11-16
- **Steward:** Cash Myers / EnaC
- **Domain:** Meta-Framework
- **Scope Notes:** Governs deterministic regeneration of SCS-T1/T2/T3 documents.

## 1. Term Identity
### 1.1 Primary Name
- **Name:** Semantic Compiler
- **Acronym:** SC
- **Short Handle:** semcomp

### 1.2 Concise Purpose
A deterministic processor that reads term files and generates SCS-T1, SCS-T2, and SCS-T3 outputs without AI involvement.

## 2. Canonical Definitions

### 2.1 Architecture-Facing Definition
The Semantic Compiler is a deterministic, rule-based parsing engine that reads structured regions inside term-spec files and assembles the SCS-Tier documents. It ignores human-facing sections and extracts only compiler-tagged regions.

### 2.2 Human-Facing Summary
The Semantic Compiler is the tool that rebuilds your reference documents automatically. It reads the “machine sections” inside each term file and produces the short, medium, and relational SCS outputs.

### 2.3 SCS-T1 Anchor (≤ 25 words)
A deterministic tool that extracts tagged blocks from term files and compiles SCS reference documents without requiring AI involvement.

## 3. Subsystem Views (Optional)

### 3.1 EnaC Perspective
Provides EnaC with a stable external system that offloads repetitive regeneration tasks while preserving meaning integrity.

### 3.2 SELF-ECL Perspective
Represents the “automation backbone” enabling reduction of cognitive load and preservation of conceptual clarity.

### 3.3 ABS / ARS / Meaning-Weight Interactions
- ABS: Ensures consistent structural interpretation across terms.
- ARS: Provides high-fidelity recognition through standardized term encoding.
- Meaning-Weight: Prevents semantic drift by anchoring formal definitions.

### 3.4 Other Subsystems
None.

## 4. Behavioral Implications

### 4.1 When This Term Matters
Whenever SCS-tier regeneration is needed; when updating term files; when integrating new concepts.

### 4.2 Failure Modes
- Missing compiler tags.
- Tag drift.
- Incomplete term files.
- Human edits not mirrored in tagged blocks.

### 4.3 Observable Signals
- Outdated SCS documents.
- Divergence between full term spec and extracted summaries.

## 5. Historical / Evolution (Optional)

### 5.1 Origin Context
Arises from the need to remove AI from repetitive regeneration and reduce kill-page instability.

### 5.2 Revision History
v1.0 — foundational definition, tags, and subsystem mapping.

### 5.3 Deprecated Meanings
None.

## 6. References

### 6.1 Primary Sources
- Term_Spec_Template_v1.0.md

### 6.2 Secondary Sources
- SCS-T1/T2/T3 design notes

### 6.3 External Influences (Optional)
None.

## 7. RDP / Safety Notes
- **Allowed Refactors:** Add new compiler tags; enhance extraction rules.
- **Forbidden Refactors:** Redefining tag semantics; altering machine-facing contract.
- **Additional Notes:** Compiler must always operate deterministically.

---

# Compiler Extraction Blocks

```SCS_T1
### Semantic Compiler
A deterministic extraction tool that rebuilds SCS-Tier documents using compiler-tagged regions.
```

```SCS_T2
## Semantic Compiler — SC
**Summary:** A deterministic parser that extracts machine-tagged data from term files to auto-generate SCS outputs.
**Definition (Source):** The Semantic Compiler reads SCS-tagged blocks and assembles short/medium/relational outputs.
**Sources:** Term_Spec_Template_v1.0.md
**Tier Relevance:** T1
**Related Terms:** SCS-T1,SCS-T2,SCS-T3,ABS,ARS,EnaC
**Cluster:** Meta-Framework
---
```

```SCS_T3
- Semantic Compiler -> SCS-T1 [relation: generates]
- Semantic Compiler -> SCS-T2 [relation: generates]
- Semantic Compiler -> SCS-T3 [relation: generates]
- Semantic Compiler -> ABS [relation: reinforces]
- Semantic Compiler -> EnaC [relation: offloads-tasks]
```
