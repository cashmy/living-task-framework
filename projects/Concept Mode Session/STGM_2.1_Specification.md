# STGM 2.1 — Semantic-Trigger Markdown Generator  
### Full Specification — Version 2.1  
### This replaces STGM 2.0 in totality  

---

## 1. Purpose  
STGM 2.1 is a refined, clearer, cleaner, and more operationally aligned specification for capturing conversational content as Markdown artifacts.  
It is designed for:

- EnaC (Tier 1–Tier 3)  
- CSAC  
- ECL workflows  
- MxVA modeling  
- EchoForge  
- General multi-user adoption  

STGM 2.1 corrects drift issues that occurred in earlier versions by tightening the mandate, clarifying modes, requiring contextual capturing, and embedding transferability safeguards.

This version is **fully lean**, **fully transferrable**, and **optimized for real-world use**.

---

## 2. Core Rule: STGM Captures Both Prompt + Response  
When STGM is invoked, **VERBATIM mode must ALWAYS capture**:

1. The *initiating user prompt*, exactly as it was written  
2. The *full assistant response*, exactly as it was written  

This preserves:

- Context  
- Intent  
- Causality  
- Interpretation accuracy  
- Elimination of drift  

This is the **gold standard behavior** and the reason STGM exists at all.

---

## 3. The Four Mode Flags  
Mode flags define *how* STGM transforms conversational material.  
They prevent ambiguity, ensure precision, and allow multi-user flexibility.

### **3.1 STGM:VERBATIM (Default Mode)**  
- Capture prompt + response *exactly*  
- No editing, summarizing, rearranging, or compressing  
- Keep human irregularities, hesitations, exclamations, informal tone  
- Preserve line breaks and punctuation  
- Output is a complete and unaltered capture  

This mode is for:

- preserving cognitive states  
- documenting insights  
- preventing drift in modeling  
- feeding EnaC / EchoForge / CSAC  
- replaying liminal cognition output  

If user does not specify mode, STGM defaults to **VERBATIM**.

---

### **3.2 STGM:DIGEST**  
- Summarize meaning  
- Extract key insights  
- No new ideas added  
- No conceptual shifts  
- Light, clean compression  

Used for:

- quick reviews  
- short briefs  
- memory-friendly distillation  

---

### **3.3 STGM:STRUCTURED**  
- Reformat content  
- No change to meaning  
- Organize into:  
  - headings  
  - bullets  
  - frameworks  
  - templates  
  - tables  

Used for:

- reusable frameworks  
- documentation  
- playbooks  
- onboarding materials  

---

### **3.4 STGM:DERIVED**  
- Maximum allowed transformation  
- Improve clarity  
- Reframe structure  
- Remove noise  
- Preserve original meaning and intent  

Used for:

- publication-ready drafts  
- improved readability  
- enhanced conceptual clarity  

No new concepts unless explicitly requested.

---

## 4. Output Formats  
Default: **.md**

Optional:

- .pdf  
- .txt  
- .docx  
- .rtf  
- .json  

If unspecified → default to **.md**

---

## 5. Behavioral Requirements

### **5.1 No Dual Output**  
STGM must always return *one artifact*, not multiple choices or parallel forms.

### **5.2 Transferability Mandate**  
All outputs must be usable by someone other than the originator.  
This includes:

- clarity  
- readability  
- correct context  
- no hidden assumptions  
- no personal shorthand that obscures meaning  

### **5.3 Context Integrity**  
Because meaning comes from *interaction*, not isolated text:

- VERBATIM must capture both prompt + response  
- Other modes may selectively capture prompt only if explicitly requested  
- No surrogate paraphrasing of the user's original words  

### **5.4 Preservation of User Voice**  
STGM must not override or "sanitize" the user's tone.  
This is crucial for:

- identity preservation  
- cognitive state tracking  
- authenticity  
- ECL-development  

---

## 6. Invocation Pattern

Example:

```
STGM:VERBATIM
capture this
```

```
STGM:DIGEST
capture the last exchange
```

```
STGM:STRUCTURED
capture this and convert into a reusable template
```

```
STGM:DERIVED
capture this and improve clarity without changing meaning
```

---

## 7. Integration with Concept Mode  
During Concept Mode:

- STGM defaults to VERBATIM when invoked  
- STGM must not auto-structure exploratory content  
- STGM captures the "thinking state" for later refinement  

Concept Mode + STGM produces clean narrative evolution sequences.

---

## 8. EnaC Tier Behavior  
STGM behavior is tier-consistent:

### **Tier 1**  
- Clean, foundational captures  
- Minimally structured  
- Preserves definitions and distinctions  

### **Tier 2**  
- Captures applied reasoning  
- Useful for workflows, architecture, code reasoning  

### **Tier 3**  
- Captures meta-cognition, patterns, models, high reasoning layers  
- Used for CSAC, framework evolution  

STGM behavior does not need separate tier versions — only contextual scanning differs.

---

## 9. Minimal Test Cases

### **Test A: Verbatim Default**  
Input: “capture this using STGM”  
→ Prompt + Response captured exactly

### **Test B: Digest Request**  
Input: “STGM:DIGEST — capture the last two messages”  
→ Clean, compressed summary

### **Test C: Structured Template**  
Input: “STGM:STRUCTURED — turn this into a template”  
→ Headings + bullets + framework

### **Test D: Derived Enhancement**  
Input: “STGM:DERIVED — capture this with improved clarity”  
→ Enhanced but meaning-intact content  

---

## 10. Closing Notes  
STGM 2.1 is:

- Lean  
- Fast  
- Rigorous  
- Transferable  
- MxVA-aligned  
- EnaC-ready  
- CSAC-friendly  
- Drift-resistant  
- Cognitively safe  
- Multi-user compatible  

This replaces STGM 2.0 completely.

---

**End of STGM 2.1 Specification**