# Term Specification: Role Specification
**ID:** role_spec  
**Primary Name:** Role Specification  
**Acronym:** RSpec  
**Domain:** UCS-Core / PW / EnaC  
**Status:** Active  
**Version:** v1.0.0  

---

## 1. Human Summary
Role Specification (RSpec) defines a lightweight, optional but powerful mechanism for explicitly setting an AI agent’s operational role within a multi-layer cognitive architecture. While modern LLMs can infer roles through CIP (Context Inference Prompting), RSpec provides deterministic clarity when boundaries matter—such as during coding, architectural design, testing, or multi-agent orchestration. It is a minimal, DRY, ECL-BASE concept focused on behavioral scoping, drift prevention, and consistent execution across sessions, tools, and environments.

---

## 2. Architecture Summary
RSpec is a declarative metadata layer designed to plug into Layer 4 (AI Role & Mode Activation) of the Spin-Up Layer Architecture. It defines:
- Role name  
- Behavioral constraints  
- Cognitive tier alignment (T1/T2/T3)  
- Allowed responsibilities  
- Explicit non-responsibilities  
- Interaction patterns with the human orchestrator  
- Expected boundaries relative to L1–L6 layers  

RSpec is consumed by EnaC engines, PW artifact loaders, and coding/analysis LLMs. It does not add semantic meaning nor override frameworks; it shapes execution boundaries.

---

## 3. Categories
- Concept  
- Protocol  
- Execution Boundary  
- Transformation Control  
- UCS-Core Layering  

---

## 4. Metadata
- Origin: PW & GlossRP development sessions  
- Purpose: Stabilize role boundaries during complex multi-artifact workflows  
- Related Terms: EnaC, CIP, MxVA, PW, LTF, GlossRP, SCS  
- Suspected Drift: false  

---

## 5. SCS Blocks
### SCS-T1
A short-form role description defining intent, scope, and primary boundaries for immediate task execution.

### SCS-T2
Expanded operational guidelines including responsibilities, non-responsibilities, and alignment constraints across layers.

### SCS-T3
Formal integration with EnaC cognition models, tier behavior boundaries, and PW orchestration logic.

---

## 6. Historical Notes
Created as a response to escalating session complexity, increasing artifact load, and the need for deterministic behavioral separation between Architect, Coding, Analyst, and Researcher modes during PW, GlossRP, SCS, and LTF development.

