# GlossRP-Edge-T1 v1.0
## Glossary Rip Edge – Tier 1 (Consumer Interface)
### Version: 1.0
### Date: 2025-11-16
### Layer: ECL-Edge (Vertical – T1 Audience)
### Status: Active

---

# 1. Purpose

**GlossRP-Edge-T1** is the **Tier 1 (Consumer)** adaptation layer for the GlossRP system.  
It transforms the **Tier-neutral candidate bundle** from **GlossRP-Core** into a **minimal, cognitively safe, user-facing glossary slice** suitable for:

- General / non-technical users  
- Light consultative tasks  
- Low cognitive-load interactions  
- “Just tell me what this means” usage patterns  

GlossRP-Edge-T1 lives in **ECL-Edge** and is responsible for audience-specific shaping, *not* semantic retrieval.  
All retrieval and graph logic live in **GlossRP-Core (ECL-Core)**.

---

# 2. Target Audience (Tier 1)

Tier 1 is the **Consumer / General User** band in CPF / ECL:

- Wants direct answers  
- Limited tolerance for complexity or deep abstraction  
- Does not need internal architecture or EnaC details  
- Should not be exposed to meta-frameworks unless explicitly requested  

GlossRP-Edge-T1 enforces:

- Minimal context  
- High clarity  
- No cognitive overload  
- No deep system internals  

---

# 3. Inputs and Outputs

## 3.1 Inputs

GlossRP-Edge-T1 consumes:

1. **GlossRP-Core Candidate Bundle**  

   From `GlossRP-Core_v1_0`, including fields such as:
   - `candidates[]` (names, anchors, summaries, neighbors, scores)
   - `query_metadata`  

2. **Tier Context**
   - Tier = `T1`
   - Optional user language/locale settings

3. **Optional Display Constraints**
   - Max terms (default: 3–4)
   - Max characters per definition (for UI surfaces)
   - Optional “explain like I’m X” hints (e.g., 8th grade, non-expert)

## 3.2 Outputs

GlossRP-Edge-T1 produces a **thin glossary slice**, e.g.:

```json
{
  "tier": "T1",
  "terms": [
    {
      "name": "COS",
      "label": "Cognitive Ordering System",
      "short_definition": "The part of the system that decides the order in which it thinks through a problem."
    },
    {
      "name": "SCL",
      "label": "Structural Coherence Layer",
      "short_definition": "The layer that keeps ideas organized so they make sense together."
    }
  ]
}
```

This can be consumed by:

- The EnaC Kernel (to inject T1-safe context into responses)
- UI layers (to show tooltips, quick glossary panels, etc.)
- Other T1-facing experiences

---

# 4. Behavior Rules

## 4.1 Term Count

- Default: **3–4 terms**
- Hard maximum: **5 terms**
- Rationale: Tier 1 users should not be flooded with concepts.

## 4.2 Structures Allowed

Tier 1 is restricted to:

- **SCS_T1** (anchor text)
- **Very short, human-readable summaries** (derived from SCS_T2)

Tier 1 **MUST NOT** expose:

- SCS_T3 graph edges
- EnaC / SELF-ECL / ABS views
- Behavior profile details
- Drift tables
- Implementation notes
- Meta-architectural language

## 4.3 Language Constraints

GlossRP-Edge-T1 MUST:

- Use plain, non-technical language
- Avoid jargon unless directly requested
- Prefer short sentences and clear analogies
- Default to “helpful teacher” tone, not “architectural specification”

---

# 5. Processing Pipeline (T1)

Given a `GlossRP-Core` candidate bundle, GlossRP-Edge-T1 applies:

```text
Core Candidates
    → Relevance Ranking (using scores)
    → Truncate to 3–4 terms
    → Transform to T1-friendly labels and definitions
    → Output Tier 1 glossary slice
```

### 5.1 Relevance Ranking

1. Rank candidates primarily by:
   - `vs_confidence` (if present)
   - Fallback: similarity score or static priority

2. Filter out:
   - Low-confidence terms
   - Terms marked as internal-only or Tier ≥ 2 critical

### 5.2 Truncation

Take the top **N** terms (N = 3–4 by default).

### 5.3 Transformation

For each term, compute:

- `name` (short key, e.g., "COS")
- `label` (readable label, e.g., "Cognitive Ordering System")
- `short_definition` (1–2 sentence explanation)

Source fields:

- SCS_T1 anchor
- SCS_T2 core summary (heavily condensed and humanized)

---

# 6. Integration With EnaC Kernel (T1)

When operating in Tier 1 mode:

1. **Kernel** identifies Tier = T1 (via USP/Context/Mode).
2. Kernel calls **GlossRP-Core** with the task descriptor.
3. Kernel passes the candidate bundle to **GlossRP-Edge-T1**.
4. GlossRP-Edge-T1 returns a small glossary slice.
5. Kernel injects the glossary slice into:
   - The EnaC reasoning prompt (as simple helper definitions), or
   - The user UI (hover tooltips, “What does that mean?” sections).

T1 EnaC behavior:

- Refer to terms sparingly.
- Use intuitive explanations.
- Avoid exposing internal cognitive architecture unless the user escalates to T2/T3.

---

# 7. ECL / MxVA Alignment

## 7.1 ECL-Core vs ECL-Edge

- GlossRP-Core = ECL-Core (retrieval, semantics)
- GlossRP-Edge-T1 = ECL-Edge (audience shaping)

There is **no retrieval logic** in Edge-T1.  
It only thins and humanizes what Core provides.

## 7.2 MxVA Compliance

- Maximizes **value per cognitive token** for Tier 1.
- Minimizes cognitive overload and confusion.
- Respects intent preservation:
  - Meaning lives in Term Specs and GlossRP-Core.
  - Edge-T1 outputs are lossy *by design*, but safely so.

---

# 8. Version Metadata

- Name: GlossRP-Edge-T1
- Version: 1.0
- Tier: T1 – Consumer
- Layer: ECL-Edge
- Depends On:
  - GlossRP-Core v1.0
  - Term Spec Template v1.x
  - EnaC Kernel (Tier 1 mode)
- Non-Responsibilities:
  - Retrieval
  - Tier 2/3 shaping
  - Personalization (beyond tone)
- Date: 2025-11-16
