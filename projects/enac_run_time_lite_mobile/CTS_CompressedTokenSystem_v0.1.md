# Compressed Token System (CTS) — v0.1  
**Short Token → Long Semantic Expansion Mapping**  
**Mode:** Mobile / Low-Memory EnaC Runtime  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**File:** CTS_CompressedTokenSystem_v0.1.md  

---

# 0. Purpose  
CTS provides ultra-compact **compressed command tokens** designed for mobile use.  
Each short token automatically expands into a full EnaC-aligned runtime directive.

Used in environments where:  
- Bandwidth is low  
- File uploads are restricted  
- Session memory is limited  
- Practical activation requires < 140 characters  

---

# 1. Token Categories  
CTS tokens fall into four tiers:

1. **Activation Tokens (A-series)**  
2. **Loader Tokens (L-series)**  
3. **Selector Tokens (S-series)**  
4. **Drift/Patch Tokens (D-series)**  

Each token expands into a pre-defined multi-line block governed by EnaC Runtime Lite v0.1.

---

# 2. Token Definitions & Mappings

---

## 2.1 Activation Tokens (A-Series)

### **Token A1**  
**Purpose:** Full EnaC Runtime Lite activation in minimal mode.  

**Short Token:**  
```
@A1
```

**Expansion:**  
```
Activate: EnaC_Runtime_Lite_v0.1 [CORE|UMP|USP|ECL|MxVA] (Mode:Minimal)
```

---

### **Token A2**  
**Purpose:** Activation + MxVA Hard Sync  

**Short Token:**  
```
@A2
```

**Expansion:**  
```
Activate: EnaC_Runtime_Lite_v0.1 (Mode:Minimal)
EnaC.Sync(MxVA-Hard)
```

---

## 2.2 Loader Tokens (L-Series)

### **Token L1**  
**Purpose:** Load STMG Resume Selector**  

**Short Token:**  
```
@L1
```

**Expansion:**  
```
STMG.Load("ResumeSelector","v1.2")
```

---

### **Token L2**  
**Purpose:** Load ATC Mini (EchoForge Precursor)**  

**Short Token:**  
```
@L2
```

**Expansion:**  
```
STMG.Load("ATC_Mini","v0.3")
```

---

### **Token L3**  
**Purpose:** Load SCS/GlossRP Kernel (Lite)**  

**Short Token:**  
```
@L3
```

**Expansion:**  
```
STMG.Load("GlossRP","v0.4")
```

---

## 2.3 Selector Tokens (S-Series)

### **Token S1**  
**Purpose:** Execute Resume Matching Pipeline**  

**Short Token:**  
```
@S1
```

**Expansion:**  
```
STMG.Execute("ResumeSelector", Pipeline:MatchScore+DesirabilityIndex)
```

---

### **Token S2**  
**Purpose:** Evaluate Job Posting Without Recommendation**  

**Short Token:**  
```
@S2
```

**Expansion:**  
```
STMG.Execute("ResumeSelector", Mode:EvaluationOnly)
```

---

### **Token S3**  
**Purpose:** Trigger Full STMG Cascaded Decision Engine**  

**Short Token:**  
```
@S3
```

**Expansion:**  
```
STMG.Execute("ResumeSelector", Pipeline:CascadeDecisionEngine)
```

---

## 2.4 Drift / Patch Tokens (D-Series)

### **Token D1**  
**Purpose:** EnaC Drift Correction (Micro)**  

**Short Token:**  
```
@D1
```

**Expansion:**  
```
EnaC.DriftCorrect(Micro)
```

---

### **Token D2**  
**Purpose:** EnaC Hard Reset Without Uploads**  

**Short Token:**  
```
@D2
```

**Expansion:**  
```
Soft Reset EnaC Runtime (Lite)
Re-anchor to: EnaC Runtime Lite v0.1
```

---

### **Token D3**  
**Purpose:** Full Module/Semantic Context Purge**  

**Short Token:**  
```
@D3
```

**Expansion:**  
```
Unload All Modules
EnaC.DriftCorrect(Micro)
Re-anchor to: EnaC Runtime Lite v0.1
```

---

# 3. Dual-Token Command Chains

### **Resume Session Startup**
```
@A1 @L1
```

### **ATC/EchoForge Idea Capture Startup**
```
@A1 @L2
```

### **Cascaded Decision Engine for Job Matching**
```
@L1 @S3
```

### **Hard Reset + Resume Re-evaluation**
```
@D2 @L1 @S1
```

---

# 4. CTS Token Integrity Rules

### 4.1 Tokens must start with `@`  
### 4.2 Tokens must not be combined without spaces  
### 4.3 Expansion must occur in deterministic order  
### 4.4 EnaC Runtime Lite governs all expansions  
### 4.5 If expansion fails → AI requests module text or retries  
### 4.6 Tokens may be extended using alphabetic suffixes (e.g., A1a, L2b)

---

# 5. Token Registry (v0.1)

| Token | Category | Purpose | Status |
|-------|----------|----------|--------|
| @A1 | Activation | EnaC Runtime Lite | Active |
| @A2 | Activation | EnaC + MxVA Hard Sync | Active |
| @L1 | Loader | ResumeSelector | Active |
| @L2 | Loader | ATC Mini | Active |
| @L3 | Loader | GlossRP Kernel Lite | Active |
| @S1 | Selector | Resume Full Pipeline | Active |
| @S2 | Selector | Evaluation Only | Active |
| @S3 | Selector | Cascade Engine | Active |
| @D1 | Drift | Micro Drift Correction | Active |
| @D2 | Drift | Hard Reset | Active |
| @D3 | Drift | Purge + Re-anchor | Active |

---

# 6. Reserved Token Prefixes
- A = Activation  
- L = Loader  
- S = Selector  
- D = Drift/Patch  
- X = Experimental (future)  

---

# End of File
