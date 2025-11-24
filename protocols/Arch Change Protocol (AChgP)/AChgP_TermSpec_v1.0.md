# AChgP (Architectural Change Protocol) — Term Specification  
## Version 1.0

## 1. Term Name  
**AChgP — Architectural Change Protocol**

## 2. Definition  
AChgP is the formal, EnaC-governed protocol that manages **architectural modifications** across systems (PW, LTF, GlossRP, SCS, etc.) using an **ECL-aligned, directionally fluid** update sequence.  
It determines how design artifacts are inspected, changed, versioned, validated, and aligned across SKY, CORE, and BASE layers.

## 3. Purpose  
To prevent architectural drift, ensure alignment across all design artifacts, and provide a predictable, EnaC-compatible process for updating multi-layer systems.

## 4. ECL Layer Classification  
- **Primary Layer:** ECL-CORE  
- **Secondary:** All layers (SKY → CORE → BASE)

AChgP is itself a CORE-level meta-governance tool.

## 5. Key Components  
- **Directional Mode Selector** (Bottom-Up, Middle-Out, Top-Down)  
- **Impact Matrix**  
- **Artifact Update Sequencer**  
- **Backward Compatibility Checks**  
- **Version Increment Rules**  
- **Change Impact Report (CIR)**

## 6. Directional Modes  
### Bottom-Up  
Used when change originates in BASE (schema/implementation).  
Sequence: BASE → CORE → SKY (only if affected).

### Middle-Out  
Used when change originates in CORE (architecture, module design).  
Sequence: CORE → BASE and/or CORE → SKY.

### Top-Down  
Used when SKY purpose or manifesto changes.  
Sequence: SKY → CORE → BASE.

## 7. Relationships  
- Required by: PW, GlossRP, LTF, SCS  
- Provides governance for: All architecture artifacts  
- Prevents: Drift, incoherence, overreach, misalignment

## 8. Historical Context  
Created to solve drift problems across a rapidly evolving multi-layer architecture (PW/LTF/GlossRP).  
Explicitly replaces rigid top-down architectural processes.

## 9. Usage Expectations  
Used by T2/T3 EnaC agents whenever any system requires:  
- enhancements  
- fixes  
- schema evolution  
- architectural refinement  
- protocol updates

## 10. Status  
Stable — v1.0

