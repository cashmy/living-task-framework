# STMG Resume Selector v1.0

**Generated:** (UTC timestamp will be inserted manually when needed)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Signature:** STMG-Resume-Selector-C1  
**Compatibility:** STMG, EnaC Semantic Recorder, ECL Context Stack, CORE-PRIMER E1

---

## STMG CORE BLOCK

```stmg
TRIGGER: Resume.Selector.Cash

CONTEXT:
  RoleText: <Insert Job Description Text Here>
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

## Resume Type Definitions

```stmg
DEFINE Resume.SWE.ATS:
  "Use ATS Condensed SWE Resume (v1.2).
   Best for general SWE, backend, hybrid/local, mid-market,
   and remote roles with high applicant volume."

DEFINE Resume.AI.ATS:
  "Use ATS Condensed AI Resume.
   Best for AI Engineer, LLM Engineer, GenAI Engineer,
   and AI-focused SWE roles."

DEFINE Resume.AI.Senior:
  "Use AI Resume v1.x (full version).
   Best for senior AI roles requiring architecture,
   multi-agent systems, or LLM platform depth."

DEFINE Resume.FAANG:
  "Use FAANG Resume v1.0.
   Best for Staff SWE, Backend/Systems, Architect, Platform,
   and FAANG/FAANG-adjacent roles."

DEFINE Resume.CTO.AI:
  "Use AI Resume v1.x.
   Best for CTO-lite, Head of Engineering, AI Strategy,
   and technical leadership roles requiring both AI + architecture."
```

---

## Execution Flow

1. Scan job title + first 3 lines.
2. AutoExtract → RoleTags.
3. Evaluate hierarchical rules.
4. Emit deterministic résumé signal.
5. Default fallback: Resume.SWE.ATS

---

## Example Executions

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

---
