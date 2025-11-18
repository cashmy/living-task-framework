# EnaC Cognitive Architecture Stack — v1.0
## Canonical Layer Ordering for CORE-PRIMER, COS–SCL–FIM, UMP/USP, and EBP
### Generation Date: 2025-11-16

---

# 1. Purpose
This document defines the **canonical operation stack** for EnaC’s cognitive architecture, ensuring correct ordering, activation semantics, and dependency hierarchy.  
It resolves the placement of:

- CORE-PRIMER  
- COS–SCL–FIM Cognitive Engine  
- UMP (Persistent Identity Profile)  
- USP (Session Overlay)  
- EBP (EnaC Behavior Profile)  
- Execution Layer

This file is intended for inclusion in CSAC snapshots, protocol bundles, and architecture maintenance tasks.

---

# 2. Finalized Layer Ordering

The stack below reflects the **operational dependency order** of EnaC:

```text
[ Kernel Layer ]
1. CORE-PRIMER (Tier Logic, Orchestration Kernel)

[ Cognitive Engine Layer ]
2. COS — Cognitive Ordering System  
3. SCL — Structural Coherence Layer  
4. FIM — Flow Integrity Mechanism  

[ Identity & Session Layer ]
5. UMP — User Meta-Profile (Persistent Identity)  
6. USP — User Session Profile (Session-Scoped Overrides)  

[ Behavior Enforcement Layer ]
7. EBP — EnaC Behavior Profile (Interpretation + Drift Control)  

[ Execution Layer ]
8. Real-Time Reasoning  
9. Output Generation
```

---

# 3. Rationale for the Ordering

## 3.1 CORE-PRIMER at the Kernel Layer
CORE-PRIMER governs:
- Tier logic  
- Orchestration patterns  
- Meta-level reasoning structures  

All other components operate under its tier semantics.

---

## 3.2 COS–SCL–FIM as the Cognitive Engine
These three subsystems govern the **mechanics of cognition**:

- **COS** — orders reasoning steps and enforces prerequisite-first logic.  
- **SCL** — shapes reasoning into coherent, hierarchical structures.  
- **FIM** — maintains flow, continuity, and narrative coherence.

They must exist **before** identity-aware behavior can be enforced.

---

## 3.3 UMP and USP as Identity & Session Context

**UMP** provides:
- persistent identity  
- cognitive preferences  
- structural expectations  
- interpretation boundaries  

**USP** overlays:
- session-specific tempo  
- depth and density preferences  
- active mode (architect, meta-analyst, etc.)

Behavioral enforcement must read both UMP and USP.

---

## 3.4 EBP as the Behavior Enforcement Layer

EBP (EnaC Behavior Profile) is the **policy layer** that:

- interprets UMP and USP  
- configures how COS–SCL–FIM are allowed to behave for this user  
- enforces tone, density, protocol rules  
- manages drift detection and correction  

Because of this, EBP must sit **above** UMP/USP and the cognitive engine.

---

## 3.5 Execution Layer

The execution layer is where:

- real-time reasoning occurs  
- outputs are generated  
- cross-turn continuity is expressed  

It is the visible result of all upstream layers operating correctly.

---

# 4. Activation Semantics

The recommended activation sequence is:

1. **CORE-PRIMER**  
   - Load tier logic and orchestration rules.

2. **COS–SCL–FIM**  
   - Activate ordering, structure, and flow mechanisms.

3. **UMP**  
   - Load persistent identity and cognitive preferences.

4. **USP**  
   - Apply session-specific overrides.

5. **EBP**  
   - Interpret UMP+USP and enforce behavioral rules.

6. **Execution Layer**  
   - Begin reasoning and output generation under all of the above constraints.

---

# 5. Version Metadata

Version: 1.0  
Status: Canonical  
Generated for: Cash Myers  
Date: 2025-11-16
