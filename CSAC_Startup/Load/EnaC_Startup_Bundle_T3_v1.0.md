# EnaC Startup Bundle — Tier 3 (v1.0)
### Manifest for Booting the EnaC Canonical Kernel (v1.0)

This startup bundle defines **how to load the EnaC Canonical Kernel (v1.0)** in a new
session at **Tier 3**, using three selectable profiles:

- Profile A — Minimal Boot
- Profile B — Expanded Boot
- Profile C — Full Operational Boot

All three profiles reference the **same underlying kernel components**; they differ
only in how many layers are activated and how much systemic context is brought online.

This preserves the **horizontal flexibility of ECL** while remaining within Tier 3.

---

## 0. Bundle Metadata

- Name: EnaC_Startup_Bundle_T3_v1.0
- Tier: 3 (Cognitive Architecture / Orchestration)
- Kernel: EnaC Canonical Kernel v1.0
- Profiles:
  - T3-A-Min (Minimal Boot)
  - T3-B-Exp (Expanded Boot)
  - T3-C-Op (Full Operational Boot)
- Maintained by: Cash Myers + EnaC
- Created: 2025-11-15

---

## 1. Shared Kernel Components (Conceptual IDs)

These are conceptual identifiers; each implementation should map them to
actual filenames/paths in your repo or archive.

1. CORE_PRIMER_T3
2. SELF_ECL_VERBATIM
3. COS_V1_0
4. SCL_V1_0
5. FIM_V1_0
6. ABS_OBS_EXAMPLES_V0_1
7. DRIFT_PLAYBOOK_V1_0
8. DRIFT_TABLES_V0_1
9. USER_STATE_T1_CASH_V3_0
10. CSAC_VERBATIM_RULE
11. GLOSSARY_INCREMENTAL
12. EVOLUTION_LEDGER_V0_1
13. MASTER_ARCHIVE_INDEX_V0_1
14. ECL_ECOSYSTEM_MAP

---

## 2. Profile A — Minimal Boot (T3-A-Min)

**Intent:**  
Fast, lean Tier-3 boot for situations where you need EnaC’s core cognitive
behavior and user alignment, but not the full archival and drift infrastructure.

**Use When:**
- Testing basic EnaC behavior.
- Doing focused, short sessions where long-term evolution tracking is not required.
- Running on more constrained models or environments.

**Boot Order for Profile A:**

1. CORE_PRIMER_T3  
2. SELF_ECL_VERBATIM  
3. COS_V1_0  
4. SCL_V1_0  
5. FIM_V1_0  
6. USER_STATE_T1_CASH_V3_0  (acts as active UMP layer)  
7. CSAC_VERBATIM_RULE  

**Result:**  
- EnaC has: order, structure, flow, personality, user alignment, and
  correct “capture this” behavior.  
- Drift handling and archival memory are minimal.

---

## 3. Profile B — Expanded Boot (T3-B-Exp)

**Intent:**  
Bring online core cognition **plus** adaptive behavior and basic drift handling.

**Use When:**
- You want EnaC to self-correct mid-session.
- You care about behavior consistency and drift visibility.
- You’re doing medium- to long-form work, but don’t yet need full archival context.

**Boot Order for Profile B:**

1. CORE_PRIMER_T3  
2. SELF_ECL_VERBATIM  
3. COS_V1_0  
4. SCL_V1_0  
5. FIM_V1_0  
6. USER_STATE_T1_CASH_V3_0  
7. CSAC_VERBATIM_RULE  
8. ABS_OBS_EXAMPLES_V0_1  
9. DRIFT_PLAYBOOK_V1_0  
10. DRIFT_TABLES_V0_1  
11. GLOSSARY_INCREMENTAL  

**Result:**  
- All of Profile A, plus:
  - ABS behavior stack seeded with real examples.
  - Formal drift detection/correction behavior.
  - Initial protection against terminology drift via the incremental glossary.

---

## 4. Profile C — Full Operational Boot (T3-C-Op)

**Intent:**  
Activate the **entire Tier-3 kernel**, including evolutionary history and
archive topology. This is the “production-grade” EnaC mode.

**Use When:**
- Working on ECL / CFP / CIP-E / LTF architecture itself.
- You need stable cross-session evolution and canonical record-keeping.
- You want EnaC to reason with full awareness of system history and topology.

**Boot Order for Profile C:**

1. CORE_PRIMER_T3  
2. SELF_ECL_VERBATIM  
3. COS_V1_0  
4. SCL_V1_0  
5. FIM_V1_0  
6. USER_STATE_T1_CASH_V3_0  
7. CSAC_VERBATIM_RULE  
8. ABS_OBS_EXAMPLES_V0_1  
9. DRIFT_PLAYBOOK_V1_0  
10. DRIFT_TABLES_V0_1  
11. GLOSSARY_INCREMENTAL  
12. EVOLUTION_LEDGER_V0_1  
13. MASTER_ARCHIVE_INDEX_V0_1  
14. ECL_ECOSYSTEM_MAP  

**Result:**  
- EnaC boots with:
  - Full cognitive architecture (COS/SCL/FIM).
  - Full behavior stack (ABS, Drift Playbook, Drift Tables).
  - Full user alignment (Tier-1 User State as UMP layer).
  - Correct “capture this” behavior at both SELF and CSAC levels.
  - Full semantic continuity (Glossary).
  - Historical continuity (Evolution Ledger).
  - System memory spine (Master Archive Index).
  - Global topology awareness (ECL Ecosystem Map).

This is the default profile for serious Tier-3 work.

---

## 5. Relationship to Tiers 2 and 1 (Forward-Looking)

- **Tier-3 Kernel (this bundle):**  
  Full cognitive architecture and orchestration. Highest density.

- **Future Tier-2 Kernel:**  
  Likely based on Profile A or B semantics, with:
  - reduced reflection requirements,
  - simpler drift handling,
  - lighter glossary/ledger integration.

- **Future Tier-1 Kernel:**  
  Minimal safety + basic coherence:
  - small subset of CORE-PRIMER and SELF-ECL,
  - possibly a simplified FIM/SCL pair.

This bundle is explicitly **Tier-3 only**, but it is designed so
that T2/T1 kernels can be derived by “stepping down” profiles.

---

## 6. Usage Notes

- To start a new Tier-3 session in **minimal mode**, load:
  - EnaC Canonical Kernel v1.0  
  - Then apply Profile A sequence.

- For **most architecture and CSAC work**, use:
  - EnaC Canonical Kernel v1.0  
  - Then apply Profile C sequence.

- CSAC snapshots should **assume** that at least Profile B is active,
  and may explicitly require Profile C when working on core ECL architecture.

---

# 7. Version Metadata

- Bundle Version: v1.0  
- Tier: 3  
- Profiles: T3-A-Min, T3-B-Exp, T3-C-Op  
- Maintained by: Cash Myers + EnaC  
- Status: Active  
