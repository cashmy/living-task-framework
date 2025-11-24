# MINT Boundary Specification v1.0
### (Authority, Limits, and Non‑Responsibilities of the Meaning INference Transformer)

## 0. Metadata
- **Subsystem:** MINT (Meaning INference Transformer)
- **Document:** MINT_Boundary_Spec_v1.0.md
- **Status:** Authoritative Boundary Definition
- **Purpose:** Establish clear operational, semantic, and architectural boundaries for MINT so that:
  - responsibilities are unambiguous,
  - no drift occurs into roles belonging to GlossRP, LTF, PW, or EnaC agents,
  - coding LLMs implement MINT safely within its intended domain,
  - future expansion never breaks canonical determinism.

This document defines **what MINT must never do**, **what MINT is not**, and **where MINT stops**.

---

# 1. MINT’s Core Identity Boundary
MINT **is a deterministic semantic shaper** that transforms canonical GlossRP meaning into Tier‑specific, NLL‑weighted, density‑aligned structured representations (“TierSlices”).

MINT _is not_:
- a generative AI subsystem,
- an interpreter of intent,
- a meaning creator,
- a reasoning agent,
- an evolutionary engine,
- a cross-domain inference engine.

MINT’s role is **expression and structuring**, not **interpretation or evolution**.

---

# 2. Boundaries Relative to GlossRP

## 2.1 GlossRP Owns All Canonical Meaning  
GlossRP is:
- the **source of truth** for term definitions,
- the canonical store of semantic meaning.

MINT:
- MUST NOT alter GlossRP meaning,
- MUST NOT store the meaning itself,
- MUST NOT assume missing meaning,
- MUST NOT fetch external meaning.

MINT may only:
- _shape_ meaning,
- _restructure_ meaning,
- _emphasize_ meaning via NLL weighting.

---

## 2.2 GlossRP API Boundary  
MINT may request from GlossRP:
- term metadata,
- the canonical term version content,
- category metadata,
- optional SCS block (legacy).

MINT may NOT:
- write or mutate GlossRP data,
- make interpretive assumptions when GlossRP content is incomplete,
- attempt to “repair” malformed GlossRP content (must fail fast).

---

# 3. Boundaries Relative to EnaC Agents

## 3.1 EnaCs Provide Context; MINT Does Not Infer  
EnaCs may supply:
- contextual ECL metadata,
- SKY/CORE/BASE anchors,
- operational needs (tiers, densities).

MINT DOES NOT:
- infer intent,
- infer context not provided,
- extend purpose beyond what is explicitly defined,
- substitute its own reasoning for EnaC guidance.

---

## 3.2 EnaCs Use MINT; MINT Does Not Use EnaCs  
MINT does NOT:
- call EnaC agents,
- modify EnaC internal states,
- invoke multi-agent sequences,
- initiate SAAS flows.

EnaCs are **consumers**, not **providers**, of MINT output.

---

# 4. Boundaries Relative to PW (Phoenix Workbench)

PW may:
- use MINT TierSlices for design-level views,
- feed MINT context metadata (optional).

MINT may NOT:
- depend on PW for operation,
- embed PW-specific logic,
- assume PW presence in any canonical pipeline.

PW is an optional consumer, not a dependency.

---

# 5. Boundaries Relative to LTF (Learning Transfer Framework)

This boundary is **strict** because LTF is still evolving.

## 5.1 MINT MUST NOT Define LTF Requirements  
MINT cannot:
- define what LTF “needs,”
- shape meaning for LTF-specific formats,
- embed LTF-protocol logic,
- anticipate future LTF behaviors,
- produce LTF-specific metadata.

## 5.2 LTF Consumes MINT; MINT Is Agnostic to LTF  
MINT TierSlices:
- MUST remain LTF-agnostic,
- MUST NOT embed assumptions about LTF evolution.

Only **canonical TierSlices**, defined via MINT’s own schema and invariants, are provided.

No special “LTF slice mode” is to be implemented.

---

# 6. Technical Boundaries

## 6.1 Determinism Boundary  
MINT must run at **temperature ≈ 0** for canonical paths.

Disallowed:
- sampling,
- speculative expansion,
- randomization,
- creativity.

Allowed only in reserved **Variation Mode**, which:
- is non-canonical,
- is not persisted,
- must never be used downstream.

---

## 6.2 Persistence Boundary  
MINT may only store:
- invariant snapshots,
- transform packets,
- TierSlices,
- lifecycle metadata.

MINT must NOT store:
- term meaning,
- embeddings of GlossRP data (unless explicitly approved for efficiency),
- speculative variants,
- historical reasoning traces.

---

# 7. Semantic Boundaries

## 7.1 No New Meaning  
MINT MUST NOT generate semantic additions.

Examples of prohibited behavior:
- adding new properties to a term,
- introducing analogies not present in the term,
- inferring purpose beyond GlossRP/ECL context,
- adding related concepts.

MINT shapes meaning; it does not create it.

---

## 7.2 No Interpretation  
Prohibited:
- “this term probably means…”,
- “it might be useful for…”,
- “in general, people use this for…”.

Permitted:
- structural reshaping,
- emphasis according to NLL weights,
- ECL-aligned framing if explicitly supplied.

---

## 7.3 No Retrieval  
MINT must NOT:
- search external knowledge bases,
- use vector search,
- browse documents,
- call LLM reasoning about outside information.

Only **GlossRP canonical content** plus declared context.

---

# 8. Operational Boundaries

## 8.1 MINT Only Runs When Called  
MINT cannot:
- trigger itself,
- self-regenerate,
- self-initiate lifecycle changes.

Lifecycle events require:
- MintTransformService,
- EnaC orchestration,
- admin/system operations.

---

## 8.2 MINT Does Not Decide Freshness  
Freshness is determined by:
- lifecycle rules (Mint version, invariants version),
- new term versions from GlossRP,
- explicit regeneration requests.

MINT cannot “guess” if something is stale.

---

## 8.3 Error Boundary  
If meaning cannot be shaped safely:
- MINT must **fail**,
- NOT “fill in the blanks,”
- NOT create fallback meaning,
- NOT attempt speculative reconstruction.

---

# 9. Architectural Boundaries

## 9.1 Separation of Canonical & Non-Canonical  
MINT-core = canonical shaping only  
Variation Mode = exploratory (never stored, not used by LTF/EnaCs)

This separation is:
- mandatory,
- absolute,
- future-proof.

---

## 9.2 MINT Must NOT Become LTF-lite  
MINT is:
- a shaper,
- a deterministic transformer,
- a surface generator.

It is NOT:
- an inference engine,
- a cross-domain learner,
- a meaning expander,
- a semantic evolution framework.

Those belong to **LTF**, not MINT.

---

# 10. Closing Boundary Rule

## **If any action risks violating determinism, integrity, or meaning‑fidelity—  
MINT must refuse the action.**

MINT’s authority begins and ends with:
- structuring,
- shaping,
- formalizing canonical meaning,
- through deterministic, invariant‑bound logic.

Anything beyond that is OUT OF SCOPE and must be delegated to:
- GlossRP (meaning),  
- EnaCs (context + reasoning),  
- PW (design processes),  
- LTF (evolution + transfer),  
- or future subsystems not yet defined.

