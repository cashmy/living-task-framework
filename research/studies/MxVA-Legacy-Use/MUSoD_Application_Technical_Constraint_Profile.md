# Application / Technical Constraint Profile — MUSoD Informatics

## A. CSAC Header
- Artifact Type: ECL-BASE (technical surface)
- Restoration Role: Reconstructs system architecture, risks, and constraints
- Use: CSAC-Tier2 → project planning, modernization reasoning
- Stability Requirement: Update when core systems or DB schema change

---

# 1. System Overview

## 1.1 MUSoDDjango (Primary Application)
- Django 3.0.6, server-rendered templates (Views/Forms/Templates)
- MSSQL backend (v17–18), via django-mssql-backend + pyodbc
- API integrations with axiUm via ITS-managed endpoints
- Modules: Attendance, Clearing, Dashboard, EndoReferrals, ExternalScripts, ImplantBridge, MySimLab (reworked), Requests, Rounds, Tracking, Utilities
- New modules: AbsenceRequests (extracted from Attendance), ExternalRotations (greenfield)
- Deployment: On-prem Linux, NGINX + Gunicorn, shared repo between Prod/Sandbox

### Key Constraints
- Outdated Django version
- Manual settings per environment (no dynamic environment detection)
- Migration drift (manual edits to django_migrations)
- No CI/CD, no containerization
- Shared main branch for prod + sandbox
- No rollback or reproducible environment

---

## 1.2 ETL_Projects (Legacy ETL)
- Procedural ETL with year-duplicated scripts
- Section 1: Pulls data from axiUm and others → CSVs
- Section 2: Bulk SQL transformation
- Section 3: Python + PDF generation → protected/ folders
- Runtime: 4.5–5 hours nightly
- Extremely fragile; deciphering logic requires guesswork and intuition

### Key Constraints
- No modular architecture
- No orchestration layer (Airflow/Prefect/Dagster)
- No shared transformations; duplicated per academic year
- High technical debt and high error risk
- No data warehouse pattern

---

## 1.3 Phone_API (Secondary Application)
- Django 4.2.23, MSSQL backend via mssql-django
- Purpose: Appointment scheduling layer separate from axiUm
- Deployment/usage unclear; may not be live

### Key Constraints
- Unknown integration state
- Possible duplication of axiUm functionality
- Requires architectural archaeology

---

# 2. Infrastructure Constraints

## 2.1 Hosting
- On-prem Linux server (ITS-managed VM)
- NGINX + Gunicorn (ownership unclear)
- Manual SSL updates
- Manual deployments

## 2.2 Environment Management
- Dev, Sandbox, Prod share repo and often settings
- Manual toggles in settings.py variants
- Drift between DB schemas across environments
- No automated database snapshots

## 2.3 Ownership Boundary
- ITS: VM, disk, OS, memory, potentially axiUm DB/API
- Informatics: App deployment, Python env, SSL, Django stack
- Unclear: NGINX, Gunicorn, OS patching, server hardening

---

# 3. MxVA Boundary Surfaces

## 3.1 Stable Intent
- Maintain operational continuity for faculty/clinics
- Preserve semester-driven uptime requirements
- Ensure integration with axiUm remains stable

## 3.2 Hard Constraints
- Cannot change axiUm data model
- Cannot rewrite major systems in a single step
- Cannot break nightly ETL cycle
- Cannot disrupt assessment modules

## 3.3 Soft Constraints
- Settings improvements allowed cautiously
- Branch discipline improvements possible
- ETL improvements allowed if identical output maintained

---

# 4. Safe Evolution Paths

- Introduce settings/environment modularization
- Improve repository discipline (feature branches + controlled PR flow)
- Module-by-module MUSoDDjango modernization
- Build a shadow ETL system behind the scenes before cutover
- Add logging, monitoring, and local tests
- Introduce minimal containerization (pilot-first)
- Incrementally isolate prod/sand envs

---

# 5. Unsafe Evolution Paths

- In-place refactor of ETL_Projects
- Major Django version upgrades without a staged environment
- Replacing MSSQL backend
- Changing axiUm integration model
- Large-scale changes pushed during academic cycles
- Introducing new architectures without pre-briefing legacy authority