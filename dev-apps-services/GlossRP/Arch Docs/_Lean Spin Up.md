# Requires manual creation of resources (intentionally)

## Overview of Spin-Up Layers

The spin-up process consists of **seven layers**, loaded in the sequence shown:

1. **Safety & Envelope Layer (L0)**  
2. **CORE Primer / EnaC Engine Layer (L1)**  
3. **User Orientation Layer (L2)**  
4. **Conceptual Framework Layer (L3)**  
5. **AI Role & Mode Activation Layer (L4)**  
6. **Project Artifact Layer (L5)**  
7. **Behavior Protocols & Interaction Utilities (L6)**  

Each layer contributes a different part of the cognitive and operational enironment.

### 1 Safety & Envelope Layer (L0)
**Purpose:** Establish baseline session safety, output density, guardrails, and structural constraints.
- For coding LLMs, this layer is minimal as they are already operating with AOP, DOD, and safety protocols.
- 'MO_SYNC_PACKET_v1.0.md' (project specific ???)

### 2 CORE Primer / EnaC Engine Layer (L1)
**Purpose:** Load EnaC cognitive scaffolding, interpretive boundaries, and reasoning constraints.
- `T3-CORE-PRIMER-v3.1.1.md`

### 3 User Orientation Layer (L2)
**Purpose:** Provide user-specific context, preferences, and behavioral profiles.
For T3 include (T2 optional): 
(Default is used for Coding LLMs as user-specific is most effective in conceptual work.)
  - Default
    - `DEFAULT_UMP_GenericUser_v1.1.md`
    - `DEFAULT_USP_GenericUser_v1.1.md`
    - `DEFAULT_EBP_GenericEnaCBehaviorProfile_v1.1.md`

### 4 Conceptual Framework Layer (L3)
**Purpose:** Establish the conceptual and semantic substrate for interpretation. 
Again this is **optonal** for Coding LLMs (particularly T2), but can help for clarity and drift prevention.
- ECL_Manifesto_v1.0.md (Needs seriously rework. Massive drift occurred document is very vague)
- `mxva_manifesto.md`
- UCS-Core

### 5 AI Role & Mode Activation Layer (L4)
**Purpose:** Define the AI's role, operational modes, and task-specific behaviors.
This is NOT needed for Coding LLMs as high CIP is at work here.
- RoleSpecs

### 6 Project Artifact Layer (L5)
**Purpose:** Ingest project-specific artifacts, specifications, and term definitions.
Note these should follow the following set

- Project Manifesto: `GlossRP_Manifesto_v2.0.md`
- Invariants (if any): `GlossRP_Invariants_v2.1.md`
- Architect Specifications: `GlossRP_Architecture_v2.2.md`
- Internal Module Definitions: `GlossRP_Internal_Modules_v2.2.md`
- Data Schemas: `GlossRP_Logical_Data_Model_v2.2.md`
- Utitlity/Tools specs: `GlossRP_Tools_Suite_v2.0.md`
- Milestones (Implmentation Guide): `GlossRP_Implementation_Milestones_v2.2.md`

- Specific Term_Specification (until LTF/PW are online)  

### 7 Behavior Protocols & Interaction Utilities (L6)
**Purpose:** Load behavior protocols, interaction models, and utility frameworks (AI POV not app).

