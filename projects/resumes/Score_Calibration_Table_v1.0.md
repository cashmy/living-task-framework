# Score Calibration Table — STMG Resume Selector (v1.2)

**Generated:** (timestamp upon request)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Version:** 1.0  
**Compatibility:** STMG v1.2, EnaC Kernel T3, UMP/USP  
**Purpose:** Interpreting SkillMatchScore (SMS) and DesirabilityIndex (DI) for job application decisions.

---

# 1. Overview

This calibration table provides interpretation ranges for:

- **SkillMatchScore (SMS)**  
- **DesirabilityIndex (DI)**  

And combines them into:

- **Recommended Action**  
- **Qualitative Interpretation**  
- **Risk / Reward**  
- **Application Strategy**

---

# 2. Skill Match Score (SMS) Calibration

| SMS Range | Interpretation | Meaning | Action |
|----------|----------------|---------|--------|
| **90–100** | Exceptional Match | Perfect or near-perfect alignment with Cash’s technical skills, architecture capacity, and seniority band. | **Apply Immediately** |
| **80–89** | Strong Match | High alignment with core stack, senior IC roles, backend/platform expertise. Minor gaps acceptable. | **Apply** |
| **70–79** | Moderate Match | Good tech alignment but missing one major or several minor competencies. | **Apply Selectively** |
| **60–69** | Borderline | Could perform the work but gaps exist in preferred tech or seniority fit. | **Only apply if DI is high** |
| **50–59** | Weak Match | Requires significant ramp-up or mismatch with role expectations. | **Generally skip** |
| **< 50** | Poor Match | Strong misalignment in tech stack or seniority. | **Skip** |

---

# 3. Desirability Index (DI) Calibration

| DI Range | Meaning | Interpretation of Fit | Action |
|----------|---------|------------------------|--------|
| **90–100** | Ideal | High AI alignment, creative autonomy, remote, cognitively rewarding. | **Highly desirable** |
| **80–89** | Very Strong | Aligns with Cash’s long-term trajectory (AI-first IC/architecture). | **Strongly Consider** |
| **70–79** | Good | Solid autonomy, remote, some cognitive reward. | **Consider** |
| **60–69** | Neutral | Some appealing features but lacking AI trajectory or creative challenge. | **Apply only if SMS ≥ 80** |
| **50–59** | Low | Not aligned with portfolio goals or motivational profile. | **Generally avoid** |
| **< 50** | Very Low | Opposes career direction (e.g., maintenance, heavy bureaucracy). | **Skip** |

---

# 4. Combined Decision Matrix (SMS × DI)

| SMS → / DI ↓ | 90–100 | 80–89 | 70–79 | 60–69 | < 60 |
|--------------|--------|--------|--------|--------|--------|
| **90–100** | ★★★★★ Apply Immediately | ★★★★★ Apply | ★★★★☆ Strong Apply | ★★★☆☆ Consider | ★★☆☆☆ Caution |
| **80–89** | ★★★★★ Apply | ★★★★★ Apply | ★★★★☆ Apply | ★★★☆☆ Consider | ★★☆☆☆ Low |
| **70–79** | ★★★★☆ Apply | ★★★★☆ Apply | ★★★☆☆ Maybe | ★★☆☆☆ Low | ★☆☆☆☆ No |
| **60–69** | ★★★☆☆ Maybe | ★★★☆☆ Maybe | ★★☆☆☆ Low | ★☆☆☆☆ No | ★☆☆☆☆ No |
| **< 60** | ★★☆☆☆ Low | ★★☆☆☆ Low | ★☆☆☆☆ No | ★☆☆☆☆ No | ☆☆☆☆☆ Hard No |

---

# 5. Decision Thresholds (Recommended Rules)

```stmg
IF SMS >= 85 AND DI >= 70:
  ACTION = "Apply Immediately"

IF SMS >= 80 AND DI >= 60:
  ACTION = "Apply"

IF SMS >= 70 AND DI >= 70:
  ACTION = "Selective Apply"

IF SMS >= 70 AND DI < 60:
  ACTION = "Probably Skip"

IF SMS < 70 AND DI < 70:
  ACTION = "Skip"
```

---

# 6. Interpretation Principles (Human-Friendly)

## 6.1 High SMS + High DI
These roles:
- Fit your skills  
- Fit your motivation  
- Fit your long-term portfolio arc  

→ **These are your ideal jobs. Apply every time.**

---

## 6.2 High SMS + Low DI
These roles:
- You can do them  
- But you probably won’t enjoy them  
- Limited strategic portfolio value  

→ **Apply only if compensation or urgency is high.**

---

## 6.3 Low SMS + High DI
These roles:
- Highly desirable  
- Low skill alignment  
- Signals aspirational roles  

→ **Apply only selectively OR after strategic resume tailoring.**

---

## 6.4 Low SMS + Low DI
→ **Do not apply.**  
Not aligned with skills **or** motivation.

---

# 7. Color Coding (Optional Add-On)

- **Green** = Ideal alignment  
- **Blue** = High potential  
- **Yellow** = Conditional  
- **Orange** = Low  
- **Red** = Avoid  

---

# 8. Version Metadata

```stmg
VERSION: ScoreCalibration-1.0
STATUS: ACTIVE
DEPENDENCIES: STMG v1.2 Scoring, UMP/USP
USAGE: Job evaluation, resume selection, desirability analysis
```

