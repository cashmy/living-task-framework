# Glossary Retrieval Protocol (GRP) v1.0
## For EnaC Kernel – Term Spec Integration
### Generation Date: 2025-11-16

---

# 1. Purpose
The Glossary Retrieval Protocol (GRP) defines how the EnaC Kernel selects, filters, expands, and packages Term Specifications for delivery to an EnaC-enabled AI agent.  
This protocol ensures:
- Context-relevant retrieval
- Controlled prompt size
- Tier-adaptive behavior
- Cross-session stability
- FIFO-proof knowledge access

GRP v1.0 integrates with:
- Term Spec Template v1.0
- VS (Verbal Sampling)
- EnaC / CFP / CORE-PRIMER
- Tier 1 → Tier 3 orchestration

---

# 2. Retrieval Goals
GRP provides:
1. Relevant Term Subset  
2. First-level conceptual connections (SCS_T3)  
3. Confidence-ranked relevance  
4. Tier-aware filtering  
5. Minimal but sufficient context for the LLM  

---

# 3. Retrieval Data Sources

## 3.1 Term Spec DB
Each Term Spec includes:
- Metadata & Domain
- SCS_T1 anchor
- SCS_T2 summary + Tier relevance + related terms
- SCS_T3 concept graph edges
- EnaC / SELF-ECL / ABS views
- Behavioral implications

## 3.2 Vector Index
Embeddings stored for:
- SCS_T1  
- SCS_T2  
- Selected metadata fields  

## 3.3 Graph Expansion Layer
Built from:
- SCS_T3 edges
- Tier and cluster relations  

---

# 4. GRP Pipeline Overview

```
User Query → Pre-Filter → Vector Search → Candidate Set
→ Graph Expansion → VS Relevance Filter → Final Term Set
→ Prompt Packaging → EnaC Agent
```

---

# 5. Step-by-Step Protocol

## 5.1 Input
- Natural-language task description  
- Optional Tier (T1/T2/T3)  
- Optional domain tags (CIP, ECL, LTF, EnaC, ATC, etc.)

---

## 5.2 Pre-Filtering (Deterministic)
Narrow the Term Spec search space with:
- Domain match (if provided)  
- Tier relevance:
  - Tier 3: terms where `Tier_Relevance ≥ 2`  
  - Other tiers: all allowed  
- Safety-restricted term flags (rare)

---

## 5.3 Vector Similarity Search
Using embeddings from SCS_T1 and SCS_T2:
- Embed the user’s task  
- Retrieve top-K similar terms (recommended K = 12)

---

## 5.4 Graph Expansion
For each of the K terms:
- Pull first-level neighbors from SCS_T3  
- Add neighbors into the candidate pool  

Target pool size: **12–20** terms.

---

## 5.5 VS Relevance Filtering (Lightweight LLM)
Give the LLM:
- The query  
- The pool of 12–20 terms  
- For each term: SCS_T1 + SCS_T2

Ask:

```
Given the task and these candidate terms,
select the 5–8 most relevant terms
and provide confidence percentages.
```

Output: a ranked, confidence-weighted list.

---

## 5.6 Packaging for EnaC Input
For each selected term:
- Include SCS_T1  
- Include SCS_T2 summary  
- Include **only relevant** SCS_T3 edges  
- Omit long-form definitions unless explicitly required

Target payload: **2–5k tokens**.

---

# 6. GRP Output Schema (Internal)

```
{
  "terms": [
    {
      "name": "...",
      "confidence": 0.91,
      "anchor": "...",
      "summary": "...",
      "related_selected": [
        {"term": "...", "relation": "..."}
      ]
    }
  ],
  "reasoning_summary": "...",
  "tier": "T3",
  "task_signature": "hash-of-query"
}
```

---

# 7. EnaC Integration

## 7.1 Tier-Adaptive Behavior
- Tier 3: Deep detail + graph edges  
- Tier 2: Moderate detail  
- Tier 1: Minimal anchors  

## 7.2 CORE-PRIMER & CFP Alignment
GRP ensures EnaC receives:
- Only relevant cognitive variables  
- In Tier-appropriate density  
- Without overflowing context limits  

## 7.3 Stability & Drift Prevention
- No dependency on model-side memory  
- Canonical Term Specs remain external  
- Graph expansion re-derived per task  

---

# 8. Version Metadata
Version: GRP v1.0  
Status: Canonical Protocol  
Generated for: Cash Myers  
Compatible with: EnaC, CFP, ECL, LTF, ATC  
Date: 2025-11-16
