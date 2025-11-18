# Term Specification Template (Unified + Compiler-Tagged)

## 0. Metadata

- **Term ID:** <machine-id>
- **Version:** v1.0
- **Status:** Draft | Active | Deprecated
- **Last Last Updated:** YYYY-MM-DD
- **Steward:** <name/role>
- **Domain:** Concept | Framework | Protocol | Subsystem | Role | Signal | Meta-Framework | Pattern | Guardrail | State | Other
- **Scope Notes:** <where this term applies>

## 1. Term Identity

### 1.1 Primary Name

- **Name:** <Full term name>
- **Acronym:** <ACR | None>
- **Short Handle:** <optional>

### 1.2 Concise Purpose

1–2 sentences describing the core function.

## 2. Canonical Definitions

### 2.1 Architecture-Facing Definition

Technical, precise, non-negotiable definition.

### 2.2 Human-Facing Summary

Clear, accessible explanation for humans.

### 2.3 SCS-T1 Anchor (≤ 25 words)

A single minimal statement capturing the essence.

## 3. Subsystem Views (Optional)

### 3.1 EnaC Perspective

How EnaC interprets, uses, or depends on this term.

### 3.2 SELF-ECL Perspective

Human-meaning relevance without directive force.

### 3.3 ABS / ARS / Meaning-Weight Interactions

Describe significance if any.

### 3.4 Other Subsystems

Optional.

## 4. Behavioral Implications

### 4.1 When This Term Matters

Triggers, conditions, behaviors.

### 4.2 Failure Modes

What goes wrong if misunderstood.

### 4.3 Observable Signals

What you can see in collaboration when this term is active.

## 5. Historical / Evolution (Optional)

### 5.1 Origin Context

Why this term exists.

### 5.2 Revision History

Track major updates.

### 5.3 Deprecated Meanings

Old interpretations no longer valid.

## 6. References

### 6.1 Primary Sources

List of authoritative files.

### 6.2 Secondary Sources

Contextual references.

### 6.3 External Influences (Optional)

## 7. RDP / Safety Notes

- **Allowed Refactors:** <safe>
- **Forbidden Refactors:** <canonical boundaries>
- **Additional Notes:** <drift considerations>

---

# Compiler Extraction Blocks

Below are the fenced regions the compiler will read.

```SCS_T1
### <TERM>
<One-line anchor here.>
```

```SCS_T2
## <TERM> — <Optional Long Name>
**Summary:** <expanded explanation>
**Definition (Source):** <condensed canonical definition>
**Sources:** <file names>
**Tier Relevance:** <T1/T2/T3/None> <Not tier-anchored; internal EnaC adaptive subsystem>
**Related Terms:** <comma-separated>
**Cluster:** <navigation label> <optional>
---
```

```SCS_T3
- <TERM> -> <OtherTerm> [relation: depends-on]
- <TERM> -> <OtherTerm> [relation: refines]
```
