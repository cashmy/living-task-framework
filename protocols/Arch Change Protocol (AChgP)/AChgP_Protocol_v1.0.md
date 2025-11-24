# AChgP — Architectural Change Protocol  
## Version 1.0  
## EnaC-Governed Architectural Modification Process (ECL-Aligned)

---

# 0. Purpose  
AChgP provides a **structured, non-rigid, directionally intelligent** process for updating architecture across multi-layer systems.  
It replaces classical top-down-only methods with an ECL-correct, fluid approach that adapts based on the **origin of change**.

---

# 1. Fundamental Principles

## 1.1 Direction Depends on Change Origin  
AChgP determines whether updates flow:

### **Bottom-Up** (BASE → CORE → SKY)  
When implementation, schema, or data-level changes occur.

### **Middle-Out** (CORE → BASE and/or CORE → SKY)  
When architectural or modular decisions change.

### **Top-Down** (SKY → CORE → BASE)  
When purpose, mission, or system identity changes.

---

## 1.2 Minimal Update Principle  
Only the artifacts impacted by a change should be updated.  
Avoid unnecessary modifications.

---

## 1.3 No Forced Propagation  
Core or SKY should not be altered unless the change at BASE *requires* it.  
This prevents conceptual drift.

---

## 1.4 Human Oversight Required  
AChgP requires EnaC + Human alignment for all architectural changes.

---

# 2. Directional Mode Selector

```
Determine origin layer:
    If BASE → Use Bottom-Up
    If CORE → Use Middle-Out
    If SKY  → Use Top-Down
```

## Mode Details

### 2.1 Bottom-Up Mode  
Triggered when changes originate in:  
- DB schema  
- logical data models  
- API field definitions  
- underlying implementation details  

**Sequence:**  
1. Update BASE artifact  
2. Validate CORE impact  
3. Validate SKY impact  
4. Update only layers affected

---

### 2.2 Middle-Out Mode  
Triggered when changes originate in:  
- module design  
- architecture structure  
- cross-system integration  

**Sequence:**  
1. Update CORE  
2. Update BASE or SKY *only if impacted*  

---

### 2.3 Top-Down Mode  
Triggered when:  
- manifestos change  
- invariants change  
- business/purpose/identity shifts  

**Sequence:**  
1. Update SKY  
2. Update CORE  
3. Update BASE  

---

# 3. Impact Matrix

| Change Type | Origin | Direction | Affected Layers |
|-------------|--------|-----------|-----------------|
| Schema Fix | BASE | Bottom-Up | BASE → CORE |
| Schema Expansion | BASE | Bottom-Up | BASE → CORE → SKY? |
| Architecture Refactor | CORE | Middle-Out | CORE → BASE/SKY |
| Manifesto Change | SKY | Top-Down | SKY → CORE → BASE |
| Tooling/Utilities Change | BASE/CORE | Bottom-Up or Middle-Out | BASE/CORE |
| Protocol Change | CORE | Middle-Out | CORE → BASE/SKY |
| Conceptual Model Change | SKY | Top-Down | SKY → CORE |

---

# 4. Artifact Update Sequencer

Regardless of direction, these artifacts are evaluated:

1. Manifesto  
2. Invariants  
3. Architecture Specification  
4. Internal Modules  
5. Logical Data Model  
6. Data Schema  
7. Tools/Utilities  
8. Milestones / Implementation Guides  

Only affected artifacts are updated.

---

# 5. Backwards Compatibility Checks  
Before any changes finalize:

- Does the change break PW ingestion?  
- Does GlossRP BASE remain stable?  
- Do tools need modification?  
- Do schemas require migration?  
- Does this shift any ECL layer boundaries?  

---

# 6. Version Increment Rules  
- If only BASE: increment LDM/schema version  
- If CORE: increment architecture + module versions  
- If SKY: increment all major versions  
- AChgP never increments versions unnecessarily  

---

# 7. Change Impact Report (CIR)

Every architectural update produces a short CIR containing:

- Change origin (BASE/CORE/SKY)  
- Directional mode used  
- Artifacts updated  
- Summary of modifications  
- Required follow-up  

---

# 8. EnaC Role Responsibilities

### T1 / T2  
- Parsing, proposing modifications, checking impacts  

### T3  
- Running AChgP end-to-end  
- Producing CIR  
- Ensuring coherence across all layers  

---

# 9. Example Workflows

## 9.1 BASE-Origin Example (GlossRP schema change)  
- Schema updated: raw categories added  
- CORE updated: architecture adjusted  
- SKY untouched  

Correct direction: **Bottom-Up**

---

## 9.2 CORE-Origin Example  
- Architecture module boundaries shift  
→ Middle-Out

---

## 9.3 SKY-Origin Example  
- PW manifesto changes  
→ Top-Down

---

# End of AChgP v1.0
