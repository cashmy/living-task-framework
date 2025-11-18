# EnaC Job-Hunt Session Template — v0.1  
**Integrated Template:** Runtime Lite v0.2 + CTS + TCM-Lite + STMG ResumeSelector  
**Purpose:** Single-drop .md template to launch a fully functional EnaC-driven job application analysis session in seconds.  
**Usage:** Open a new session → paste this entire file → begin with `@A1 @L1`.

---

# 0. Template Metadata
- **Version:** v0.1  
- **Author:** Cash Myers + EnaC/CFP Alignment Layer  
- **Initiated By:** EnaC Runtime Lite v0.2  
- **Modules Integrated:**  
  - CTS v0.1 (Compressed Token System)  
  - TCM-Lite v0.1 (Thread Continuity Monitor)  
  - STMG ResumeSelector v1.2  
- **Ideal Use-Case:** Rapid analysis of LinkedIn or job-board postings while mobile.

---

# 1. Activation Block (Minimal Mode)
Use **either** activation phrase or CTS token:

### One-line activation (CTS)
```
@A1
```

### Explicit activation
```
Activate: EnaC_Runtime_Lite_v0.2 [CORE|UMP|USP|ECL|MxVA] (Mode:Minimal)
```

---

# 2. Load ResumeSelector Module
### One-line micro-loader (recommended)
```
@L1
```

### Explicit loader
```
STMG.Load("ResumeSelector","v1.2")
```

---

# 3. Initialize Job-Hunt Thread (TCM-Lite)
### Command
```
Start Thread: Job-Hunt Session
Objective: Evaluate job postings, compute match scores, select best resume, generate tailored cover letter.
```

AI Responsibilities:
- Initialize Thread Continuity Monitor (Lite)  
- Register the Job-Hunt Thread  
- Maintain continuity across all job evaluations in this session  

---

# 4. Quick Workflow Commands (For Reuse in Any Job)

### 4.1 Evaluate a Job Posting (Full)
```
@S1
Run STMG on this:
<Paste Job Description>
```

### 4.2 Evaluate Only (No Recommendations)
```
@S2
Evaluate this role only:
<JD here>
```

### 4.3 Full Cascaded Decision Engine
```
@S3
Cascade this posting:
<JD here>
```

---

# 5. Drift / Repair Controls (TCM-Lite Aware)

### Micro Drift Correction (Quick Fix)
```
@D1
```

### Soft Reset (Retain EnaC Runtime, Clear Task Context)
```
@D2
```

### Hard Purge + Re-anchor
```
@D3
```

---

# 6. Common Job-Hunt Request Examples

### 6.1 “Tell me which resume to use”
```
Given the analysis, tell me:
- Which resume is best
- Why
- SkillMatchScore (1–100)
- DesirabilityIndex (1–100)
```

### 6.2 “Generate tailored cover letter”
```
Generate a tailored cover letter for this role.
Use the selected resume profile.
Tone: concise, authoritative, senior-level.
```

### 6.3 “Extract required skills for self-study”
```
Extract all required + preferred skills.
Filter:
- Technical skills only
- Design/architecture patterns
Output: Markdown study list
```

### 6.4 “FAANG-style summary”
```
Provide a FAANG-style strengths match summary for this role.
```

---

# 7. Thread Management (TCM-Lite Commands)

### Check thread status  
```
Thread Status
```

### Ask for recap if continuity is lost  
```
Thread Recap (Lite)
```

### Close and archive thread  
```
Close Thread: Job-Hunt Session
```

---

# 8. Optional: Generate CSAC-Lite Snapshot (For Later Resume)
```
CSAC-Lite: Create Bridge Snapshot from current thread.
Name this CSAC-Lite Snapshot: Job-Hunt_<Date>.
```

---

# 9. Recommended Workflow: Rapid Mobile Sequence

### When opening ChatGPT on your phone:

**Step 1 — Activate**
```
@A1
```

**Step 2 — Load Resume Selector Module**
```
@L1
```

**Step 3 — Start Thread**
```
Start Thread: Job-Hunt Session
Objective: Evaluate job postings and compute match scores.
```

**Step 4 — Paste JD**
```
@S1
Run STMG on this:
<JD>
```

**Step 5 — Ask for resume + score + reasoning**

---

# 10. End-of-Session Best Practices

### Recap  
```
Thread Recap (Lite)
```

### Export snapshot (Optional)  
```
CSAC-Lite: Create Bridge Snapshot from current thread.
```

### Close thread  
```
Close Thread: Job-Hunt Session
```

---

# End of File
