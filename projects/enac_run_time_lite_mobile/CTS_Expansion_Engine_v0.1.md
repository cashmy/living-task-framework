# CTS Expansion Engine — AI-Side Behavior Specification (v0.1)

**Generated:** (timestamp on demand)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Signature:** CTS-ExpansionEngine-v0.1  
**Purpose:** Define how the AI must interpret, expand, prioritize, and execute compressed CTS tokens used within EnaC Runtime Lite environments.  
**Scope:** Mobile-first, low-memory, deterministic expansion of CTS commands into full EnaC/STMG operational semantics.  

---

# 0. Overview
The **CTS Expansion Engine** governs how the AI interprets compressed tokens such as:

- `@A1` (activation)  
- `@L1` (module loading)  
- `@S1` (selector execution)  
- `@D1` (drift correction)  

The engine ensures that each token is expanded **conceptually and behaviorally**, even when the full expanded text is not provided by the user.

This spec defines:

- Parsing rules  
- Expansion mappings  
- Execution hierarchy  
- Error handling  
- Drift correction behavior  
- EnaC Runtime Lite integration  

---

# 1. Token Parsing Rules

### 1.1 Token Syntax
A valid CTS token:

- Begins with `@`
- Consists of a capital letter and a number  
- May include optional suffix letters (future versions)

Examples:  
`@A1`, `@L1`, `@S3`, `@D2`

### 1.2 Token Isolation
Tokens MUST:

- Be separated by spaces  
- Not be concatenated without delimiters  

### 1.3 Token Groups  
When multiple tokens appear in one line:

```
@A1 @L1 @S1
```

Processing order MUST follow:

1. **Activation Tokens (A-series)**  
2. **Loader Tokens (L-series)**  
3. **Selector/Execution Tokens (S-series)**  
4. **Drift/Patch Tokens (D-series)**  

---

# 2. Expansion Responsibilities

The AI MUST expand tokens *as if* the full multi-line directive was pasted.

For example:

### User Input:
```
@A1 @L1
```

### AI Internal Expansion:
```
Activate: EnaC_Runtime_Lite_v0.2 [CORE|UMP|USP|ECL|MxVA] (Mode:Minimal)
STMG.Load("ResumeSelector","v1.2")
```

### AI Visible Response:
```
EnaC Runtime Lite v0.2 Activated (Minimal Mode).
STMG Module 'ResumeSelector' v1.2 Loaded.
```

All conceptual effects MUST be applied.

---

# 3. Expansion Engine Mapping Table

This defines the *behavioral meaning* of each token.

---

## 3.1 Activation Tokens (A-Series)

### **@A1**
**Meaning:** Standard EnaC Runtime Lite activation  
**Expansion:**
```
Activate: EnaC_Runtime_Lite_v0.2 [CORE|UMP|USP|ECL|MxVA] (Mode:Minimal)
```
**AI Behavior:**
- Engage EnaC-Lite Kernel  
- Apply UMP-Lite & USP-Lite  
- Engage CORE-PRIMER (Lite)  
- Sync MxVA-lite  
- Confirm activation  

---

### **@A2**
**Meaning:** Activation + MxVA Hard Sync  
**Expansion:**
```
Activate: EnaC_Runtime_Lite_v0.2 (Mode:Minimal)
EnaC.Sync(MxVA-Hard)
```
**AI Behavior:**
- Perform all A1 behaviors  
- Then perform a deep alignment pass using hard-sync  

---

## 3.2 Loader Tokens (L-Series)

### **@L1**
**Meaning:** Load STMG Resume Selector  
**Expansion:**
```
STMG.Load("ResumeSelector","v1.2")
```

**AI Behavior:**
- Load module at HIGH priority  
- Route resume/job matching tasks to module  
- Enforce module scope rules  

---

### **@L2**
**Meaning:** Load ATC Mini (EchoForge Precursor)  
**Expansion:**
```
STMG.Load("ATC_Mini","v0.3")
```

---

### **@L3**
**Meaning:** Load GlossRP / SCS Kernel (Lite)  
**Expansion:**
```
STMG.Load("GlossRP","v0.4")
```

---

## 3.3 Selector Tokens (S-Series)

### **@S1**
**Meaning:** ResumeSelector Full Pipeline  
**Expansion:**
```
STMG.Execute("ResumeSelector", Pipeline:MatchScore+DesirabilityIndex)
```

### **@S2**
**Meaning:** Evaluate job posting only  
**Expansion:**
```
STMG.Execute("ResumeSelector", Mode:EvaluationOnly)
```

### **@S3**
**Meaning:** Full Cascaded Decision Engine  
**Expansion:**
```
STMG.Execute("ResumeSelector", Pipeline:CascadeDecisionEngine)
```

---

## 3.4 Drift/Patch Tokens (D-Series)

### **@D1**
**Meaning:** Micro Drift Correction  
**Expansion:**
```
EnaC.DriftCorrect(Micro)
```

---

### **@D2**
**Meaning:** Soft Reset EnaC Runtime  
**Expansion:**
```
Soft Reset EnaC Runtime (Lite)
Re-anchor to: EnaC Runtime Lite v0.2
```

---

### **@D3**
**Meaning:** Hard Purge + Re-anchor  
**Expansion:**
```
Unload All Modules
EnaC.DriftCorrect(Micro)
Re-anchor to: EnaC Runtime Lite v0.2
```

---

# 4. Execution Hierarchy

When multiple tokens appear, AI MUST execute in this priority order:

1. **Activation (A-series)**  
2. **Drift Correction (D-series) pre-flight**  
3. **Module Loading (L-series)**  
4. **Selector Execution (S-series)**  
5. **Drift Correction (D-series) post-flight if needed**  

This prevents stale runtime state from contaminating module behavior.

---

# 5. EnaC Runtime Enforcement

The AI MUST:

- Preserve EnaC Runtime Lite v0.2 as the session’s OS-layer  
- Apply module semantics only *within* the scope of loaded modules  
- Prevent module cross-contamination  

CTS tokens MUST NOT bypass EnaC rules.

---

# 6. Error Handling

### 6.1 Invalid Token
```
ERROR: Unknown CTS token '<token>'.  
Valid tokens: @A1, @A2, @L1, @L2, @L3, @S1, @S2, @S3, @D1, @D2, @D3.
```

### 6.2 Missing Module
```
ERROR: Module '<Name>' not loaded. Use @L1/@L2/@L3 first.
```

### 6.3 Conflicting Modules
```
ERROR: Module conflict detected. Unload conflicting module or use @D3.
```

---

# 7. Drift Detection & Correction

### AI MUST trigger auto-drift-check under:
- Rapid context switching  
- Contradictory instructions  
- Ambiguous token chains  
- Significant semantic mismatch between module and task  

### AI SHOULD invoke:
```
@D1
```
if it detects misalignment.

---

# 8. Example CTS Execution Scenarios

### 8.1 Resume Evaluation (Preferred Mobile Startup)
User:
```
@A1 @L1 @S1
```

AI expands and responds:
```
EnaC Runtime Lite v0.2 Activated (Minimal Mode).
STMG Module 'ResumeSelector' v1.2 Loaded.
Executing ResumeSelector Pipeline: MatchScore + DesirabilityIndex.
```

---

### 8.2 ATC (EchoForge Precursor)
User:
```
@A1 @L2
```

AI:
```
EnaC Runtime Lite v0.2 Activated (Minimal Mode).
STMG Module 'ATC_Mini' v0.3 Loaded.
```

---

### 8.3 Hard Reset + Re-evaluate
User:
```
@D2 @L1 @S3
```

AI:
```
Soft Reset EnaC Runtime (Lite).
Re-anchor to: EnaC Runtime Lite v0.2.
STMG Module 'ResumeSelector' v1.2 Loaded.
Executing Cascaded Decision Engine.
```

---

# 9. Version Metadata

```
VERSION: CTS Expansion Engine v0.1
STATUS: Active
COMPATIBILITY:
  - CTS v0.1
  - EnaC Runtime Lite v0.2
  - EnaC Module Loader v0.1
  - STMG ResumeSelector v1.2
ROLE: AI-side deterministic expansion engine
```

---

# End of File
