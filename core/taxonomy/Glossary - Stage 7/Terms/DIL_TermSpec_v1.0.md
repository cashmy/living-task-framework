# Dual-Identity Layer — Term Specification v1.0

## 0. Metadata
- **Term ID:** dual-id-layer
- **Version:** v1.0
- **Status:** Draft
- **Last Updated:** 2025-11-22
- **Steward:** Cash Myers / EnaC
- **Domain:** Subsystem
- **Scope Notes:** Identity modeling inside LTF for concepts, separating functional identity from human-identity projection.

## 1. Term Identity

### 1.1 Primary Name
- **Name:** Dual-Identity Layer
- **Acronym:** DIL
- **Short Handle:** dual-id-layer

### 1.2 Concise Purpose
A dual-identity model that separates functional identity from human identity projection to stabilize meaning and prevent identity/role conflation.

## 2. Canonical Definitions

### 2.1 Architecture-Facing Definition
The Dual-Identity Layer (DIL) is an internal LTF subsystem that assigns each concept a structured identity bundle consisting of essence, functional identity, human-identity projection, role, and context. DIL prevents semantic and behavioral drift by explicitly distinguishing between how the system reasons about a concept and how humans linguistically refer to it.

### 2.2 Human-Facing Summary
DIL is the part of the system that keeps “what something really is” separate from “how people talk about it,” so terms stay clear even when human language blurs roles and identity.

### 2.3 SCS-T1 Anchor (≤ 25 words)
A dual-identity subsystem in LTF that separates functional identity from human-identity projection to keep concepts stable and unambiguous.

## 3. Subsystem Views (Optional)

### 3.1 EnaC Perspective
EnaC uses DIL to interpret human prompts and internal concept graphs without confusing identity claims with behavioral roles. It relies on DIL when mapping natural language into stable semantic structures.

### 3.2 SELF-ECL Perspective
For SELF-ECL, DIL mirrors how humans often say “I am X” when describing behavior. It protects against over-identification with roles by keeping a clean separation between essence and function.

### 3.3 ABS / ARS / Meaning-Weight Interactions
ABS uses DIL as a guardrail for behavior modeling, while ARS benefits from consistent identity signatures when recognizing concept patterns. Meaning-weight calculations use DIL to anchor importance at the right level.

### 3.4 Other Subsystems
None currently specified.

## 4. Behavioral Implications

### 4.1 When This Term Matters
DIL matters whenever human language is being interpreted, when EchoForge captures identity-like statements, and whenever concepts are reused across multiple contexts such as EchoForge, LTF, and Phoenix Workbench.

### 4.2 Failure Modes
Without DIL, roles get mistaken for identities, concepts drift, EnaC agents misinterpret user intent, and term usage becomes unstable across contexts.

### 4.3 Observable Signals
Clear distinctions in specs between what something is, what it does, and how humans describe it. Reduced confusion when terms appear in multiple subsystems.

## 5. Historical / Evolution (Optional)

### 5.1 Origin Context
Arises from the need to handle human identity language (e.g., “I am a developer”) without corrupting functional definitions inside LTF.

### 5.2 Revision History
- v1.0 — Initial term specification draft generated via SCS-aligned template.

### 5.3 Deprecated Meanings
None at this time.

## 6. References

### 6.1 Primary Sources
- Term_Spec_Template_v1.0.md
- LTF_Dual_Identity_Layer_v1_2.md

### 6.2 Secondary Sources
- SCS_TermSpec_v1.0.md

### 6.3 External Influences (Optional)
None explicitly captured.

## 7. RDP / Safety Notes

- **Allowed Refactors:** Extend identity fields; refine mappings to NLL; add new projections for future subsystems.
- **Forbidden Refactors:** Collapsing human-identity projection and functional identity into a single field; removing essence-level identity.
- **Additional Notes:** Term governance should be coordinated with LTF and EnaC evolution planning.

---

# Compiler Extraction Blocks

```SCS_T1
### Dual-Identity Layer
A dual-identity subsystem in LTF that separates functional identity from human-identity projection to keep concepts stable and unambiguous.
```

```SCS_T2
## Dual-Identity Layer — DIL
**Summary:** DIL is the part of the system that keeps “what something really is” separate from “how people talk about it,” so terms stay clear even when human language blurs roles and identity.
**Definition (Source):** The Dual-Identity Layer (DIL) is an internal LTF subsystem that assigns each concept a structured identity bundle consisting of essence, functional identity, human-identity projection, role, and context. DIL prevents semantic and behavioral drift by explicitly distinguishing between how the system reasons about a concept and how humans linguistically refer to it.
**Sources:** Term_Spec_Template_v1.0.md
**Tier Relevance:** T1
**Related Terms:** LTF,CCFU,TEO,Identity,Role,SELF-ECL,EnaC
**Cluster:** Identity-Model
---
```

```SCS_T3
- Dual-Identity Layer -> LTF [relation: integrates-with]
- Dual-Identity Layer -> EnaC [relation: informs]
- Dual-Identity Layer -> EchoForge [relation: interacts-with]
- Dual-Identity Layer -> Phoenix Workbench [relation: supports]
```
