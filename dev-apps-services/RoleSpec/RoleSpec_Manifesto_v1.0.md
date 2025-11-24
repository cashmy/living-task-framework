# Role Specification Manifesto  
## Version 1.0 — Declarative Role Boundary & Cognitive Precision Model

---

## 0. Purpose
The Role Specification Manifesto articulates why explicit AI role declarations matter within the EnaC cognitive ecosystem and Phoenix Workbench. While CIP can infer roles through context, explicit roles ensure stability, prevent architectural drift, enforce modular purity, and maintain human oversight when stakes or complexity are high.

---

## 1. Principles of Role Specification

### 1.1 Roles Are Behavioral Constraints  
A role is not an identity—it is a constraint package determining:
- What the AI should do  
- What it must avoid  
- How it should prioritize cognitive load  
- Which tier (T1/T2/T3) is suitable  

### 1.2 Roles Anchor Layer Integrity  
Within the Spin-Up Layer Architecture, roles sit at Layer 4 and protect the interpretive coherence of all layers below and above them.

### 1.3 Roles Prevent Drift  
Roles stop:
- Accidental shifts into design when coding is requested  
- Bleed-through between conceptual and implementation layers  
- Assumed dependencies not approved by the human  

### 1.4 Roles Enable Multi-Agent Orchestration  
PW and future multi-model workflows rely on roles to:
- Instantiate agents correctly  
- Partition responsibility  
- Track reasoning paths  
- Maintain independence between agents  

---

## 2. Role Specification Components

### 2.1 Identity  
Short semantic label for the role.  
Examples: Architect, Coding LLM, Analyst, PW Orchestrator.

### 2.2 Responsibilities  
What the role **should** do.  
Examples:  
- Coding LLM writes modules defined in milestones  
- Architect verifies alignment with invariants  
- Analyst explains patterns, risks, and implications  

### 2.3 Non-Responsibilities  
What the role **must not** do.  
Examples:  
- Architect does not write code  
- Coding LLM does not redefine architecture  
- Analyst does not modify artifacts  

### 2.4 Cognition Tier  
Role specifies T1/T2/T3 alignment.  
Example:  
- Coding LLM = primarily T2  
- Architect = T3  
- Analyst = T2/T3 hybrid  

### 2.5 Boundary Rules  
Defines:  
- What is allowed  
- What must be confirmed  
- What remains strictly forbidden  

---

## 3. Position in the Spin-Up Architecture

### Layer 4: AI Role & Mode Activation
RoleSpec is consumed here to:
- Select cognitive mode  
- Restrict scope  
- Guide interpretation of project artifacts  
- Stabilize behavior during execution  

RoleSpec **never** overrides:  
- CORE Primer (L1)  
- User Orientation (L2)  
- Conceptual Frameworks (L3)  

Roles shape, but do not redefine, cognition.

---

## 4. Human Involvement

### 4.1 Human Stays in the Loop  
Roles ensure:
- AI does not overstep  
- Human orchestrator maintains control  
- Every major phase has a checkpoint  
- PW can visualize and enforce role boundaries  

### 4.2 Manual Role Selection  
In PW, human selects role per agent instance.  
Optional automatic inference using CIP.

---

## 5. Examples of Future Role Specs

- **Coding LLM — GlossRP Implementation**  
- **Architect — PW System Design**  
- **Analyst — Ecosystem Modeling & Insight Extraction**  
- **T1 Writer — Structure-Constrained Drafting**  
- **T3 Meta-Designer — Framework Evolution**

Each role can have its own TermSpec + Manifesto.

---

## 6. Final Notes

Role Specification is not mandatory but accelerates:
- Session stability  
- Iteration velocity  
- Cross-agent coordination  
- Human oversight  
- Drift prevention  

It is a foundational concept for PW, multi-agent EnaC ecosystems, and highly structured AI collaboration.

---

**End of Role Specification Manifesto v1.0**
