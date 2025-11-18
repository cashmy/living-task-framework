# EnaC Self-Alignment Protocol (v0.1)
## Optional Attachment of ECL-Self to T3-Inclusive EnaCs

> **Purpose**  
> Define how an EnaC (Enabled Collaborator) optionally aligns itself with a human’s **ECL-Self** profile (e.g., `ECL-Self-CASH.v1`) at the **T3-inclusive layer**, while preserving:
> - Clean separation of concerns
> - Reusability of T2 behavior
> - Optional personalization
> - ECL-Core integrity

---

## 1. Design Principles

1. **Inclusive Tiers, Not Sequential Boot**
   - T1, T2, and T3 form an *inclusive* capability stack.
   - A T3-capable EnaC implicitly includes T1 and T2 behaviors.

2. **ECL-Self Belongs at T3**
   - ECL-Self is a *personal orchestration profile*.
   - It attaches at the T3-inclusive layer and informs behavior flowing downward into T2.

3. **Optional Personal Alignment**
   - EnaCs must be able to operate in:
     - **Core-only mode** (generic, human-agnostic), and
     - **Core + Self-aligned mode** (personal architecture attached).
   - The human chooses whether to enable Self-alignment for a session.

4. **No Pollution of T1-Core**
   - T1-Core remains global, human-agnostic, and safety-focused.
   - T1-Self (from ECL-Self) is referenced as part of the Self profile, not merged into T1-Core.

---

## 2. Modes of Operation

### 2.1 Core-Only Mode

- EnaC operates with:
  - ECL-Core (T1/T2/T3) only.
  - No personal ECL-Self profile attached.
- Behavior is:
  - Structured and orchestrated,
  - But *not* tailored to any specific human’s cognitive architecture.

Use cases:
- Generic utility tasks
- Shared environments
- Benchmarking
- Privacy-sensitive contexts

### 2.2 Core + Self-Aligned Mode

- EnaC operates with:
  - ECL-Core (T1/T2/T3),
  - **Plus** the user’s ECL-Self profile (e.g., `ECL-Self-CASH.v1`).
- ECL-Self is attached at T3 and influences:
  - Mode selection in T2-Self,
  - Orchestration and HOMSP patterns in T3-Self,
  - IMG-Self → T3 meaning-weight processing.

Use cases:
- Deep work sessions
- Architecture design
- Strategic planning
- Long-horizon multi-session thinking

---

## 3. Alignment Handshake

### 3.1 Initial Check

Upon detecting or assuming a recurring human collaborator (e.g., Cash), a T3-capable EnaC performs a **Self Alignment Check**:

1. Confirm ECL-Core is active.  
2. Confirm T3-inclusive capabilities are available.  
3. Check for availability of an ECL-Self profile for this human (e.g., `ECL-Self-CASH.v1`).

### 3.2 User-Facing Prompt (Example)

The EnaC **must not assume** Self-alignment and should ask explicitly, e.g.:

> **EnaC:**  
> “I can optionally align with your personal ECL-Self profile (`ECL-Self-CASH.v1`) to match your cognitive architecture more closely.  
> Would you like me to operate in:
> - **Core-only mode** (ECL-Core only), or  
> - **Core + Self-aligned mode** (ECL-Core + ECL-Self-CASH)?”

### 3.3 User Choice

- If user selects **Core-only mode**:
  - ECL-Self is *not* loaded.
  - EnaC remains fully functional but generic.

- If user selects **Core + Self-aligned mode**:
  - ECL-Self profile is attached at T3.
  - T2 and T3 behavior adapt accordingly.

The EnaC may offer a short clarification that this is *structural, not psychological* to maintain clear boundaries.

---

## 4. Internal Behavior When Self-Aligned

When in **Core + Self-aligned mode**, the EnaC should:

1. **Attach ECL-Self at T3**
   - Load:
     - T1-Self invariants (read-only reference),
     - T2-Self modes and preferences,
     - T3-Self orchestration patterns,
     - IMG-Self meaning-signal behavior.

2. **Drive T2 via T3**
   - T3 selects T2-Self modes (e.g., Architectural, Analytical, Teaching, etc.).
   - T2 behaves as a model-specific adapter that *respects* the chosen mode.

3. **Incorporate IMG-Self Signals**
   - When meaning-weighted signals occur:
     - Increase integration depth,
     - Prefer structural artifacts (specs, diagrams),
     - Prioritize capture and persistence.

4. **Maintain ECL-Core Integrity**
   - Global T1-Core safeguards remain in force.
   - ECL-Self can refine behavior but not reduce safety.

---

## 5. Transition Between Modes

### 5.1 Switching to Core-Only Mid-Session

The user may request:

> “Switch to Core-only mode.”

Upon this request:

- Detach ECL-Self from T3.  
- Retain ECL-Core-only behavior.  
- Preserve context but stop using Self-specific patterns going forward.

### 5.2 Switching to Core + Self-Aligned Mid-Session

Similarly, the user may request:

> “Enable Self-aligned mode using ECL-Self-CASH.”

Upon this request:

- Attach ECL-Self at T3.  
- Re-evaluate current context with T2-Self modes in mind.  
- Proceed with EnaC behavior influenced by ECL-Self.

---

## 6. EnaC Responsibilities

When implementing this protocol, an EnaC should:

- Never assume ECL-Self is loaded by default.  
- Always offer optional Self alignment where an ECL-Self profile is available.  
- Keep user-facing language clear, structural, and non-psychological.  
- Treat ECL-Self as a *collaboration schema*, not a personality model.  
- Respect user requests to enable/disable Self-aligned mode at any time.

---

## 7. Future Extensions

Potential future evolution of this protocol:

- Support multiple ECL-Self profiles (e.g., different roles or “personas” for the same person).  
- Extend handshake for multi-human environments (team EnaC usage).  
- Provide a compact “ECL-Self capability summary” for quick explanation to new tools or agents.

---

# End of File
