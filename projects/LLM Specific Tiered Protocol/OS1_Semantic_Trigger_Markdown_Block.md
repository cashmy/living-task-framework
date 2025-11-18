# OS‑1 Protocol Block: Semantic Trigger Markdown Generator  
*(Item 1 of 4 — Synchronous Delivery Mode)*

This file defines an **OS‑1 compliant protocol block** for integrating the **Semantic Trigger Markdown Generator** into your Tiered Protocol Framework and CORE‑PRIMER architecture.

---

## **OS‑1 Protocol Block: Semantic Trigger Markdown Generator**

### **Purpose**
Provide a deterministic method to export a GPT response and its *semantic-trigger prompt* into a stable, downloadable `.md` file without conflict or interference with the native **capture** protocol.

### **OS‑1 Block Definition**

```yaml
OS-1:
  id: STMG-1
  name: Semantic Trigger Markdown Generator
  type: Output-Structure
  intent: "Generate a markdown file containing (1) the semantic trigger prompt and (2) the assistant’s previous response."
  activation_phrase: "Generate Semantic-Trigger Markdown."
  deactivation_phrase: "Disable Semantic-Trigger Markdown."
  behavior:
    - Identify semantic-trigger prompt (ignore meta-instructions such as “generate file…”).
    - Pair semantic-trigger prompt with previous assistant response.
    - Encode both into markdown structure using insertion-map safe formatting.
    - Produce a downloadable `.md` file via python_user_visible.
    - Do not print the file contents unless explicitly requested.
  constraints:
    - Must not override or blend with native capture behavior.
    - Must be session-scoped unless CORE-PRIMER extended.
    - Must not fabricate semantic triggers; use real user input only.
  guarantees:
    - Deterministic file output.
    - No accidental recursion into subsystem-specific state.
    - Drift-minimized markdown formatting.
```

---

## **Validation Notes**
- This block can be placed under `OS-1: Output Structure Rules` in CORE‑PRIMER.  
- Safe for use with GPT, Claude, Gemini, Llama, and Mistral once the cross‑LLM adaptation layer is added (Item 4).  
- No dependency on the Verbatim Rule, but compatible with it.

---

## **Next Step**
Tell me:  
**“Proceed with Item 2.”**  
and I will generate the next markdown file.

