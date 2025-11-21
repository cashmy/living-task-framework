# MUSoD Shadow Modernization Playbook — Executive Edition (v1.0)

## Purpose
This document provides a high-level modernization strategy for the Marquette University School of Dentistry (MUSoD) information systems. It emphasizes stability, safety, predictability, and operational continuity while enabling a gradual modernization path aligned with institutional realities.

---

## 1. MUSoD Operational Reality
- Hybrid academic-medical environment.
- Semester-driven operational cycles (Spring, Summer, Fall).
- Highly risk-averse culture.
- Decisions require incremental consensus.
- Faculty-driven requirements evolve continuously.
- Core systems must remain stable and predictable.

---

## 2. Why a “Shadow Modernization” Strategy
Shadow Modernization is a parallel approach that upgrades systems without disrupting daily operations. Its benefits include:
- Zero downtime for faculty and clinics.
- No disruptions to existing workflows.
- Ability to test improvements before replacement.
- Predictable, low-risk adoption.
- Reduced burden on the Informatics team.

---

## 3. Key System Areas
### MUSoDDjango
Main system for assessment tracking. Needs:
- Internal cleanup
- Better maintainability
- Long-term update planning

### ETL_Projects
Legacy data-processing system. Needs:
- Parallel replacement (ETL2)
- Regression parity testing
- Predictable nightly performance

### Phone_API
Emerging system. Needs:
- Role clarity
- Integration alignment

---

## 4. Guiding Principles
- Stability over novelty.
- Incremental improvements only.
- Zero disruption to faculty or students.
- Invisible changes first.
- Shadow systems for major redesigns.
- Align modernization with academic cycles.

---

## 5. The Modernization Roadmap

### Phase 1: Stabilize (0–12 months)
- Improve documentation.
- Clean up MUSoDDjango internals.
- Add basic logging.
- Map ETL2 requirements.
- Assess Phone_API status.

### Phase 2: Quiet Modernization (12–24 months)
- Construct ETL2 pipeline in parallel.
- Unify environmental settings.
- Improve sandbox/production safety.
- Gradually introduce Django upgrades internally.

### Phase 3: Transform via Shadow (2–4 years)
- Replace ETL1 with ETL2 after parity achieved.
- Begin adopting Django upgrades.
- Introduce light CI mechanisms.
- Refactor long-standing modules.

---

## 6. Risks & Mitigation
- **Risk:** Faculty disruption  
  **Mitigation:** All changes remain invisible to end users.

- **Risk:** Institutional resistance  
  **Mitigation:** Incremental, low-risk, academically aligned changes.

- **Risk:** Technical debt accumulation  
  **Mitigation:** Shadow replacement and long-term planning.

---

## 7. Benefits to MUSoD
- Lower operational risk.
- More predictable software behavior.
- Reduced dependency on individuals.
- Faster onboarding for new staff.
- Better alignment with university technology goals.

---

## 8. Summary for Leadership
This modernization strategy prioritizes MUSoD’s mission: continuity of education and clinical care. By modernizing quietly and safely, MUSoD strengthens its technological foundation without risking its operational stability.

**Shadow Modernization = Progress without disruption.**