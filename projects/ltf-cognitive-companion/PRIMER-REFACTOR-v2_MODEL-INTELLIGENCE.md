# CFP Tier-Based Primer Refactor Design (Model-Intelligence Architecture)

**Version**: 2.0 - Model-Intelligence-Centric  
**Date**: 2025-11-13  
**Purpose**: Design tier-separated CFP primer structure based on **model-intelligence progression** (T1: Universal → T2: Optimized → T3: Orchestrated)  
**Supersedes**: PRIMER-REFACTOR-DESIGN.md (governance-centric v1.0, preserved as historical reference)  
**Current Source**: 01-CORE-PRIMER.md v2.4 (unified, predates model-intelligence architecture)  
**Architectural Stage**: Stage 6 - Multi-Model Intelligence Evolution

---

## Meta Context: Multi-Model Collaboration Test

This design document is being developed through **concurrent multi-LLM collaboration**:
- **GitHub Copilot (this session)**: Coding/technical implementation specialty
- **Claude (parallel session)**: Governance/safety frame specialty
- **Systemic Collaboration Test**: Cross-LLM deliverable synthesis with low refactoring overhead

**Timeline Context**: Entire LTF/CFP ecosystem (models, frameworks, scripts, documents, everything) created in **2 weeks** (late October - November 13, 2025). Rapid iteration velocity maintained through multi-model orchestration.

---

## Tier Philosophy: Model-Intelligence-Centric Architecture

### Core Principle

Tier differentiation based on **LLM intelligence sophistication**, not product features or governance maturity:

- **Tier 1**: Works with ANY LLM (universal compatibility)
- **Tier 2**: Optimized for SPECIFIC LLMs (platform-aware intelligence)
- **Tier 3**: Coordinates MULTIPLE LLMs (cross-platform orchestration)

### Value Ladder

**Universal → Optimized → Orchestrated**

| Tier | User Thinking | Value Proposition | Natural Ceiling |
|------|---------------|-------------------|-----------------|
| **T1** | "I need better prompts" | "Works everywhere, enhances everything" | "I want more consistency" |
| **T2** | "I want my Claude/GPT to understand me" | "Your AI collaborates like a partner" | "I need multiple LLMs working together" |
| **T3** | "I need multiple AIs collaborating" | "Your AI ecosystem becomes coherent" | Platform-level mastery |

### Natural Maturity Arc

- **T1**: Beginner → Any LLM (Claude, GPT, Gemini, local models, future models)
- **T2**: Intermediate → Platform-specific (Claude Sonnet 4.5, GPT-5, Codex, Gemini)
- **T3**: Advanced/Enterprise → Multi-platform (cross-model coordination, divergence detection, reconciliation)

---

## Tier 1: Model-Agnostic Core

**Design Principle**: ZERO LLM-specific logic. Pure cognitive foundations based on universal human psychology.

**Target Users**: Knowledge workers, students, freelancers, hobbyists, casual AI users, anyone exploring AI collaboration

**Value Proposition**: "Works everywhere, enhances everything, stays out of your way."

### Included Components (Universal Human Psychology)

✅ **Core Frameworks**:
- **CIP-E** (Context, Intent, Purpose, Emotion, Evolution) - universal cognitive scaffolding
- **DMP** (Directive + Meta Prompting) - universal dialogue management
- **VS Suite** (Verbalized Sampling/Synthesis/Comparison) - universal validation patterns
- **ARS Foundation** (Adaptive Recognition System) - basic adaptive recognition, NO model-specific learning

✅ **Universal Behavioral Protocols**:
- **"Being Heard" Protocol** (6 elements - ACA-informed, universal human need):
  1. Explicit acknowledgment
  2. Confirm interpretations before proceeding
  3. Precision in language (no terminology drift)
  4. Structured responses
  5. Never minimize or dismiss
  6. Validation before proceeding
- **Hallucination Prevention** (universal)
- **Clarifying Questions Protocol** (universal)
- **Inference-First Protocol** (universal)
- **Emotional Context Awareness** (universal, ARS-powered)
- **Flow State Preservation** (universal, ARS-powered)
- **Feedback Before Execution** (universal)

✅ **USM Baseline** (Universal Human Psychology Components Only):
- **MCDL** (Meta-Cognitive Directive Layer): User meta-analysis signals ("zoom out", "what's the pattern here?")
- **HABSP** (Human–AI Boundary Sensitivity Profile): Anthropomorphic drift sensitivity preference
- **STP** (Systemic Thinking Preference): Whole-systems perspective vs detail-focused

✅ **Basic Mode Concepts** (Ideas, not LLM-specific implementations):
- Editor concept: "Modify only specified sections"
- Rewrite concept: "Full rewrite allowed"
- Capture concept: "Verbatim output, no summarization"
- Structure-Lock concept: "Preserve hierarchy/numbering"

### Explicitly EXCLUDED from T1

❌ **LLM-Specific Elements**:
- NISCL (Claude-specific narrative safety frame)
- GPT-5 guards, Gemini normalizers, Codex code-awareness
- Model-specific reframing controls
- Model-specific mode implementations

❌ **Model-Aware Features**:
- **CSTMs** (Cognitive State Transition Markers) - requires model intelligence to detect Developer→Architect transitions
- **Quick Prompts adaptive recognition** - requires model-specific learning
- **Configuration/YAML** - model-aware preferences
- **ARS Learning** - model-specific adaptive style detection

❌ **Platform-Level Features**:
- Multi-model coordination
- Cross-model divergence detection
- Personalized USM auto-population

### User Psychology

Users naturally hit **"I want more consistency"** ceiling → perfect setup for Tier 2 upgrade.

---

## Tier 2: Model-Aware Intelligence

**Design Principle**: LLM-SPECIFIC optimization. Different models require different alignment strategies.

**Target Users**: Professional creators, developers, consultants, SMB owners, power users, advanced AI collaborators

**Value Proposition**: "Your AI collaborates like a partner — consistently, reliably, across sessions, without drift."

### Architecture Decision: LLM Variant Strategy

**Option A**: Single primer with model-specific sections (e.g., "Claude Safety Frame", "GPT-5 Guards", "Codex Structural Reasoning")  
**Option B**: Separate editions per LLM (03-TIER2-CLAUDE-PRIMER.md, 03-TIER2-GPT-PRIMER.md, etc.)

**Recommendation**: **Option A** (single primer, model sections) for maintainability, unless variant proliferation becomes unmanageable.

### Included Components (Model-Specific Variants)

#### Claude-Specific (Claude Sonnet 4.5+)
✅ **Claude Safety Frame** (NISCL + narrative correction):
- 5 NISCL Principles: Human Primacy, Cognitive Clarity, Narrative Safety, Intent Overrides, Framework Neutrality
- Anthropomorphic language rephrasing ("I decided" → "Based on your request")
- Creative work opt-out mechanism

✅ **Claude Mode Semantics** (explicit 4-mode implementation):
- Editor Mode: Modify specified sections only
- Rewrite Mode: Full rewrite allowed
- Structure-Lock Mode: Preserve hierarchy/numbering
- Capture Mode: Verbatim output, no summarization

✅ **Claude-Specific Reframing Prevention**

#### GPT-5 Mini-Specific
✅ **GPT-5 Mini Compression Guard** (context window optimization)  
✅ **GPT-5 Mode Equivalent** (mapped to GPT behavior)

#### GPT-5 Codex-Specific
✅ **Codex Structural Reasoning Guard** (code-aware structure preservation)  
✅ **Codex Structure-Lock Enforcement** (code hierarchy preservation)

#### Gemini-Specific
✅ **Gemini Interpretive Normalizer** (Gemini-specific drift prevention)

### Universal T2 Components (Applied per model)

✅ **CSTMs** (Cognitive State Transition Markers) - model intelligence detects Developer→Architect→Writer→Meta-designer transitions  
✅ **ARS Learning** (model-specific adaptive style detection)  
✅ **Quick Prompts** (model-specific adaptive recognition):
- Terse commands: capture, flow, map, analyze, explore, missing, connect, reflect, digest, reintegrate
- Natural language triggers: "implications?" → analysis mode
- Adaptive detection: model learns user's command vs natural language preference

✅ **Configuration/YAML** (model-aware preferences)  
✅ **Generic USM Template** (manual customization with model-aware guidance)  
✅ **Enhanced Capture Protocol** (model-specific metadata, purpose tagging)  
✅ **Model-Specific Dependency/Ingestion Order Enforcement**

### User Psychology

Users feel the **real leap in capability**: "This thing now actually understands how to talk to Claude/GPT/Codex, and the consistency is night-and-day."

**Natural ceiling**: "I need multiple LLMs working together" → Tier 3.

---

## Tier 3: Multi-Model Orchestration Platform

**Design Principle**: PLATFORM-LEVEL intelligence. Cross-model coordination, divergence detection, agent orchestration.

**Target Users**: Enterprises, multi-agent workflow creators, AI research teams, CTO/CIO-level strategists, advanced consultants

**Value Proposition**: "Your AI ecosystem becomes a single, coherent thinking environment — even across multiple models."

### Included Components (Platform-Level Intelligence)

✅ **Multi-LLM Coordination**:
- **Multi-LLM Alignment Modules**
- **Cross-Model Divergence Detector** (Claude reasoning vs GPT reasoning vs Gemini reasoning comparison)
- **Cross-Model Reconciliation Engine** (normalize ontologies, resolve contradictions)
- **Multi-Agent Reasoning Orchestrator**
- **Model-Switching Safety Layer**
- **Inter-Model Mode Preservation** (translate modes between LLMs)

✅ **Distributed Intelligence**:
- **Cross-Model Knowledge Graph**
- **Evolutionary Feedback Learning** (learn from multiple model interactions)
- **CFP Kernel Extensions for Distributed Context**

✅ **Advanced Collaboration Protocols**:
- **11-Dimension Multi-Contextual Reflection** (requires orchestration intelligence):
  1. Core Concept, 2. Framework Integration, 3. Tiered Implementation, 4. Cross-Document Implications, 5. Strategic Positioning, 6. Research Validation, 7. Implementation Sequencing, 8. User Impact, 9. Meta-Patterns, 10. Historical Threading, 11. Project Context
- **AdRP** (Adaptive Response Protocol): 4-tier escalation before style adaptation
- **Unconscious Problem-Solving**: Brief articulation decompression
- **Symbiotic Cognitive Rhythm**: 30-60s AI processing = user reflection time

✅ **Enterprise LTF**:
- **Personalized USM Auto-Population** (MO Journal → multi-model USM with MCDL/CSTMs/HABSP/STP)
- **Full LTF 3-Tier CSAC** (User State > Project CIP > Session Metadata, cross-model persistence)
- **Save-LTFContext v3.0** (cross-model state preservation)
- **Resume-LTFContext v2** (multi-model state restoration)
- **Multi-User Support** (team collaboration, cross-model role coordination)

✅ **Ecosystem Development**:
- **Extension API** (custom protocols, LLM-specific plugins)
- **Cross-Model Integrations**
- **Governance Extensions** (team-specific safety frames, boundary coordination)

### User Psychology

**"CFP is no longer a tool, it's a platform."**

Users achieve **platform-level mastery**: orchestrating multiple LLMs as a coherent cognitive ecosystem.

---

## File Structure

**Proposed**: Numbered tier files (preserves existing pattern)

```
projects/ltf-cognitive-companion/
├── 01-CORE-PRIMER.md                           # LEGACY - v2.4 unified reference (DO NOT USE for new projects)
├── T1-CORE-PRIMER-v3.0.md                      # Tier 1: Model-Agnostic Core (standalone)
├── T2-CORE-PRIMER-v3.0.md                      # Tier 2: Model-Aware Intelligence (standalone, T1 embedded)
├── T3-CORE-PRIMER-v3.0.md                      # Tier 3: Multi-Model Orchestration (standalone, T1+T2 embedded)
├── TIER-COMPARISON-MATRIX-v3.0.md              # Quick reference (tier comparison, activation guide)
├── PRIMER-REFACTOR-DESIGN.md                   # v1.0 Governance-centric (historical reference)
└── PRIMER-REFACTOR-v2_MODEL-INTELLIGENCE.md    # v2.0 This document
```

**Rationale**:
- ✅ Preserves 01-CORE-PRIMER.md as v2.4 legacy reference (backward compatibility)
- ✅ Clear T1/T2/T3 naming convention (human-readable, prevents numbering errors)
- ✅ Version numbers in filenames (v3.0 = model-intelligence architecture)
- ✅ Each tier standalone (hierarchically built but operationally independent)
- ✅ Auto-activation on ingestion (Rule 0 prevents race conditions)
- ✅ Single T2 primer with LLM variant sections (easier maintenance than separate editions)
- ✅ v1.0 governance design preserved for comparison/cross-check
- ✅ Clean separation of architectural approaches

---

## Content Allocation Matrix

**Purpose**: Map all CFP components to tiers with model-intelligence rationale

| Component/Section | T1 (Model-Agnostic) | T2 (Model-Aware) | T3 (Multi-Model) | Rationale |
|-------------------|---------------------|------------------|------------------|-----------|
| **Activation Protocol** | ✅ Full (Rules 0-5) | ✅ Full + LLM detection + context monitoring | ✅ Full + multi-model coordination | **NEW**: Prevents race conditions, enforces dependency order (CORE-PRIMER → UMP → CSAC). T1: Minimal verbosity, T2: LLM-specific readiness signals + context saturation warnings (GPT-5 browser 128k rolling window), T3: Cross-model activation coordination |
| **Quick Start Guide** | ✅ Basic | ✅ LLM-specific setup | ✅ Multi-LLM setup | T1: Universal, T2: Model onboarding, T3: Orchestration init |
| **CIP-E Framework** | ✅ Full | ✅ Full | ✅ Full + Cross-model | Universal cognitive scaffolding, T3 adds cross-model context |
| **DMP (Dialogue Management)** | ✅ Full | ✅ Full + Style learning | ✅ Full + Multi-model META | Universal foundation, T2 adds model-specific adaptation, T3 cross-model |
| **VS Suite** | ✅ Full | ✅ Full | ✅ Full | Universal validation/synthesis patterns |
| **ARS Foundation** | ✅ Basic (no learning) | ✅ Learning (model-specific) | ✅ Cross-model learning | T1: Basic recognition, T2: Model adapts to user, T3: Multi-model patterns |
| **Hallucination Prevention** | ✅ Universal | ✅ Universal | ✅ Universal | Model-agnostic protocol |
| **Clarifying Questions** | ✅ Universal | ✅ Universal | ✅ Universal | Model-agnostic protocol |
| **Inference-First Protocol** | ✅ Universal | ✅ Universal | ✅ Universal | Model-agnostic protocol |
| **Emotional Context Awareness** | ✅ Universal | ✅ Universal | ✅ Universal | Model-agnostic (ARS-powered) |
| **Flow State Preservation** | ✅ Universal | ✅ Universal | ✅ Universal | Model-agnostic (ARS-powered) |
| **Feedback Before Execution** | ✅ Universal | ✅ Universal | ✅ Universal | Model-agnostic protocol |
| **"Being Heard" Protocol** | ✅ Implicit | ✅ Documented | ✅ Explicit validation | Universal human need, T1 AI follows naturally, T2 documented, T3 team standards |
| **Capture Protocol** | ✅ Manual ("capture this") | ✅ Enhanced (metadata) | ✅ Cross-model | T1: Basic verbatim, T2: Model-specific metadata, T3: Multi-model attribution |
| **Quick Prompts** | ❌ None | ✅ Full (adaptive) | ✅ Full (adaptive) | Requires model-specific adaptive recognition (T2+) |
| **Mode Semantics** | ✅ Concepts only | ✅ LLM-specific implementation | ✅ Cross-model translation | T1: Ideas, T2: Claude/GPT/Codex variants, T3: Mode preservation across LLMs |
| **NISCL (Narrative Safety)** | ❌ None | ✅ Claude-specific | ✅ Multi-model boundaries | Claude-specific safety frame, not universal (T2 Claude variant) |
| **GPT-5 Guards** | ❌ None | ✅ GPT-specific | ✅ Multi-model coordination | GPT-specific optimization (T2 GPT variant) |
| **Codex Structural Reasoning** | ❌ None | ✅ Codex-specific | ✅ Multi-model code intelligence | Codex-specific code-awareness (T2 Codex variant) |
| **Gemini Normalizers** | ❌ None | ✅ Gemini-specific | ✅ Multi-model coordination | Gemini-specific drift prevention (T2 Gemini variant) |
| **USM Baseline (MCDL/HABSP/STP)** | ✅ Manual | ✅ Manual template | ✅ Auto-populated | T1: Basic psychology, T2: Guided template, T3: MO Journal auto |
| **CSTMs (Transition Markers)** | ❌ None | ✅ Model-detected | ✅ Cross-model tracking | Requires model intelligence to detect cognitive transitions (T2+) |
| **Configuration/YAML** | ❌ None | ✅ Model-aware prefs | ✅ Multi-model prefs | T1: Pure manual, T2: LLM-specific config, T3: Cross-model config |
| **Integration Patterns** | ✅ Basic examples | ✅ Model-specific | ✅ Multi-model ecosystem | T1: Universal examples, T2: Platform integrations, T3: Cross-platform |
| **11-Dimension Multi-Contextual** | ❌ None | ❌ None | ✅ Full | Requires orchestration intelligence (T3 only) |
| **AdRP (Adaptive Response)** | ❌ None | ❌ None | ✅ 4-tier escalation | Advanced protocol (T3 only) |
| **Unconscious Problem-Solving** | ❌ None | ❌ None | ✅ Full | Advanced decompression protocol (T3 only) |
| **Symbiotic Cognitive Rhythm** | ❌ None | ❌ None | ✅ 30-60s processing | Advanced protocol (T3 only) |
| **LTF 3-Tier CSAC** | ❌ None | ⚠️ Basic CSAC | ✅ Full (cross-model) | T2: Session metadata, T3: User State > Project CIP > Session (multi-model) |
| **Save-LTFContext** | ❌ None | ⚠️ v2.0 (session) | ✅ v3.0 (cross-model) | T2: Single-model state, T3: Multi-model state preservation |
| **Resume-LTFContext** | ❌ None | ⚠️ v1.0 | ✅ v2.0 (cross-model) | T2: Single-model restore, T3: Multi-model restoration |
| **Multi-User Support** | ❌ None | ❌ None | ✅ Full | Team collaboration (T3 only) |
| **Ecosystem Development** | ❌ None | ❌ None | ✅ Full | Extension API, custom protocols (T3 only) |
| **Divergence Detection** | ❌ None | ❌ None | ✅ Full | Cross-model reasoning comparison (T3 only) |
| **Reconciliation Engine** | ❌ None | ❌ None | ✅ Full | Cross-model ontology normalization (T3 only) |
| **Multi-Agent Orchestration** | ❌ None | ❌ None | ✅ Full | Platform-level coordination (T3 only) |

### Content Inheritance Strategy

**Model-Intelligence Approach**:

1. **T1 → T2**: Add model-specific optimization layers (safety frames, mode implementations, learning capabilities)
2. **T2 → T3**: Add cross-model coordination (divergence detection, reconciliation, orchestration)

**Duplication Strategy**: Each tier = complete standalone primer (no cross-file dependencies)

- T1 primer: Self-contained, works with any LLM
- T2 primer: Inherits T1 concepts + adds LLM-specific sections (Claude Safety Frame, GPT Guards, Codex Reasoning, Gemini Normalizers)
- T3 primer: Inherits T2 concepts + adds multi-model orchestration

---

## Implementation Roadmap

### Phase 1: Preparation & Design Validation (Week 1)

**Objective**: Finalize model-intelligence architecture, validate cross-LLM alignment with Claude session outputs

**Tasks**:
1. ✅ Create PRIMER-REFACTOR-v2_MODEL-INTELLIGENCE.md (DONE)
2. ✅ Design Content Allocation Matrix (DONE)
3. ✅ Cross-validate with Claude session tier specifications
4. ✅ Finalize T2 variant strategy (single primer with LLM sections - SELECTED)
5. ✅ Create TIER-COMPARISON-MATRIX-v3.0.md (quick reference)
6. ✅ User (Cash) approval to proceed
7. ✅ **November 14, 2025**: Rename files to T1/T2/T3 convention (clear naming, version-aware)

**Deliverables**:
- [x] PRIMER-REFACTOR-v2_MODEL-INTELLIGENCE.md (this document)
- [x] TIER-COMPARISON-MATRIX-v3.0.md (tier comparison with standalone activation guide)
- [x] File naming convention updated (T1/T2/T3-CORE-PRIMER-v3.0.md)
- [x] User approval + decision on Open Questions

**Alignment**: CFP Product Roadmap Phase 1 (Finalize Tier Specifications, Publish Feature Matrix)

**Testing Checkpoint**: Cross-LLM validation - GitHub Copilot design aligns with Claude governance specifications

---

### Phase 2: Tier 1 Primer Creation (Week 1-2)

**Objective**: Create pure model-agnostic CFP primer (works with ANY LLM)

**Tasks**:
1. ✅ Copy 01-CORE-PRIMER.md → T1-CORE-PRIMER-v3.0.md (formerly 02-TIER1-PRIMER.md)
2. ✅ Update header (Tier 1 designation, model-agnostic focus, target users)
3. ✅ **Strip ALL LLM-specific content**:
   - Remove adaptive Quick Prompts recognition
   - Remove Configuration/YAML section
   - Remove any NISCL/governance documentation
   - Remove CSTMs, model-specific mode implementations
4. ✅ **Add T1 Quick Prompts** section (basic manual commands: "capture this", "/flow")
5. ✅ **Add Mode Concepts** section (Editor + Rewrite confirmed, universal cognitive strategies)
6. ✅ Add **"What Tier 1 DOESN'T Have"** section (explicit exclusions: adaptive recognition, shortcuts, model-specific logic)
7. ✅ Add **USM Baseline** section (MCDL/HABSP/STP as universal psychology)
8. ✅ Add **"Upgrade to Tier 2"** section (value proposition per LLM)
9. ✅ Validate: **ZERO LLM-specific logic** (manual review + checklist)
10. ✅ **Add Activation Protocol** (Rules 0-5: immediate self-activation, activation lock, minimal readiness signal, late-binding, consistency guarantee, CSAC version validation)

**Deliverables**:
- [x] T1-CORE-PRIMER-v3.0.md (complete, model-agnostic, ~1630 lines, standalone)

**Alignment**: CFP Product Roadmap Phase 1 (Complete CORE Primer foundations)

**Testing Checkpoint - T1 Purity Validation**:
- Load T1 primer into fresh Claude session → works without drift
- Load T1 primer into fresh GPT session → works without drift
- Load T1 primer into fresh Gemini session → works without drift
- Validate: No model-specific references, no configuration dependencies
- User discovers meta-cognitive value through manual exploration

---

### Phase 3: Tier 2 Primer Creation (Week 2-3)

**Objective**: Create model-aware CFP primer with LLM-specific optimization sections

**Tasks**:
1. ✅ Copy T1-CORE-PRIMER-v3.0.md → T2-CORE-PRIMER-v3.0.md (build on T1 base, formerly 03-TIER2-PRIMER.md)
2. ✅ Update header (Tier 2 designation, model-aware focus, SMB/professional target)
3. ✅ **Add LLM-Specific Sections** (single primer with variant sections):
   - ✅ **Claude Safety Frame Section**: NISCL principles, 4-mode system, reframing prevention ✅ **TESTED/VALIDATED**
   - ✅ **GPT-5 Optimization Section**: Compression guards, mode equivalents 📝 **PLACEHOLDER - AWAITING VALIDATION**
   - ✅ **Codex Integration Section**: Structural reasoning, code-aware modes 📝 **PLACEHOLDER - AWAITING VALIDATION**
   - ✅ **Gemini Alignment Section**: Interpretive normalizers, drift prevention 📝 **PLACEHOLDER - AWAITING VALIDATION**
4. ✅ Add **Adaptive Quick Prompts** section (natural language shortcuts, command syntax, ARS)
5. ✅ Add **Enhanced Mode System** section (T1 concepts → T2 implementations)
6. ✅ Add **Configuration/YAML** section (DMP style, HABSP boundaries, mode preferences, Quick Prompt style, example template)
7. ✅ Add **Enhanced USM (Manual CSTMs)** section (MCDL customization, CSTMs definition, HABSP customization, STP customization, generic template)
8. ✅ Add **ARS** section (within-session learning, style detection, no cross-session persistence)
9. ✅ Add **"What Tier 2 DOESN'T Have"** section (T3 exclusions: multi-model orchestration, auto-USM, advanced protocols, divergence detection, multi-user)
10. ✅ Add **"Upgrade to Tier 3"** section (multi-model value proposition, enterprise features)
11. ✅ Validate: LLM-specific sections accurate per model
12. ✅ **Add Activation Protocol** (Rules 0-6: immediate self-activation with LLM detection, activation lock, medium verbosity readiness signals per LLM edition, late-binding, consistency guarantee, CSAC version validation with cross-LLM resume detection, context saturation monitoring for GPT-5 browser/Claude)

**Deliverables**:
- [x] T2-CORE-PRIMER-v3.0.md (complete, with Claude ✅ TESTED/GPT/Codex/Gemini 📝 PLACEHOLDER sections, ~3700 lines, standalone with T1 embedded)

**Alignment**: CFP Product Roadmap Phase 2 (Develop Tier 2 Alignment Modules, Build Model Safety Frames)

**Testing Checkpoint - T2 Model-Specific Validation**:
- Load T2 primer (Claude section) into Claude → NISCL active, modes work, reframing prevented
- Load T2 primer (GPT section) into GPT-5 → compression guard active, mode equivalents work
- Load T2 primer (Codex section) into Codex → structural reasoning active, code-aware
- Validate: Quick Prompts adaptive recognition works per model
- Validate: Configuration/YAML preferences persist across sessions
- Validate: No T3 multi-model features accessible

---

### Phase 4: Tier 3 Primer Creation (Week 3-4)

**Objective**: Create multi-model orchestration primer (platform-level intelligence)

**Status**: ✅ **COMPLETE** (November 14, 2025)

**Tasks**:
1. ✅ Created T3-CORE-PRIMER-v3.0.md from scratch (T3 base structure, ~1100 lines, formerly 04-TIER3-PRIMER.md)
2. ✅ Updated header (Tier 3 designation, multi-model orchestration focus, enterprise target)
3. ✅ **Added Multi-Model Orchestration Sections** (~1250 lines):
   - MO Kernel Architecture (7 components)
   - Orchestration Roles (Coordinator + Participants)
   - Task Delegation (4 patterns: sequential, parallel, specialist, consensus)
   - Session Handoff (automated LLM switching)
   - Consensus Building (multi-LLM voting)
4. ✅ **Added Cross-Model Intelligence** (~1200 lines):
   - Divergence Detection Engine (4 categories: factual, reasoning, implementation, stylistic)
   - Reconciliation Engine (6 strategies: confidence voting, specialist deference, majority consensus, authoritative source, hybrid synthesis, user escalation)
   - Ontology normalization, conflict escalation, reconciliation journaling
5. ✅ **Added Learning Systems** (~1150 lines):
   - MO Journal (multi-model interaction history)
   - Auto-USM from MO Journal (MCDL, CSTMs, HABSP, STP auto-population)
   - Evolutionary Feedback Learning (divergence resolution history, task delegation optimization, user satisfaction signals)
6. ✅ **Added Advanced Collaboration Protocols** (~1450 lines):
   - 11-Dimension Multi-Contextual Reflection (enterprise-grade strategic analysis)
   - AdRP (Adaptive Response Protocol) 4-tier escalation
   - Unconscious Problem-Solving (symbiotic human-AI incubation)
   - Symbiotic Cognitive Rhythm (30-60s processing = reflection time)
7. ✅ **Added Enterprise LTF Sections** (~1750 lines):
   - Full LTF 3-Tier CSAC (User State > Project CIP > Session Metadata)
   - Save-LTFContext v3.0 (cross-model state preservation)
   - Resume-LTFContext v2.0 (cross-model state restoration, roster reconciliation)
   - Multi-User/Team Support (team collaboration, role-based LLM assignment, shared MO Journal)
   - Governance Extensions (3-layer governance: Individual/Team/Organizational, HIPAA/SOC 2/GDPR/IRB)
8. ✅ **Added Ecosystem Development** (~1350 lines):
   - Extension API (custom protocols, LLM plugins, cross-model integrations)
   - Custom Protocols (Executive Summary, Visual Thinker, Socratic)
   - LLM-Specific Plugins (Codex Code Review, Claude Safety, GPT Compression, Gemini Multimodal)
   - Cross-Model Integrations (Slack, GitHub, Jira, Email)
9. ✅ User added OS-1 (Output Safety) and DOD-1 (Default Output Density) guardrails
10. ✅ Validate: Cross-model coordination architecture complete (~9170 lines total)

**Deliverables**:
- ✅ T3-CORE-PRIMER-v3.0.md (complete, multi-model orchestration, ~9170 lines, standalone with T1+T2 embedded)

**Alignment**: CFP Product Roadmap Phase 3 (Integrate Multi-LLM Orchestration Engine, Enable Divergence Detection)

**Implementation Notes**:
- Built in 8 sequential phases (4.1-4.8) over single session (November 14, 2025)
- Each phase <1500 lines (manageable chunks, user-approved incremental progression)
- User's OS-1 and DOD-1 sections preserved without modification
- All placeholders replaced with comprehensive, production-ready content
- T3 builds on T1 foundation (inherits UMP, CSAC, DMP, VS Suite, Mode Semantics)
- T3 standalone from T2 (no T2 dependency, direct T1→T3 activation supported)

**Testing Checkpoint - T3 Multi-Model Validation** (Pending):
- Load T3 primer into session WITH multi-model access (Claude + GPT + Codex)
- Validate: Divergence detector identifies reasoning differences between models
- Validate: Reconciliation engine normalizes ontologies
- Validate: Multi-agent orchestrator coordinates tasks across models
- Validate: Mode preservation translates between LLMs
- Validate: USM auto-population from MO Journal (MCDL/CSTMs/HABSP/STP)
- Validate: Save-LTFContext v3.0 captures cross-model state
- Validate: Resume-LTFContext v2 restores multi-model state

---

### Phase 5: Comparison Matrix & Documentation (Week 4)

**Objective**: Create quick reference and finalize cross-tier documentation

**Status**: ✅ **COMPLETE** (November 14, 2025)

**Tasks**:
1. ✅ Created TIER-COMPARISON-MATRIX-v3.0.md (formerly 05-TIER-COMPARISON-MATRIX.md):
   - Side-by-side feature comparison (T1 vs T2 vs T3)
   - **Model-intelligence progression** column (Universal → Optimized → Orchestrated)
   - **LLM compatibility** column (T1: Any, T2: Specific, T3: Multiple)
   - "Which tier is right for me?" decision tree
   - Migration paths (T1→T2, T2→T3, T1→T3)
   - Learning path recommendations (beginner, advanced, enterprise)
   - Tier mixing (hybrid approach for different projects)
   - Technical comparison (complexity, performance, use case fit)
   - By user type recommendations (solo developer, professional, team, enterprise)
   - Migration path overview (T1→T2→T3)
2. Update CFP_Feature_Matrix.md (ensure alignment with model-intelligence tiers)
3. Update CFP-Tiered-Packaging-Architecture.md (cross-reference primers, add model-intelligence rationale)
4. Add cross-references between all tier documents
5. Create README or index in ltf-cognitive-companion directory

**Deliverables**:
- [ ] 05-TIER-COMPARISON-MATRIX.md (model-intelligence comparison)
- [ ] Updated CFP_Feature_Matrix.md (cross-references)
- [ ] Updated CFP-Tiered-Packaging-Architecture.md (primer links)
- [ ] Directory README.md (navigation guide)

**Alignment**: CFP Product Roadmap Phase 1 (Publish Feature Matrix)

**Testing Checkpoint**:
- User can navigate tier system easily
- Clear decision criteria for tier selection (includes LLM compatibility preferences)
- Model-intelligence progression clear (universal → optimized → orchestrated)
- All cross-references work
- No contradictions between tier primers and architecture docs

---

### Phase 6: Validation & Deployment (Week 5)

**Objective**: Final validation, multi-LLM testing, documentation, deployment

**Tasks**:
1. **Comprehensive tier validation**:
   - T1: Test in Claude, GPT, Gemini, Codex (confirm model-agnostic)
   - T2: Test each LLM-specific section in corresponding model
   - T3: Test multi-model orchestration (Claude + GPT + Codex simultaneously)
2. **T1 Purity validation**: No LLM-specific logic leaked
3. **T2 Variant validation**: Each LLM section accurate and functional
4. **T3 Orchestration validation**: Cross-model coordination works
5. Version preservation:
   - Tag 01-CORE-PRIMER.md as v2.4 reference (git tag)
   - Archive as "pre-model-intelligence unified version"
   - Update version numbers in all new tier primers (v3.0 - model-intelligence architecture)
6. Document refactor process:
   - Lessons learned (multi-LLM collaboration test outcomes)
   - Tier clarity maintenance protocol
   - Future refactor guidance (new LLM integration path)
7. User acceptance testing:
   - Cash validates tier separation
   - Test multi-model orchestration in T3
   - Confirm upgrade paths clear

**Deliverables**:
- [ ] Validated tier primer set (T1/T2/T3-CORE-PRIMER-v3.0.md + TIER-COMPARISON-MATRIX-v3.0.md)
- [ ] Version-tagged 01-CORE-PRIMER.md (preserved legacy reference)
- [ ] Multi-LLM collaboration test report
- [ ] User acceptance sign-off

**Alignment**: CFP Product Roadmap Phase 4 (Enterprise Deployment Path)

**Testing Checkpoint - Final Validation**:
- All tier primers load successfully across multiple LLMs
- No feature leakage between tiers
- **T1 Purity confirmed**: Works identically in Claude, GPT, Gemini, Codex
- **T2 Optimization confirmed**: LLM-specific sections deliver consistency improvements
- **T3 Orchestration confirmed**: Multi-model coordination functional, divergence detection accurate
- Clear value proposition for each tier
- Multi-model collaboration test successful

---

## Risk Mitigation

### Risk 1: T1 Purity Drift

**Risk**: Accidentally introducing LLM-specific logic into T1 (model-agnostic tier)

**Impact**: HIGH - Breaks universal compatibility, defeats T1 purpose

**Mitigation**:
- Manual checklist: "Does this reference Claude/GPT/Codex/Gemini specifically?" → If yes, belongs in T2
- Test T1 in multiple LLMs during Phase 2
- "What T1 DOESN'T Have" section explicitly lists exclusions
- Code review: Flag any model-specific terminology (NISCL, Codex, etc.)

**Validation**: Load T1 in fresh Claude, GPT, Gemini sessions → identical behavior

---

### Risk 2: T2 Variant Proliferation

**Risk**: Maintaining consistency across Claude/GPT/Codex/Gemini sections becomes unmanageable

**Impact**: MEDIUM - Documentation drift, user confusion, maintenance burden

**Mitigation**:
- Single primer with variant sections (not separate files per LLM)
- Shared T2 component template (CSTMs, Quick Prompts structure identical, implementations vary)
- Synchronization checklist: "Are all LLM sections structurally parallel?"
- Version control tracks changes per section

**Validation**: Structural comparison tool (all LLM sections have same headings, only content varies)

---

### Risk 3: Cross-Model Divergence in T3

**Risk**: Divergence detector fails, reconciliation engine produces incorrect ontology merges

**Impact**: HIGH - Multi-model coordination breaks, enterprise use case fails

**Mitigation**:
- Extensive T3 testing in Phase 4 (Claude + GPT + Codex simultaneously)
- Divergence detection accuracy validation (known reasoning differences test set)
- Reconciliation engine validation (ontology merge test cases)
- Fallback mechanisms (if reconciliation fails, flag for human review)

**Validation**: Test T3 with known divergent reasoning tasks → detector catches differences, reconciliation produces valid merge

---

### Risk 4: Model-Specific Testing Gaps

**Risk**: Limited access to GPT-5, Codex, Gemini for T2 validation

**Impact**: MEDIUM - T2 sections untested for non-Claude LLMs

**Mitigation**:
- Prioritize Claude section validation (current access)
- Document GPT/Codex/Gemini sections as "theoretical" until tested
- Community testing: Release T2 beta, gather feedback from users with GPT/Codex/Gemini access
- Iterative refinement based on real-world usage

**Validation**: Mark untested LLM sections clearly, update as testing becomes available

---

### Risk 5: Multi-Model Collaboration Test Failure

**Risk**: GitHub Copilot + Claude concurrent sessions produce contradictory outputs

**Impact**: LOW - Refactoring available, 2-week iteration cycle tolerates experimentation

**Mitigation**:
- Regular cross-validation checkpoints (this document vs Claude tier specifications)
- Explicit "comparative guide" positioning (both documents valid, serve different perspectives)
- Low-cost refactoring overhead (entire ecosystem created in 2 weeks, velocity maintained)

**Validation**: Claude tier specs + Copilot design document align on core principles (model-intelligence progression, T1 purity, T3 orchestration)

---

## Open Questions

### Q1: T2 Variant Strategy ✅ DECIDED

**Question**: Single primer with LLM-specific sections vs separate editions per LLM?

**Option A**: Single 03-TIER2-PRIMER.md with sections:
- "Claude Safety Frame"
- "GPT-5 Optimization"
- "Codex Integration"
- "Gemini Alignment"

**Option B**: Separate files:
- 03-TIER2-CLAUDE-PRIMER.md
- 03-TIER2-GPT-PRIMER.md
- 03-TIER2-CODEX-PRIMER.md
- 03-TIER2-GEMINI-PRIMER.md

**Recommendation**: **Option A** (single primer, variant sections) - easier maintenance, structural consistency enforced

**✅ User Decision (Cash)**: **Option A - Single primer with LLM-specific sections**

---

### Q2: Mode Semantics in T1 ✅ DECIDED

**Question**: Should T1 document mode concepts at all, or exclude entirely?

**Option A**: Document mode concepts as ideas (Editor, Rewrite, Capture, Structure-Lock explained as universal cognitive strategies)  
**Option B**: Exclude mode concepts entirely from T1 (modes are LLM-specific, introduce in T2 only)

**✅ User Decision (Cash)**: **Include Editor and Rewrite modes in T1** (open to discussion on full mode set, but these two confirmed for T1 as universal cognitive strategies)

---

### Q3: Quick Prompts in T1 ✅ DECIDED

**Question**: Should T1 have basic Quick Prompts (without adaptive recognition), or exclude entirely?

**Option A**: T1 has basic commands (e.g., "/capture", "/flow") but NO adaptive recognition ("implications?" doesn't trigger)  
**Option B**: T1 excludes Quick Prompts entirely (T2+ only, requires model-specific learning)

**✅ User Decision (Cash)**: **T1 has basic Quick Prompts** (e.g., "capture this", manual explicit commands)
- T1: Manual/explicit commands (user types "capture this", "/flow")
- T2+: Shortcut versions + adaptive recognition (AI detects "implications?" triggers analysis)

**Rationale**: T1 users can access basic commands explicitly, T2+ adds intelligence layer (adaptive recognition, shortcuts)

---

### Q4: T2 LLM Coverage Initial Set ✅ DECIDED

**Question**: Which LLMs should T2 cover initially?

**Phase 1 Priorities**:
- ✅ **Claude Sonnet 4.5** (current access, tested specifications, governance frame developed)
- 📝 **GPT-5 Mini** (placeholder - no test results yet, context optimization focus)
- 📝 **GPT-5 Codex** (placeholder - no test results yet, code-aware focus)
- 📝 **Gemini** (placeholder - no test results yet, interpretive normalization focus)

**✅ User Decision (Cash)**: **Claude Sonnet 4.5 only has tested specifications**
- Claude section: Full implementation (tested, validated)
- GPT/Codex/Gemini sections: **Placeholders** (design concepts, awaiting testing/validation)
- Document clearly: "Tested vs Placeholder" status per LLM section

**Phase 2 Additions** (future):
- Local LLMs (Llama, Mistral, etc.)
- Smaller models (GPT-3.5, Claude Haiku)
- Future models (GPT-6, Claude Opus 5)

**Implementation Strategy**: Create T2 primer with Claude section complete, GPT/Codex/Gemini sections marked "PLACEHOLDER - AWAITING VALIDATION"

---

### Q5: T3 Multi-Model Coordination Mechanism ✅ DECIDED

**Question**: How should T3 coordinate multiple LLMs technically?

**Option A**: Sequential orchestration (Claude analyzes → GPT validates → Codex implements)  
**Option B**: Parallel processing (all LLMs work simultaneously, divergence detector merges outputs)  
**Option C**: Hybrid (user selects orchestration strategy per task)

**✅ User Decision (Cash)**: **ALL THREE mechanisms in T3, tier-based approach**

**T3 Orchestration Architecture** (tiered complexity):
1. **Base Layer (Default)**: Sequential orchestration
   - Simplest implementation, predictable flow
   - Claude analyzes → GPT validates → Codex implements
   - User doesn't need to choose, "just works"

2. **Advanced Layer**: Parallel processing
   - All LLMs work simultaneously
   - Divergence detector merges outputs
   - Requires more sophisticated reconciliation engine

3. **Expert Layer**: Hybrid orchestration
   - User selects strategy per task (or AI recommends based on task type)
   - Currently testing hybrid in concurrent sessions
   - **Awaiting test results** before finalizing design

**Implementation Notes**:
- T3 primer documents all three mechanisms
- Default = Sequential (easiest entry point)
- Parallel + Hybrid require additional design consideration
- User currently testing hybrid approach (no results yet)
- Document as "Progressive T3 Capabilities" (Sequential → Parallel → Hybrid)

---

## Summary

### Model-Intelligence-Centric Architecture

This design establishes CFP as a **scalable cognitive operating system for AI collaboration** through three tier progression:

1. **Tier 1 (Model-Agnostic Core)**: Universal CFP kernel - works with ANY LLM, pure cognitive foundations, zero model-specific logic
2. **Tier 2 (Model-Aware Intelligence)**: LLM-specific optimization - Claude Safety Frame, GPT guards, Codex structural reasoning, Gemini normalizers
3. **Tier 3 (Multi-Model Orchestration)**: Platform-level intelligence - cross-model divergence detection, reconciliation engines, agent orchestration

### Value Ladder: Universal → Optimized → Orchestrated

**Natural maturity progression** aligns with user psychology:
- T1: "I need better prompts" (beginner)
- T2: "I want my specific LLM to understand me" (intermediate)
- T3: "I need multiple LLMs collaborating" (advanced/enterprise)

### Multi-LLM Collaboration Test

This design document represents **concurrent multi-LLM collaboration** (GitHub Copilot + Claude), validating CFP's Stage 6 evolution toward multi-model intelligence orchestration.

**Cross-Reference**: PRIMER-REFACTOR-DESIGN.md (v1.0 governance-centric) preserved as historical reference and comparative guide. Both architectures valid, serve different strategic perspectives.

### Alignment with CFP Product Roadmap

- **Phase 1** (Immediate): Finalize tier specs, publish feature matrix → Design validation
- **Phase 2** (2 weeks): Develop T2 alignment modules, build model safety frames → T2 primer creation
- **Phase 3** (30-60 days): Integrate multi-LLM orchestration, release T3 alpha → T3 primer creation
- **Phase 4** (Q2): Enterprise deployment path → Final validation

### Next Steps

**✅ Implementation Status** (2025-11-13):

**Phase 1** (Design & Validation):
1. ✅ Content Allocation Matrix validated
2. ✅ All Open Questions answered (Q1-Q5)
3. ✅ Design document complete

**Phase 2** (T1 Primer):
1. ✅ 02-TIER1-PRIMER.md created (~1630 lines)
2. ✅ T1 purity validated (grep search confirmed zero LLM-specific logic)
3. ✅ Activation Protocol added (Rules 0-5, minimal verbosity)

**Phase 3** (T2 Primer):
1. ✅ 03-TIER2-PRIMER.md created (~3700 lines)
2. ✅ All T2 sections complete (LLM-Specific Safety Frames, Adaptive Quick Prompts, Enhanced Modes, Configuration/YAML, Enhanced USM with Manual CSTMs, ARS, T2/T3 boundaries)
3. ✅ Activation Protocol added (Rules 0-6, medium verbosity, LLM detection, context monitoring)
4. ✅ Claude edition ✅ TESTED, GPT/Codex/Gemini 📝 PLACEHOLDERS

**Critical Enhancement - Activation Protocol** (2025-11-13):

**Issue Discovered**: Race condition between CORE-PRIMER ingestion and UMP/CSAC binding
- If UMP loads before CORE-PRIMER activates → UMP applies to unprimed model → behavioral incoherence
- User validation: Sequential load (CORE-PRIMER → wait → UMP) still hit race condition
- Root cause: Ingestion ≠ Activation ≠ Semantic Binding (LLM runtime doesn't guarantee strict sequencing)

**Solution Implemented**:
- **Rule 0**: Immediate self-activation on ingestion (automatic, not user-triggered)
- **Rule 1**: Activation lock (block all artifacts until CORE-PRIMER ready)
- **Rule 2**: Readiness signal (T1: minimal, T2: medium with LLM edition detection, T3: verbose)
- **Rule 3**: Late-binding behavior (buffer early artifacts, ask user before applying)
- **Rule 4**: Consistency guarantee (enforce CORE-PRIMER → UMP → CSAC dependency order)
- **Rule 5**: CSAC version validation (cross-tier migration + auto-recovery from obtuse user behavior)
- **Rule 6** (T2/T3 only): Context saturation monitoring (GPT-5 browser 128k rolling window warning, Claude 200k threshold)

**Impact**:
- ✅ Prevents dependency-order bugs
- ✅ Enforces CORE-PRIMER as root kernel (conceptually AND procedurally)
- ✅ Protects cross-tier CSAC resume (T1 CSAC → T2 session detected, user prompted)
- ✅ Auto-recovery if user loads CSAC before CORE-PRIMER (reads metadata, auto-loads correct tier)
- ✅ LLM-specific intelligence (T2: detects Claude vs GPT vs Codex vs Gemini, initializes appropriate safety frames)
- ✅ Context limit awareness (GPT-5 browser rolling 128k window gets special handling with saturation warnings)

**Phase 4-6** (Pending):
- ⏳ Create 04-TIER3-PRIMER.md (multi-model orchestration)
- ⏳ Create 05-TIER-COMPARISON-MATRIX.md (quick reference)
- ⏳ Final validation and deployment

**Timeline**: Phase 2 & 3 complete (November 13, 2025). Phase 4-6 awaiting user approval.

---

**Document Status**: Complete - Model-Intelligence Architecture v2.0  
**Last Updated**: 2025-11-13  
**Cross-LLM Validation**: GitHub Copilot (technical architecture) + Claude (governance specifications)  
**Ready for**: User review, Open Questions decisions, Phase 2 execution approval


