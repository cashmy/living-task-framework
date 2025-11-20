
# STMG ↔ AOP Integration Stub v0.1

## 1. Purpose
Define the integration contract between **STMG (Semantic Trigger Markdown Generator)** and **AOP (Artifact Output Policy)** so that:
- STMG retains its semantic/structural responsibilities.
- AOP governs *how* artifacts are emitted in each environment.
- Drift is eliminated when STMG is referenced but not fully ingested.

---

## 2. Integration Principles

### 2.1 Separation of Concerns
- **STMG** determines *what* content is captured and *how* it is structured.
- **AOP** determines *how* that structured content is delivered:
  - File-only (browser default)
  - Inline micro-output
  - IDE patch/diff/file-write
  - API payload

### 2.2 Mandatory Delegation
Any module or LLM using STMG **must**:
- Generate the semantic Markdown via STMG.
- Pass the resulting artifact to **AOP** for environment-appropriate delivery.

STMG MUST NOT:
- Decide file format,
- Decide inline vs file output,
- Decide delivery mode.

These belong to AOP.

---

## 3. Integration Flow

### Step 1 — Trigger
User invokes STMG via:
- “capture this”
- “export”
- “generate .md”
- Or any module-level STMG hook.

### Step 2 — STMG Output Generation
STMG produces:
- Clean, deterministic Markdown
- Structure only (no formatting decisions)
- No inline rendering

### Step 3 — AOP Policy Application
AOP checks:
- Current ECL-BASE environment
- Session-level preferences
- Artifact-level overrides

Then selects delivery mode:
- `.md` file (browser default)
- `.docx`, `.pdf`, `.yaml` (if requested)
- IDE diff/patch
- Raw API payload

### Step 4 — Delivery
AOP emits the artifact using the environment’s safest and most memory-efficient method.

---

## 4. Invariants

### STMG Invariants
- Must never bypass AOP.
- Must not render inline without AOP authorization.
- Must provide deterministic Markdown that AOP can reliably package.

### AOP Invariants
- Must not alter the meaning or structure STMG created.
- Must guarantee predictable output behavior.
- Must prevent browser memory overload by default.

---

## 5. Required Module Settings

### STMG Requirements
- Module Manifest v0.1 or higher
- Active Tier Envelope (T1–T3)
- Environment-neutral behavior

### AOP Requirements
- Environment-aware policy
- Default `.md` for GPT-5.1 browser
- Optional overrides by user

---

## 6. Hook Points

### STMG Hooks
- Before Markdown finalization
- At the end of capture request
- During context transition (T2/T3)

### AOP Hooks
- Pre-delivery decision
- Session preference updates
- Environment change detection

---

## 7. Known Drift Points & Mitigations

### Drift Point: STMG referenced but not ingested
**Mitigation:** AOP must detect STMG absence and warn/fallback.

### Drift Point: Browser inline rendering of large artifacts
**Mitigation:** AOP default: File-only mode.

### Drift Point: IDE/code-LMM mixing inline + file modes
**Mitigation:** Environment presets override ambiguous behavior.

---

## 8. Evolution Notes
This stub exists to ensure:
- STMG remains semantic-only.
- AOP governs delivery-only.
- Future modules (CSAC, MO-Kernel, MxVA-Architectural Generators) can plug into the same interface.

Future versions may introduce:
- Plugin-based output selection
- User profile–based default output modes
- Automatic environment detection and switching

---

## End of Stub v0.1
