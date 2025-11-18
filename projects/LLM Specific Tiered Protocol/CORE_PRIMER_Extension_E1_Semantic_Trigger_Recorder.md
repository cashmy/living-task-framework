# CORE-PRIMER Extension Snippet  
## E‑1: Semantic Trigger Recorder (STR)  
*(Item 3 of 4 — Synchronous Delivery Mode)*

This file defines a **CORE-PRIMER extension module** that introduces a clean, interoperable mechanism for exporting the *semantic trigger prompt + assistant response* pair using the **Semantic Trigger Markdown Generator (STMG)**.

The purpose of this extension is to integrate STMG safely into the CORE‑PRIMER architecture without interfering with state discipline, drift control, or multi‑LLM orchestration.

---

# **E‑1: Semantic Trigger Recorder (STR)**  
### *CORE‑PRIMER Extension Snippet*

```yaml
Extension:
  id: E-1
  name: Semantic Trigger Recorder (STR)
  category: Export-Subsystem
  description: >
    Provides deterministic extraction of the semantic trigger prompt
    and verbatim capture of the assistant's previous response.
    Integrates the STMG (Semantic Trigger Markdown Generator) into
    CORE-PRIMER as a safe, drift-free archival subsystem.

  activation_phrase: "Generate Semantic-Trigger Markdown."
  deactivation_phrase: "Disable Semantic-Trigger Markdown."

  behavior:
    - Identify the semantic trigger prompt:
        rule: "Select the user prompt that directly caused the assistant's prior response; ignore meta-instructions."
    - Capture semantic trigger verbatim.
    - Capture prior assistant response verbatim.
    - Encode both sections into a clean insertion-map-safe `.md` file.
    - Do not alter, compress, summarize, or restructure the captured content.
    - Produce file via python_user_visible with no additional commentary.
    - Maintain strict separation from DOD-1 behavior (global exemption rule).
    - Execute in a single-pass, non-recursive operation unless user explicitly requests recursion.

  guardrails:
    - Must not inherit density constraints (DOD-1 exempt).
    - Must not alter content via SCL (Structured Compression Layer).
    - Must not activate Tier-2 analytical expansions unless requested.
    - Must not conflict with any agent orchestration architecture.
    - STR is a pure export/logging subsystem — not conversational.

  guarantees:
    - Archival fidelity.
    - Multi-LLM deterministic behavior.
    - Drift-free reconstruction suitability (CSAC-compatible).
    - Safe integration with CIP-E, LTF, and CFP ecosystems.

  placement:
    core_primer_section: "Subsystem Extensions"
    recommended_order: 
      before: "Tier Architecture"
      after:  "Verbatim Rule"
```

---

## **Notes for Integration**
- This extension becomes the **canonical method** for capturing user → assistant semantic relationships.
- STMG operations will inherit this STR definition automatically when the CORE‑PRIMER is loaded.
- Compatible with GPT, Claude, Gemini, Llama, Mistral when the cross‑LLM tiered protocol layer is applied (Item 4).

---


