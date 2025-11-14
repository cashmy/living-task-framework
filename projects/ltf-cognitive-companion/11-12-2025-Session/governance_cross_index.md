# CFP Governance Cross-Document Index

This index maps how the governance layer and NISCL-related documents align with the
CFP Feature Matrix and future Tier-specific CORE documents.

---

## Documents

- `CFP_Feature_Matrix.md`
- `governance.md`
- `NISCL_Addendum.md`
- `NISCL_clause.md`
- `CFP_Master_Governance_Document.docx`
- `pivotal_moment_capture.md`

---

## Alignment Map

### 1. CFP_Feature_Matrix.md
- **Governance Link:** Integrates with `governance.md` and `NISCL_Addendum.md`.
- **Insertion Points:**
  - Framework Behaviors → reference governance mesh and NISCL.
  - Narrative or reflective features → mark with (N) to indicate NISCL applicability.
- **Tier Dependencies:** Ties directly into Tier 1–3 behavior, but defers governance specifics to `governance.md`.

### 2. governance.md
- **Role:** Canonical governance kernel.
- **Interfaces:**
  - Defines human primacy, NISCL rules, override modes, and meta-protocols.
  - Provides `Integration Scaffolding` section specifying exact insertion points for Tier docs.
- **Dependency:** Assumes CFP_Feature_Matrix exists but does not modify it directly.

### 3. NISCL_Addendum.md
- **Role:** Detailed specification of the NISCL layer.
- **Interfaces:**
  - Extends governance.md with specifics on cross-tier influence, override semantics, and narrative safety.
- **Association:** Linked to any feature tagged (N) in the Feature Matrix.

### 4. NISCL_clause.md
- **Role:** Minimal clause for embedding in user profile/state or smaller docs.
- **Use:** Acts as a short-form governance snippet for environments that cannot ingest full governance files.

### 5. CFP_Master_Governance_Document.docx
- **Role:** Human-readable, editable governance source-of-truth.
- **Use Cases:** Compliance, audits, manual annotation, legal/organizational review.

### 6. pivotal_moment_capture.md
- **Role:** Historical/contextual record of the emergence of NISCL and its rationale.
- **Use Cases:** Meta-analysis, case study references, long-term documentation of design intent.

---

## Future Tier CORE Documents (T1, T2, T3)

For each Tier CORE document:

- **Reference:** `governance.md` and `NISCL_Addendum.md`.
- **Guarantee:** No tier-level rule should contradict governance.
- **Integration:** Use the `Integration Scaffolding` section in `governance.md` to locate merge points.

---

End of Cross-Document Index.
