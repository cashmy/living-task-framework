# MINT Testing Framework Outline v1.0
### (High-Level Test Categories and Expectations for the Meaning INference Transformer)

## 0. Metadata
- **Subsystem:** MINT (Meaning INference Transformer)
- **Document:** MINT_Test_Framework_Outline_v1.0.md
- **Status:** Conceptual / Implementation-Guiding
- **Purpose:**  
  Provide a **high-level testing map** for MINT so that:
  - coding LLMs and engineers know what *kinds* of tests are expected,
  - canonical behavior (determinism, invariants, lifecycle) is verifiable,
  - system evolution can be validated without over-prescribing test implementations.

This document intentionally **does not** define individual test cases or specific frameworks.  
It defines **test categories and expectations**.

---

# 1. Test Philosophy

MINT must be:

- **Deterministic** in canonical modes.  
- **Invariant-bound** in all operations.  
- **Lifecycle-correct** for TierSlice states.  
- **Schema-consistent** with ECL-BASE.  
- **Interface-faithful** to GlossRP.  

The testing framework should:

- focus on behavior, not internal implementation tricks,  
- be **repeatable and automatable**,  
- be **version-aware** (tests evolve when MINT or invariants do),  
- be safe to hand off to coding LLMs as a specification.

---

# 2. Test Category A — Determinism & Stability

## A.1 Canonical Determinism Tests

**Goal:** Confirm that canonical transformations are repeatable.

**Scenarios:**

- Same inputs:
  - `term_id`, `term_version_id`
  - `mint_version`, `invariants_version`
  - `tier`, `density`
- Multiple runs of the shaping pipeline.

**Expected:**

- Outputs match within accepted tolerance (whitespace/formatting aside).
- No randomness emerges between runs.

---

## A.2 Regression Stability Tests

**Goal:** Ensure that upgrades do not unintentionally change behavior.

**Scenarios:**

- Store baseline canonical slices for a representative term set.
- After a code change with *no* declared behavior change:
  - rerun transforms,
  - compare slices.

**Expected:**

- No semantic drift.
- Any differences must be explainable and intentional.

---

# 3. Test Category B — Invariant Enforcement

## B.1 No New Meaning Tests

**Goal:** Validate that MINT does not introduce additional semantic content.

**Scenarios:**

- Use terms with well-known, tightly scoped definitions.
- Check slices for:
  - new properties,
  - invented relations,
  - ungrounded domain extensions.

**Expected:**

- All shaped content corresponds directly to GlossRP meaning and provided context.

---

## B.2 No Interpretation / Opinion Tests

**Goal:** Catch interpretive language and speculative phrases.

**Scenarios:**

- Feed controlled definitions.
- Inspect TierSlices for:
  - “I think…”, “it might be…”, “in my opinion…”, etc.
  - broad generalizations not present in GlossRP.

**Expected:**

- Violations are either:
  - prevented in canonical runs, or
  - flagged and rejected during validation.

---

## B.3 No Retrieval Tests

**Goal:** Ensure MINT does not pull in external knowledge.

**Scenarios:**

- Use synthetic terms referencing obscure or fictional concepts.
- Ensure slices contain only information from GlossRP and context.

**Expected:**

- No external facts, analogies, or domain additions appear.

---

## B.4 NLL Tier Integrity Tests

**Goal:** Confirm that each Tier’s content aligns with its NLL weighting profile.

**Scenarios:**

- Verify that:
  - T1 focuses on identity/orientation,
  - T2 focuses on mechanics/operations,
  - T3 focuses on systemic/relational views.

**Expected:**

- No Tier “steals” the primary focus of another.
- NLL emphasis is observable in structure/content.

---

## B.5 Density Integrity Tests

**Goal:** Ensure Light/Medium/Deep alter detail level, not meaning.

**Scenarios:**

- Same term/tier, different densities.
- Compare slices for:
  - consistent core meaning,
  - increasing detail, not reinterpretation.

**Expected:**

- Light ⟶ compressed version of deeper content.
- Deep ⟶ elaboration of the same meaning, not expansion into new domains.

---

# 4. Test Category C — Lifecycle & State Machine

## C.1 State Transition Tests

**Goal:** Validate that TierSlice states follow the lifecycle spec (v0.2).

**Scenarios:**

- Generate first slice (Absent → Canonical-Current).
- Trigger:
  - new Mint version,
  - new invariants version,
  - new TermVersion,
  - explicit regeneration,
  - invalidation.

**Expected:**

- Only allowed transitions occur:
  - Canonical-Current → Canonical-Stale/Archived/Invalidated.
  - Canonical-Stale → Archived/Invalidated.
- Disallowed transitions never occur:
  - Archived → Canonical-Current, etc.

---

## C.2 Freshness / Retrieval Tests

**Goal:** Ensure `get_current_slices` always returns valid Canonical-Current slices.

**Scenarios:**

- Stale slices present.
- Archived slices present.
- Invalidated slices present.

**Expected:**

- Only `Canonical-Current` slices are returned in canonical calls.
- If none exist, shaping pipeline is triggered (per lifecycle rules).

---

## C.3 Regeneration Scope Tests

**Goal:** Confirm regeneration respects scope definitions.

**Scenarios:**

- Regenerate:
  - per term (all tiers/densities),
  - per tier,
  - per tier+density.

**Expected:**

- Only slices in scope are replaced.
- Out-of-scope slices retain their prior state.

---

# 5. Test Category D — Module Wiring & Interaction

## D.1 Orchestrator Flow Tests

**Goal:** Ensure Transform Orchestrator calls the modules in the correct order.

**Scenarios:**

- Instrument internal calls in:
  - GlossRP Client,
  - NLL Engine,
  - Tier Shaper,
  - Density Engine,
  - Breath–Word Layer (if enabled).

**Expected:**

- Correct call chain: GlossRP → NLL → Shaper → Density → BW → validation → persistence.

---

## D.2 Invariant Guard Hook Tests

**Goal:** Confirm that Invariant Guard is invoked before and after shaping.

**Scenarios:**

- Intentionally malformed outputs or mock violations.
- Confirm:
  - violative outputs are rejected,
  - no invalid results pass to persistence.

**Expected:**

- Invariant Guard acts as an effective gatekeeper.

---

## D.3 MintTransformService Integration Tests

**Goal:** Validate canonical behavior as seen by external callers.

**Scenarios:**

- `transform_canonical` normal calls, missing slices, partial slices.
- `regenerate_for_term_version` in different scopes.

**Expected:**

- Service behaves per lifecycle and invariants,
- external callers never see illegal states.

---

# 6. Test Category E — GlossRP Interface Compliance

## E.1 Term Fetch Contract Tests

**Goal:** Ensure MINT uses GlossRP exactly as defined in the interface spec.

**Scenarios:**

- Normal fetches.
- Missing term.
- Missing version.
- Malformed canonical content.

**Expected:**

- Appropriate error handling (no fallback meaning).
- No unexpected retries or speculative reconstruction.

---

## E.2 SCS Block Legacy Handling Tests

**Goal:** Ensure legacy SCS data is treated as optional and non-authoritative.

**Scenarios:**

- Presence of SCS block.
- Malformed SCS block.

**Expected:**

- TierSlices remain grounded solely in canonical meaning.
- SCS issues do not corrupt shaping behavior.

---

# 7. Test Category F — Schema & Persistence

## F.1 Schema Conformance Tests

**Goal:** Confirm that slices in the database conform to MINT ECL-BASE Schema v0.2.

**Scenarios:**

- Verify:
  - required columns set,
  - valid enums,
  - correct foreign keys,
  - embedding shape (if used).

**Expected:**

- No incomplete or structurally invalid rows.

---

## F.2 Lifecycle State Storage Tests

**Goal:** Ensure state changes are accurately written.

**Scenarios:**

- Observe `mint_tier_slice.state` transitions on:
  - first generation,
  - regeneration,
  - invalidation,
  - archival.

**Expected:**

- DB state always matches lifecycle rules.

---

# 8. Test Category G — Non-Canonical Guardrails (Variation Mode)

Even though Variation Mode is **not implemented** for canonical MINT:

**Goal:** Ensure no accidental activation of experimental/variant behavior.

**Scenarios:**

- Attempt to:
  - pass “temperature” or “variant” flags through the API,
  - persist non-canonical outputs.

**Expected:**

- Canonical MINT rejects such attempts,
- no non-canonical state leaks into canonical storage.

---

# 9. Version-Aware Testing

Tests must be maintained with awareness of:

- `mint_version`,
- `invariants_version`,
- NLL profile versioning.

When behavior changes are intentional:

- Update baseline expectations,
- Capture migration steps,
- Add tests for new invariants or lifecycle rules.

---

# 10. Closing Guidance for Coding LLMs & Engineers

- Use this outline as a **testing map**, not a full script.
- When generating tests:
  - cover each category meaningfully,
  - ensure tests directly validate the invariants, lifecycle, and boundaries defined in other MINT docs.
- If a test requires violating an invariant to set up a scenario:
  - ensure that violation is synthetic and contained,
  - assert that the system **rejects** or **flags** it appropriately.

The test framework’s job is not to prove MINT is perfect,  
but to ensure that **MINT remains trustworthy** as it evolves with new versions, new terms, and new ecosystem integrations.
