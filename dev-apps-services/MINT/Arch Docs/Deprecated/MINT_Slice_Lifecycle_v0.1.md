# MINT Slice Lifecycle v0.1  
### (Canonical Lifecycle Specification + Reserved Variation Concept)

## 0. Metadata
- **Name:** MINT (Meaning INference Transformer)
- **Document:** MINT_Slice_Lifecycle_v0.1.md  
- **Status:** Draft — Operational Lifecycle Definition  
- **Purpose:** Define *precisely* when, why, and how Mint TierSlices are created, regenerated, stored, invalidated, and consumed.  
- **Includes:** Reserved conceptual definition of “variation mode,” NOT executable, NOT active.

---

# 1. Guiding Principles

### 1.1 Deterministic Canonical Output  
Mint **must** produce deterministic, invariant-bound results for canonical TierSlices:  
> Same term version + same Mint version + same invariants + same density → **same slice**.

### 1.2 Slice Lifecycle is Version-Driven, Not Request-Driven  
Slices are *not* created on every request.  
They are generated only when specific lifecycle events occur.

### 1.3 Canonical vs Non-Canonical Output  
Only the **canonical transformation path** may generate stored TierSlices.  
Exploratory/variant generation is reserved conceptually, but **non-executable**.

### 1.4 GlossRP Is the Sole Source of Meaning  
Mint shapes meaning but does not store or own canonical meaning.  
It relies on:
- `term_id`
- `term_version_id`
- invariant/reference metadata  
Obtained from GlossRP or GlossRP API.

---

# 2. Lifecycle States

A Term’s Mint TierSlices can be in one of the following states:

- **Absent** — no slices produced yet  
- **Canonical-Current** — up-to-date, matches current Mint version + invariants  
- **Canonical-Stale** — slices were produced under older Mint or GlossRP versions  
- **Invalidated** — intentionally cleared due to semantic or architectural change  
- **Archived** — older generation retained for lineage analysis  
- **Variant (Reserved)** — conceptual placeholder, not active or stored

---

# 3. Lifecycle Events (Triggers)

## 3.1 Creation Events (Canonical Slice Generation)

Mint creates canonical slices under **exactly three conditions**:

### **Event A: New TermVersion**  
Triggered when GlossRP emits a new `term_version_id` for a term.  
This represents actual semantic change.  
Mint must:
- generate fresh T1/T2/T3 slices  
- mark all prior slices for this term as “Canonical-Stale”

### **Event B: New Mint Version (or Invariant Version)**  
Mint slicing logic evolves.  
This constitutes a new shaping regime.

Must:
- generate slices under new version  
- archive or invalidate older slices  
- ensure version metadata is recorded in `mint_transform_packet`

### **Event C: Explicit Regeneration Request**  
Triggered by:
- EnaC  
- SAAS  
- system administrator  
- automated nightly integrity check (optional future)

This is a controlled, intentional lifecycle step.

---

## 3.2 Non-Creation Events (Requests That DO NOT Generate New Slices)

### **Requesting a slice does NOT generate a slice**  
Mint returns the stored canonical slice unless:
- it doesn’t exist, or
- it is stale due to the rules above.

### **EnaC requesting multiple densities or tiers**  
Mint returns canonical slices for each requested dimension.

### **LTF requesting slices**  
Mint returns canonical slices only.

---

# 4. Canonical Slice Regeneration Rules

### 4.1 Regeneration = Full Rewrite  
Regeneration replaces the entire set of TierSlices for a specific:
- `term_version_id`  
- `mint_version`  
- `invariants_version`  
- `density` profile (if differently stored)

### 4.2 Stale → Archive → Replace  
The recommended handling pipeline is:

1. Mark old slices as **Canonical-Stale**  
2. Copy to archival table or partition  
3. Generate new slices  
4. Store as Canonical-Current  
5. Update MintTransformPacket references

This preserves lineage integrity for LTF.

---

# 5. Slice Storage Rules

### 5.1 Canonical Slices Must Be Stored  
Each canonical slice must include:
- Tier (T1/T2/T3)  
- Density  
- NLL-weight vector  
- Mint version  
- Invariant version  
- GlossRP term_version_id  
- Content (md or json)  
- Embedding (optional, Mint-specific)

### 5.2 Canonical Slices Must Be Query-Optimized  
Use indexes on:
- `semantic_term_id`
- `term_version_id`
- `tier`
- `density`
- `mint_version`

---

# 6. Retrieval Rules

### 6.1 Direct Retrieval  
Mint responds to a request for a canonical slice with:
- canonical slice if current  
- regenerated slice if stale  
- fresh slice if absent

### 6.2 Bundle Retrieval  
For multi-tier requests:
- return [T1, T2, T3] as they exist  
- if one is missing, generate missing tier *only* (not full regeneration)

### 6.3 Freshness Guarantee  
Mint guarantees that returned slices are:
- canonical  
- current  
- deterministic  
- aligned with invariants

---

# 7. Deprecation & Invalidation

Slices are invalidated under:
- new GlossRP term version  
- new Mint version  
- new invariants version  
- structural upgrade (schema / logic)  
- explicit SAAS/EnaC request  

Invalidation rule:
> If Mint cannot guarantee deterministic correctness, slices are invalid.

---

# 8. Reserved Section — Variation Mode (Concept Only)

### 8.1 This section is NON-EXECUTABLE.  
Variation mode is **defined**, but:
- not implemented  
- not exposed  
- not used in canonical workflows  
- not persisted  
- not referenced from other subsystems

### 8.2 Purpose of Recording the Concept
We record this concept here to:
- preserve future design options  
- avoid buried assumptions  
- maintain clarity on canonical vs exploratory shaping  
- prevent accidental “creative drift” in core Mint

### 8.3 Definition of Variation Mode (Conceptual Only)

Variation Mode represents:
- an **exploratory shaping path**
- potentially allowing:
  - temperature adjustments  
  - alternative phrasing  
  - creative expansions  
  - variant TierSlices  

But **outputs are:**
- NOT canonical  
- NOT stored  
- NOT used for LTF  
- NOT used for EnaC system reasoning  
- NOT considered part of Mint-Core

### 8.4 Variation Mode Must Remain Segregated  
Any future implementation must:
- live behind a separate API  
- be explicitly labeled “non-canonical”  
- produce outputs with safeguard boundaries  
- ensure zero interference with Mint-Core determinism

---

# 9. Notes + Future Attachments

### 9.1 Related Documents
- Mint Architecture Manifesto  
- Mint Invariants v0.2  
- Mint NLL–Tier Identity Model  
- Breath–Word Integration Note  
- LTF Integration Note  

### 9.2 Next Possible Document
- `MINT_Slice_Lifecycle_Implementation_Guide_v0.2.md`  
  - API design  
  - regeneration endpoints  
  - EnaC consumption patterns  

---

# 10. Closing Statement

The Mint Slice Lifecycle ensures:
- deterministic semantic shaping  
- version-driven evolution  
- clean separation from creative/stochastic behavior  
- structured regeneration patterns  
- stability for EnaC and LTF  
- future space for exploratory shaping without corrupting canonical flows

Variation Mode is acknowledged, defined, and **intentionally dormant**, preserving flexibility without risking core stability.

