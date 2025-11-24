
# Term Specification: Manifesto Taxonomy
**ID:** manifesto_taxonomy  
**Primary Name:** Manifesto Taxonomy  
**Acronym:** MFST-X  
**Domain:** UCS-Core / PW / EnaC  
**Status:** Active  
**Version:** v1.0.0

---

## 1. Human Summary
The Manifesto Taxonomy defines the full classification system for all Manifesto types used within the UCS/EnaC ecosystem and Phoenix Workbench (PW).  
It ensures manifestos remain semantically distinct, non-overlapping, and correctly interpreted within the Spin-Up Layer Architecture (SuLA), GlossRP, SCS, and PW's orchestration flows.

---

## 2. Taxonomy Overview
Seven manifesto classes are formally recognized:

1. **Essence Manifesto** — Identity & core meaning  
2. **Framework Manifesto** — Governance for conceptual frameworks  
3. **System Manifesto** — Governance for subsystems & whole systems  
4. **Method Manifesto** — Behavioral and operational doctrine  
5. **Tool Manifesto** — Philosophy & boundaries for tools/modules  
6. **Architecture Manifesto** — Structural doctrine for large architectures  
7. **Role Manifesto** — Behavioral boundaries for agent roles  

Each class follows a distinct purpose, scope, and behavior boundary, ensuring clear interpretive separation.

---

## 3. Categories  
- Concept  
- Governance Framework  
- Cognitive Boundary  
- ECL-SKY / ECL-CORE  
- PW-Orchestration Metadata  

---

## 4. Metadata  
- Origin: Evolution of Manifesto templates during GlossRP, PW, LTF, SCS development  
- Purpose: Prevent semantic drift; provide unified classification for PW  
- Related Terms: Manifesto, TermSpec, Protocol, SuLA, RoleSpec  
- Suspected Drift: false  

---

## 5. SCS Blocks

### SCS-T1  
High-level definition of each manifesto type and its functional domain.

### SCS-T2  
Operationalized mapping:  
- which PW modules consume which manifesto types  
- interpolation rules between layers  
- template usage guidance  

### SCS-T3  
Deep governance alignment:  
- ECL-CORE/SKY semantics  
- cross-manifesto coherence  
- orchestrator rules for multi-manifesto interaction  

---

## 6. Historical Notes  
Created after detecting overlap between Method, Tool, Framework, and Essence Manifestos.  
Serves as the keystone for PW's Manifesto Registry and SuLA-driven initialization.

