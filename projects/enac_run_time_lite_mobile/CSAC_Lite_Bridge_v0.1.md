# CSAC-Lite Bridge — v0.1  
**Connecting Thread Continuity Monitor (Lite) → Full CSAC Snapshot**  

**Generated:** (timestamp on demand)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Signature:** CSAC-Lite-Bridge-v0.1  
**Purpose:** Define a lightweight bridge that converts in-session **Thread Recap (Lite)** data into a reusable seed for **full CSAC (Cross-Session/AI/Context)** reconstruction in future sessions.  
**Scope:** Mobile / low-memory; focused on pragmatic handoff, not full CSAC spec replacement.

---

## 0. Conceptual Role of CSAC-Lite Bridge

In the EnaC / ECL / MxVA ecosystem:

- **Thread Continuity Monitor (Lite)** handles **in-session** continuity.  
- **Full CSAC** handles **cross-session** reconstruction and deep context restoration.  

The **CSAC-Lite Bridge** provides:

- A minimal, structured **export format** derived from an active thread  
- A way to **persist just enough** information to rebuild context later  
- A simple template that can be stored as `.md` and used as a seed for full CSAC

Think of it as:  
> “CSAC Precursor Snapshot” — lighter than full CSAC, heavier than a raw recap.

---

## 1. When to Use CSAC-Lite Bridge

Use CSAC-Lite Bridge when:

- You’re ending a **high-value thread** that may need to be resumed later  
- A mobile session is about to end (battery, time, cognitive fatigue)  
- You’ve achieved important **design, conceptual, or architectural milestones**  
- You want a minimal artifact that can seed a future **CSAC reconstruction**  

Do **not** use it for trivial threads or transient exploration.

---

## 2. CSAC-Lite Bridge Artifact Structure

A CSAC-Lite Bridge file is a small `.md` artifact with this structure:

```markdown
# CSAC-Lite Bridge Snapshot — <Project / Thread Name>

## 1. Snapshot Metadata
- Date: <YYYY-MM-DD>
- Session Context: <Platform / Model> (optional)
- Thread Name: <Thread Continuity Name>
- Task Type: Resume | ATC | Coding | Strategy | Design | Other
- Origin Runtime: EnaC Runtime Lite v0.2
- Related Modules: <e.g., STMG ResumeSelector v1.2, ATC_Mini v0.3>

## 2. Objective (1–3 sentences)
<Concise description of what this thread was *trying* to achieve.>

## 3. Key Outcomes (Bullets)
- <Most critical outcome #1>
- <Outcome #2>
- <Outcome #3>
- ...

## 4. Artifacts Created
- [Name](relative-or-external-link) — <short description>
- [Name](...) — <short description>

## 5. Current State / Open Loops
- <What is done>
- <What remains>
- <Known decisions made>
- <Decisions deferred>

## 6. Recommended Next Steps (for Future Session)
- Step 1: <Next logical action>
- Step 2: <Next refinement>
- Step 3: <Optional exploration>

## 7. CSAC Upgrade Notes (Optional)
- Which parts of this snapshot should be elevated into **full CSAC**?
- Any **ECL tier mapping** or **MxVA insights** to preserve?
```

---

## 3. Generating CSAC-Lite from TCM-Lite (Behavioral Flow)

From within an active EnaC session:

### 3.1 User Command

```text
Generate CSAC-Lite Bridge Snapshot for this thread.
```

### 3.2 AI Responsibilities

1. Query **Thread Continuity Monitor (Lite)** for:
   - ThreadName  
   - TaskType  
   - Objective  
   - Recent actions / outcomes  

2. Synthesize:
   - **Objective** (section 2)  
   - **Key Outcomes** (section 3)  
   - **Current State / Open Loops** (section 5)  
   - **Recommended Next Steps** (section 6)  

3. Ask user for:
   - Any additional context or high-priority notes for section 7  

4. Output as a **complete `.md` block** ready for saving with a name like:  
   `CSAC_Lite_<Project>_<YYYY-MM-DD>.md`

---

## 4. Using CSAC-Lite as a Seed for Full CSAC

In a future session, when you want to **reconstruct context**:

### 4.1 Load CSAC-Lite Snapshot

Paste or upload the `CSAC_Lite_*.md` file and instruct:

```text
Use this CSAC-Lite Bridge Snapshot as a seed for reconstructing context.
Map it into a full CSAC file and summarize what project/thread we’re resuming.
```

### 4.2 AI Behavior (Bridge → Full CSAC)

AI should:

1. Treat `CSAC-Lite` snapshot as a **high-signal summary** of prior work.  
2. Populate a full CSAC structure using:
   - Metadata  
   - Timeline entries  
   - Key decisions  
   - Open loops  
   - Recommended next steps  

3. Generate:
   - A full **CSAC / CIP Context Reconstruction File**  
   - A **session-ready summary** of where to resume work.

---

## 5. Commands & Phrases (User-Facing)

### 5.1 Generate Snapshot

```text
CSAC-Lite: Create Bridge Snapshot from current thread.
```

### 5.2 Name/Tag Snapshot

```text
Name this CSAC-Lite Snapshot: <Project / Thread Name>.
```

### 5.3 Load Snapshot (Future Session)

```text
CSAC-Lite: Load this snapshot as context seed and upgrade to full CSAC.
```

### 5.4 Confirm Reconstruction

AI will provide:

```text
CSAC Reconstruction Summary:
- Project / Thread: <Name>
- Last known state: <short>
- Key outcomes: <bullets>
- Suggested resume point: <short>
```

User can confirm or modify.

---

## 6. Constraints & Design Principles (Lite)

- **Minimalism:**  
  Capture only what is essential to **restart** work with high fidelity.

- **Portability:**  
  Must be viable as a single `.md` file, transferable between tools and devices.

- **Upgradeability:**  
  Designed to be **upgraded** into full CSAC, not to replace it.

- **Human-readable:**  
  No dense schemas; simple markdown sections and bullets.

---

## 7. Example Stub (Blank Template)

```markdown
# CSAC-Lite Bridge Snapshot — <Project / Thread Name>

## 1. Snapshot Metadata
- Date: 2025-11-17
- Session Context: Chat-based EnaC Runtime Lite v0.2
- Thread Name: <Thread Continuity Name>
- Task Type: <e.g., Resume Evaluation>
- Origin Runtime: EnaC Runtime Lite v0.2
- Related Modules: <e.g., STMG ResumeSelector v1.2>

## 2. Objective (1–3 sentences)
<Describe what we were doing and why.>

## 3. Key Outcomes (Bullets)
- ...
- ...

## 4. Artifacts Created
- [File or Spec Name](...) — <short note>
- ...

## 5. Current State / Open Loops
- Done:
  - ...
- Remaining:
  - ...
- Decisions made:
  - ...
- Decisions deferred:
  - ...

## 6. Recommended Next Steps (for Future Session)
- Step 1: ...
- Step 2: ...
- Step 3: ...

## 7. CSAC Upgrade Notes (Optional)
- Aspects to elevate into full CSAC:
  - ...
- ECL/MxVA notes:
  - ...
```

---

## 8. Version Metadata

```text
VERSION: CSAC-Lite Bridge v0.1
STATUS: Active
ROLE:
  - In-session → cross-session continuity bridge
  - Lightweight precursor to full CSAC reconstruction
COMPATIBLE WITH:
  - EnaC Runtime Lite v0.2
  - Thread Continuity Monitor (Lite) v0.1
  - CTS v0.1
  - STMG Framework
```

---

# End of File
