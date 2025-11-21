# MUSoD Shadow Modernization Playbook — Technical Edition (v1.0)

## Purpose
Provide a practical, detailed modernization roadmap tailored to MUSoD’s specific cultural, organizational, and technical constraints.

---

## 1. MUSoD Technical Environment Overview

### MUSoDDjango
- Django 3.0.x
- Views/Forms/Templates architecture
- MSSQL backend
- NGINX + Gunicorn deployment
- Environment drift between sandbox and production
- No formal CI/CD

### ETL_Projects
- Legacy SQL-heavy pipeline
- 4.5–5 hour nightly process
- Per-year duplicated script directories
- High maintenance cost
- Fragile structure

### Phone_API
- Django-based
- Partially deployed
- Unclear long-term role

---

## 2. Guiding Philosophy: MxVA (Minimum Viable Architecture)
- Only modernize what is necessary.
- Prefer reversible steps.
- Preserve behavior unless explicitly changed.
- Shadow-first approach to major redesigns.

---

## 3. MUSoDDjango Modernization Strategy

### 3.1 Internal Cleanup
- Consolidate logic within modules.
- Extract reusable utilities.
- Minimize duplicated code.
- Document legacy assumptions.

### 3.2 Configuration Stabilization
- Reduce multiple settings.py copies.
- Introduce safe branching structure.
- Add light pre-deploy checks.

### 3.3 Upgrade Path
- Create isolated dev sandbox.
- Test Django 3.2/4.x upgrades without user exposure.
- Maintain backward compatibility.

---

## 4. ETL Modernization Strategy: ETL2

### 4.1 Why ETL1 Cannot Be Refactored
- Structural fragility.
- Volume of legacy assumptions.
- High regression risk.

### 4.2 ETL2 Design Principles
- Pure-function transformations.
- SQL extraction isolation layer.
- Strong logging and traceability.
- Config-driven processing.
- One-script-per-domain structure.

### 4.3 Parallel Run & Parity Verification
- Run ETL1 and ETL2 concurrently.
- Compare outputs for at least one academic cycle.
- Implement automatic diff checks.

### 4.4 Safe Cutover
- Only after 100% parity.
- Faculty sees zero changes.
- Performance improvements optional.

---

## 5. Deployment & Environment Improvements

### 5.1 Environment Separation
- Introduce a settings pattern: base.py, prod.py, sandbox.py
- Remove manual environment toggles.

### 5.2 Deployment Reliability
- Add pre-deploy validation.
- Use Git branches to contain experimental code.
- Prevent production drift through light automation.

### 5.3 Incremental CI
- Start with:
  - Linting
  - Syntax checks
  - Basic tests

---

## 6. Phone_API Roadmap
- Clarify purpose (replacement vs extension of axiUm scheduling).
- Define data contract boundaries.
- Identify integration patterns.
- Prepare for phased expansion.

---

## 7. Data & Reporting Improvements
- Migrate custom reports into defined structures.
- Reduce duplicated SQL queries.
- Introduce metadata layer for dashboard generation.

---

## 8. Security & Compliance Considerations
- HIPAA considerations for data access.
- FERPA for academic records.
- Avoid unnecessary exposure of clinical data.
- Ensure secure handling between Django and ETL systems.

---

## 9. Year-by-Year Technical Roadmap

### Year 1 (Stabilization)
- Document key modules.
- Add runtime logging.
- Begin ETL2 planning.
- Clean up MUSoDDjango structure.

### Year 2 (Shadow Integration)
- Build ETL2 core engine.
- Test Django upgrade in sandbox.
- Improve deployment safety.

### Year 3 (Refinement)
- Parity test ETL2.
- Introduce automated checks.
- Gradually refactor modules.

### Year 4 (Selective Cutover)
- Deploy ETL2 based on parity.
- Map long-term upgrades.
- Finalize modernization pivot.

---

## 10. Developer & Team Enablement
- Use micro-refactoring practices.
- Capture design decisions using STGM.
- Provide onboarding materials.
- Distribute the Technical Edition internally.

---

## 11. Summary
This playbook provides a safe, incremental modernization strategy aligned with MUSoD’s culture, constraints, and mission. It enables technical evolution without operational disruption.