
# Organizational Insight Matrix — Marquette University School of Dentistry (MUSoD)

## A. CSAC Header (Environment Context Layer)
- Artifact Type: ECL-BASE Environmental Context Map
- Intended Use: CSAC-Tier2 → Project CIP → Organizational Context
- Restoration Role: Reconstructs MUSoD’s operational, cultural, and governance constraints for EnaC
- Stability Requirement: Update only upon major organizational shifts (leadership change, governance restructuring, or major IT‑Ops integration)

---

## B. MxVA Header (Evolution Boundary Anchor)
- Function: Defines MUSoD’s permissible change boundaries and evolution tolerance
- MxVA Use: Derive stable intent from faculty and leadership; constrain implementation paths to safe, incremental, low-disruption changes
- Interpretation Rule: Faculty requests = raw intent signals, not architectural definitions

---

## C. ECL Header (BASE Mapping)
- Vertical Layer: ECL-BASE (environment expression)
- Horizontal Vectors Captured: governance, awareness, flexibility, definition mode
- Transformation Rule: Narrative inputs should be transformed into BASE-level vectors for EnaC reasoning

---

## D. EnaC Behavior Header (Interpretation & Drift Rules)
- Posture: Architect Mode + Cultural Interpreter Mode
- Inference: High inference allowed (80%+)
- Drift Watch: legacy influence, faculty requirement inflation, Ops delays, silo reactivity
- Compression: Disabled (retain nuance)

---

# 1. Raw Narrative Context (Provided)
MUSoD is a hybrid medical–academic institution within Marquette University, under Jesuit/Catholic values.  
It comprises 5 internal clinics serving the public and training students.  
The academic year (Spring, Summer, Fall) heavily dictates decision pace.  
Decision-making is slow and hierarchical, sometimes very slow at higher levels.  
Financial/HR decisions are constrained and influenced by student market competition.  
Tech aspirations exist but execution is slow, conservative, and risk-averse.  
ITS serves as Ops; Informatics as Dev, with incomplete handoffs.  
Past Director holds strong technical authority, though semi-retired.  
Faculty generate many requests, often complex, exhaustive, and outcome-oriented.  
Technical environment is very outdated; upgrades not permitted.  
Silos exist with variable severity depending on context.

---

# 2. Structured Organizational Insight Matrix (EnaC-Generated)

## 2.1 Governance Signals
- Leadership Structure:
  - University CIO (highest authority, rarely invoked locally)
  - Dean of MUSoD (school-level authority)
  - Faculty/Clinic Directors (operational request drivers)
  - Past Director of Informatics (dominant technical influencer)
  - Associate Dean (administrative oversight)
  - New Associate Director (bridge between ITS and Informatics)
- Decision-Making Model:  
  Slow, hierarchical, academically timed; high approval inertia.
- Approval Bottlenecks:
  - Movement up authority chain
  - ITS Dev/Ops separation
  - HR-driven constraints
  - Faculty procedural cycles
- Change Tolerance:
  Very low; conservative, risk-averse culture.
- Hidden Rules:
  - Technical change is dangerous unless faculty-driven.
  - Legacy authority (Past Director) overrides formal structure.
  - Semester timing dictates feasibility of implementation.

---

## 2.2 ECL-H Vectors
- Flexibility: **Rigid → Bounded**  
- Governance Mode: **Prescriptive (risk-focused) with Principle-Based overlay (Jesuit values)**
- Awareness: **Self → Local (faculty, clinics)**
- Definition Mode: **End-result oriented; non-systemic, non-UX-aware**

---

## 2.3 Cultural Constraints (MxVA-Relevant)
- Stability Requirements:
  - Systems must not disrupt clinics or academic workflow.
  - Avoid changes during key semester periods.
- Forbidden Changes:
  - Major version upgrades
  - Cross-system refactors involving ITS without strong justification
- Required Legacy Compatibilities:
  - Un-upgraded Python version
  - Legacy workflows tied to long-standing faculty practices
- Risk Boundaries:
  - External integrations (HIPAA concerns)
  - Non-University-managed systems

---

## 2.4 Power Structures & Political Dynamics
- Key Influencers:
  - Past Director (technical gatekeeper)
  - Faculty Directors (procedural authority)
  - Dean (strategic authority)
  - CIO (oversight, not daily operations)
- Resistance Areas:
  - Faculty resistance to workflow optimization
  - ITS reluctance to engage in modernization
- Historical Trauma:
  - Evidence of failed or disrupted modernization attempts
  - General institutional memory of instability during changes
- Territorial Sensitivities:
  - ITS–Informatics boundaries
  - Faculty ownership of assessment processes

---

## 2.5 Organizational Evolution Tolerance
- Safe Changes:
  - Incremental workflow improvements
  - Hidden backend optimizations
  - UI/UX simplifications aligned to faculty goals
- Unsafe Changes:
  - Major refactors
  - System rewrites
  - Structural changes requiring ITS coordination
- Long-Term Potential:
  - High (with new Associate Director)
  - Transition phase expected to last 1–2 years

---

# 3. EnaC Operational Guidance
- Output Framing:
  Use stewardship, student-benefit, and academic mission framing.
- Required Abstraction Level:
  Mid → High; hide architectural complexity.
- Incrementalism:
  Very high; propose only reversible, low-disruption changes.
- Communication Mode:
  Diplomatic, faculty-aligned, low-jargon.
- Architecture Exposure Limits:
  Avoid challenging past-director authority; adapt to legacy systems.

---

# 4. MxVA-Compatible Boundary Surface

## Stable Intent (Org-Level):
- Enhance student assessment
- Maintain clinic stability
- Improve tracking/documentation
- Support academic excellence
- Reduce faculty workload (even if not explicitly stated)

## Fixed Constraints:
- Outdated tech stack
- Academic timing
- Risk-averse leadership
- Legacy authority structures
- Compliance constraints (HIPAA/FERPA)

## Flexible Regions:
- Faculty-driven workflows
- Small UX improvements
- Backend automation invisible to users
- Reporting enhancements

## Permitted Evolution Paths:
- Incremental modernizations
- Shadow-layer architectures
- Additive interfaces
- Non-invasive augmentation

## Prohibited Evolution Paths:
- Core rewrites
- Full-stack upgrades
- Cross-department refactor dependencies
- Any change causing clinic downtime
