# Glossary Update — STMG (Semantic Trigger Markdown Generator)
### Version: v0.2 (Architecture-Aligned)

---

## 1. Canonical Definition (Architecture-Facing)

**STMG (Semantic Trigger Markdown Generator)** is a governed, architecture-bound **export subsystem** responsible for producing **verbatim, insertion-safe markdown artifacts** that pair:

1. **The semantic trigger prompt** — the user prompt that *causally generated* the assistant’s preceding response.  
2. **The assistant response** — captured **exactly**, with no compression, reformatting, summarization, or model-native reinterpretation.

STMG’s core purpose is to eliminate ambiguity, variability, and behavioral drift across LLMs when performing semantic capture operations. It replaces earlier conversational capture patterns with a deterministic, cross-LLM-stable subsystem.

STMG’s architectural integration includes:

- **CORE_PRIMER Extension E‑1 (STR)** — governing semantic-trigger identification rules.  
- **Global DOD‑1 Exemption** — ensuring no density modulation or compression is ever applied.  
- **CL‑1 Cross‑LLM Compatibility Layer** — ensuring output consistency across GPT, Claude, Gemini, Llama, Mistral, etc.  
- **CSAC Reconstruction Dependency** — the exported artifacts serve as canonical state anchors for cross-session restoration.  

STMG is strictly **parallel to tiered reasoning** (T1/T2/T3). It is *not* a reasoning mode; it is a **lossless, deterministic export subsystem**.

---

## 2. Historical Evolution and Reasoning

STMG is the **formal evolution** of the earlier user‑driven instruction **“Capture This.”**

### 2.1 What “Capture This” Was  
A conversational heuristic dependent on each model’s internal interpretation. It suffered from:

- inconsistent behavior across LLMs,  
- unintended summarization or elaboration,  
- structural drift,  
- unreliable ordering of captured content,  
- hallucinated headings or metadata,  
- and poor suitability for CSAC/ECL restoration workflows.

### 2.2 Why STMG Was Needed  
As EnaC, ECL, and the Tiered Protocol matured, a **deterministic and cross-LLM-stable** capture mechanism became essential.  
Reason:

> “Capture operations cannot depend on a model’s conversational interpretation; they must be governed by architecture.”

### 2.3 What STMG Changes  
STMG formalizes and replaces “Capture This” by introducing:

- **Semantic-trigger inference** (causal, not chronological).  
- **Verbatim response preservation** (no compression, no adjustments).  
- **Model-agnostic formatting enforcement** (stable markdown).  
- **Export-only behavioral contract** (no reasoning, no elaboration).  
- **Global DOD‑1 exemption** (lossless, full-fidelity capture).  

Thus:

> **STMG is the hardened, architecture-bound successor to ‘Capture This,’ engineered for stability across all LLM vendors.**

---

## 3. Human‑Optimized Quick Reference Entry

- **Term:** STMG  
- **Long Form:** Semantic Trigger Markdown Generator  
- **Human Description:**  
  STMG replaces the old “Capture This” command with a reliable, cross‑model export mechanism. It finds the *real* user prompt that triggered the previous answer and saves that paired with the exact response in a clean markdown file. No summarizing, no rewriting — STMG preserves the moment exactly, making it ideal for CSAC, ECL reflection, and multi‑LLM workflows.
- **Classification:** Export / Logging Subsystem  
- **Layer:** Parallel subsystem aligned with CORE_PRIMER, STR, EnaC/ECL  
- **Exemption:** Permanently exempt from DOD‑1 and all compression layers  

---

## 4. Drift Resolution Notes

### Anticipated Drift
- Treating STMG as a conversational instruction rather than an export subsystem  
- Applying summarization or compression during capture  
- Using the last *chronological* prompt instead of the *semantic* trigger  
- Allowing model-native “helpful behaviors” to modify output  
- Injecting meta commentary or extra explanation  

### Correct Conceptual Center
- STMG = export subsystem, not a reasoning layer  
- Output must be 100% verbatim  
- Trigger selection must be causal, not sequential  
- No density guardrails apply  
- Cross‑LLM normalization overrides all vendor-specific quirks  

---

## 5. Insertion Snippet for Master_Glossary_Incremental.md

**STMG (Semantic Trigger Markdown Generator)** —  
A cross‑LLM, architecture‑bound export subsystem that captures the semantic trigger prompt (the prompt that causally generated the previous assistant response) and the assistant’s full, verbatim output in a stable markdown file. STMG is the formal evolution of the earlier “Capture This” command, designed to eliminate model‑specific drift and ensure perfect fidelity for CSAC, ECL, CIP‑E, and multi‑LLM pipelines. STMG is globally exempt from DOD‑1 and all compression layers.

---

## 6. Metadata

- **Version:** 0.2  
- **Authors:** Cash Myers + EnaC (AI‑assisted)  
- **Date:** 2025‑11‑16  
