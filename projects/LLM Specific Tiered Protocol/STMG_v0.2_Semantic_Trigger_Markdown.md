# STMG_v0.2_Semantic_Trigger_Markdown
## Semantic Trigger Prompt
Rewrite STMG v0.2

## Assistant Response
# STMG v0.2 — Semantic Trigger Markdown Generator  
### *Export Subsystem Specification (ECL/EnaC Aligned)*

---

## 1. Term Metadata

- **Term:** STMG  
- **Long Form:** Semantic Trigger Markdown Generator  
- **Version:** **v0.2**  
- **Category:** Export / Logging Subsystem  
- **Status:** Draft (Architecture-Stable)  
- **Depends On:** CORE_PRIMER, STR (Extension E-1), DOD-1 Exemption Layer, CL-1 Cross-LLM Compatibility  
- **Date:** 2025-11-16  

---

# 2. Canonical Definition (Architecture-Facing)

**STMG (Semantic Trigger Markdown Generator)** is a **dedicated, architecture-bound export subsystem** that captures the *semantic trigger prompt* and the *assistant’s response* as a **verbatim, insertion-safe markdown artifact**, insulated from all conversational variability and model-specific interpretation.

STMG exists to solve a fundamental problem:  
Different LLMs interpret generalized instructions like “capture this” unpredictably.  
STMG replaces that ambiguity with a governed, deterministic, **cross-LLM-normalized** mechanism.

At its core, STMG performs two operations:

1. **Semantic Trigger Extraction**  
   Identify the *actual* user prompt responsible for producing the previous assistant reply.  
   - Excludes meta-instructions (e.g., “generate a file,” “download this”).  
   - Anchors capture to **semantic causality**, not chronological adjacency.

2. **Verbatim Response Preservation**  
   The assistant’s previous message is exported **without alteration**, unaffected by:  
   - DOD-1  
   - SCL  
   - summarization heuristics  
   - model-specific reformatting  
   - conversational compression behaviors

The resulting `.md` file becomes a **canonical cross-session artifact**, designed to be fed back into CSAC, CIP-E, LTF, ECL reflection layers, or multi-model pipelines.

---

# 3. Origin & Evolution — The Successor to “Capture This”

STMG is the **formal evolution** of the earlier human protocol *“Capture This.”*

### 3.1 What “Capture This” Was
A conversational instruction interpreted differently by every LLM:
- Sometimes treated as a summary request  
- Sometimes as a verbatim copy  
- Sometimes ignored  
- Sometimes mixed with analysis  
- Sometimes generating hallucinated metadata  

This made it **non-deterministic** and **not portable** across LLM vendors.

### 3.2 What STMG Fixes
STMG isolates this behavior inside a **governed subsystem**, ensuring:
- consistent trigger extraction  
- consistent formatting  
- consistent verbatim copying  
- consistent file output  
- consistent behavior across GPT, Claude, Gemini, Llama, Mistral  

### 3.3 Architectural Insight
> **STMG is the hardened, cross-LLM, architecture-bound successor to “Capture This.”**  
> It transforms a conversational heuristic into a deterministic subsystem.

---

# 4. Behavioral Contract

STMG must always:

- Use **semantic-trigger inference**, not temporal inference  
- Export **verbatim** content with zero modification  
- Produce **clean, insertion-map-safe markdown**  
- Operate **independently of all guardrails** (DOD-1, SCL, summarization logic)  
- Honor **strict cross-LLM normalization rules**  
- Avoid all meta-commentary  
- Produce only:
  - a file  
  - or a link to the file  

### Explicit Prohibitions
STMG **must not**:
- summarize  
- compress  
- restructure  
- clarify  
- interpret tone  
- add commentary  
- reflow text  
- collapse whitespace  
- reorder sections  
- infer missing material  
- auto-correct syntax or content

This subsystem is **pure export**, nothing else.

---

# 5. DOD-1 Exemption (Global Rule)

STMG is categorically and permanently exempt from:

- **DOD-1 (Default Output Density Guardrail)**  
- **Structured Compression Layer (SCL)**  
- any tier-bound density modulation  
- any model-native compression behavior  

Rationale:
- Export must be **lossless**  
- CSAC reconstruction must trust STMG artifacts  
- Fidelity outweighs verbosity  

> **STMG is the only subsystem permitted to fully bypass density guardrails.**

---

# 6. Integration With ECL / EnaC / CORE_PRIMER

STMG participates in the EnaC/ECL ecosystem as follows:

### 6.1 CORE_PRIMER
The **STR (Semantic Trigger Recorder)** extension governs:
- how triggers are identified  
- how capture models operate  
- how file safety is preserved  
- how model heuristics are suppressed  

### 6.2 ECL / Tiered Protocol Stack
STMG is **outside tiered reasoning behaviors**:
- It is not T1, T2, or T3  
- It is **parallel to tiers**, not inside them  
- It exports content **produced by** the tier engine, but is not governed by its density rules  

### 6.3 CSAC
STMG artifacts are a **first-class input** for cross-session reconstruction:
- semantic accuracy  
- response fidelity  
- predictable structure  

### 6.4 EnaC (AI-as-Collaborator)
STMG acts as a **collaboration accountability anchor**:
- reliable memory of “what was asked” + “what was answered”  
- zero drift  
- zero reinterpretation  

---

# 7. Cross-LLM Compatibility Layer Overview

STMG includes embedded normalization rules that force consistent behavior across models:

- **GPT:** suppress elaboration + reformatting  
- **Claude:** suppress reflection + analysis layers  
- **Gemini:** block auto-summarization  
- **Llama:** enforce strict delimiters for formatting stability  
- **Mistral:** override auto-compression tendencies  

Each model must adhere to a **shared section structure**:

```
# Title  
## Semantic Trigger Prompt  
<verbatim_user_prompt>  

## Assistant Response  
<verbatim_assistant_output>  
```

---

# 8. Output Specification

### 8.1 Required File Format
- Markdown (`.md`)  
- UTF-8 encoded  
- 1 H1 header  
- 2 H2 sections  
- No trailing commentary  
- No leading commentary  
- No inferred metadata  

### 8.2 Required Structure

```markdown
# <Context Name>  
## Semantic Trigger Prompt  
[verbatim user semantic trigger]  

## Assistant Response  
[verbatim assistant response]  
```

### 8.3 Tooling Requirements
When implemented via python_user_visible or equivalent:
- Only output should be the file link  
- No echoed contents  
- No file metadata  
- No logs or analysis  

---

# 9. Human-Optimized Summary Entry

**STMG** is a subsystem that takes the *real question that mattered* (the semantic trigger) and the *exact answer given* and stores them together as a pristine markdown file.  
It replaces the old “Capture This” behavior with something predictable, portable, and architecture-safe.  
It doesn’t summarize, explain, or clean anything up—it preserves the moment exactly as it happened so you can reuse it in CSAC, ECL reflections, or multi-LLM workflows later.

---

# 10. Drift Resolution Guidelines

Common drift patterns STMG must resist:

- Treating “previous prompt” as the last instruction  
- Summarizing or compressing content during export  
- Injecting analysis or tone adjustments  
- Treating STMG as conversational  
- Embedding model-native “helpful behavior”  

Correct center:
- STMG is an export subsystem  
- Export ≠ conversation  
- Export must remain deterministic and verbatim  
- Export must be consistent across all LLM vendors  
- STMG is the hardened, architecture-bound successor to “capture this”

---

# 11. Insertion Snippet for Master_Glossary_Incremental

**STMG (Semantic Trigger Markdown Generator)** —  
A cross-LLM, architecture-bound export subsystem that captures the semantic trigger prompt and the assistant’s response as a verbatim, insertion-safe markdown file. STMG is the formal evolution of the former “Capture This” command, isolating its behavior from model-specific heuristics and ensuring fidelity across vendors. It is globally exempt from DOD-1 and compression layers, anchored to CORE_PRIMER’s STR rules, and serves as a canonical artifact format for CSAC, CIP-E, ECL, and multi-model pipelines.

