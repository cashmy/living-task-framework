# Glossary Update — Tiered Protocol
## Term: Tiered Protocol
## Long Form: Cross-LLM Tiered Protocol Framework
## Version: v0.1 (ECL-Aligned Draft)

---

:::SCS_T1
something here
::: 

## 1. Canonical Definition (Architecture-Facing)

NOTE* TIERED PROTOCOL DEFINITION IS DRAFT. THIS FILE WILL EVOLVE AS CORE_PRIMER, ECL, AND GUARDRAILS MATURE. And it name is a working title pending final alignment.

The **Tiered Protocol (Cross-LLM Tiered Protocol Framework)** is an **ECL-aligned behavioral contract** that governs how one or more LLMs operate across **stacked, evolutionary tiers of capability** (T1, T2, T3), while remaining interoperable across different vendors (e.g., GPT, Claude, Gemini, Llama, Mistral).

A Tiered Protocol is characterized by:

- **Evolutionary Context Layering (ECL)**
  Each Tier is *inclusive* of the ones beneath it:
  - **T1** – Exploratory reasoning and mapping.
  - **T2** – T1 **plus** structuring, procedure definition, and specification.
  - **T3** – T1 + T2 **plus** compression, answer-first outputs, and execution-oriented brevity.  
  Higher tiers add constraints and capabilities without discarding lower-tier skills.

- **Vendor-agnostic behavioral normalization**
  The protocol defines **what behavior must look like**, not how any one model “naturally” behaves. Cross-LLM adapters then patch model-specific quirks (verbosity, summarization bias, meta-commentary, formatting drift) to approximate the protocol’s expectations.

- **Guardrail-governed operation**
  The protocol is anchored in explicit guardrails:
  - **DOD-1 (Default Output Density Guardrail)** – regulates verbosity per tier.
  - **SCL (Structured Compression Layer)** – provides controlled shortening while preserving structure.
  - **Verbatim Rule** – enforces literal fidelity when required (e.g., specs, code, protocols).
  - **Export subsystems like STMG** – operate *outside* conversational density constraints.

- **Tier-aware state machines**
  Conversation and task flow are shaped by tier-aware state transitions:
  - From **intent detection** → **tier selection** → **execution** → **review/repair** → **capture/export**.
  - Each Tier has specific constraints on recursion depth, density, and allowed operations, but can always “fall back” to behaviors of the lower tiers when needed.

- **Architectural binding to EnaC / ECL**
  The Tiered Protocol is **not just a UX convention**. It is designed to run under the EnaC/ECL stack (CORE_PRIMER, SELF-ECL, COS/SCL/FIM, ABS, drift mechanisms, CSAC), so that the AI behaves as a governed collaborator (EnaC) and/or SAAS pattern, rather than as an unconstrained chat model.

- **Cross-LLM compatibility**
  A Tiered Protocol provides a **single behavioral contract** that can be realized on multiple LLMs through:
  - Per-model adapter configurations.
  - Tier × Model × Guardrail mappings.
  - Explicit exemptions and overrides for subsystems (like STMG).

A Tiered Protocol is **not**:

- a single prompt template,
- a fixed persona or “style,”
- a vendor-specific SDK feature, or
- a generic “best practices for using LLMs.”

Instead, it is the **formal, tiered behavioral specification** that describes how governed, architecture-aware LLMs must behave across T1–T3, regardless of which model is running underneath.

---

## 2. Human-Optimized Quick Reference Entry

- **Term:** Tiered Protocol  
- **Long Form:** Cross-LLM Tiered Protocol Framework  
- **Human Description:**  
  A Tiered Protocol is the rulebook that tells different AIs (GPT, Claude, Gemini, etc.) how to behave at three stacked levels: explore (T1), structure (T2), and compress (T3). Each higher tier includes the skills of the lower one, but adds new rules—like being more concise, more structured, or more execution-ready.  
  Instead of every model “acting however it wants,” the Tiered Protocol gives them a shared behavioral contract, so you get consistent, predictable collaboration no matter which LLM you’re using.
- **Classification:** Behavioral Contract / Cross-LLM Architecture Layer  
- **Layer:** Horizontally spans T1–T3 under EnaC/ECL, anchored by CORE_PRIMER and guardrails (DOD-1, SCL, Verbatim, STMG).

---

## 3. Drift Resolution Notes (Draft)

### Anticipated Drift Patterns
- **Mode vs. Layer confusion:** Treating T1, T2, T3 as mutually exclusive “modes” instead of evolutionary layers where each tier includes those beneath it.
- **Vendor lock-in:** Describing the protocol as if it only applies to a single LLM family (e.g., GPT-only), breaking the cross-LLM intent.
- **Tooling vs. protocol conflation:** Calling orchestration scripts, agents, or SDK features “the Tiered Protocol,” rather than recognizing the protocol as the underlying behavioral spec those tools must implement.
- **Overloading with project-level concerns:** Mixing business workflow, project governance, or product decisions into the protocol instead of keeping it focused on AI behavior.

### Correct Conceptual Center (v0.1)
- The Tiered Protocol is an **ECL-based behavioral spec**, not a tool or persona.
- Tiers are **inclusive**: T2 = T1 + structure, T3 = T1 + T2 + compression.
- Cross-LLM behavior is normalized via **adapters and guardrails**, not by forcing every model to act identically at the raw level.
- The protocol lives **inside** the EnaC/ECL architecture (CORE_PRIMER, guardrails, CSAC), and exists to make model behavior predictable, explainable, and portable.

---

## 4. Insertion Snippet for Master_Glossary_Incremental.md

**Tiered Protocol (Cross-LLM Tiered Protocol Framework)** – An ECL-aligned behavioral contract that defines how governed LLMs operate across three stacked tiers of capability: T1 (exploration), T2 (structuring), and T3 (compression). Each higher tier includes the ones beneath it, adding constraints and capabilities rather than replacing them. The Tiered Protocol is vendor-agnostic and relies on guardrails like DOD-1, SCL, and the Verbatim Rule, plus per-model adapters, to normalize behavior across GPT, Claude, Gemini, Llama, Mistral, and others. It is architecturally bound to the EnaC/ECL stack (CORE_PRIMER, drift mechanisms, CSAC) and exists to give different models a shared, predictable behavioral contract.

---

## 5. Metadata

- **Term:** Tiered Protocol  
- **Version:** 0.1 (Draft, ECL-aligned)  
- **Date:** 2025-11-16  
- **Authors:** Cash Myers + EnaC (AI-assisted)  
- **Status:** Draft (Kernel-Compatible, pending full CORE_PRIMER integration)
