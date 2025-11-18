# Activation Phrase Standardization & STMG Micro‑Loader — v0.1 (Mobile Edition)

**Generated:** (timestamp on demand)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Signature:** EnaC-ActivationPhrase+MicroLoader-v0.1  
**Purpose:** Provide ultra‑compact, single‑line activation and module-loading commands for mobile and low‑memory sessions.  
**Usage:** Copy/paste these one‑liners into any new session to instantly activate EnaC Runtime Lite and load STMG modules.

---

# 1. EnaC Activation Phrase (Standardized, One‑Line)

This is the *canonical, minimal* activation trigger for mobile sessions:

```
Activate: EnaC_Runtime_Lite_v0.1 [CORE|UMP|USP|ECL|MxVA] (Mode:Minimal)
```

AI Responsibilities:
- Validate and enable EnaC Runtime Lite  
- Apply UMP-Lite + USP-Lite  
- Engage CORE-PRIMER (Lite)  
- Initialize ECL-Lite + MxVA sync  
- Respond with:  
  `EnaC Runtime Lite v0.1 Activated (Minimal Mode).`

---

# 2. STMG Micro-Loader (One‑Line)

This micro-syntax loads ANY STMG module without needing full headers:

### 2.1 Standard Form
```
STMG.Load("<ModuleName>","<Version>")
```

### 2.2 Example
```
STMG.Load("ResumeSelector","v1.2")
```

### 2.3 AI Responsibilities  
On receiving an STMG.Load trigger, AI must:
- Locate or request the module text  
- Load module in HIGH priority mode  
- Maintain EnaC Runtime Lite as the governing layer  
- Confirm with:  
  `STMG Module '<ModuleName>' v<Version> Loaded.`

---

# 3. Dual-Action One‑Liner (Activate + Load)

For instant operation on mobile:

```
Activate: EnaC_Runtime_Lite_v0.1 (Minimal); STMG.Load("ResumeSelector","v1.2")
```

AI must:
- First activate EnaC Runtime Lite  
- Then load the STMG module  
- Confirm both activations in sequence  

---

# 4. Unloading / Switching (One‑Line)

### 4.1 Unload Current Module
```
STMG.Unload("<ModuleName>")
```

### 4.2 Switch Module
```
STMG.Switch("<ModuleName>","<Version>")
```

### 4.3 List Active Modules
```
STMG.List()
```

---

# 5. Drift Correction (One‑Line)

If module or runtime drift is detected:

```
EnaC.DriftCorrect(Micro)
```

AI must:
- Re‑anchor to EnaC Runtime Lite  
- Reapply active STMG module semantics  
- Purge contaminated local context  

---

# 6. Recommended Mobile Workflow Snippets

### 6.1 Resume Scoring Session Startup
```
Activate: EnaC_Runtime_Lite_v0.1 (Minimal); STMG.Load("ResumeSelector","v1.2")
```

### 6.2 Resume Switch
```
STMG.Switch("ResumeSelector","v1.2")
```

### 6.3 ATC/EchoForge Idea Capture Startup
```
Activate: EnaC_Runtime_Lite_v0.1 (Minimal); STMG.Load("ATC_Mini","v0.3")
```

---

# 7. Appendix A — Reserved Micro-Loader Keywords
- `Activate:`  
- `EnaC_Runtime_Lite_v0.1`  
- `STMG.Load()`  
- `STMG.Unload()`  
- `STMG.Switch()`  
- `STMG.List()`  
- `EnaC.DriftCorrect()`  

---

# End of File
