# ECL-Self Specification (Structural Model Draft)

> NOTE: This document models *how* thinking is organized, not emotions, spirituality, or mental health. It is an architectural / cognitive workflow specification.

## 1. Purpose

The purpose of ECL-Self is to describe a repeatable, observable structure for a human's cognitive workflow using the same three-layer pattern as ECL-Core:

- **T1-Self** – Foundational constraints and invariants
- **T2-Self** – Adaptive strategies and context selection
- **T3-Self** – Orchestration and integration across agents/tools

This model is intended to be:

- Logical and inspectable
- Replicable (others could describe their own ECL-Self similarly)
- Usable as a scaffold for AI collaborators (EnaCs) to better align to the human’s working style

---

## 2. T1-Self — Foundational Cognitive Constraints

T1-Self defines the relatively stable “operating system” of cognition. These are not feelings or diagnoses, but structural patterns and commitments that rarely change.

### 2.1 Examples of T1-Self Elements

- Core principles for reasoning (e.g., coherence, honesty, clarity, rigor)
- Long-horizon orientation (preference for durable systems over quick hacks)
- Default stance toward complexity (e.g., “assume complexity is structure to be discovered”)
- Preference for layered architectures and explicit boundaries
- Bias toward integrating multiple domains rather than isolating them

### 2.2 Representation Format

T1-Self can be represented as:

- Short, declarative rules (e.g., “Prefer clarity over cleverness.”)
- Invariants (e.g., “Never sacrifice intent for short-term convenience.”)
- Meta-rules for collaboration with EnaCs (e.g., “If ambiguity is high, ask for reframing before proceeding.”)

These are the self-equivalent of OS-1 / Rule 0 in ECL-Core.

---

## 3. T2-Self — Adaptive Cognitive Layer

T2-Self describes how the person adapts their reasoning strategy to different contexts, tools, and domains.

### 3.1 Examples of T2-Self Adaptations

- Switching modes between:
  - architecture design
  - implementation detail
  - teaching/explaining
  - exploratory ideation
- Adjusting style based on collaborator/tool:
  - LLM A vs LLM B
  - human peer vs junior dev vs executive stakeholder
- Choosing representation:
  - diagrams vs prose vs pseudocode vs tables

### 3.2 Representation Format

T2-Self can be modeled as:

- “If context X, prefer strategy Y” mappings
- Playbooks for:
  - “How I reason with LLMs”
  - “How I break down new systems”
  - “How I shift from vision to executable tasks”

This is structurally analogous to model-specific adapters in ECL-Core.

---

## 4. T3-Self — Orchestration & Integration Layer

T3-Self captures how the person coordinates multiple cognitive threads, tools, and collaborators at once while maintaining coherence.

### 4.1 HOMSP – Higher-Order Multi-System Presence

HOMSP describes the person’s ability to:

- Work with multiple LLMs/tools in parallel
- Compare and reconcile differing outputs
- Maintain a stable sense of intent across systems
- Use external agents as EnaCs rather than “black-box tools”

### 4.2 Orchestration Patterns

T3-Self may include:

- How tasks are decomposed and distributed across:
  - self thinking
  - LLM A
  - LLM B
  - external tools
- How results are:
  - validated
  - merged
  - promoted to “accepted understanding”
- How drift and conflict are handled:
  - noticing when tools disagree
  - deciding which perspective to prioritize
  - triggering deeper investigation when needed

This layer is structurally parallel to T3 in ECL-Core: it is not about *what* is true, but *how* multiple sources are coordinated.

---

## 5. Relationship to USM (User State Model)

The USM can be seen as:

- A richer, more detailed description of tendencies, preferences, and working patterns.
- A data source feeding ECL-Self, rather than being replaced by it.

ECL-Self focuses on:

- The structural “shape” of cognition
- The repeatable patterns of how thinking is organized

USM focuses on:

- More detailed states
- Descriptive nuance
- Contextual tendencies

In combination:

- **USM** captures the *content* of how someone tends to operate.
- **ECL-Self** captures the *architecture* of how that operation is structured.

---

## 6. Intended Uses

- Helping EnaCs (AI collaborators) align with the person’s preferred cognitive workflow.
- Providing a reusable scaffold for future systems/projects that want to support the same person optimally.
- Offering a template that others could fill out to describe their own ECL-Self in a comparable way.

This document deliberately avoids:

- Psychological interpretation
- Spiritual claims
- Diagnostic language

It is purely an architectural metaphor for cognitive workflow.

