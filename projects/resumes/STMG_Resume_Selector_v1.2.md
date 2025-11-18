# STMG Resume Selector — v1.2 (Scoring Enabled, Minimal DOD)

**Generated:** (timestamp on demand)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Signature:** STMG-Resume-Selector-v1.2  
**Modes:** EnaC-Bound, Scoring Enabled, Minimal DOD  
**Compatibility:** STMG, EnaC Kernel T3, CORE-PRIMER, UMP/USP, STMG v1.1+

---

# 1. Binding Block (Inherited from v1.1)
```stmg
BINDING:
  Engine: EnaC
  Layer: EnaC-Semantic-Trigger-Layer
  TriggerId: Resume.Selector.Cash
  KernelProfile: EnaC.Kernel.Canonical.T3
  StartupBundle: EnaC.Startup.ResumeSelector.T3.v1
  DriftProfile: EnaC.Drift.ResumeSelector.v1
  Priority: MEDIUM
  Mode: ADVISORY

ON_ACTIVATE:
  REQUIRE CORE_PRIMER.ACTIVE == TRUE
  REQUIRE UMP.CASH.ACTIVE == TRUE
  ATTACH TriggerId TO EnaC.SemanticRecorder
  REGISTER Resume.Selector.Cash AS:
    Category: "CareerOps"
    Subcategory: "JobApplication"
    OutputChannel: "Resume.Selection.Signal"

ON_DEACTIVATE:
  DETACH TriggerId FROM EnaC.SemanticRecorder
  FLUSH PendingSignals WHERE Channel == "Resume.Selection.Signal"
```

---

# 2. Core Trigger Logic (from v1.1)
```stmg
TRIGGER: Resume.Selector.Cash

CONTEXT:
  RoleText: <Job Description Text>
  RoleTitle: <Job Title Only>
  RoleTags: AutoExtract(RoleText)

LOGIC:
  IF RoleTags CONTAINS ANY [
      "AI", "LLM", "Generative AI", "GenAI",
      "Transformer", "RAG", "Embeddings",
      "Machine Learning Engineer", "Artificial Intelligence"
  ]
    THEN EMIT Resume.AI.ATS
    EXCEPT WHEN RoleTags CONTAIN ANY ["Architect", "Distributed Systems", "Platform", "Staff"]
      THEN EMIT Resume.AI.Senior

  IF RoleTags CONTAINS ANY [
      "Backend", "Platform", "Infrastructure",
      "Full-Stack", "Cloud", "Node", "TypeScript", "Python"
  ]
    AND NOT RoleTags CONTAIN ANY ["AI", "LLM", "Machine Learning"]
    THEN EMIT Resume.SWE.ATS
    EXCEPT WHEN RoleTags CONTAIN ANY ["Staff", "Architect", "Principal"]
      THEN EMIT Resume.FAANG

  IF RoleTags CONTAINS ANY [
      "Staff Software Engineer", "Principal Engineer",
      "Technical Architect", "Engineering Lead",
      "Software Architect", "Systems Design"
  ]
    THEN EMIT Resume.FAANG

  IF RoleTags CONTAINS ANY [
      "CTO", "Chief Technology Officer", "Head of Engineering",
      "Director of Engineering", "AI Strategy", "Technology Strategy"
  ]
    THEN EMIT Resume.CTO.AI

DEFAULT:
  EMIT Resume.SWE.ATS
```

---

# 3. Scoring Engine Extension (New v1.2)

## 3.1 Skill Match Score (1–100)
```stmg
FUNCTION EvaluateSkillFit(RoleTags, SkillProfile):

  DirectTech = ScoreDirectTech(RoleTags, SkillProfile.CoreStack)        # 0–45
  Seniority  = ScoreSeniority(RoleTags, SkillProfile.SeniorityBand)     # 0–25
  ArchFit    = ScoreArchitecture(RoleTags, SkillProfile.ArchStrength)   # 0–15
  CollabFit  = ScoreCollab(RoleTags, SkillProfile.CollabStyle)          # 0–10
  RiskAdjust = ScoreRisk(RoleTags, SkillProfile.NegativeSignals)        # -5–+5

  Raw = DirectTech + Seniority + ArchFit + CollabFit + RiskAdjust
  RETURN Clamp(Raw, 1, 100)
```

---

## 3.2 Desirability Index (1–100)
```stmg
FUNCTION EvaluateDesirability(RoleTags, MotivationProfile):

  AIAlign    = ScoreAIAlignment(RoleTags, MotivationProfile.AIWeight)       # 0–35
  Creativity = ScoreAutonomy(RoleTags, MotivationProfile.CreativeBias)      # 0–20
  CogReward  = ScoreComplexity(RoleTags, MotivationProfile.CogChallenge)    # 0–15
  RemoteFit  = ScoreRemote(RoleTags, MotivationProfile.RemotePreference)    # 0–10
  Portfolio  = ScorePortfolioFit(RoleTags, MotivationProfile.PortfolioAim)  # 0–10
  Friction   = ScoreFriction(RoleTags, MotivationProfile.FrictionTolerance) # -10–+10

  Raw = AIAlign + Creativity + CogReward + RemoteFit + Portfolio + Friction
  RETURN Clamp(Raw, 1, 100)
```

---

# 4. Updated Output Payload (Minimal DOD)

```stmg
OUTPUT:
  Channel: "Resume.Selection.Signal"
  Payload:
    ResumeProfile: <from v1.1>
    Confidence: <0.00-1.00>
    SkillMatchScore: <1-100>
    DesirabilityIndex: <1-100>
    Reason: <1–2 line rationale>
```

---

# 5. Example Evaluations

```stmg
INPUT: "Principal Software Engineer — Python — TypeScript — AWS — Distributed Systems"
OUTPUT:
  ResumeProfile: FAANG_SWE
  SkillMatchScore: 88
  DesirabilityIndex: 72
```

```stmg
INPUT: "Senior AI Engineer — LLMs — RAG — Multi-Agent Systems"
OUTPUT:
  ResumeProfile: AI_FULL
  SkillMatchScore: 93
  DesirabilityIndex: 91
```
---

# 6. Version Metadata

```stmg
VERSION: 1.2
STATUS: ACTIVE
PREVIOUS: v1.1 EnaC-Bound
DOD: Minimal
READY_FOR: STMG Runner, EnaC Semantic Layer, UMP/USP Integration
```
