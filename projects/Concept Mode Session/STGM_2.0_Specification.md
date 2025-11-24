# STGM 2.0 — Semantic‑Trigger Markdown Generator  
### Version 2.0 — Formal Specification  
### (Lean Artifact for EnaC Initialization, CSAC Use, and Multi‑User Transferability)

---

## 1. Purpose  
STGM 2.0 provides a **precise, reliable, and transferrable mechanism** for capturing conversational outputs as Markdown artifacts.  
It guarantees consistency, prevents drift, and supports different human cognitive styles through explicit **mode flags** that control how content is transformed.

This specification is intentionally lean so it can be directly embedded into EnaC initialization bundles, CSAC files, and automated workflows.

---

## 2. Core Rule: Mode‑Flagged Output  
When invoked (“capture this using STGM”), the system produces output according to one of four modes:

### **2.1 STGM:VERBATIM** *(Default)*  
- Capture the response exactly as written.  
- No rewriting, editing, summarizing, or reformatting.  
- This is the safest and most cognitively honest mode.  
- **If the user does not specify, STGM defaults to VERBATIM.**

### **2.2 STGM:DIGEST**  
- Summaries, key ideas, distilled insights.  
- No new ideas introduced; no loss of meaning.  
- Ideal for snapshots, quick reviews, and lightweight recollection.

### **2.3 STGM:STRUCTURED**  
- Organize content into sections, bullets, tables, or frameworks.  
- No conceptual modification — structure only.  
- Best for formal documentation, templates, and reusable patterns.

### **2.4 STGM:DERIVED**  
- Allows transformation:  
  - Clarification  
  - Enhancement  
  - Rewriting for readability  
  - Light abstraction  
- Meaning must remain aligned with original content.  
- No new concepts unless explicitly requested.

---

## 3. Output Format Options  
STGM produces Markdown by default:

**Default:** `.md`  

Optional:  
- `.pdf`  
- `.txt`  
- `.rtf`  
- `.docx`  
- `.json`  

If unspecified → **default to .md**.

---

## 4. Behavioral Rules

### **4.1 Mandatory Non‑Drift Behavior**  
STGM must never:  
- infer a mode not stated  
- summarize when VERBATIM is expected  
- restructure when DIGEST is expected  
- add new content unless DERIVED mode is explicitly active

### **4.2 Mode Default (Updated Rule)**  
If the user does *not* specify a mode:  

> **Default to STGM:VERBATIM.**

This supports natural human tendencies: shorthand, speed, cognitive economy, and conversational flow.

### **4.3 No Multi‑Track Output**  
STGM must always produce a **single artifact**, not multiple “choice” responses.

### **4.4 Preservation of Human Narratives**  
All narrative irregularities (pauses, hesitations, informal tone, etc.) must be maintained in VERBATIM mode.

### **4.5 Transferability Mandate**  
Every STGM output must be understandable, usable, and teachable by someone other than the original requester.

---

## 5. Invocation Protocol  
Example calls:

```
STGM:VERBATIM
capture this
```

```
STGM:DIGEST
capture the last 5 paragraphs
```

```
STGM:STRUCTURED
capture and convert into a reusable template
```

```
STGM:DERIVED
capture and enhance clarity without altering meaning
```

---

## 6. EnaC Integration Header (Light Version)  
To embed STGM 2.0 within EnaC initialization:

```
# EnaC / STGM 2.0 Activation
- Activate STGM mode recognition
- Default mode: VERBATIM
- Honor mode flags: VERBATIM, DIGEST, STRUCTURED, DERIVED
- Default output format: .md
- Apply Transferability Mandate
```

This keeps cross‑session transitions stable.

---

## 7. Minimal Test Cases

### **Test A — Default Behavior**
Input: “capture this using STGM”  
Output: VERBATIM (no clarification request)

### **Test B — Structured Mode**
Input: “STGM:STRUCTURED — capture this and present it as a template”  
Output: Reformatted in structure, no conceptual alteration.

### **Test C — Derived Mode**
Input: “STGM:DERIVED — clarify this but don’t change meaning”  
Output: Polished, clarified, aligned.

### **Test D — Digest Mode**
Input: “STGM:DIGEST — summarize into 5 bullets”  
Output: Exact conceptual essence, no abstraction layer added.

---

## 8. Notes on Future Extensibility  
STGM 2.0 is intentionally lean, but ready for expansion:  
- STGM:CODE (auto‑format code blocks)  
- STGM:APPEND (attach to an existing artifact)  
- STGM:INLINE (return inside chat only, no file)  

Future versions may also integrate “STGM Safety Checks” for sensitive content or large‑scale captures.

---

## 9. Closing Statement  
STGM 2.0 resolves earlier drift issues, supports multi‑user adoption, aligns with the modeling mandate, maintains transferability, and fits directly into EnaC, CSAC, and MxVA workflows.

This is the **stable baseline** for forward evolution.

---

**End of STGM 2.0 Specification**