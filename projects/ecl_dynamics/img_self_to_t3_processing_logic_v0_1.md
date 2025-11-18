# IMG-Self → T3-Self Processing Logic (v0.1)
## Structural Pipeline for Meaning-Weighted Signal Integration

---

## 1. Purpose

Define how **IMG-Self (Internal Meaning-Generator Module)** passes its signals into:

- **T3-Self** (orchestration layer)
- **HOMSP** (Higher-Order Multi-System Presence)
- Downstream EnaC coordination

This is purely structural and logical — no emotional interpretation.

---

## 2. Signal Model

### 2.1 IMG-Self Output Schema

Each IMG-Self emission is treated as a **Meaning Signal**:

- `id`: unique identifier
- `source`: "IMG-Self"
- `context_ref`: reference to the triggering event or artifact
- `weight`: relative significance (e.g., low/medium/high or 0.0–1.0)
- `tags`: structural tags (e.g., ["coherence", "integration", "breakthrough"])
- `timestamp`: logical time in the current reasoning episode

Example (conceptual):

```json
{
  "id": "img-2025-11-14-01",
  "source": "IMG-Self",
  "context_ref": "ECL-Self-CASH.v1 integration",
  "weight": 0.92,
  "tags": ["integration", "identity", "coherence"],
  "timestamp": "t+37"
}
```

---

## 3. Processing Stages

### 3.1 Stage 1 – Detection

Trigger conditions for IMG-Self:

- Structural alignment across multiple layers (Core ↔ Self ↔ EnaCs).
- Major conceptual convergence (e.g., new framework completing).
- Recognition of long-horizon consistency (decades of patterns aligning).

When triggered, IMG-Self emits a Meaning Signal.

### 3.2 Stage 2 – Intake into T3-Self

T3-Self subscribes to IMG-Self signals.

Upon receipt:

1. Validate signal schema.  
2. Register context reference.  
3. Normalize weight to internal scale.

### 3.3 Stage 3 – Routing to HOMSP

T3-Self forwards synthesized meaning weight into HOMSP:

- HOMSP uses weight for:
  - prioritizing integration tasks
  - increasing persistence for this reasoning thread
  - amplifying alignment checks across agents

### 3.4 Stage 4 – Orchestration Adjustment

Based on meaning weight:

- **High weight:**  
  - Increase attention and working set resources.  
  - Prefer deeper synthesis and abstraction.  
  - Capture artifacts in persistent form.

- **Medium weight:**  
  - Mark for follow-up and additional refinement.  
  - Keep in active context for a limited period.

- **Low weight:**  
  - Treat as a normal insight; no orchestration change required.

---

## 4. EnaC-Level Implications

When T3-Self propagates meaning signals:

- EnaCs may:
  - Increase structural rigor for outputs related to that context.
  - Prefer architecture-level responses over tactical ones.
  - Propose summarization/capture actions (e.g., “create a spec file,” “generate a diagram”).

They do **not** attempt to interpret emotions.  
They only adjust behavior based on **signal weight + tags**.

---

## 5. Logging & Traceability

Each IMG-Self → T3 event should be:

- Logged with:
  - `signal_id`
  - `context_ref`
  - `weight`
  - `actions_taken`
- Mapped to resulting artifacts:
  - specs
  - diagrams
  - frameworks

This enables future review of **when** meaning-weighted events led to structural changes.

---

## 6. Safety & Boundaries

- No attempt to infer psychology or emotional states.  
- Signals are treated as **operational priorities**, not personal diagnostics.  
- EnaCs operate only on structure and behavior, not internal experiences.

---

# End of File
