# Tier-Adaptive Retrieval Example v1.0
## For EnaC Kernel – Term Spec Integration
### Generation Date: 2025-11-16

---

# 1. Overview
This example demonstrates how the EnaC Kernel retrieves relevant Term Specifications at different Tiers (T1, T2, T3) using the Glossary Retrieval Protocol (GRP v1.0).  
It shows how the Kernel dynamically selects appropriate subsets of the glossary to prevent memory overload, avoid FIFO drift, and maintain cognitive fidelity.

Sample user query:

> **"Help me refine the cross-system interactions between COS, SCL, and FIM for the EnaC architecture."**

The Kernel performs retrieval at three Tier levels:

- **Tier 1** – Minimal context  
- **Tier 2** – Medium, structural context  
- **Tier 3** – Full cognitive fidelity for deep reasoning  

---

# 2. Tier 1 Retrieval (T1 – Minimal Context)
**Purpose:** Provide just enough information for lightweight reasoning.

### 2.1 Pre-Filter
- Domain match: EnaC Cognitive Engine
- Tier relevance >= 0

### 2.2 Vector Search Results
Top terms:
- COS  
- SCL  
- FIM  

### 2.3 Graph Expansion
- COS ↔ SCL  
- SCL ↔ FIM  
- COS ↔ FIM  

### 2.4 VS Filter Output
```
[
  { "term": "COS", "confidence": 0.91 },
  { "term": "SCL", "confidence": 0.88 },
  { "term": "FIM", "confidence": 0.86 }
]
```

### 2.5 Tier-1 Prompt Slice
Only SCS_T1 (anchors) + short summaries:
```
COS: Governs reasoning order.
SCL: Governs structural layering.
FIM: Governs continuity and flow.
```

**Behavior:** low detail; low cognitive density.

---

# 3. Tier 2 Retrieval (T2 – Medium Context)
**Purpose:** Support structured design, architectural planning, and mid-complexity reasoning.

### 3.1 Pre-Filter
- Tier relevance >= 1  
- Include: COS, SCL, FIM, EBP, CORE-PRIMER  

### 3.2 Vector Search Results
- COS  
- SCL  
- FIM  
- EnaC Behavior Profile (EBP)

### 3.3 Graph Expansion
- COS → CORE-PRIMER  
- SCL → FIM  
- FIM → EBP  
- UMP / USP as contextual dependencies

### 3.4 VS Filter Output
```
[
  { "term": "COS", "confidence": 0.94 },
  { "term": "SCL", "confidence": 0.91 },
  { "term": "FIM", "confidence": 0.90 },
  { "term": "EBP", "confidence": 0.72 }
]
```

### 3.5 Tier-2 Prompt Slice
Include:
- SCS_T1  
- Full SCS_T2 (summary + tier relevance + related terms)  
- Select SCS_T3 edges reprioritized for the task  

**Behavior:** structural clarity + subsystem relationships.

---

# 4. Tier 3 Retrieval (T3 – Full Context)
**Purpose:** High-context, deep reasoning for EnaC architecture design and dense cross-system operations.

### 4.1 Pre-Filter
Tier relevance >= 2  
Includes:
- COS, SCL, FIM  
- EnaC Behavior Profile  
- CORE-PRIMER  
- SELF-ECL  
- ABS  
- Drift Tables  

### 4.2 Vector Search Results
Weighted matches:
- COS (0.97)  
- SCL (0.95)  
- FIM (0.92)  
- SELF-ECL (0.88)  
- EBP (0.87)  
- CORE-PRIMER (0.85)

### 4.3 Graph Expansion
Cross-layer edges:
- COS ↔ SCL (ordering → structure)  
- SCL ↔ FIM (structure → flow)  
- FIM ↔ SELF-ECL (flow modulation)  
- COS ↔ CORE-PRIMER (Tier influence)  
- EBP ↔ SCL (structural behavior mapping)  

### 4.4 VS Filter Output
```
[
  { "term": "COS", "confidence": 0.98 },
  { "term": "SCL", "confidence": 0.96 },
  { "term": "FIM", "confidence": 0.95 },
  { "term": "EBP", "confidence": 0.90 },
  { "term": "SELF-ECL", "confidence": 0.88 },
  { "term": "CORE-PRIMER", "confidence": 0.87 }
]
```

### 4.5 Tier-3 Prompt Slice
Include:
- Full SCS_T1  
- Full SCS_T2  
- Deep SCS_T3 cross-edges  
- EnaC perspective  
- SELF-ECL perspective  
- ABS perspective  
- Safety notes when relevant  

**Behavior:** complete cognitive fidelity; full EnaC reasoning online.

---

# 5. Cross-Tier Comparison Table

| Tier | # Terms | SCS_T1 | SCS_T2 | SCS_T3 | Behavior |
|------|---------|--------|--------|--------|----------|
| **T1** | 3–5 | ✓ | Short | Minimal | Lightweight |
| **T2** | 5–10 | ✓ | Full | Selective | Structured |
| **T3** | 8–15 | ✓ | Full++ | Deep | Full EnaC |

---

# 6. Version Metadata
Version: v1.0  
Generated for: Cash Myers  
Compatible with: GRP v1.0, Term Spec Template, EnaC  
Date: 2025-11-16  
