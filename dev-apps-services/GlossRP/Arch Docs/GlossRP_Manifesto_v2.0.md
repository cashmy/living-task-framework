# GlossRP Manifesto v2.0
## Retrieval Without Interpretation

### 1. Identity Statement
GlossRP is the **Semantic Retrieval System** of the Unified Cognition Stack (UCS).  
Its purpose is simple and focused:

> **Find the right terms. Return them clearly. Get out of the way.**

GlossRP does not think. It does not interpret. It does not evolve concepts.  
It retrieves meaning so that other systems can do their work.

---

### 2. Why GlossRP Must Exist
In a rich semantic ecosystem with:
- TermSpecs,
- evolving frameworks,
- EnaCs,
- SCS,
- LTF,
- Phoenix Workbench,

there must be a **single, reliable, deterministic service** that answers the question:

> “What do we already know about this term, concept, or domain?”

Without GlossRP, every subsystem would reinvent retrieval:
- EchoForge would guess,
- SCS would scrape,
- LTF would overreach,
- PW would hard-code lists.

GlossRP exists to prevent that fragmentation.

---

### 3. Core Principles

1. **Retrieval, not reasoning.**  
   GlossRP does not interpret concepts; it only returns them.

2. **Tier-neutral.**  
   No T1/T2/T3 behavior. GlossRP serves raw semantics; SCS shapes them.

3. **DRY and atomic.**  
   It avoids duplicating logic from SCS or LTF. It focuses on lookup only.

4. **Deterministic and predictable.**  
   Same query → same response (given the same dataset).

5. **Composable.**  
   EchoForge, SCS, LTF, PW, and EnaCs can all call GlossRP without side effects.

---

### 4. What GlossRP Does

- Looks up terms by:
  - id,
  - acronym,
  - title/name,
  - semantic similarity,
  - category.

- Returns:
  - full TermSpecs,
  - SCS compiler blocks (T1/T2/T3) as data,
  - raw relationship metadata (SCS_T3) when requested,
  - structured bundles for vector neighborhoods,
  - category-based term collections.

It is the **semantic catalog service** of the ecosystem.

---

### 5. What GlossRP Does *Not* Do

GlossRP:
- does **not** create or evolve relationships,
- does **not** infer Tier behavior,
- does **not** decide which meaning “wins”,
- does **not** track temporal evolution or drift,
- does **not** generate artifacts or text.

Those responsibilities belong to:
- **SCS** (compilation & Tier shaping),
- **LTF** (relationships & evolution),
- **PW** (artifacts),
- **EnaCs** (applied cognition).

---

### 6. Retrieval Modes (Philosophical View)

1. **Single Term Mode — “Name the thing.”**  
   When identity is known, GlossRP returns the exact definition and structure.

2. **Vector Bundle Mode — “Show me the neighborhood.”**  
   When context is fuzzy, GlossRP returns the local semantic field.

3. **Category Mode — “Show me the family.”**  
   When the user wants a whole conceptual set (e.g., all frameworks, all tools).

These three modes together allow humans and EnaCs to navigate the conceptual space without drowning in noise.

---

### 7. Relationship to SCS, LTF, and PW

- **To SCS:** GlossRP is the **data source** for semantic compilation.
- **To LTF:** GlossRP is a **lookup oracle** for concept identity and clusters.
- **To PW:** GlossRP is the **feeder** for glossary and index generation.

GlossRP is the **library**, not the author.

---

### 8. Evolution Path

As the ecosystem grows, GlossRP may:

- support more refined filters,
- plug into more storage backends,
- offer richer retrieval analytics.

But it must never:

- absorb Tier behavior,
- duplicate LTF’s semantics,
- overwrite SCS’s role as compiler.

---

### 9. Closing Declaration

GlossRP is the quiet backbone of semantic retrieval:

> It remembers so that other systems can think.  
> It retrieves so that others can evolve.  
> It stays simple so the whole can remain powerful.

