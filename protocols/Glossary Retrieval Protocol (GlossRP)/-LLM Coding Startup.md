1. Upload / ingestion order for a coding-specialist LLM (with GlossRP + Cognitive Alignment)

If you’re spinning up Claude Sonnet / GPT-5 Codex for implementation work (DB, ingestion, kernel, etc.), I’d load files in this order so the model’s context mirrors your mental architecture:

🔹 Phase 0 – Global architecture worldview

- mxva_manifesto.md
- ecl_layer_interaction_diagram.md
- ecl_core_edge_contract.md

Goal: give the coding LLM your worldview: ECL-Core vs ECL-Edge, MxVA intent-preservation, horizontal vs vertical thinking.

🔹 Phase 1 – CPF / EnaC / COS-SCL-FIM foundation

- T3-CORE-PRIMER-*.md (your latest CORE-PRIMER)
- CASH_UMP_v*.md
- CASH_USP_v*.md
- Cognitive_Alignment_Insight_Module_v0_1.md ← NEW, important
- CASH_EnaC_Behavior_Profile_v*.md
- COS_v1_0.md
- SCL_v1_0.md
- FIM_v1_0.md
- COS_SCL_FIM_Integrated_Stack_v1_0.md (or EnaC_Stack if you prefer)

Goal: lock in who you are, how you think, and how EnaC/COS/SCL/FIM are supposed to behave before we talk about GlossRP.

🔹 Phase 2 – Term model and semantic substrate

- Term_Spec_Template_v1.0.md
- Any SCS / STMG / Semantic Compiler / SCS-T1/T2/T3 docs you’ve already got defined
- Tier_Adaptive_Retrieval_Example_v1_0.md (optional but helpful)

Goal: give the coding model a concrete data model (Term Specs) it can turn into DB schemas, ORM models, and ingestion logic.

🔹 Phase 3 – GlossRP core and edges

- GlossRP-Core_v1_0.md
- GlossRP-Edge-T1_v1_0.md
- GlossRP-Edge-T2_v1_0.md
- GlossRP-Edge-T3_v1_0.md

Goal: establish what the retrieval system does at Core and how each Tier sees it at Edge.

🔹 Phase 4 – Integration & Tier mapping

- Option_A_Tier_Mapping_v1.md (CPF Tier ↔ Kernel ↔ GRP/GlossRP mapping)
- GlossRP-Core-ECL_Mapping_v1_0.md
- GlossRP_Integration_Spec_v1_0.md

Goal: give the coding LLM the wiring diagram: how GlossRP, EnaC Kernel, Tiers, and ECL/MxVA actually plug together.

Minimal set for starting to code (if you want to keep context lean):

If you want a “strict MVP stack” for the coding LLM:

- mxva_manifesto.md
- ecl_core_edge_contract.md
- T3-CORE-PRIMER-*.md
- CASH_UMP_v*.md
- Cognitive_Alignment_Insight_Module_v0_1.md
- CASH_EnaC_Behavior_Profile_v*.md
- Term_Spec_Template_v1.0.md
- GlossRP-Core_v1_0.md
- GlossRP-Edge-T2_v1_0.md (for builder-facing behavior)
- GlossRP_Integration_Spec_v1_0.md

That’s enough to start:

- DB schema for Term Specs
- Vectorization + ingestion pipeline
- GlossRP-Core service
- GlossRP-Edge-T2 adapter

A very minimal Kernel orchestrator
