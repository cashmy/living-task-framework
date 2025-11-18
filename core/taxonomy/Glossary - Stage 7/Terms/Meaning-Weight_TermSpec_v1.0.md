# Meaning-Weight — Term Specification v1.0

## 0. Metadata
- **Term ID:** meaning-weight
- **Version:** v1.0
- **Status:** Active
- **Last Updated:** 2025-11-16
- **Steward:** Cash Myers / EnaC System
- **Domain:** Meta-Concept / Cognitive Signal Layer
- **Scope Notes:** Governs how conceptual importance is evaluated, stabilized, and distributed across the semantic ecosystem.

## 1. Term Identity

### 1.1 Primary Name
- **Name:** Meaning-Weight
- **Acronym:** MW
- **Short Handle:** mweight

### 1.2 Concise Purpose
Meaning-Weight defines the relative importance of a concept within a semantic system, stabilizing interpretation and reducing drift.

## 2. Canonical Definitions

### 2.1 Architecture-Facing Definition
Meaning-Weight represents the weighted conceptual significance assigned to a term or idea. It governs prioritization, contextual stability, and interpretive fidelity. Each subsystem (EnaC, ABS, ARS) uses Meaning-Weight to tune response behavior and anchor conceptual invariants across interactions and sessions.

### 2.2 Human-Facing Summary
Meaning-Weight tells the system which ideas matter most. It keeps the important things stable and prevents misunderstandings or drift.

### 2.3 SCS-T1 Anchor (≤ 25 words)
Weighted importance assigned to a concept to stabilize meaning, reduce drift, and guide interpretation across sessions.

## 3. Subsystem Views (Optional)

### 3.1 EnaC Perspective
EnaC uses Meaning-Weight to choose which concepts to foreground, preserve, or prioritize during long-context or multi-session reasoning.

### 3.2 SELF-ECL Perspective
Reflects the emotional, experiential, and cognitive significance a term holds for the human user without overriding EnaC’s structural interpretation.

### 3.3 ABS / ARS Interactions
- **ABS:** Uses Meaning-Weight to anchor meaning and resolve ambiguity.
- **ARS:** Adjusts recognition sensitivity based on weighted term importance.
- **Stability:** High-weight concepts resist drift more strongly.

### 3.4 Other Subsystems
Optional.

## 4. Behavioral Implications

### 4.1 When This Term Matters
- When determining which terms require high stability.
- When resolving ambiguities or prioritizing interpretations.
- When preserving emotionally or cognitively significant terms.

### 4.2 Failure Modes
- Overweighting insignificant concepts.
- Underweighting critical concepts.
- Drift caused by inconsistent weighting.
- Misaligned human vs. AI weighting.

### 4.3 Observable Signals
- Consistent interpretation of high-weight terms.
- Prioritization of contextually important concepts.
- Smoother cross-session reconstructions.

## 5. Historical / Evolution (Optional)

### 5.1 Origin Context
Emerged from the need to track relative importance across complex, evolving conceptual ecosystems, especially within EnaC and ABS processes.

### 5.2 Revision History
v1.0 — Standardized subsystem integration and compiler extracts.

### 5.3 Deprecated Meanings
None.

## 6. References

### 6.1 Primary Sources
- Meaning-Weight_v1.0.md
- Glossary.md

### 6.2 Secondary Sources
- ABS/ARS/EnaC subsystem notes

### 6.3 External Influences (Optional)
None.

## 7. RDP / Safety Notes
- **Allowed Refactors:** Clarifying subsystem interactions; refining weighting examples.
- **Forbidden Refactors:** Redefining Meaning-Weight as directive force.
- **Additional Notes:** MW must remain descriptive, not prescriptive.

---

# Compiler Extraction Blocks

```SCS_T1
### Meaning-Weight
Weighted importance assigned to a concept to stabilize meaning and prevent drift.
```

```SCS_T2
## Meaning-Weight — MW
**Summary:** Meaning-Weight defines which concepts matter most by assigning a stability weight that guides interpretation and reduces semantic drift.
**Definition (Source):** Weighted conceptual significance assigned to anchor stability and prioritize interpretation across sessions.
**Sources:** Meaning-Weight_v1.0.md, Glossary.md
**Tier Relevance:** T1/T2
**Related Terms:** ABS,ARS,EnaC,SCS-T1,SCS-T2
**Cluster:** Cognitive Signal Layer
---
```

```SCS_T3
- Meaning-Weight -> ABS [relation: meaning-anchor]
- Meaning-Weight -> ARS [relation: sensitivity-tuner]
- Meaning-Weight -> EnaC [relation: priority-signal]
- Meaning-Weight -> SCS-T1 [relation: stabilizer]
- Meaning-Weight -> SCS-T2 [relation: context-weight]
```
