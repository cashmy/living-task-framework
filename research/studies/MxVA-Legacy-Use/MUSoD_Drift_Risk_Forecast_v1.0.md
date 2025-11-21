
# Drift-Risk Forecast — MUSoD Informatics (v1.0)

## CSAC Header
- Artifact Type: ECL-BASE Risk Analysis
- Function: Forecast degradation patterns, failure surfaces, and systemic drift
- Use Cases: Leadership insight, modernization prioritization, EnaC risk navigation
- Stability: Update whenever system architecture or workflows materially change

---

# 1. Executive Drift Summary

MUSoD Informatics is **stable by habit, not by design**.  
The environment will continue functioning—until a failure vector is triggered.  
The underlying drift pattern shows *increasing brittleness* across all layers:

- Organizational drift: slow decision cycles lead to tech stagnation.  
- Team drift: knowledge concentration risks single-point failure.  
- Technical drift: outdated systems accumulate invisible fragility.  
- ETL drift: exponential risk increase with each new academic year.  
- Deployment drift: manual steps create configuration entropy.

**Without corrective action, the system will fail predictably, not suddenly.**

---

# 2. Drift Surface Breakdown

## 2.1 MUSoDDjango Drift Vectors

### Current Stability:
Moderate but fragile.

### Drift Causes:
- Outdated Django version.
- Manual settings management.
- Migration table manipulation.
- No reproducible environments.
- No DevOps orchestration.

### 12–24 Month Drift Prediction:
- Increased migration failures.
- Higher risk of untracked schema divergence.
- Growing dependency mismatch hazards.
- Difficulty onboarding new developers.

### Long-Term Failure Mode:
**Schema drift** leading to partial database corruption or failed migrations during high-stakes academic cycles.

---

## 2.2 ETL_Projects Drift Vectors

### Current Stability:
Stable only due to unchanging structure.

### Drift Causes:
- Duplication of year-by-year pipelines.
- SQL logic divergence.
- CSV → SQL → PDF multi-step fragility.
- 4.5–5 hour runtime limits scalability.
- Near-zero observability.

### 12–24 Month Drift Prediction:
- Runtime may exceed daily cycle limits.
- Silent logic inconsistencies accumulate.
- Output accuracy may degrade year-over-year.

### Long-Term Failure Mode:
**ETL collapse**—multi-hour failure leading to missing daily analytics.

This is the **highest-risk subsystem**.

---

## 2.3 Phone_API Drift Vectors

### Current Stability:
Unknown; potentially unused.

### Drift Causes:
- Unclear deployment.
- Possible duplication of axiUm features.
- Untended subsystem risk.

### 12–24 Month Drift Prediction:
- Divergence from main system architecture.
- Increasing code rot.
- Security vulnerability risk.

### Long-Term Failure Mode:
**Shadow-system failure** or security exposure if left unmaintained.

---

# 3. Infrastructure Drift Vectors

## 3.1 DevOps / Environment Drift
- Shared repo → environmental drift grows.
- Manual settings → config breakage risk.
- Manual deploys → human error.
- No snapshots → irreversible failures possible.

### Failure Mode:
**Configuration entropy** leading to environment divergence that blocks deployments.

---

## 3.2 AxiUm-Related Drift
- axiUm updates may invalidate assumptions.
- Read-only integration masks upstream changes.
- ITS-side updates may break API logic.

### Failure Mode:
**Integration drift** where Django or ETL logic no longer matches upstream realities.

---

# 4. Organizational Drift Factors

## 4.1 Cultural Drift
- Fear-based change resistance grows with time.
- Team aging increases knowledge bottlenecks.
- Slow decision cycles widen the modernization gap.

### Failure Mode:
**Institutional paralysis** where technical debt outpaces capability to correct it.

---

## 4.2 Knowledge Drift
- Legacy expert dependency (T.W.).
- Minimal documentation.
- No reproducible onboarding path.

### Failure Mode:
**Single-point cognitive failure** if key personnel retire, move, or shift roles.

---

# 5. Drift Timeline Forecast

### 0–12 Months:
- More migration friction.
- Higher ETL runtime variability.
- Growing environment divergence.

### 12–24 Months:
- First ETL correctness failures likely.
- Missing analytics triggers operational stress.
- Security risks accrue in Phone_API.

### 24–48 Months:
- Major architecture breakage possible.
- High-probability ETL replacement emergency.
- Significant modernization crisis.

---

# 6. Critical Drift Surfaces (Highest Risk)

1. **ETL_Projects — structural degradation**  
2. **Environment drift — migration + settings divergence**  
3. **Knowledge bottleneck — legacy expert dependency**  
4. **Integration drift with axiUm**  
5. **DevOps fragmentation — increasing manual error incidence**

---

# 7. Strategic Drift Mitigation Recommendations

### Immediate (0–6 Months)
- Introduce settings modularization.
- Add migration sanity checks.
- Add minimal logging to Django + ETL.

### Mid-Term (6–18 Months)
- Build ETL2 shadow system.
- Clean Django modules incrementally.
- Improve repo discipline.

### Long-Term (18–48 Months)
- Replace ETL legacy pipeline fully.
- Containerize environments.
- Modernize Django stack in shadow.

---

# 8. Meta-Drift Interpretation

The drift is not caused by incompetence, but by:
- institutional structure  
- resource scarcity  
- legacy patterns  
- siloed authority  
- fear of breakage  
- low modernization absorption capacity  

Drift will continue until:
- stabilization measures are taken  
- modernization is made invisible  
- replacement systems are built in parallel  

MxVA interpretation:
> Drift is a trajectory, not an event.  
> And MUSoD is already on that trajectory.

