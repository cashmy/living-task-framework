# SCS — Term Specification v2.0

## 0. Metadata
- **Term ID:** scs-v2
- **Primary Name:** Semantic Compiler System
- **Version:** v2.0
- **Domain:** UCS Semantic Core
- **Status:** Active

---

## 1. Identity & Purpose

### 1.1 Identity
SCS is the **semantic compiler** for UCS.

### 1.2 Purpose
Transform TermSpecs and semantic bundles into **Tier‑specific meaning slices** ready for EnaC, LTF, and PW.

---

## 2. Definitions

### 2.1 Architecture Definition
SCS parses TermSpecs, processes SCS compiler blocks, applies Tier rules, adjusts semantic density, and produces structured meaning in T1/T2/T3 forms.

### 2.2 Human Definition
SCS turns raw concepts into clear explanations at the right level of detail.

---

## 3. Responsibilities

- Parse TermSpecs and compiler blocks  
- Compile meaning according to Tier rules  
- Apply meaning-weight, density modulation  
- Enforce EBP and cognitive constraints  
- Provide structured semantic slices to EnaC, LTF, PW  

---

## 4. Non‑Responsibilities

SCS must **not**:
- retrieve data (GlossRP)  
- create/evolve relationships (LTF)  
- generate artifacts (PW)  
- ingest captures (EchoForge)  
- store evolution history  

---

## 5. Inputs

- TermSpecs  
- semantic bundles from GlossRP  
- EBP configurations  
- Tier parameters  
- density constraints  

---

## 6. Outputs

- T1 semantic slices  
- T2 structured meaning  
- T3 expanded conceptual sets  
- EnaC-ready payloads  
- LTF-ready semantic inputs  

---

## 7. Relations to Other Systems

- **GlossRP:** supplies raw TermSpecs  
- **LTF:** consumes compiled slices for evolution  
- **PW:** consumes slices for artifact construction  
- **EnaCs:** direct downstream cognitive actors  

---

## 8. SCS Compiler Blocks

```SCS_T1
SCS turns raw TermSpecs into Tier-specific meaning slices.
```

```SCS_T2
SCS is the semantic compiler that parses TermSpecs, applies Tier and density rules, and produces structured cognitive-ready meaning for EnaCs, PW, and LTF.
```

```SCS_T3
- SCS <- GlossRP [input: TermSpecs, raw relationships]
- SCS -> EnaC [output: Tier-shaped meaning]
- SCS -> LTF [output: structured semantic content]
- SCS -> PW [output: formatted meaning blocks]
- SCS !> retrieval [constraint]
- SCS !> relationship creation [constraint]
```
