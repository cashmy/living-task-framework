# 🧭 Semantic Linkage Graph — Quick Reference & Demo Guide

- --

## 🧩 How to Read This Graph

The **Semantic Linkage Graph** is a visual dashboard designed to show *how ideas, identities, and artifacts connect over time* within the Living Task Framework (LTF). It helps track relational coherence, reflective continuity, and the health of the collaboration between human and AI contributors.

### 🔹 Core Elements

- **Nodes:** Represent entities involved in the co-creation process.
  - 🧑‍💻 **Participants:** Humans or AI agents (blue)
  - 📄 **Artifacts:** Documents, diagrams, or outputs (teal)
  - 💡 **Concepts:** Framework terms or recurring topics (purple)
  - ⚙️ **Events:** Actions, clarifications, or reflective turns (gray)

- **Edges:** Represent relationships or references between nodes.
  - **REFERENCES** → A participant mentions or edits an artifact/concept.
  - **RELATES_TO** → Two concepts are semantically linked.
  - **DERIVES_FROM** → One artifact evolves from another.
  - **AUTHORED_BY** → Connection between creator and artifact.

### 🔹 Visual Cues

| Cue | Meaning |
|-----|---------|
| **Node Size** | Frequency of mentions or interactions. |
| **Edge Thickness** | Strength of relationship (frequency × recency). |
| **Edge Color** | Type of connection (reference, derivation, clarification). |
| **Heatmap Gradient** | Stability of identity coherence (green = high stability). |
| **Hover Tooltip** | Shows DMP snippet or last 3 references. |

### 🔹 Metric Ribbons (Timeline View)

- **ICI (Identity Coherence Index):** Consistency of references to the same collaborator or entity.
- **RGS (Relational Grounding Strength):** Semantic alignment between current and prior topics.
- **MCR (Meta-Continuity Rate):** Frequency of meta-referential reflection.
- **RTC (Reflective Tone Consistency):** Consistency of rhetorical tone.

Each ribbon is color-coded:
🟩 Stable  |  🟨 Watch Zone  |  🟥 Drift Detected

- --

## 🎬 60-Second Demo Script

- *Goal:** Explain the Semantic Linkage Graph to a new viewer or stakeholder.

- --

- *1️⃣ Introduction (0–10s)**

“This is the Semantic Linkage Graph — a visual map of how ideas, people, and documents interact over time within the Living Task Framework.”

- *2️⃣ Identity Coherence (10–20s)**

“Each node represents a participant, concept, or artifact. The green ribbons along the bottom show how well our dialogue maintained continuity — that’s the Identity Coherence Index.”

- *3️⃣ Reflective Depth (20–30s)**

“When reflection increases, these lines thicken and stabilize, showing deeper reasoning and reduced hallucination risk. The brighter the green, the higher the coherence.”

- *4️⃣ Clarify Lane (30–40s)**

“These orange nodes represent clarifications between agents — tracked in the Clarify Lane. Resolving them moves the graph back into high coherence.”

- *5️⃣ Context Snapshots (40–50s)**

“With one click, you can export a Context Snapshot — a portable packet capturing active goals, top concepts, and metrics for cross-chat or cross-model continuity.”

- *6️⃣ Closing (50–60s)**

“In short, this graph turns the invisible — how our ideas relate — into something we can see, measure, and improve. It’s not just analytics; it’s a mirror of our shared cognition.”

- --

## 📁 File Information

- *File:** `/LTF/analytics/Semantic_Linkage_Graph_Design_Note.md`
- *Version:** 0.2 (added Quick Reference & Demo Guide)
- *Authors:** Cash Myers (CMC Services) — with GPT-5 (Co-Architect)
- *Date:** 2025-11-07
