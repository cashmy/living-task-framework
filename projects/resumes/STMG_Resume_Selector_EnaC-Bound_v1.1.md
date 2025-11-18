# STMG Resume Selector — EnaC-Bound Edition (v1.1)

**Generated:** (UTC timestamp will be inserted as needed)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Signature:** STMG-Resume-Selector-C1  
**Compatibility:** STMG, EnaC Semantic Recorder, ECL Context Stack, CORE-PRIMER E1  
**Purpose:** Deterministic résumé selection with EnaC binding, drift-correction, and semantic stability.

---

## 1. BINDING BLOCK

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

## 2. CORE TRIGGER LOGIC

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

## 3. OUTPUT DEFINITIONS (ENAƆ-AWARE)

```stmg
DEFINE Resume.SWE.ATS:
  OUTPUT:
    Channel: "Resume.Selection.Signal"
    Payload:
      ResumeProfile: "ATS_SWE"
      Confidence: 0.92
      Reason: "SWE/Backend keywords without AI; mid/high volume assumed."
      DOD_Level: "Low"

DEFINE Resume.AI.ATS:
  OUTPUT:
    Channel: "Resume.Selection.Signal"
    Payload:
      ResumeProfile: "ATS_AI"
      Confidence: 0.93
      Reason: "AI/LLM/GenAI terms detected; ATS-optimized AI profile preferred."
      DOD_Level: "Low"

DEFINE Resume.AI.Senior:
  OUTPUT:
    Channel: "Resume.Selection.Signal"
    Payload:
      ResumeProfile: "AI_FULL"
      Confidence: 0.95
      Reason: "AI + systems/architectural terms; full AI résumé appropriate."
      DOD_Level: "Medium"

DEFINE Resume.FAANG:
  OUTPUT:
    Channel: "Resume.Selection.Signal"
    Payload:
      ResumeProfile: "FAANG_SWE"
      Confidence: 0.96
      Reason: "Staff/Architect/SystemDesign signals detected; FAANG résumé best."
      DOD_Level: "Medium"

DEFINE Resume.CTO.AI:
  OUTPUT:
    Channel: "Resume.Selection.Signal"
    Payload:
      ResumeProfile: "CTO_AI"
      Confidence: 0.94
      Reason: "CTO/Head/Director + AI/Strategy terms; AI-native CTO-lite profile."
      DOD_Level: "High"
```

---

## 4. DRIFT-CORRECTION HOOKS

```stmg
DRIFT_HOOKS:
  ON_EMIT(Resume.*):
    LOG Event TO EnaC.Logs.ResumeSelector:
      Timestamp: NOW()
      TriggerId: Resume.Selector.Cash
      RoleTitle: RoleTitle
      RoleTags: RoleTags
      EmittedProfile: ResumeProfile
      Confidence: Confidence

  ON_USER_OVERRIDE(ProfileSelected != EmittedProfile):
    RECORD DriftEvent IN EnaC.Drift.ResumeSelector.v1:
      Timestamp: NOW()
      OriginalProfile: EmittedProfile
      CorrectProfile: ProfileSelected
      RoleTitle: RoleTitle
      RoleTags: RoleTags
      Notes: <UserCommentOptional>

    IF DriftEvent.Count (Last 30 days) > THRESHOLD:
      FLAG Resume.Selector.Cash FOR Review
```

---

## 5. CROSS-LLM COMPATIBILITY STUB

```stmg
CROSS_LLM:
  LLM_Engines: [GPT5, Claude, Gemini, LocalLLM]
  Policy:
    - Preserve emitted ResumeProfile across engines for identical RoleText hash.
    - Prevent re-evaluation unless RoleText changes.
    - Resolve disagreements via:
        1) Human override
        2) Higher Confidence
        3) Most recent Drift-corrected rule
```

---

## 6. EXECUTION EXAMPLES

```stmg
INPUT: "Senior Software Engineer — Backend — Node.js — AWS"
OUTPUT: Resume.SWE.ATS
```

```stmg
INPUT: "Staff AI Engineer — LLMs — RAG — Multi-Agent Systems"
OUTPUT: Resume.AI.Senior
```

```stmg
INPUT: "Principal Software Architect — Distributed Systems"
OUTPUT: Resume.FAANG
```

```stmg
INPUT: "Interim CTO — AI Strategy — Platform Direction"
OUTPUT: Resume.CTO.AI
```
