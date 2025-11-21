# MUSoD Modernization Support Plan — One Page (v1.0)
### (Optimized for T.W. — Visual, Simple, Operational)

---

## 1. Current System Strengths (Green)
- Long-term stability
- Faculty workflows unchanged
- Reliable Django + ETL pipeline
- Deep institutional knowledge
- Predictable semester-cycle behavior

---

## 2. Emerging Support Challenges (Yellow)
- Prod/Sandbox environment differences requiring manual fixes
- ETL runtime increasing (4.5–5+ hrs)
- Year-to-year SQL complexity growth
- Longer debugging due to scale
- Rising data and reporting demands

---

## 3. Low-Risk Improvements (“Easy Wins”) — Blue
- Clearer environment separation
- Light logging for runtime + errors
- Small Django internal cleanups
- Document top fragile ETL steps
- Add pre-deployment checks

*Outcome: fewer surprises, smoother updates.*

---

## 4. Mid-Term Enhancements (Unobtrusive) — Teal
- Build simplified parallel ETL version (no workflow changes)
- Organize duplicated SQL logic gradually
- Internal module refactors only
- Improve onboarding readiness

*Outcome: lower long-term workload.*

---

## 5. Long-Term Stability Prep — Grey
- Shadow ETL replacement path
- Prepare safe Django upgrade environment
- Clarify Phone_API future role

*Outcome: protects existing architecture while preparing for future.*

---

## 6. Guiding Principle
**All changes maintain current workflows and system stability — zero disruption.**