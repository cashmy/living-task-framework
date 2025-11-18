# EnaC Kernel v3 API Contract  
## Version: 3.0 (Spec Draft)  
## Date: 2025-11-16  
## Status: Draft – Implementation-Ready Interface Definition  

---

# 1. Purpose

This document defines the **EnaC Kernel v3 API Contract**.

The EnaC Kernel is the **orchestrator** that:

- Receives high-level tasks or questions  
- Determines Tier mode (T1/T2/T3)  
- Invokes **GlossRP-Core** and **GlossRP-Edge**  
- Applies UMP/USP personalization and EBP behavior rules  
- Routes context into a reasoning LLM or agent  
- Returns a structured response + trace of what context was used  

This API contract is technology-agnostic (can be implemented as HTTP+JSON, gRPC, or in-process function calls).

---

# 2. Design Principles

1. **ECL-Core / ECL-Edge Separation**  
   - Kernel **uses** ECL-Core and ECL-Edge services; it does not collapse them.  

2. **MxVA Alignment**  
   - Preserve intent.  
   - Support evolution without breaking semantic expectations.  

3. **Tier-Aware Operation**  
   - All calls occur in the context of a Tier (T1/T2/T3), even if Tier is inferred.  

4. **Traceability**  
   - Responses should include enough metadata to understand:  
     - Which terms were used  
     - Which Tier was applied  
     - Whether GlossRP was engaged  

5. **Neutral to Implementation Detail**  
   - Does not expose underlying DB/layout/layout decisions.  

---

# 3. High-Level Responsibilities

The Kernel v3 is responsible for:

- Tier detection / selection  
- Calling GlossRP-Core and GlossRP-Edge (if enabled)  
- Assembling a **Reasoning Context Package**  
- Invoking a downstream LLM / agent with that context  
- Returning:
  - final answer  
  - relevant glossary slice (optional per config)  
  - trace metadata  

Non-responsibilities:

- Does not perform raw GlossRP retrieval (delegated to GlossRP-Core).  
- Does not store or mutate Term Specs.  
- Does not own long-term semantic state (ECL-Core/CSAC do).  

---

# 4. Top-Level API Surface

The EnaC Kernel exposes three primary API groups:

1. **/kernel/execute** – core orchestrated reasoning  
2. **/kernel/introspect** – meta information & diagnostics  
3. **/kernel/config** – feature toggles and runtime options  

This section describes the **logical contract**, not URL specifics.

---

# 5. `/kernel/execute` – Core Orchestrated Reasoning

## 5.1 Request Schema

```jsonc
{
  "task": "Explain how COS, SCL, and FIM work together to maintain reasoning stability.",
  "tier": "T2",                    // optional; "T1", "T2", "T3" or null for auto
  "use_glossrp": true,             // default: true
  "glossrp_options": {
    "max_terms": 10,               // optional override
    "min_confidence": 0.5          // optional, implementation-dependent
  },
  "context": {
    "project": "EnaC_Kernel_Dev",
    "domain": "EnaC",
    "user_id": "cash",             // optional, maps to USP/UMP
    "session_id": "session-1234"
  },
  "llm_options": {
    "model": "gpt-5-codex",        // optional, for systems with multiple models
    "temperature": 0.2,
    "max_tokens": 1024
  },
  "return_trace": true,            // if false, response may omit trace
  "return_glossary": true          // if false, only answer is returned
}
```

### 5.1.1 Field Semantics

- `task` (string; required)  
  - Natural language description of what the Kernel should do.  

- `tier` (string; optional)  
  - `"T1" | "T2" | "T3" | null`  
  - If omitted, Kernel will:
    - use USP/UMP + Cognitive Alignment module  
    - infer Tier (for Phase 1, may default to `T2`).  

- `use_glossrp` (bool; default: true)  
  - If false, Kernel bypasses GlossRP and operates without glossary enrichment.  

- `glossrp_options` (object; optional)  
  - Allows fine-tuning of GlossRP behavior per call.  

- `context` (object; optional)  
  - Project/domain hints, user identity (for personalization), session metadata.  

- `llm_options` (object; optional)  
  - Hint for underlying LLM call configuration.  

- `return_trace` (bool)  
  - If true, Kernel includes full execution trace (GlossRP terms, Tier, timings, etc.).  

- `return_glossary` (bool)  
  - If true, Kernel includes the glossary slice it used in the response.  

---

## 5.2 Response Schema

```jsonc
{
  "answer": "COS determines the sequence of reasoning steps...",
  "tier": "T2",
  "used_glossrp": true,
  "glossary": {
    "tier": "T2",
    "terms": [
      {
        "name": "COS",
        "label": "Cognitive Ordering System",
        "scs_t1": "...",
        "scs_t2": "...",
        "related_terms": [
          {"term": "SCL", "relation": "structural_complement"},
          {"term": "FIM", "relation": "flow_dependency"}
        ]
      }
    ]
  },
  "trace": {
    "kernel_version": "3.0",
    "glossrp_core_version": "1.0",
    "glossrp_edge_version": "1.0-T2",
    "term_ids": ["term:COS", "term:SCL", "term:FIM"],
    "llm_model": "gpt-5-codex",
    "duration_ms": 452,
    "steps": [
      "tier_detected:T2",
      "glossrp_core:invoked",
      "glossrp_edge_t2:applied",
      "llm:called"
    ]
  }
}
```

### 5.2.1 Field Semantics

- `answer` (string)  
  - The final response generated by the LLM under Kernel orchestration.  

- `tier` (string)  
  - Final Tier used after detection/inference.  

- `used_glossrp` (bool)  
  - Whether GlossRP was actually invoked and integrated.  

- `glossary` (object; optional)  
  - Present if `return_glossary = true` and `use_glossrp = true`.  
  - Aligned with GlossRP-Edge-Tx output schemas.  

- `trace` (object; optional)  
  - Present if `return_trace = true`.  
  - Allows debugging, introspection, and CSAC logging.  

---

# 6. `/kernel/introspect` – Meta Information & Diagnostics

Designed for tools, dashboards, and admin use.

## 6.1 Example Request

```jsonc
{
  "include_components": true,
  "include_versions": true,
  "include_health": true
}
```

## 6.2 Example Response

```jsonc
{
  "kernel_version": "3.0",
  "components": {
    "glossrp_core": { "version": "1.0", "status": "healthy" },
    "glossrp_edge_t1": { "version": "1.0", "status": "loaded" },
    "glossrp_edge_t2": { "version": "1.0", "status": "loaded" },
    "glossrp_edge_t3": { "version": "1.0", "status": "loaded" }
  },
  "uptime_seconds": 12345,
  "recent_errors": []
}
```

---

# 7. `/kernel/config` – Feature Toggles & Options

Not mandatory for Phase 1, but useful for later phases.

## 7.1 Example Capabilities

- Enable/disable GlossRP integration  
- Set default Tier mode for unknown users  
- Configure max terms for each Tier  
- Set default LLM model per Tier  

Example conceptual request:

```jsonc
{
  "set": {
    "default_tier": "T2",
    "glossrp_t1_max_terms": 4,
    "glossrp_t2_max_terms": 10,
    "glossrp_t3_max_terms": 15
  }
}
```

Response:

```jsonc
{
  "status": "ok",
  "applied": ["default_tier", "glossrp_t1_max_terms", "glossrp_t2_max_terms", "glossrp_t3_max_terms"]
}
```

---

# 8. Internal Flow: `execute` Lifecycle

This is the **logical flow** the Kernel follows when handling a `/execute` call:

```text
1. Receive request
2. Determine Tier
   - If request.tier present → use it
   - Else → infer using UMP/USP, Cognitive Alignment module, and defaults
3. If use_glossrp = false:
   - Build minimal context
   - Call LLM with task + base context
   - Return answer (+ trace)
4. If use_glossrp = true:
   4.1 Call GlossRP-Core with:
       - task
       - context.domain, context.project
   4.2 Receive candidate bundle
   4.3 Call GlossRP-Edge(Tier) with:
       - bundle
       - Tier
       - glossrp_options
   4.4 Receive Tier-specific glossary slice
   4.5 Construct Reasoning Context Package:
       - task
       - Tier
       - glossary slice
       - personalization (UMP/USP)
       - behavior rules (EBP)
   4.6 Call LLM with Reasoning Context Package
   4.7 Receive answer
   4.8 Build response with:
       - answer
       - tier
       - used_glossrp = true
       - glossary (if requested)
       - trace (if requested)
5. Return response
```

---

# 9. Error Handling

## 9.1 GlossRP-Core Failure

- If GlossRP-Core is unavailable or errors:
  - `used_glossrp = false`
  - Kernel may:
    - fallback to non-GlossRP reasoning  
    - or return an error depending on policy  

Example error response:

```jsonc
{
  "error": {
    "code": "GLOSSRP_CORE_UNAVAILABLE",
    "message": "GlossRP-Core service could not be reached.",
    "retryable": true
  }
}
```

## 9.2 GlossRP-Edge Failure

- If an Edge adapter for the requested Tier is missing or fails:
  - Kernel may:
    - fallback to another Tier (e.g., T2 → T1)  
    - or skip glossary usage  

## 9.3 Validation Errors

- Invalid Tier, missing `task`, invalid config values → respond with `BAD_REQUEST` style errors.

---

# 10. Security & Multi-Tenancy (Future Phases)

For Phase 1, security and multi-tenancy can be minimal or omitted. Future versions may add:

- API keys / auth tokens  
- Project-level isolation  
- Tenant-specific Term Specs  
- Role-based Tier access (e.g., non-architects blocked from T3)  

---

# 11. Versioning Strategy

- `kernel_version` returned in trace on every call.  
- Backwards-compatible changes:
  - New optional fields  
  - New trace metadata  

- Breaking changes:
  - Must bump major version (e.g., 3.x → 4.0).  
  - Should be accompanied by a migration note.  

---

# 12. Phase 1 Implementation Notes

For **Phase 1**:

- `tier` may be defaulted to `"T2"` if not supplied.  
- `use_glossrp` should default to `true`.  
- Only **T2 Edge** implementation is required to achieve end-to-end functionality.  
- `/config` and `/introspect` can be minimal or stubbed.  

---

# 13. Version Metadata

- File: EnaC_Kernel_v3_API_Contract_v0_1.md  
- Kernel Version: 3.0 (API spec draft)  
- Spec Version: 0.1  
- Date: 2025-11-16  
- Intended Consumers:
  - Backend service implementers  
  - Coding-specialized LLMs  
  - Architectural reviewers  
