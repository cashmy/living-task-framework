# MINT Internal Modules v1.0  
### (Implementation-Facing Module Specification)

## 0. Metadata
- **Subsystem:** MINT (Meaning INference Transformer)
- **Document:** MINT_Internal_Modules_v1.0.md  
- **Status:** Draft v1.0 — Implementation-facing  
- **Scope:** Defines the internal modules required to implement MINT in a way that honors:
  - MINT Architecture Manifesto v0.1  
  - MINT Invariants v0.2  
  - MINT Slice Lifecycle v0.1  
  - MINT ECL-BASE Schema v0.2  
  - NLL-weighted Tier Identity Model  
  - Breath→Word Integration Note  

This document is for implementation (coding LLMs / engineers).  
It describes *how* MINT should be structured internally to fulfill its conceptual and architectural contracts.

---

# 1. Module Layering Overview

MINT internal modules are grouped into three layers:

1. **Core Shaping Modules** — implement the actual semantic shaping:
   - NLL weighting
   - Tier shaping
   - Density shaping
   - Breath→Word mapping

2. **Operational Orchestration Modules** — control execution flow:
   - Orchestration
   - Lifecycle enforcement
   - Contract checking

3. **Integration & Persistence Modules** — manage:
   - DB reads/writes
   - external system communication (GlossRP, LTF, PW, EnaCs)
   - slice storage and retrieval

All modules must respect MINT’s:
- deterministic nature
- non-interpretive role
- non-generative (no new meaning creation) boundaries
- slice lifecycle rules
- invariants and architecture constraints

---

# 2. Core Shaping Modules

These modules are responsible for *how* MINT shapes meaning into TierSlices.  
They should be **pure**, stateless, and deterministic functions where possible.

---

## 2.1 NLL Weight Engine

**Purpose:**  
Apply the correct NLL gravity model to a given Tier (T1/T2/T3) so that each slice reflects the appropriate weighting of:

- Who  
- What  
- How  
- Where  
- When  
- Why  
- Whom Else  

**Responsibilities:**

- Encode the Tier-specific NLL weighting model (from the NLL–Tier Identity document).
- Expose functions for:
  - `get_nll_profile_for_tier(tier: T1|T2|T3) -> NLLWeights`
- Provide defaults and sanity checks (weights sum normalization if applicable).
- Be deterministic and version-aware (changes to NLL logic must be versioned).

**Notes:**

- This module does not generate text.  
- It only produces structured weight profiles used by TierShaper and downstream logic.

---

## 2.2 Tier Shaper

**Purpose:**  
Generate Tier-specific structured content (T1/T2/T3) using:

- the canonical meaning from GlossRP,
- the NLL profile from NLL Weight Engine,
- and the MINT invariants.

**Responsibilities:**

- For a given `(term_id, term_version_id, tier, density)`:
  - produce the TierSlice content (e.g. markdown/JSON body),
  - ensure that the content aligns with:
    - the Tier’s role (T1 identity, T2 mechanics, T3 systemic purpose),
    - the NLL weighting profile,
    - the invariants (no interpretation, no new meaning).
- Expose a core method, e.g.:
  - `shape_tier_slice(term_data, tier, density, nll_profile) -> TierSliceContent`

**Notes:**

- This is where LLM-backed logic is most likely to be used.
- Must be configured to behave deterministically (e.g. temperature≈0).
- Must not mutate term meaning; only structure and emphasis.

---

## 2.3 Density / DOD Engine

**Purpose:**  
Control the **level of detail** for each TierSlice without changing its *meaning*.

**Responsibilities:**

- Implement Light / Medium / Deep density profiles.
- Ensure that:
  - Light = outline/essential points only
  - Medium = normal operating view
  - Deep = expanded detail (within invariant boundaries)
- Expose a function such as:
  - `apply_density(tier_slice_content, density) -> tier_slice_content`

**Notes:**

- Density must never add new meaning, only expand or compress expression.
- For canonical slices, density profiles must be reproducible.

---

## 2.4 Breath→Word Projection Layer

**Purpose:**  
Map ECL SKY/CORE/BASE essence and intent into concrete UCS Word-level structure.

**Responsibilities:**

- Integrate:
  - MINT’s Breath–Word Integration Note
  - ECL-related contextual metadata (when provided)
- Provide hooks to:
  - receive “essence-level” descriptors (if present),
  - ensure TierShaper honors that essence while structuring content.

**Notes:**

- This layer is more of a *conceptual alignment module* than a heavy logic module.
- It should not add new content; it shapes emphasis and framing in line with the term’s purpose.

---

# 3. Operational Orchestration Modules

These modules govern **how** the core shaping modules are invoked and in what order, and ensure lifecycle and invariants are correctly applied.

---

## 3.1 Transform Orchestrator

**Purpose:**  
Coordinate all internal MINT modules to perform a complete canonical transformation for a given term version.

**Responsibilities:**

- Accept structured requests from the MintTransformService with:
  - `term_id`
  - `term_version_id`
  - requested Tiers
  - density
  - Mint version
  - invariants snapshot
- For each requested Tier:
  - query necessary term data (via integration module),
  - get the correct NLL profile,
  - call TierShaper,
  - apply Density Engine,
  - assemble TierSlice structures.
- Report back TierSlice results to the caller (service layer).

**Notes:**

- Orchestrator does **not** talk to the DB directly.
- It is a pure coordination layer above core shaping modules.

---

## 3.2 Invariant Guard

**Purpose:**  
Enforce MINT invariants at runtime.

**Responsibilities:**

- Pre-checks:
  - verify that requested operations comply with invariants:
    - no interpretation
    - no retrieval
    - no evolution
- Post-checks:
  - verify shaped output is structurally valid (no missing fields, no disallowed patterns).
- Provide standardized error states when invariants would be violated.

**Notes:**

- Can be implemented as:
  - decorators,
  - wrapper functions,
  - or middleware around the Orchestrator calls.

---

## 3.3 MintTransformService (Operational Integration Module)

**Purpose:**  
Provide the **single, authoritative interface** for external callers (EnaCs, PW, jobs, APIs) to use Mint.

**Responsibilities:**

- Implement the canonical lifecycle-driven operations:
  - **`transform_canonical(term_id, term_version_id, tiers, density)`**
    - Check if canonical-current slices exist.
    - If yes, return them.
    - If not, create a `MintTransformPacket`, invoke the Orchestrator, store new slices, then return.
  - **`regenerate_for_term_version(term_id, term_version_id, tiers, density)`**
    - Mark existing slices stale/archived.
    - Generate and store new slices as canonical-current.
- Enforce:
  - MINT Slice Lifecycle rules.
  - Deterministic behavior for canonical transformations.
- Hide DB details and internal shaping modules from external callers.

**Notes:**

- This module is **implementation-level**, not conceptual.
- All canonical use of Mint must go through this service.
- No direct DB access or direct TierShaper calls from outside.

---

# 4. Integration & Persistence Modules

These modules manage interaction with external systems and MINT’s own database.

---

## 4.1 GlossRP Client

**Purpose:**  
Provide a clean, typed interface for Mint to retrieve canonical meaning from GlossRP.

**Responsibilities:**

- Given `term_id` and `term_version_id`, fetch:
  - canonical TermVersion content (markdown / structured),
  - any necessary metadata (e.g. categories, origin),
  - optional SCSBlocks data (for historical comparison only).
- Handle:
  - API calls or DB queries (depending on deployment),
  - error handling,
  - timeouts, etc.

**Notes:**

- Must respect ECL/MxVA boundaries:
  - MINT never mutates GlossRP data.
- Treat SCSBlocks as **legacy, read-only** historical artifacts only.

---

## 4.2 MintPersistenceAdapter

**Purpose:**  
Handle all interaction with the MINT ECL-BASE schema (PostgreSQL + pgvector).

**Responsibilities:**

- CRUD operations for:
  - `mint_invariant_snapshot`
  - `mint_transform_packet`
  - `mint_tier_slice`
- Utility methods such as:
  - `get_current_slices(term_id, term_version_id, tiers, density)`
  - `mark_slices_stale_or_archived(term_id, term_version_id, tiers, density)`
  - `save_new_slices(packet, slices)`
- Respect Slice Lifecycle states:
  - `canonical_current`
  - `canonical_stale`
  - `archived`
  - `invalidated`

**Notes:**

- No lifecycle decisions should be made here — that belongs to MintTransformService and lifecycle logic.
- This module should be a thin data access layer with clear query/update methods.

---

## 4.3 LTF Adapter (Future-Facing)

**Purpose:**  
Provide LTF with stable, current canonical TierSlices and associated metadata.

**Responsibilities:**

- Surface:
  - for a given `term_version_id`:
    - T1/T2/T3 slices,
    - NLL weights,
    - embeddings (when used),
    - lifecycle/version metadata.
- Support batch exports for LTF ingestion.

**Notes:**

- LTF’s worldview is outside this document.
- This module only ensures that Mint’s outputs are available in a clear, structured way.

---

## 4.4 Logging & Audit Module

**Purpose:**  
Track critical operations for observability and debugging.

**Responsibilities:**

- Log:
  - transformation requests (term_id, term_version_id, tiers, density),
  - slice generation events,
  - regeneration events,
  - invariant violations or errors.
- Provide trace IDs or correlation IDs for cross-system debugging.

**Notes:**

- Must avoid logging sensitive content if any privacy constraints exist.
- Useful for analyzing behavior and drift detection.

---

# 5. Module Interaction Summary

High-level call sequence for `transform_canonical`:

1. **Caller** → `MintTransformService.transform_canonical(...)`
2. **MintTransformService**:
   - Calls `MintPersistenceAdapter.get_current_slices(...)`
   - If slices exist and are canonical-current → returns them.
   - If not:
     - Creates `MintTransformPacket`
     - Calls **Transform Orchestrator**:
       - Uses **GlossRP Client** to fetch term data.
       - Uses **NLL Weight Engine** to get NLL profile.
       - Uses **Tier Shaper** to build Tier content.
       - Uses **Density/DOD Engine** to adjust detail level.
       - Uses **Breath→Word Layer** to ensure purpose alignment.
     - Returns TierSlices to MintTransformService.
   - MintTransformService:
     - Calls **MintPersistenceAdapter.save_new_slices(...)**
     - Returns canonical-current slices to the caller.

All invariant checks and lifecycle rules must be enforced along this path.

---

# 6. Notes for Coding LLMs / Implementers

1. **Do NOT bypass MintTransformService**  
   - All external systems must go through this service.

2. **Do NOT write application code that manipulates Mint DB tables directly**  
   - Use MintPersistenceAdapter methods instead.

3. **Do NOT introduce randomness in Tier shaping for canonical paths**  
   - Configure model calls for deterministic behavior.

4. **DO keep modules small and testable**  
   - NLL Weight Engine, Tier Shaper, Density Engine should be unit-testable.

5. **DO version behavior changes**  
   - When modifying NLL logic or Tier shaping behavior, bump Mint version and/or invariants version.

---

# 7. Future Extensions (Non-Canonical)

The following are **possible future modules**, but are NOT to be implemented in canonical MINT v1.0:

- **MintVariantExplorer** — experimental shaping with variant phrasing / non-deterministic modes.
- **MintUIHelper** — formatting assistance for direct human-facing tools.

Any such modules must:

- be explicitly labeled non-canonical,
- never write to canonical TierSlice storage,
- never be used by LTF or EnaCs for system reasoning.

---

# 8. Closing Statement

This Internal Modules specification defines the minimal, necessary structure to implement MINT in a way that:

- respects its architecture and invariants,
- enforces its lifecycle,
- integrates cleanly with GlossRP and LTF,
- provides a safe interface for EnaCs, PW, and other systems,
- and remains deterministic, stable, and testable.

Implementation details (frameworks, patterns, etc.) may vary,  
but these modules and responsibilities must remain recognizable and intact.

