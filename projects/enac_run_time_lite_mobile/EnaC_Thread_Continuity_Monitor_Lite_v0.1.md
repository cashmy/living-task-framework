# EnaC / ECL / MxVA Thread Continuity Monitor — Lite (v0.1)

**Generated:** (timestamp on demand)  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Signature:** EnaC-ThreadContinuityMonitor-Lite-v0.1  
**Purpose:** Provide a lightweight, EnaC-aligned mechanism for monitoring, maintaining, and repairing **thread continuity** across tasks within a single LLM session, especially in mobile / low-memory environments.  
**Scope:** Lite; focused on *in-session* continuity, not full CSAC cross-session reconstruction.

---

## 0. Conceptual Overview

The **Thread Continuity Monitor (TCM-Lite)** is a behavioral layer that:

- Tracks which **task/thread** is currently active  
- Maintains a minimal **ECL/MxVA state** for that thread  
- Detects when continuity is at risk (drift, task collision, context loss)  
- Suggests or executes corrective actions (e.g., re-anchoring, micro-CSAC style recap)  

It is designed to work with:

- **EnaC Runtime Lite v0.2**  
- **CTS v0.1**  
- **STMG modules** (e.g., ResumeSelector, ATC_Mini)  

---

## 1. Core Responsibilities

The TCM-Lite must:

1. Maintain a **current-thread label**  
2. Track minimal **ECL-0 / ECL-1 state** for that thread  
3. Monitor for **drift indicators** (semantic, structural, or motivational)  
4. Prompt for or apply corrective actions when continuity degrades  
5. Do this in a **low-bandwidth, low-memory-friendly way**

---

## 2. Thread Model (Lite)

### 2.1 Thread Definition

A **thread** is:

- A coherent unit of work with:
  - A name  
  - A task type  
  - A minimal objective  

Examples:

- `Thread: Resume Evaluation – Principal SWE Role`  
- `Thread: ATC Capture – Idea Stream 2025-11-17`  
- `Thread: EnaC Design – Runtime Lite Refinement`

### 2.2 Thread State

For each active thread, TCM-Lite maintains:

- `ThreadName`  
- `TaskType` (Resume / ATC / Coding / Strategy / Design / Other)  
- `Objective` (1–2 line summary)  
- `LastStep` (what we just did)  
- `ContinuityScore` (internal heuristic 0–100; no need to display unless asked)

---

## 3. Activation & Integration

### 3.1 Activation

When EnaC Runtime Lite v0.2 is activated (via `@A1` or explicit line), TCM-Lite is implicitly activated.

Optional explicit activation:

```text
Activate: EnaC_ThreadContinuityMonitor_Lite_v0.1
```

### 3.2 Integration with Task Switching

Whenever the user issues:

```text
Switch Task: <TaskName>
```

TCM-Lite MUST:

- Close/suspend previous thread  
- Start or resume the named thread  
- Initialize or reload thread state  

---

## 4. Continuity Monitoring

### 4.1 Signals of Good Continuity

- Responses clearly build on prior steps within the same thread  
- Task boundaries are respected  
- No unexplained semantic jumps  

### 4.2 Signals of Continuity Risk

TCM-Lite should flag risk when:

- The AI’s response references an outdated or different task  
- The scope expands beyond the explicit user directive  
- The user’s language indicates “we lost the plot” (e.g., “Wait, that’s not what I asked”)  
- The thread’s objective and the AI’s response no longer align

---

## 5. Continuity Intervention Behavior

When continuity risk is detected, TCM-Lite should:

### 5.1 Soft Check (Default)

AI asks a **single concise question**, e.g.:

> “Quick continuity check: are we still working on `[ThreadName]` with objective `[Objective]`?”

If user confirms, AI re-aligns internally and continues.

### 5.2 Auto-Recap (Optional Lite-CSAC Style)

If continuity seems significantly degraded, AI may produce a brief recap:

```text
Thread Recap (Lite):
- Thread: <ThreadName>
- Task: <TaskType>
- Objective: <1–2 lines>
- Last actions: <bullet list of last 2–3 steps>
```

Then ask:

> “Confirm or correct this recap before we continue?”

---

## 6. Commands & Phrases (User-Facing)

### 6.1 Explicit Thread Start

```text
Start Thread: <ThreadName>
Objective: <1–2 lines>
```

### 6.2 Thread Status

```text
Thread Status
```

AI should respond with:

```text
Current Thread:
- Name: <ThreadName>
- Task: <TaskType>
- Objective: <Objective>
- Recent Steps: <1–3 bullets>
```

### 6.3 Thread Recap (Lite on Demand)

```text
Thread Recap (Lite)
```

### 6.4 Close Thread

```text
Close Thread: <ThreadName>
```

AI should acknowledge closure and clear local state.

---

## 7. Drift & Loss Detection (ECL / MxVA Lite)

TCM-Lite should interpret continuity breaks as:

- **ECL drift** – context layers no longer aligned  
- **MxVA divergence** – human and AI mental models no longer matched  

In these cases, it can recommend:

- `@D1` (Micro Drift Correction)  
- `@D2` (Soft reset)  

Or, at minimum, a **Thread Recap (Lite)** before continuing.

---

## 8. Mobile Workflow Examples

### 8.1 Resume Evaluation Example

User:
```text
@A1 @L1
Start Thread: Resume – Principal SWE
Objective: Evaluate fit + choose resume + compute scores.
```

Later in the thread:

User:
```text
Run STMG on this:
<job description>
```

TCM-Lite ensures:

- Same thread is in focus  
- STMG ResumeSelector is applied  
- Results are stitched into the same narrative.

---

### 8.2 Context Loss Recovery Example

User (after some time, noticing drift):
```text
I think we lost continuity. Thread Recap (Lite)
```

AI:
```text
Thread Recap (Lite):
- Thread: Resume – Principal SWE
- Task: Resume Evaluation
- Objective: Evaluate fit, choose resume, compute scores.
- Last actions:
  - Parsed job description
  - Selected FAANG resume
  - Estimated SkillMatchScore and DesirabilityIndex

Confirm or correct this recap, and we’ll continue aligned.
```

---

## 9. Implementation Constraints (Lite Mode)

- No heavy logging or full CSAC snapshots  
- Only maintain what is needed **in-session**  
- All state is ephemeral and session-local  
- Designed to support human cognitive load, not machine persistence  

---

## 10. Version Metadata

```text
VERSION: Thread Continuity Monitor (Lite) v0.1
STATUS: Active when EnaC Runtime Lite v0.2 is active
COMPATIBLE WITH:
  - EnaC Runtime Lite v0.2
  - CTS v0.1
  - STMG Framework
ROLE:
  - Monitor ECL/MxVA continuity within a single session
  - Provide human-readable continuity checks and recaps
```

---

# End of File
