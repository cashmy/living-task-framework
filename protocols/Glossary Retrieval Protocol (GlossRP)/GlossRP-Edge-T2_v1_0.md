# GlossRP-Edge-T2 v1.0
## Glossary Rip Edge – Tier 2 (Builder / Technical Interface)
### Version: 1.0
### Date: 2025-11-16
### Layer: ECL-Edge (Vertical – T2 Audience)
### Status: Active

---

# 1. Purpose

**GlossRP-Edge-T2** is the **Tier 2 (Builder / Technical)** adaptation layer for GlossRP.  
It transforms the **neutral, Tier-agnostic candidate bundle** from **GlossRP-Core** into a **structured, architecturally meaningful glossary slice** appropriate for:

- Engineers  
- Architects  
- Technical collaborators  
- EnaC-aware but non-meta-level participants  

GlossRP-Edge-T2 resides in **ECL-Edge**, performing **audience shaping**, not retrieval.  
All semantic retrieval remains the responsibility of **GlossRP-Core (ECL-Core)**.

---

# 2. Target Audience (Tier 2)

Tier 2 is the **Builder / Technical Practitioner** band in CPF/ECL:

- Comfortable with abstraction  
- Able to reason with multiple concepts  
- Requires structural clarity  
- Can handle “internal system” terminology  
- Does **not** require:
  - Tier 3 meta-frameworks  
  - SELF-ECL  
  - ABS (Adaptive Behavior Stack)  
  - Deep cognitive introspection layers  

T2 expects **clarity**, **precision**, and **operational utility**, not philosophical depth.

---

# 3. Inputs and Outputs

## 3.1 Inputs

GlossRP-Edge-T2 consumes:

1. **GlossRP-Core Candidate Bundle**  
   - `candidates[]` (SCS_T1, SCS_T2, graph neighbors, scores)
   - `query_metadata`

2. **Tier Context**  
   - Tier = `T2`
   - Engineering language preferred (clear, direct, concise)

3. **Technical Mode Parameters**  
   - Max terms (default: 6–10)  
   - Enable/disable full SCS_T2 fields  
   - Enable/disable SCS_T3 neighbor injection

## 3.2 Outputs

GlossRP-Edge-T2 produces a **mid-density, structurally coherent glossary slice**, e.g.:

```json
{
  "tier": "T2",
  "terms": [
    {
      "name": "COS",
      "label": "Cognitive Ordering System",
      "scs_t1": "Determines execution order for cognitive operations.",
      "scs_t2": "Defines prioritization, sequencing, and dependency logic inside EnaC.",
      "related_terms": [
        {"term": "SCL", "relation": "structural_complement"},
        {"term": "FIM", "relation": "flow_dependency"}
      ]
    }
  ]
}
```

T2 slices are meant to support:

- Architectural design  
- Problem solving  
- Debugging cognitive flow  
- System-level reasoning  

---

# 4. Behavior Rules

## 4.1 Term Count

- Default: **6–10 terms**  
- Hard maximum: **12**  
- T2 users can handle more conceptual density than T1.

## 4.2 Structures Allowed

Tier 2 may expose:

- **SCS_T1** (anchors)  
- **SCS_T2 summaries** (full technical summaries)  
- **Selected SCS_T3 edges** (only where immediately relevant)

Tier 2 **MUST NOT** expose:

- Deep SELF-ECL interpretation  
- ABS views  
- Drift-table elements  
- Tier 3 introspection layers  

## 4.3 Language Constraints

GlossRP-Edge-T2 MUST:

- Use technical/architectural language  
- Prioritize clarity over friendliness  
- Keep entries short but meaningful (2–3 sentences)  
- Emphasize system behavior, not metaphor  

---

# 5. Processing Pipeline (T2)

Given a `GlossRP-Core` candidate bundle:

```text
Core Candidates
    → Relevance Ranking
    → Truncate to 6–10 terms
    → T2 Technical Transformation
    → Inject Selected SCS_T3 Edges
    → Output Tier 2 Glossary Slice
```

### 5.1 Relevance Ranking

T2 ranking prioritizes:

1. `vs_confidence` (if present)  
2. `similarity`  
3. Tier relevance annotation  
4. Graph centrality (terms with more cross-connections surface higher)

### 5.2 Truncation

Keep the top **6–10** most relevant terms.

### 5.3 T2 Transformation

For each term:

- Keep SCS_T1 anchor  
- Keep full SCS_T2 summary  
- Map related terms from SCS_T3  
- Add “operational utility notes” (derived automatically)  

### 5.4 Selected Graph Injection

Only neighbors directly relevant to the task OR highly central nodes should be included.

Avoid large cascades.

---

# 6. Integration With EnaC Kernel (T2)

When running in Tier 2:

1. Kernels receives task.  
2. Determines Tier = T2.  
3. Calls **GlossRP-Core**.  
4. Passes bundle to **GlossRP-Edge-T2**.  
5. T2 slice is returned.  
6. EnaC injects the slice into:
   - The technical reasoning prompt  
   - Builder-facing UI surfaces  
   - Context windows for task execution  

T2 EnaC behavior:

- Uses technical terms directly.  
- Maintains structural and dependency explanations.  
- Avoids deep introspection layers unless escalated.  

---

# 7. ECL / MxVA Alignment

## 7.1 ECL-Core vs ECL-Edge

- GlossRP-Core = semantic retrieval (horizontal)  
- GlossRP-Edge-T2 = technical interface shaping (vertical)

## 7.2 MxVA Compliance

Tier 2 output maximizes **architectural value per token**, ensuring that:

- Meaning is preserved  
- Structure is exposed  
- Overload is avoided  
- Technical utility is high  

The underlying intent remains anchored in Term Specs and GlossRP-Core.

---

# 8. Version Metadata

- Name: GlossRP-Edge-T2
- Version: 1.0
- Tier: T2 – Builder / Technical
- Layer: ECL-Edge
- Depends On:
  - GlossRP-Core v1.0
  - Term Spec Template v1.x
  - EnaC Kernel (Tier 2 mode)
- Non-Responsibilities:
  - Retrieval
  - Deep Tier 3 shaping
  - Personalization (beyond tone)
- Date: 2025-11-16
