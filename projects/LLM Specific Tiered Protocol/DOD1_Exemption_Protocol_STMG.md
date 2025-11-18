# DOD-1 Exemption Protocol for STMG  
*(Item 2 of 4 — Corrected Version Aligned With Actual DOD-1 Definition)*

This file defines the **Default Output Density Guardrail (DOD-1) Exemption Protocol** specifically for the **Semantic Trigger Markdown Generator (STMG)**.

Because STMG and DOD-1 have *contrary intents*, this protocol ensures clean separation, preventing cross-system interference in multi-LLM orchestration environments.

---

# **DOD-1 Exemption Protocol: STMG**

## **Purpose**
Ensure that the **Semantic Trigger Markdown Generator (STMG)** always produces uncompressed, verbatim files — completely unaffected by the Default Output Density Guardrail.

This guarantees **archival fidelity**, **traceability**, and **accurate reconstruction** across sessions and across LLM platforms.

---

## **DOD-1 Exemption Rule (Global)**

```yaml
DOD-1:
  exemption:
    id: STMG-EXEMPT-GLOBAL
    target: Semantic Trigger Markdown Generator
    type: Global-Exemption
    rationale: >
      DOD-1 restricts conversational verbosity to prevent cascades and drift.
      STMG requires verbatim, uncompressed export of both the semantic trigger prompt
      and the previous assistant response. These intents are structurally incompatible.
      Therefore, STMG is globally exempt from DOD-1 compression behavior.
    behavior:
      - When STMG is invoked, no output density reduction may be applied.
      - Semantic trigger prompt must be captured verbatim.
      - Previous assistant response must be captured verbatim.
      - No summarization, compression, rewriting, or density modulation is permitted.
      - This exemption applies regardless of LLM, tier, mode, or agent state.
    scope: 
      global: true
      persistent: true
      affects: 
        - GPT models
        - Claude models
        - Gemini models
        - Llama models
        - Mistral models
      interaction:
        - STMG must not inherit or be influenced by DOD-1 behavior.
        - DOD-1 continues to govern conversational output everywhere else.
    guarantees:
      - Exported files always reflect true, unaltered content.
      - Cross-LLM normalization remains consistent and predictable.
      - Reconstruction tools (CSAC, CIP-E, LTF, etc.) operate on accurate data.
```

---

## **Placement in CORE-PRIMER**
Add this block under:

### **`DOD-1: Density Guardrails` → `Exemptions`**

This establishes STMG as a **special subsystem** outside conversational output constraints.

---
