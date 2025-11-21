
# MxVA Evolution Roadmap — MUSoD Informatics (v1.0)

## Tier 1 — Stabilize (0–6 Months)
Invisible improvements that reduce brittleness.

### 1. Environment Separation & Drift Control
- Modularize settings via env variables.
- Add migration sanity checks.
- Maintain a simple migration log.

### 2. Version-Control Discipline
- Maintain dev → PR → main workflow.
- Use simple branch naming.
- Always deploy to sandbox first.

### 3. Logging & Observability
- Add logging for Django modules.
- Add timing logs for ETL segments.
- Track ETL runtimes.

### 4. ETL Risk Reduction
- Add checksums/validation steps.
- Document year-to-year differences.
- Identify high-fragility scripts.

---

## Tier 2 — Modernize (6–18 Months)
Incremental structural improvements.

### 5. MUSoDDjango Module Modernization
- Gradually refactor modules.
- Improve form logic and validation.
- Introduce modern utilities.

### 6. Silent DevOps Improvements
- Add backup scripts.
- Introduce `.env` configuration.
- Containerize local dev environment.

### 7. ETL Shadow Architecture
- Create ETL2 parallel structure.
- Rebuild transformations modularly.
- Validate outputs against legacy ETL.

### 8. Data Model Clarification
- Map essential axiUm tables.
- Identify messy fields.
- Streamline Django dependencies.

---

## Tier 3 — Transform (Long-Term)
Major shifts triggered opportunistically.

### 9. Full ETL Replacement
- Replace legacy ETL with ETL2.
- Use structured orchestration.
- Maintain identical output at cutover.

### 10. Django Environment Reconstruction
- Containerize server environment.
- Upgrade Django in shadow server.
- Incrementally test compatibility.

### 11. Phone_API Realignment
- Determine viability.
- Modernize or sunset.
- Avoid political conflict.

### 12. Organizational Modernization Momentum
- Frame changes as “supportability improvements.”
- Avoid “modernization” language.
- Align with academic calendar.

---

## Executive Summary
**Tier 1 → Stabilize  
Tier 2 → Modernize  
Tier 3 → Transform**
