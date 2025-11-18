# Cross‑LLM Compatibility Layer  
## CL-1: Semantic Trigger Markdown Generator (STMG)  
*(Item 4 of 4 — Synchronous Delivery Mode)*

This file defines the **cross‑LLM compatibility specification** for the  
**Semantic Trigger Markdown Generator (STMG)**, ensuring stable, predictable,  
and interoperable behavior across GPT, Claude, Gemini, Llama, Mistral, and  
future models.

This compatibility layer is designed for your **Tiered Protocol Framework**  
to normalize export behavior in multi‑model orchestration environments.

---

# **CL‑1: Cross‑LLM Compatibility Layer for STMG**

```yaml
CrossLLM:
  id: CL-1
  name: STMG Cross‑LLM Compatibility Layer
  category: Normalization
  description: >
    Ensures that the Semantic Trigger Markdown Generator behaves 
    deterministically and identically across heterogeneous LLMs, despite
    differing native tendencies toward verbosity, recursion, inference depth,
    formatting, and prompt interpretation.

  subsystem: STMG
  version: 1.0

  global_rules:
    - STMG output must be verbatim, uncompressed, and not subject to any
      density reduction or model‑specific stream formatting.
    - Semantic trigger extraction must prioritize semantic causality over
      temporal adjacency.
    - All target models must follow identical markdown structuring.
    - No model-specific elaboration, creativity injection, or “helpful expansion”
      is permitted.
    - STMG must operate as a pure export/logging subsystem across all vendors.

  model_overrides:
    GPT:
      notes:
        - GPT tends to elaborate by default; enforce strict non-expansion.
        - GPT respects file creation boundaries well.
        - Risk: may incorrectly use last meta‑instruction — STR mitigates this.

    Claude:
      notes:
        - Claude tends to self-correct and meta‑explain; disable all reflexive elaboration.
        - Must explicitly suppress “helpful commentary” during STMG execution.

    Gemini:
      notes:
        - Tends to reorder or optimize text; enforce strict verbatim preservation.
        - High risk of unrequested summarization without constraints.

    Llama:
      notes:
        - May require explicit delimiters to maintain verbatim fidelity.
        - Reinforce insertion‑map safety to avoid formatting drift.

    Mistral:
      notes:
        - Tends to compress content automatically; override with strict no‑compression rule.
        - Ensure markdown headings remain stable.

  formatting_rules:
    - Only two sections allowed:
        1. Semantic Trigger Prompt
        2. Assistant Response
    - No banners, prefaces, or model metadata.
    - Markdown must be Git‑safe and CORE-PRIMER compatible.
    - Linebreaks must not be collapsed or expanded by model heuristics.

  conflict_resolution:
    - If the host model attempts to summarize → STOP and retry in verbatim mode.
    - If the host model tries to elaborate → truncate and re‑enforce STMG constraints.
    - If the host model reorders content → fall back to delimiter‑locked versioning.

  guarantees:
    - Identical STMG output across GPT, Claude, Gemini, Llama, and Mistral.
    - No drift introduced via model-level creativity or inference bias.
    - Predictable cross‑session logs suitable for CSAC, LTF, CIP‑E, and CFP ecosystems.
    - Full preservation of semantic causality between user prompt and assistant response.
```

---

# **Integration Notes**
- CL‑1 should be placed in your Tiered Protocol Framework under  
  **Cross‑LLM Normalization Layer**.
- When CORE‑PRIMER loads, it should automatically register this layer.
- STMG becomes part of your *canonical multi‑model export standard*, guaranteeing consistent behavior regardless of LLM vendor.

---

# **This completes Item 4.**
If you'd like a unified bundle, or want these 4 items stitched into a single  
deployable `.md` for your repository, just say the word.

