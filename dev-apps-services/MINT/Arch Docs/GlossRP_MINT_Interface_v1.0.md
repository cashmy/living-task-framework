# GlossRP ↔ MINT Interface Specification v1.0
### (Canonical Meaning Exchange Contract Between GlossRP and the Meaning INference Transformer)

## 0. Metadata
- **Subsystems:** GlossRP (Semantic Canon), MINT (Meaning INference Transformer)
- **Document:** GlossRP_MINT_Interface_v1.0.md
- **Status:** Authoritative Contract
- **Purpose:**  
  Establish the **precise, minimal, stable, and future-proof boundary** between GlossRP and MINT.  
  This interface ensures:
  - GlossRP maintains sole ownership of canonical meaning.
  - MINT performs deterministic shaping *only from the authoritative source*.
  - Neither subsystem leaks responsibility into the other.
  - Canonical meaning and canonical structure remain cleanly separated.

This contract defines:
- What GlossRP MUST provide  
- What MINT MAY request  
- What MINT MUST NOT assume  
- What MINT MUST NOT mutate  
- What happens on version changes  
- Error modes and handling rules  

This is a **semantic API contract**, not a network API spec.

---

# 1. Subsystem Roles (Non-Negotiable)

## 1.1 GlossRP Role
GlossRP is the **source of truth** for:
- canonical meaning,
- semantic versions,
- category attribution,
- initial term metadata.

GlossRP:
- writes meaning,
- evolves meaning,
- owns term lineage.

GlossRP does **not**:
- shape meaning,
- generate Tiers,
- apply NLL weighting,
- perform density transformations,
- handle ECL/BW semantic projection.

---

## 1.2 MINT Role
MINT:
- receives canonical meaning,
- applies deterministic, invariant-bound shaping,
- generates TierSlices,
- stores only structured canonical surface representations.

MINT does **not**:
- alter meaning,
- evolve meaning,
- interpret meaning,
- extend meaning,
- re-categorize terms,
- query outside GlossRP.

---

# 2. GlossRP → MINT Data Contract

MINT may request a **Term Version Package** from GlossRP, which must include:

## 2.1 Required Fields

### 2.1.1 Term Identifiers
- `term_id` (UUID or canonical unique ID)
- `term_version_id` (monotonically increasing per term)

### 2.1.2 Canonical Term Content
- `canonical_markdown`  
  or  
- `canonical_structured` (JSON)

### 2.1.3 Metadata
- `categories` (list)
- `term_origin` (optional)
- `created_at` (timestamp)
- `version_notes` (optional)

### 2.1.4 Optional Legacy Block
- `SCS_block`  
  - A legacy-only, read-only semantic context file.  
  - Used only for historical lineage comparison.  
  - Never used as primary meaning.

---

## 2.2 Field Integrity Requirements
GlossRP MUST guarantee:

- All fields present are semantically correct.
- All canonical fields are final and authoritative.
- `term_version_id` increments reflect *semantic change*.
- Meaning is fully resolved and contains no placeholders, stubs, or TODOs.

If data is malformed:
- MINT must fail fast.
- GlossRP must be corrected manually or via its own lifecycle logic.

---

# 3. Allowed MINT Requests (Read-Only)

MINT is allowed to execute the following logical requests:

### 3.1 `fetch_term(term_id, term_version_id)`
Returns a Term Version Package (as defined in §2).

### 3.2 `fetch_latest_version(term_id)`
Returns the most recent `term_version_id`.

### 3.3 `list_categories(term_id)`
Returns categories associated with the term.

### 3.4 `fetch_scs_block(term_id, term_version_id)`
(Only if stored; read-only legacy.)

---

# 4. Prohibited MINT Requests (Hard Boundary)

MINT MUST NOT:

1. Write or mutate GlossRP meaning  
   - no updates  
   - no version creation  
   - no deletion  
   - no recategorization

2. Request external meaning or inference  
   - no similarity search  
   - no corpus exploration  
   - no fact retrieval

3. Request cross-term analysis from GlossRP  
   - no “find related terms”  
   - no semantic clustering  
   - no concept graphs

4. Attempt to correct or rebind malformed meaning  
   - no inference to patch missing data  
   - no fallback reconstruction

MINT is **meaning-blind** outside what GlossRP provides explicitly.

---

# 5. Versioning Rules Across the Interface

## 5.1 GlossRP Version Changes
When GlossRP emits a new `term_version_id`:

- Mint MUST treat all prior slices for that term as **Canonical-Stale** or **Archived**.
- MINT MUST re-transform meaning under the current:
  - mint_version,
  - invariants_version,
  - NLL profiles.

No silent carryover is allowed.

---

## 5.2 MINT Version Changes
When MINT changes version (shaping logic or invariants):

- MINT MUST regenerate TierSlices for all terms *as requested*.
- MINT MUST NOT ask GlossRP for meaning beyond the current canonical version.

No change in MINT’s version may force a meaning change in GlossRP.

---

# 6. Canonical Contract: Truth Direction

Meaning flows in exactly one direction:

```
GlossRP  →  MINT
(meaning)   (shaping)
```

Reverse flow is forbidden:

```
MINT  ✗→  GlossRP
(no mutation, inference, or interpretation)
```

---

# 7. Error Modes and Handling

## 7.1 Missing Term or Version
GlossRP MUST return a structured error:
- `TERM_NOT_FOUND`
- `VERSION_NOT_FOUND`

MINT MUST:
- propagate error upward,
- NOT attempt fallback meaning creation.

---

## 7.2 Malformed Meaning
If markdown or structured content is invalid:

MINT MUST:
- fail fast,
- refuse to shape,
- return `INVALID_CANONICAL_CONTENT`,
- request human intervention.

---

## 7.3 SCS Block Legacy Read
If SCS blocks exist but don’t match MINT’s structural expectations:
- treat as non-fatal,
- log warning,
- continue using canonical meaning only.

---

# 8. What the Interface Guarantees (Mutual)

## 8.1 GlossRP Guarantees
- Meaning fidelity  
- Canonical stability  
- Version accuracy  
- Clean semantic lineage  
- No unannounced breaking changes  

## 8.2 MINT Guarantees
- Deterministic shaping  
- No interpretation  
- No retrieval  
- No mutation  
- No cross-term inference  
- Stable structured representation  

---

# 9. Integration Geometry (Conceptual Diagram)

```
 ┌──────────────────┐
 │     GlossRP      │
 │  (Meaning Core)  │
 └───────┬──────────┘
         │ Canonical Term Version Package
         ▼
 ┌──────────────────┐
 │       MINT       │
 │ (Deterministic   │
 │   Semantic        │
 │   Shaper)         │
 └──────────────────┘
         │ TierSlices
         ▼
   LTF / PW / EnaC
   (Consumers Only)
```

Meaning never flows upward from MINT into GlossRP.

---

# 10. Closing Statement

This interface specification ensures that:

- GlossRP remains the **unquestioned owner** of meaning.  
- MINT remains the **deterministic shaper**, not a semantic co-author.  
- Versioning, lifecycle, and error modes are cleanly defined.  
- Future systems (LTF, PW, EnaCs) can rely on a stable canonical substrate.

This is the **minimal and correct** contract for long-term system evolution under ECL and MxVA principles.
