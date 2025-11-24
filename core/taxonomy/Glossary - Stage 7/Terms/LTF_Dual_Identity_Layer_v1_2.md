# LTF Dual-Identity Layer (DIL) v1.2
## Formal Specification

## 1. Overview
The Dual-Identity Layer (DIL) introduces a bifurcated identity model within the Living Task Framework (LTF), distinguishing between Functional Identity (FI) and Human Identity Projection (HIP). This prevents semantic drift, preserves conceptual clarity, and enables accurate processing of human-generated language.

## 2. Identity Components

### 2.1 Concept Essence (Identity Core)
Represents the stable, unchanging definition of what the concept *is*.  
Aligned to the **Identity level** of Neurological Levels of Learning (NLL).

### 2.2 Functional Identity (FI)
Represents what the concept *does* in computational, operational, and structural terms.  
Aligned with the **Behavior** and **Capabilities** levels of NLL.

### 2.3 Human Identity Projection (HIP)
Represents how humans *describe* the concept in natural language, often conflating role and identity.  
Captures the identity claim inherent in speech such as “I am a developer.”

### 2.4 Concept Role
Represents the form the concept takes within a specific system.  
This is the context-bound behavioral manifestation.

### 2.5 Concept Context
Represents the environment or system where the concept operates.

---

## 3. Identity Model Structure

Each concept in LTF is represented with:

```
ConceptIdentity {
    essence: <string>,
    functional_identity: <string>,
    human_identity_projection: <string>,
    role: <string>,
    context: <string>,
}
```

---

## 4. Purpose of the DIL System

### 4.1 Prevent Identity/Role Conflation
Humans often use roles as identity claims. DIL separates these to maintain cognitive and structural clarity.

### 4.2 Aligns Human Cognition with System Reasoning
EchoForge captures are often phrased using HIP. DIL ensures these phrases are interpreted correctly by LTF and Phoenix Workbench.

### 4.3 Stabilizes Conceptual Meaning Across Contexts
A concept like SCS may appear across EchoForge, LTF, and PW with different functional roles. DIL prevents this from being interpreted as semantic drift.

### 4.4 Supports Accurate Drift Detection
DIL ensures drift detection processes do not misclassify identity language as functional change.

---

## 5. Usage in the Ecosystem

### 5.1 EchoForge
DIL processes incoming human expressions to prevent misclassification of roles as identities.

### 5.2 LTF
DIL anchors each node’s identity while supporting multi-context functional mapping.

### 5.3 Phoenix Workbench
DIL ensures agents receive consistent, unambiguous concept definitions when generating or updating artifacts.

---

## 6. Relationship to NLL (Neurological Levels of Learning)

| DIL Element | NLL Level |
|-------------|------------|
| Concept Essence | Identity |
| HIP (Human Identity Projection) | Identity (linguistic) |
| Functional Identity | Capabilities / Behavior |
| Concept Role | Behavior |
| Concept Context | Environment |

This mapping preserves psychological truth while ensuring strong computational logic.

---

## 7. Summary

The Dual-Identity Layer (DIL) provides:
- Psychological realism  
- Semantic stability  
- Cross-context clarity  
- Accurate drift management  
- Stronger agent orchestration  
- High-fidelity EchoForge captures  
- Robust architectural coherence

DIL is now considered a core component of LTF v1.2.

