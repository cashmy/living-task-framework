# CFP Tier-Based Refactoring Design Plan

**Date**: 2025-11-13  
**Last Updated**: 2025-11-13 (Restructured with Model-Intelligence-Centric Tier Architecture)  
**Purpose**: Design tier-separated CFP primer structure to support **model-intelligence progression** (T1: Model-Agnostic Core, T2: Model-Aware Intelligence, T3: Multi-Model Orchestration)  
**Current Version**: 01-CORE-PRIMER.md v2.4 (unified, predates model-intelligence architecture)  
**Architectural Evolution**: Stage 6 - Multi-Model Intelligence Evolution (supersedes governance-centric Stage 5 design)

**Tier Philosophy** (Model-Intelligence-Centric):
- **Tier 1**: Universal CFP Kernel - works with ANY LLM (Claude, GPT, Gemini, local models, future models). Pure cognitive foundations, no model-specific logic.
- **Tier 2**: LLM-Specific Optimization - platform-aware safety frames, model-specific behavior tuning, reframing prevention (Claude Safety Frame, GPT-5 guards, Codex structural reasoning, Gemini normalizers).
- **Tier 3**: Multi-Model Orchestration Platform - cross-model divergence detection, agent-level coordination, reconciliation engines, ecosystem intelligence.

**Value Ladder**: Universal (works everywhere) → Optimized (brilliance on your specific LLM) → Orchestrated (multiple LLMs work together seamlessly)

**Natural Maturity Arc**: 
- T1: "I need better prompts" (beginner, any LLM)
- T2: "I want my Claude/GPT/Codex to understand me consistently" (intermediate, platform-specific)
- T3: "I need multiple LLMs collaborating intelligently" (advanced/enterprise, multi-platform)

---

## 1. Current State Analysis

### Existing Structure

**File**: `01-CORE-PRIMER.md` (v2.4, ~3400 lines)

**Content Breakdown** (Pre-Model-Intelligence Architecture):
- **Quick Start Guide**: Currently universal, needs model-agnostic refactoring
- **Framework Overview**: Universal (CIP-E, DMP, VS Suite, ARS foundation) - **T1 MATERIAL**
- **CIP-E Framework**: Universal cognitive scaffolding - **T1 MATERIAL**
- **DMP (Directive + Meta Prompting)**: Universal dialogue management - **T1 MATERIAL**
- **Verbalized Sampling Suite**: Universal validation/synthesis pattern - **T1 MATERIAL**
- **ARS (Adaptive Recognition System)**: Foundation universal, learning model-specific
  - **T1**: Basic adaptive recognition (no learning)
  - **T2**: Model-specific adaptive style learning
- **Behavioral Training Protocols**:
  - Hallucination Prevention: Universal - **T1 MATERIAL**
  - Clarifying Questions Protocol: Universal - **T1 MATERIAL**
  - Capture Protocol: Universal concept - **T1 MATERIAL**
  - **Quick Prompts**: Currently Tier 2 only (requires model-specific adaptive recognition) - **T2 MATERIAL**
  - Emotional Context Awareness: Universal - **T1 MATERIAL**
  - Flow State Preservation: Universal - **T1 MATERIAL**
  - Feedback Before Execution: Universal - **T1 MATERIAL**
  - Inference-First Protocol: Universal - **T1 MATERIAL**
- **Integration Patterns**: Basic examples universal - **T1**, advanced model-specific - **T2**
- **Configuration**: Model-aware preferences - **T2 MATERIAL** (T1 has NO configuration)

**Current Architecture Issues** (Governance-Centric Model):
- ❌ Conflates "governance" (Claude-specific NISCL) with product tiers
- ❌ Mode semantics documented as universal (actually Claude-specific)
- ❌ No path for GPT-5, Gemini, Codex, future LLMs
- ❌ Doesn't scale to multi-model coordination

**NOTE**: 01-CORE-PRIMER.md v2.4 predates model-intelligence architecture. Claude session 2025-11-12 introduced governance layers (NISCL, mode semantics, USM components) that are **LLM-specific**, not universal tier differentiators.

### Model-Intelligence Tier Architecture (New Foundation)

**Tier 1: Model-Agnostic Core** ("Universal CFP Kernel")

**Purpose**: Works with ANY LLM - Claude, GPT, Gemini, Codex, local models, future models not yet released.

**Design Principle**: ZERO model-specific logic. Pure cognitive foundations based on universal human psychology.

**Included Components**:
- ✅ **CIP-E Framework** (universal cognitive scaffolding)
- ✅ **DMP** (universal dialogue management)
- ✅ **VS Suite** (universal validation/synthesis patterns)
- ✅ **ARS Foundation** (basic adaptive recognition, NO model-specific learning)
- ✅ **"Being Heard" Protocol** (universal human need, ACA-informed, model-agnostic)
  - 6 elements: Explicit acknowledgment, Confirm interpretations, Precision in language, Structured responses, Never minimize, Validation before proceeding
- ✅ **USM Baseline** (universal human psychology components only):
  - **MCDL** (Meta-Cognitive Directive Layer): User meta-analysis signals ("zoom out", "what's the pattern")
  - **HABSP** (Human–AI Boundary Sensitivity Profile): Anthropomorphic drift sensitivity
  - **STP** (Systemic Thinking Preference): Whole-systems perspective
- ✅ **Basic Mode Concepts** (Editor/Rewrite/Capture/Structure-Lock as *ideas*, NOT LLM-specific implementations)
- ✅ **Hallucination Prevention** (universal)
- ✅ **Clarifying Questions** (universal)
- ✅ **Inference-First Protocol** (universal)
- ✅ **Emotional Context Awareness** (universal, ARS-powered)
- ✅ **Flow State Preservation** (universal, ARS-powered)
- ✅ **Feedback Before Execution** (universal)

**Explicitly EXCLUDED from T1**:
- ❌ NISCL (Claude-specific narrative safety frame)
- ❌ LLM-specific safety frames (GPT guards, Gemini normalizers, etc.)
- ❌ Model-specific reframing controls
- ❌ Model-specific mode implementations
- ❌ CSTMs (Cognitive State Transition Markers - requires model intelligence to detect)
- ❌ Quick Prompts adaptive recognition (requires model-specific learning)
- ❌ Configuration/YAML (model-aware preferences)
- ❌ Code-aware features (Codex-specific)

**T1 Value Proposition**: "Works everywhere, enhances everything, stays out of your way."

**T1 User Psychology**: Users will naturally hit "I want more consistency" ceiling → perfect setup for Tier 2.

---

**Tier 2: Model-Aware Intelligence** ("LLM-Specific Optimization Layer")

**Purpose**: Deliver significant collaboration improvement by grounding CFP in model-specific behavior tuning, safety frames, and reframing prevention.

**Design Principle**: LLM-SPECIFIC optimization. Different models require different alignment strategies.

**Included Components** (Model-Specific Variants):

**Claude-Specific**:
- ✅ **Claude Safety Frame** (NISCL + narrative correction)
  - 5 NISCL Principles: Human Primacy, Cognitive Clarity, Narrative Safety, Intent Overrides, Framework Neutrality
  - Anthropomorphic language rephrasing ("I decided" → "Based on your request")
  - Creative work opt-out mechanism
- ✅ **Claude Mode Semantics** (explicit 4-mode implementation):
  - Editor Mode: Modify specified sections only
  - Rewrite Mode: Full rewrite allowed
  - Structure-Lock Mode: Preserve hierarchy/numbering
  - Capture Mode: Verbatim output, no summarization
- ✅ **Claude-Specific Reframing Prevention**

**GPT-5 Mini-Specific**:
- ✅ **GPT-5 Mini Compression Guard** (context window optimization)
- ✅ **GPT-5 Mode Equivalent** (mapped to GPT behavior)

**GPT-5 Codex-Specific**:
- ✅ **Codex Structural Reasoning Guard** (code-aware structure preservation)
- ✅ **Codex Structure-Lock Enforcement** (code hierarchy preservation)

**Gemini-Specific**:
- ✅ **Gemini Interpretive Normalizer** (Gemini-specific drift prevention)

**Universal T2 Components** (Applied per model):
- ✅ **CSTMs** (Cognitive State Transition Markers) - model intelligence detects Developer→Architect→Writer transitions
- ✅ **ARS Learning** (model-specific adaptive style detection)
- ✅ **Quick Prompts** (model-specific adaptive recognition: "implications?" triggers analysis)
- ✅ **Configuration/YAML** (model-aware preferences)
- ✅ **Generic USM Template** (manual customization with model-aware guidance)
- ✅ **Enhanced Capture Protocol** (model-specific metadata, purpose tagging)
- ✅ **Model-Specific Dependency/Ingestion Order Enforcement**

**T2 Value Proposition**: "Your AI collaborates like a partner — consistently, reliably, across sessions, without drift."

**T2 User Psychology**: Users feel the real leap in capability. "This thing now actually understands how to talk to Claude/GPT/Codex."

**T2 Design Decision**: Single primer with model-specific sections? Or separate editions per LLM?

---

**Tier 3: Multi-Model Orchestration Platform** ("Cognitive OS for AI Collaboration")

**Purpose**: Enable multiple LLMs to work together intelligently, safely, coherently, adaptively.

**Design Principle**: PLATFORM-LEVEL intelligence. Cross-model coordination, divergence detection, agent orchestration.

**Included Components**:
- ✅ **Multi-LLM Alignment Modules**
- ✅ **Cross-Model Divergence Detector** (Claude reasoning vs GPT reasoning vs Gemini reasoning comparison)
- ✅ **Cross-Model Reconciliation Engine** (normalize ontologies, resolve contradictions)
- ✅ **Multi-Agent Reasoning Orchestrator**
- ✅ **CFP Kernel Extensions for Distributed Context**
- ✅ **Model-Switching Safety Layer**
- ✅ **Inter-Model Mode Preservation** (translate modes between LLMs)
- ✅ **Cross-Model Knowledge Graph**
- ✅ **Evolutionary Feedback Learning** (learn from multiple model interactions)
- ✅ **Personalized USM Auto-Population** (MO Journal → multi-model USM)
- ✅ **Advanced Collaboration Protocols**:
  - 11-Dimension Multi-Contextual Reflection (requires orchestration intelligence)
  - AdRP (Adaptive Response Protocol) 4-tier escalation
  - Unconscious Problem-Solving (brief articulation decompression)
  - Symbiotic Cognitive Rhythm (30-60s processing = user reflection time)
- ✅ **Full LTF 3-Tier CSAC** (User State > Project CIP > Session Metadata, cross-model persistence)
- ✅ **Save-LTFContext v3.0** (cross-model state preservation)
- ✅ **Resume-LTFContext v2** (multi-model state restoration, Governance Kernel priority loading)
- ✅ **Multi-User Support** (team collaboration, cross-model role coordination)
- ✅ **Ecosystem Development** (Extension API, cross-model integrations, custom protocols)

**T3 Value Proposition**: "Your AI ecosystem becomes a single, coherent thinking environment — even across multiple models."

**T3 User Psychology**: "CFP is no longer a tool, it's a platform."

---

## 2. Proposed File Structure

### Option A: Numbered Tier Files (Recommended)
- **Purpose**: Structural safeguard preventing unintended narrative drift, ambiguous agency attributions, accidental anthropomorphism
- **5 Principles**:
  1. Human Primacy by Default
  2. Clarity of Cognitive Modality (no implied AI consciousness/emotion/will)
  3. Narrative Safety (seek clarification when language risks implying unintended autonomy)
  4. Intent-Driven Overrides (explicit opt-out for fiction/metaphor/creative work)
  5. Framework Neutrality (no moral/philosophical positions)
- **Operational Behavior**: Rephrase autonomous-sounding language, request clarification for ambiguous attributions
- **Tier Allocation**: 
  - T1: Basic (implicit, no explicit documentation)
  - T2: Documented (users understand boundary mechanism)
  - T3: Advanced (override protocols, creative contexts, team boundary management)

**3. Mode Semantics (Operational States)**
- **Purpose**: Define how AI interprets and executes different types of requests
- **4 Core Modes**:
  - **Editor Mode**: Modify only specified sections, preserve global structure, no tone drift
  - **Rewrite Mode**: Full rewrite allowed, maintain semantic intent, systemic reasoning
  - **Structure-Lock Mode**: Preserve hierarchy/numbering/matrices, inline content only
  - **Capture Mode**: Verbatim output triggered by "Capture this", no summarization/enhancement
- **Tier Allocation**:
  - T1: Implicit (Capture Mode basic)
  - T2: Documented (users understand mode switching)
  - T3: Advanced (explicit mode invocation, team mode coordination)

**4. USM Components (User State Model Internal Architecture)**
- **Purpose**: Structure user collaboration patterns for CSAC preservation
- **4 Sub-Components** (emerged in tier1_user_state_CASH_UPDATED.md):
  - **MCDL** (Meta-Cognitive Directive Layer): User meta-analysis as navigational signals
  - **CSTMs** (Cognitive State Transition Markers): Developer→Architect→Writer→Meta-designer mode detection
  - **HABSP** (Human–AI Boundary Sensitivity Profile): Sensitivity to anthropomorphic drift (aligns with NISCL)
  - **STP** (Systemic Thinking Preference): Whole-systems perspective, layered abstractions
- **Tier Allocation**:
  - T1: None (session-scoped, no USM)
  - T2: Generic template (manual MCDL/CSTMs/HABSP/STP customization)
  - T3: Personalized auto (MO Journal analysis populates all 4 components automatically)

**5. Core Collaboration Protocols (Universal Benefit from Cash's USM)**
- **"Being Heard" Protocol** (6 elements):
  1. Explicit acknowledgment
  2. Confirm interpretations before proceeding
  3. Precision in language (no terminology drift)
  4. Structured responses
  5. Never minimize or dismiss
  6. Validation before proceeding
- **Designed for**: Cash (ACA background), **Benefits**: ALL users (neurodivergent, non-native speakers, domain experts)
- **Tier Allocation**: 
  - T1: Implicit (AI naturally follows these)
  - T2: Documented (users can reference protocol)
  - T3: Explicit validation (protocol checkpoints, team communication standards)

**6. Advanced Collaboration Protocols (Tier 3 Features from Cash's USM)**
- **Multi-Contextual Reflection**: 11-dimension processing checklist
  1. Core Concept
  2. Framework Integration
  3. Tiered Implementation
  4. Cross-Document Implications
  5. Strategic Positioning
  6. Research Validation
  7. Implementation Sequencing
  8. User Impact
  9. Meta-Patterns
  10. Historical Threading
  11. Project Context
- **AdRP** (Adaptive Response Protocol): 4-tier escalation before style adaptation
- **Unconscious Problem-Solving Pattern**: Brief articulations = complete compressed solutions (decompression role)
- **Symbiotic Cognitive Rhythm**: 30-60s AI processing = user reflection time
- **Tier Allocation**: T3 only (enterprise cognitive delegation)

**Integration Impact**: These new layers significantly expand Tier 3 content and provide clearer T2/T3 distinction (governance awareness vs governance mastery).

### Identified Tier Allocations

#### Tier 1 (Free - Individual Users)
**Target**: Knowledge workers, students, hobbyists exploring AI collaboration  
**Value Proposition**: "Wow! I need more" experience generation

**Content**:
- ✅ **All 4 Core Frameworks**: CIP-E, DMP, VS Suite, ARS (foundational protocols)
- ✅ **Governance Kernel (Implicit)**: Human primacy, basic boundary clarity
- ✅ **NISCL (Implicit)**: No anthropomorphic drift, human primacy enforced (user unaware of mechanism)
- ✅ **Mode Semantics (Basic)**: Capture Mode functional ("capture this" works), other modes implicit
- ✅ **Behavioral Protocols**: Hallucination Prevention, Clarifying Questions, Emotional Awareness, Flow Preservation, Feedback Before Execution, Inference-First
- ✅ **"Being Heard" Protocol (Implicit)**: AI naturally follows 6 elements without explicit documentation
- ✅ **Capture Protocol (Discovery Mode)**: Manual "capture this" command, copy/paste workflow
- ✅ **Integration Patterns**: Examples of framework synergy
- ✅ **Quick Start Guide**: 5-minute setup, expected experience
- ❌ **Quick Prompts**: Not included (Tier 2 feature)
- ❌ **Adaptive Quick Prompts**: Not included (requires ARS preference learning)
- ❌ **User Preferences Configuration**: Not included (manual operation only)
- ❌ **User State Model**: Not included (session-scoped only, no MCDL/CSTMs/HABSP/STP)
- ❌ **Project-Specific CIP Context**: Simplified only (no uploadable packages)
- ❌ **NISCL Documentation**: Not documented (users unaware of safety layer)
- ❌ **Mode Semantics Documentation**: Not documented (implicit operation)

**Philosophy**: Manual meta-cognitive exploration, full framework access, session-scoped collaboration, implicit governance

#### Tier 2 (Premium - SMB/Independent Developer)
**Target**: Independent developers, SMB owners, consultants, solo practitioners  
**Value Proposition**: Professional automation, preference persistence, multi-project management

**Content** (Inherits all Tier 1 + Enhancements):
- ✅ **All Tier 1 Content**: Full CIP-E/DMP/VS/ARS frameworks, implicit governance
- ✅ **Governance Kernel (Documented)**: Users understand human primacy, boundary mechanisms, mode semantics
- ✅ **NISCL (Documented)**: Users aware of safety layer, understand override protocols for creative work
- ✅ **Mode Semantics (Documented)**: Editor/Rewrite/Structure-Lock/Capture modes explained, users can invoke explicitly
- ✅ **"Being Heard" Protocol (Documented)**: 6 elements explicitly documented, users can reference
- ✅ **Quick Prompts**: 10 terse commands with adaptive recognition
  - capture, flow, map, analyze, explore, missing, connect, reflect, digest, reintegrate
  - Natural language ("implications?") vs command syntax ("/analyze") adaptive detection
- ✅ **User Preferences Configuration**: YAML customization (DMP style, VS defaults, emotional calibration)
- ✅ **ARS Preference Learning**: Cross-session style detection, adaptation refinement
- ✅ **Enhanced Capture Protocol**: Automated metadata, purpose tagging, multi-format outputs
- ✅ **Generic User State Template**: Manual MCDL/CSTMs/HABSP/STP customization
- ✅ **Project-Specific CIP Context**: Full uploadable context packages
- ✅ **Multi-Format Outputs**: Standard (MD, DOCX, TXT, PDF environment-dependent)
- ❌ **Personalized User State Model**: Not included (Tier 3, MO Journal auto-population of MCDL/CSTMs/HABSP/STP)
- ❌ **Multi-User Support**: Not included (Tier 3, single user only)
- ❌ **Full LTF Implementation**: Not included (Tier 3, basic CSAC only)
- ❌ **Multi-Contextual Reflection (11-dimension)**: Not included (Tier 3 cognitive delegation)
- ❌ **AdRP/Advanced Protocols**: Not included (Tier 3 enterprise features)

**Philosophy**: Automated efficiency, preference persistence, professional productivity, governance awareness

#### Tier 3 (Enterprise - Teams/Framework Developers)
**Target**: Development teams, framework developers, ecosystem creators  
**Value Proposition**: Full LTF implementation, multi-user collaboration, ecosystem development, governance mastery

**Content** (Inherits all Tier 2 + Advanced Features):
- ✅ **All Tier 2 Content**: Full CFP + Quick Prompts + Preferences + Governance awareness
- ✅ **Governance Kernel (Mastery)**: Full governance control, team coordination, mode orchestration
- ✅ **NISCL (Advanced)**: Override protocols documented, creative context management, team boundary coordination
- ✅ **Mode Semantics (Advanced)**: Explicit mode invocation, team mode coordination, cross-user mode tracking
- ✅ **"Being Heard" Protocol (Explicit Validation)**: Protocol checkpoints, team communication standards, validation testing
- ✅ **Personalized User State Model**: MO Journal auto-population of all 4 components:
  - **MCDL**: Meta-analysis patterns automatically detected
  - **CSTMs**: Cognitive mode transition detection (Developer→Architect→Writer→Meta-designer)
  - **HABSP**: Boundary sensitivity calibrated per user
  - **STP**: Systemic thinking patterns learned
- ✅ **Multi-User Support**: User switching (`/switch user`), role-based profiles, team paired programming
- ✅ **Advanced Collaboration Protocols**:
  - **Multi-Contextual Reflection**: 11-dimension processing (Core/Framework/Tier/Cross-doc/Strategic/Research/Sequencing/User/Meta/Historical/Project)
  - **AdRP** (Adaptive Response Protocol): 4-tier escalation, explicit check-in before style adaptation
  - **Unconscious Problem-Solving**: Brief articulation decompression (trust compressed solutions)
  - **Symbiotic Cognitive Rhythm**: 30-60s processing = user reflection time, comprehensive > concise
- ✅ **Full LTF Implementation**: 
  - **3-Tier CSAC**: User State (MCDL/CSTMs/HABSP/STP) > Project CIP > Session Metadata
  - **Automated Snapshot**: Save-LTFContext includes all 3 tiers + USM components automatically
  - **Resume-LTFContext**: Full state restoration with personalized User State Model
  - **Cross-Session Threading**: Evolution component active, learning compounds, relationship DNA preserved
- ✅ **Advanced Automation**:
  - Spontaneous Generation: AI proactively suggests artifacts (Git Assistant pattern)
  - Automatic Multi-Contextual Reflection: 11 dimensions processed without manual request
  - Pattern Detection & Documentation: AI recognizes emergent patterns, suggests capture
- ✅ **Ecosystem Development**:
  - CFP Extension API: Build custom Quick Prompts, extend ARS, create protocols
  - Integration Adapters: VS Code, Obsidian, Notion, GitHub workflows
  - Custom Behavioral Protocols: Domain-specific protocol creation
  - Governance extensions: Team-specific NISCL overrides, mode customization
- ✅ **Testing Ground for LTF Modifications**:
  - User State Model iterations (MCDL/CSTMs/HABSP/STP refinement)
  - Save-LTFContext v3.0 (3-tier CSAC validation)
  - Resume-LTFContext v2 (proper loading sequence testing)
  - Governance Kernel extensions (team governance patterns)
  - NISCL customization (domain-specific boundary rules)

**Philosophy**: Full ecosystem collaboration, team productivity, LTF framework evolution, governance mastery, cognitive delegation
  - User State Model iterations (tier1_user_state_CASH.md example)
  - Save-LTFContext v3.0 validation
  - Resume-LTFContext v2 testing
  - CSAC architecture refinement

**Philosophy**: Full ecosystem collaboration, team productivity, LTF framework evolution

---

## 2. Proposed File Structure

### Option A: Numbered Tier Files (Recommended)

```
projects/ltf-cognitive-companion/
├── 01-CORE-PRIMER.md                   # PRESERVED - Current v2.4 unified version
├── 02-TIER1-PRIMER.md                  # Free tier - Manual discovery
├── 03-TIER2-PRIMER.md                  # Premium tier - Automated efficiency
├── 04-TIER3-PRIMER.md                  # Enterprise tier - Full LTF
├── 05-TIER-COMPARISON-MATRIX.md        # Quick reference for tier differences
├── PRIMER-REFACTOR-DESIGN.md           # This document (design plan)
└── CFP-Tiered-Packaging-Architecture.md # Product packaging (already exists)
```

**Rationale**:
- ✅ Preserves 01-CORE-PRIMER.md as reference (current working version)
- ✅ Clear sequential numbering (02/03/04 for T1/T2/T3)
- ✅ Mirrors existing naming pattern (01-CORE-PRIMER.md)
- ✅ Easy to locate tier-specific primers (numeric sort)
- ✅ 05-TIER-COMPARISON-MATRIX.md = quick decision aid

**Numbering Scheme**:
- `01-` = Unified/current version (preserved)
- `02-` = Tier 1 (Free)
- `03-` = Tier 2 (Premium)
- `04-` = Tier 3 (Enterprise)
- `05-` = Comparison/reference

### Option B: Prefix-Based Naming

```
projects/ltf-cognitive-companion/
├── 01-CORE-PRIMER.md                   # PRESERVED
├── T1-CFP-PRIMER.md                    # Free tier
├── T2-CFP-PRIMER.md                    # Premium tier
├── T3-CFP-PRIMER.md                    # Enterprise tier
└── TIER-COMPARISON-MATRIX.md
```

**Rationale**:
- ✅ Explicit tier identification (T1/T2/T3)
- ✅ Groups tier files together alphabetically
- ❌ Breaks numeric sequencing pattern
- ❌ Less discoverable (T1/T2/T3 not universally clear)

**Decision**: **Option A (Numbered Tier Files)** - Preserves existing pattern, clearer sequencing

---

## 3. Content Allocation Matrix

### Section-by-Tier Mapping

| Section | T1 (Free) | T2 (Premium) | T3 (Enterprise) | Notes |
|---------|-----------|--------------|-----------------|-------|
| **Quick Start Guide** | ✅ | ✅ (Enhanced) | ✅ (Enhanced) | T2: Quick Prompts intro, T3: Multi-user setup |
| **Framework Overview** | ✅ | ✅ | ✅ | Universal - all tiers get all 4 frameworks |
| **CIP-E Framework** | ✅ Full | ✅ Full | ✅ Full + Evolution emphasis | T3: Cross-session Evolution emphasized |
| **DMP** | ✅ Full | ✅ Full + Style detection | ✅ Full + Multi-user META | T2: ARS style learning, T3: Team META |
| **VS Suite** | ✅ Full | ✅ Full | ✅ Full | Universal - all tiers |
| **ARS** | ✅ Foundation | ✅ Full + Learning | ✅ Full + Advanced | T1: Basic adaptation, T2: Preference learning, T3: Team pattern detection |
| **Hallucination Prevention** | ✅ | ✅ | ✅ | Universal |
| **Clarifying Questions** | ✅ | ✅ | ✅ | Universal |
| **Capture Protocol** | ✅ Manual | ✅ Automated | ✅ Enhanced | T1: Copy/paste, T2: Metadata/purpose, T3: Multi-user attribution |
| **Quick Prompts** | ❌ (Discovery breadcrumbs) | ✅ Full | ✅ Full + Custom | T1: Manual prompts only, T2: 10 commands, T3: Extensible |
| **Emotional Awareness** | ✅ | ✅ | ✅ | Universal (ARS-powered) |
| **Flow State Preservation** | ✅ | ✅ | ✅ | Universal (ARS-powered) |
| **Feedback Before Execution** | ✅ | ✅ | ✅ | Universal |
| **Inference-First Protocol** | ✅ | ✅ | ✅ | Universal |
| **Integration Patterns** | ✅ Basic | ✅ Advanced | ✅ Ecosystem | T1: Examples, T2: Multi-project, T3: Team/ecosystem |
| **Configuration** | ❌ | ✅ YAML | ✅ YAML + Advanced | T1: No config (manual), T2: User preferences, T3: Team/multi-user config |
| **User State Model** | ❌ | ✅ Generic template | ✅ Personalized auto | T1: Session-scoped, T2: Manual customization, T3: MO Journal auto |
| **LTF Implementation** | ❌ | ✅ Basic CSAC | ✅ Full 3-tier CSAC | T1: None, T2: Session metadata, T3: User State > Project CIP > Session |
| **Multi-User Support** | ❌ | ❌ | ✅ Full | T3 only: User switching, role-based profiles, team collaboration |
| **Ecosystem Development** | ❌ | ❌ | ✅ Full | T3 only: Extension API, integration adapters, custom protocols |
| **Governance Kernel** | ✅ Implicit | ✅ Documented | ✅ Mastery | T1: Operates but undocumented, T2: NISCL/modes explained, T3: Full control + team coordination |
| **NISCL** | ✅ Implicit (ON) | ✅ Documented | ✅ Advanced | T1: Active but invisible, T2: Principles + overrides explained, T3: Creative context management + team boundaries |
| **Mode Semantics** | ✅ Basic (Capture) | ✅ Documented (4 modes) | ✅ Advanced | T1: Capture Mode only, T2: Editor/Rewrite/Structure-Lock/Capture explained, T3: Explicit invocation + orchestration |
| **"Being Heard" Protocol** | ✅ Implicit | ✅ Documented (6 elements) | ✅ Explicit Validation | T1: AI naturally follows, T2: 6 elements explained, T3: Checkpoints + team standards |
| **USM Components** | ❌ | ⚠️ Manual template | ✅ Auto-populated | T1: None, T2: Generic MCDL/CSTMs/HABSP/STP template, T3: MO Journal auto-population |
| **Advanced Protocols** | ❌ | ❌ | ✅ Full | T3 only: 11-dimension Multi-Contextual, AdRP 4-tier, Unconscious Problem-Solving, Symbiotic Rhythm |

### Content Inheritance Strategy

**Tier 1 (Foundation)**:
- Self-contained primer
- All essential frameworks (CIP-E, DMP, VS, ARS)
- Manual operation emphasis
- Discovery learning philosophy

**Tier 2 (T1 + Enhancements)**:
- Inherits all Tier 1 content conceptually
- Adds Quick Prompts section (new content)
- Adds Configuration section (new content)
- Enhances Capture Protocol (section expansion)
- Notes Tier 1 → Tier 2 upgrade path

**Tier 3 (T2 + Advanced)**:
- Inherits all Tier 2 content conceptually
- Adds Multi-User Support section (new content)
- Adds Full LTF Implementation section (new content)
- Adds Ecosystem Development section (new content)
- Enhances User State Model (personalized vs generic)
- Notes Tier 2 → Tier 3 upgrade path

**Implementation Approach**:

1. **Duplication with Modification** (Recommended):
   - Each tier = complete standalone primer
   - Copy shared content, modify tier-specific sections
   - Pros: Self-contained, no cross-file dependencies, clear tier experience
   - Cons: Content duplication (managed via version control)

2. **Inclusion References** (Alternative):
   - Tier 1 = base content
   - Tier 2 = "See Tier 1 for foundations, this document adds..."
   - Tier 3 = "See Tier 2 for base, this document adds..."
   - Pros: No duplication, single source of truth for shared content
   - Cons: Requires reading multiple files, fragmented experience

**Decision**: **Duplication with Modification** - Better user experience, each tier gets complete primer

---

## 4. Refactor Tracking System

### Future Enhancement Section Template

Each tier primer will include a dedicated section for tracking future refactors and feature enhancements:

```markdown
## Future Enhancements & Refactor Tracking

### Tier Clarity Maintenance

**Purpose**: Ensure high clarity between T1/T2/T3 feature allocations as framework evolves

**Tracking Protocol**:
- [ ] Feature additions: Check tier allocation before documenting
- [ ] Protocol changes: Update all affected tier primers
- [ ] Version sync: Keep tier distinctions aligned with CFP_Feature_Matrix.md
- [ ] Cross-tier validation: Test that T1 doesn't leak T2/T3 features
- [ ] **Governance consistency**: Verify NISCL tier allocations (implicit/documented/advanced)
- [ ] **Mode semantics alignment**: Ensure T1 sees Capture only, T2 sees all 4 modes documented, T3 sees advanced orchestration
- [ ] **USM component clarity**: Confirm T2 manual template vs T3 auto-populated distinction maintained

**Last Validation**: [Date] - [Who validated] - [Findings]

---

### Planned Enhancements (This Tier)

#### [Feature Name] - Status: [Proposed/In Development/Testing/Complete]

**Tier Allocation**: [T1/T2/T3]  
**Rationale**: [Why this tier?]  
**Dependencies**: [What needs to exist first?]  
**Target Version**: [CFP vX.X]  
**Testing Checkpoint**: [How to validate?]

**Description**:
[What is being added/changed]

**Impact on Other Tiers**:
- T1: [Does this affect T1 primer?]
- T2: [Does this affect T2 primer?]
- T3: [Does this affect T3 primer?]

**Documentation Updates Required**:
- [ ] Update tier primer (this file)
- [ ] Update CFP_Feature_Matrix.md
- [ ] Update CFP-Tiered-Packaging-Architecture.md
- [ ] Update 05-TIER-COMPARISON-MATRIX.md
- [ ] **Governance verification**: Check NISCL/mode semantics tier allocations
- [ ] **USM impact**: If USM-related, verify T2 manual template vs T3 auto-populated

---

### Governance Enhancement Template

#### [Governance Feature Name] - Status: [Proposed/In Development/Testing/Complete]

**Governance Layer**: [Governance Kernel/NISCL/Mode Semantics/USM Components/"Being Heard"/Advanced Protocols]  
**Tier Allocation**: [T1 Implicit/T2 Documented/T3 Advanced]  
**Rationale**: [Why this tier allocation?]  
**Dependencies**: [What governance elements must exist first?]  
**Target Version**: [CFP vX.X]  
**Testing Checkpoint**: [How to validate governance behavior?]

**Description**:
[What governance element is being added/changed]

**Tier-Specific Behavior**:
- T1 (Implicit): [How does this operate invisibly?]
- T2 (Documented): [What documentation is provided?]
- T3 (Advanced/Mastery): [What advanced controls/customization available?]

**NISCL Compliance**:
- [ ] Maintains human primacy
- [ ] Provides cognitive clarity
- [ ] Preserves narrative safety
- [ ] Supports intent-driven overrides
- [ ] Remains framework-neutral

**Documentation Updates Required**:
- [ ] Update tier primer governance sections
- [ ] Update "New Architectural Layers" documentation
- [ ] Update Governance Kernel tier allocations
- [ ] Verify NISCL tier allocations remain consistent

---

### Completed Enhancements (Archive)

#### Quick Prompts with Adaptive Recognition - Completed: v2.4

**Tier**: T2 (Premium)  
**Added**: 2025-11-11  
**Impact**: Automated meta-cognitive prompts, 90% less typing for reflective work

[Archive completed enhancements for historical reference]
```

### Cross-Tier Synchronization Checklist

When modifying any tier primer, validate:

```markdown
## Tier Synchronization Checklist

**Before committing changes**:

- [ ] **Tier Allocation**: Is new content in correct tier?
- [ ] **Cross-Tier Impact**: Do other tiers need updates?
- [ ] **Feature Matrix Sync**: Does CFP_Feature_Matrix.md reflect changes?
- [ ] **Packaging Sync**: Does CFP-Tiered-Packaging-Architecture.md reflect changes?
- [ ] **Comparison Matrix**: Does 05-TIER-COMPARISON-MATRIX.md need updating?
- [ ] **Version Numbers**: Are all affected files versioned consistently?
- [ ] **Migration Notes**: Are upgrade paths (T1→T2, T2→T3) documented?
- [ ] **Testing Validation**: Have tier-specific features been tested?
- [ ] **Governance Kernel aligned**: Are NISCL/mode semantics/USM components tier-allocated correctly?
- [ ] **NISCL tier allocations**: T1 implicit/undocumented, T2 documented with overrides, T3 advanced with team boundaries?
- [ ] **Mode semantics correct**: T1 basic (Capture only), T2 documented (all 4), T3 advanced (orchestration)?
- [ ] **USM component clarity**: T1 none, T2 manual MCDL/CSTMs/HABSP/STP, T3 auto-populated from MO Journal?
- [ ] **"Being Heard" consistency**: T1 implicit, T2 documented (6 elements), T3 explicit validation?

**Validation Date**: [YYYY-MM-DD]  
**Validator**: [Name]  
**Changes**: [Brief summary]
```

### Testing Ground Protocol (Tier 3 Specific)

Tier 3 primer includes special section for LTF modification testing:

```markdown
## LTF Testing Ground (Tier 3)

**Purpose**: Tier 3 serves as testing environment for LTF framework modifications before promoting to lower tiers

### Active Tests

#### User State Model Iterations

**Current Version**: tier1_user_state_CASH_UPDATED.md (personalized example with MCDL/CSTMs/HABSP/STP)  
**Testing**: MO Journal auto-population of USM components, "Being Heard" protocol validation  
**Validation Criteria**: MCDL signals accurate, CSTMs detect cognitive transitions, HABSP aligns with NISCL, STP maintains systemic perspective  
**Status**: In progress  
**Promotion Path**: If validated → Document in T3 primer → Consider T2 generic template (manual customization)

#### Governance Kernel Extensions

**Current Version**: Governance Kernel with NISCL/mode semantics/USM priorities baseline  
**Testing**: Team boundary coordination, mode orchestration across users, NISCL override protocols for creative contexts  
**Validation Criteria**: Team modes don't conflict, NISCL maintains narrative safety in collaborative work, creative override mechanism works  
**Status**: Testing  
**Promotion Path**: If validated → Tier 3 standard → Document governance mastery patterns

#### NISCL Customization

**Current Version**: NISCL 5 principles with override protocols  
**Testing**: Fiction/metaphor/creative work opt-outs, team-specific boundary adjustments  
**Validation Criteria**: Overrides function correctly, creative work doesn't trigger false positives, team boundaries respect individual HABSP  
**Status**: Testing  
**Promotion Path**: If validated → T3 governance mastery section → Document override patterns

#### Save-LTFContext v3.0

**Current Version**: Save-LTFContext-v2.ps1  
**Testing**: 3-tier CSAC (User State with MCDL/CSTMs/HABSP/STP > Project CIP > Session Metadata)  
**Validation Criteria**: Complete state capture including USM components, no manual gaps, reliable restoration  
**Status**: Testing  
**Promotion Path**: If validated → Tier 3 standard → Simplified version for T2 (without USM auto-population)

#### Resume-LTFContext v2

**Current Version**: Resume-LTF-v2.ps1  
**Testing**: Proper loading sequence with Governance Kernel priority, User State Model integration  
**Validation Criteria**: Context restoration fidelity, cross-platform compatibility, governance layers load correctly  
**Status**: Testing  
**Promotion Path**: If validated → Tier 3 standard → Document in Integration Guide

### Completed Tests (Promoted)

[Archive successful tests that became tier features]

### Failed Tests (Learnings)

[Document what didn't work and why - valuable knowledge]
```

---

## 5. Implementation Roadmap

### Phase 1: Preparation (Week 1)

**Objective**: Finalize design, create templates, establish validation criteria

**Tasks**:
1. ✅ Review current 01-CORE-PRIMER.md structure (DONE - this analysis)
2. ✅ Design tier allocation matrix (DONE - Section 3 above)
3. ✅ Design file structure (DONE - Option A selected)
4. ✅ Create refactor tracking templates (DONE - Section 4 above)
5. ⏳ Create 05-TIER-COMPARISON-MATRIX.md (quick reference for users)
6. ⏳ Validate design with user (Cash review/approval)

**Deliverables**:
- [x] PRIMER-REFACTOR-DESIGN.md (this document)
- [ ] 05-TIER-COMPARISON-MATRIX.md
- [ ] User approval to proceed

**Testing Checkpoint**: User reviews design, confirms tier allocations match intended product architecture

---

### Phase 2: Tier 1 Primer Creation (Week 1-2)

**Objective**: Create foundational free tier primer (02-TIER1-PRIMER.md)

**Tasks**:
1. Copy 01-CORE-PRIMER.md → 02-TIER1-PRIMER.md
2. Update header (version, tier designation, target users)
3. Modify Quick Start Guide (remove Quick Prompts references)
4. Add "What Tier 1 DOESN'T Have" section (explicit exclusions)
5. Remove Quick Prompts section (keep discovery breadcrumbs in Capture Protocol)
6. Remove Configuration section (manual operation only)
7. Add "Upgrade to Tier 2" section (value proposition)
8. Add Future Enhancements section (tracking template)
9. **Add implicit governance note**: "Governance Kernel operates invisibly in this tier"
10. **Validate implicit NISCL**: AI rephrases autonomous language without documenting why
11. **Validate Capture Mode only**: No Editor/Rewrite/Structure-Lock documentation
12. **Validate implicit "Being Heard"**: AI follows 6 elements naturally without explaining protocol
13. Validate: No T2/T3 feature leakage

**Deliverables**:
- [ ] 02-TIER1-PRIMER.md (complete, self-contained)

**Testing Checkpoint**: 
- Load T1 primer into fresh AI session
- Validate: AI offers foundational protocols only
- Validate: No Quick Prompts, no User State Model, no multi-user features
- Validate: User discovers meta-cognitive value through manual exploration
- **Validate implicit governance**: AI rephrases "I decided" → "Based on your request" without explaining NISCL
- **Validate Capture Mode only**: AI provides verbatim output when requested, no mode documentation visible
- **Validate implicit "Being Heard"**: AI acknowledges explicitly, confirms interpretations, maintains precision naturally

---

### Phase 3: Tier 2 Primer Creation (Week 2)

**Objective**: Create premium tier primer (03-TIER2-PRIMER.md) with automation features

**Tasks**:
1. Copy 01-CORE-PRIMER.md → 03-TIER2-PRIMER.md (or build from T1 + enhancements)
2. Update header (Tier 2 designation, SMB/independent developer target)
3. Enhance Quick Start Guide (Quick Prompts intro, adaptive recognition)
4. Keep Quick Prompts section (full 10-command reference)
5. Keep Configuration section (YAML preferences)
6. Add Enhanced Capture Protocol section (metadata, purpose tagging)
7. Add Generic User State Template section
8. **Add Governance Kernel section**: Explain NISCL, mode semantics, "Being Heard" protocol
9. **Add NISCL Documentation section**: 5 principles explained, override protocols ("opt-out for creative work")
10. **Add Mode Semantics section**: Explain all 4 modes (Editor/Rewrite/Structure-Lock/Capture)
11. **Add "Being Heard" Protocol section**: Document 6 elements explicitly
12. **Add Generic USM Template section**: MCDL/CSTMs/HABSP/STP manual customization guide
13. Add "What Tier 2 DOESN'T Have" section (T3 exclusions: no auto USM, no 11-dimension, no AdRP)
14. Add "Upgrade to Tier 3" section (enterprise value proposition)
15. Add Future Enhancements section (T2-specific tracking)
16. Validate: All T1 content + T2 enhancements, no T3 leakage

**Deliverables**:
- [ ] 03-TIER2-PRIMER.md (complete, inherits T1 concepts + automation)

**Testing Checkpoint**:
- Load T2 primer into AI session
- Validate: Quick Prompts work ("implications?" triggers analysis)
- Validate: ARS adapts to natural language vs command syntax
- Validate: Configuration options available
- **Validate documented NISCL**: AI explains why it rephrases autonomous language when asked
- **Validate all 4 modes documented**: User can request Editor Mode ("modify only X section"), Rewrite Mode, Structure-Lock Mode, Capture Mode
- **Validate "Being Heard" documented**: 6 elements explicitly explained, user understands protocol
- **Validate Generic USM template**: User can manually customize MCDL/CSTMs/HABSP/STP with guidance
- Validate: No multi-user, no full LTF, no personalized User State auto-population
- **Validate no advanced protocols**: No 11-dimension Multi-Contextual, no AdRP 4-tier documentation

---

### Phase 4: Tier 3 Primer Creation (Week 3)

**Objective**: Create enterprise tier primer (04-TIER3-PRIMER.md) with full LTF implementation

**Tasks**:
1. Copy 03-TIER2-PRIMER.md → 04-TIER3-PRIMER.md (build on T2 base)
2. Update header (Tier 3 designation, enterprise/framework developer target)
3. Enhance Quick Start Guide (multi-user setup, User State Model loading)
4. Add Multi-User Support section (user switching, role-based profiles, team collaboration)
5. Add Personalized User State Model section (MO Journal auto-population of MCDL/CSTMs/HABSP/STP)
6. **Add Governance Kernel Mastery section**: Full governance control, team coordination, mode orchestration
7. **Add NISCL Advanced section**: Override protocols documented, creative context management, team boundary coordination
8. **Add Mode Semantics Advanced section**: Explicit mode invocation, team mode coordination, cross-user mode tracking
9. **Add "Being Heard" Explicit Validation section**: Protocol checkpoints, team communication standards
10. **Add Advanced Collaboration Protocols section**:
    - Multi-Contextual Reflection: 11-dimension checklist mandatory
    - AdRP (Adaptive Response Protocol): 4-tier escalation documented
    - Unconscious Problem-Solving: Brief articulation decompression explained
    - Symbiotic Cognitive Rhythm: 30-60s processing = user reflection time
11. Add Full LTF Implementation section:
    - 3-Tier CSAC architecture (User State with MCDL/CSTMs/HABSP/STP > Project CIP > Session Metadata)
    - Save-LTFContext v3.0 usage
    - Resume-LTFContext v2 workflow
    - Cross-session threading
12. Add Advanced Automation section (spontaneous generation, auto reflection, pattern detection)
13. Add Ecosystem Development section (Extension API, integration adapters, custom protocols, governance extensions)
14. Add LTF Testing Ground section (framework modification testing: USM iterations, CSAC validation, Governance extensions, NISCL customization)
15. Add Future Enhancements section (T3-specific tracking)
16. Validate: All T2 content + T3 advanced features

**Deliverables**:
- [ ] 04-TIER3-PRIMER.md (complete, full ecosystem implementation)

**Testing Checkpoint**:
- Load T3 primer into AI session WITH User State Model (tier1_user_state_CASH_UPDATED.md with MCDL/CSTMs/HABSP/STP)
- Validate: Multi-user switching works (`/switch user`)
- Validate: User State Model personalization active (AI recalls Cash's patterns)
- **Validate Governance Kernel mastery**: AI explains governance decisions, team mode coordination visible
- **Validate NISCL advanced**: Override protocols work for creative contexts, team boundaries respect individual HABSP
- **Validate mode orchestration**: Explicit mode invocation works ("Use Editor Mode"), team members' modes don't conflict
- **Validate "Being Heard" explicit validation**: Protocol checkpoints active, team communication standards documented
- **Validate Advanced Protocols active**: 
  - 11-dimension Multi-Contextual Reflection runs on complex requests
  - AdRP 4-tier escalation before style adaptation
  - Unconscious Problem-Solving decompresses brief articulations
  - Symbiotic Rhythm: AI takes 30-60s for comprehensive processing
- Validate: USM components auto-populated from MO Journal (MCDL signals, CSTMs transitions, HABSP sensitivity, STP systemic perspective)
- Validate: Save-LTFContext includes all 3 CSAC tiers (User State with USM components > Project CIP > Session Metadata)
- Validate: Resume-LTFContext restores complete state with Governance Kernel priority loading
- Test: Framework modifications (new Quick Prompt, custom protocol, NISCL customization, Governance extension)

---

### Phase 5: Comparison Matrix & Documentation (Week 3)

**Objective**: Create quick reference and finalize documentation

**Tasks**:
1. Create 05-TIER-COMPARISON-MATRIX.md:
   - Side-by-side feature comparison table
   - **Governance comparison column**: Implicit (T1) vs Documented (T2) vs Mastery (T3)
   - **NISCL comparison column**: Implicit/undocumented (T1) vs Documented with overrides (T2) vs Advanced with team boundaries (T3)
   - **Mode semantics comparison**: Basic/Capture only (T1) vs Documented/all 4 modes (T2) vs Advanced/orchestration (T3)
   - **USM components comparison**: None (T1) vs Manual MCDL/CSTMs/HABSP/STP (T2) vs Auto-populated (T3)
   - **"Being Heard" comparison**: Implicit (T1) vs Documented 6 elements (T2) vs Explicit validation (T3)
   - **Advanced Protocols comparison**: None (T1/T2) vs Full (T3: 11-dimension, AdRP, etc.)
   - "Which tier is right for me?" decision tree
   - Pricing summary (link to CFP-Tiered-Packaging-Architecture.md)
   - Migration path overview (T1→T2→T3)
2. Update CFP_Feature_Matrix.md (ensure alignment with governance layers)
3. Update CFP-Tiered-Packaging-Architecture.md (cross-reference primers, add governance tier allocations)
4. Add cross-references between all tier documents
5. Create README or index in ltf-cognitive-companion directory

**Deliverables**:
- [ ] 05-TIER-COMPARISON-MATRIX.md
- [ ] Updated CFP_Feature_Matrix.md (cross-references)
- [ ] Updated CFP-Tiered-Packaging-Architecture.md (primer links)
- [ ] Directory README.md (navigation guide)

**Testing Checkpoint**:
- User can navigate tier system easily
- Clear decision criteria for tier selection (includes governance visibility preferences)
- **Governance comparison clear**: Users understand implicit → documented → mastery progression
- **NISCL tier allocations visible**: T1 users see no NISCL documentation, T2 users understand override protocols, T3 users see advanced team boundary options
- **Mode semantics tier boundaries clear**: T1 Capture only, T2 all 4 modes documented, T3 orchestration capabilities
- **USM component progression clear**: T1 none, T2 manual template, T3 auto-populated from MO Journal
- All cross-references work
- No contradictions between tier primers and architecture docs

---

### Phase 6: Validation & Preservation (Week 4)

**Objective**: Final validation, version preservation, documentation

**Tasks**:
1. Comprehensive tier validation:
   - T1: Load in fresh session, validate free tier experience (implicit governance only)
   - T2: Load in session, test Quick Prompts and preferences (documented governance)
   - T3: Load with User State Model, test full LTF workflows (governance mastery)
2. **Governance tier boundary validation**:
   - T1: Verify NISCL operates but isn't documented, Capture Mode only, "Being Heard" implicit
   - T2: Verify NISCL 5 principles documented, override protocols explained, all 4 modes documented, Generic USM template available
   - T3: Verify Governance Kernel mastery section present, NISCL advanced overrides work, mode orchestration functional, personalized USM auto-populated
3. Cross-tier consistency check:
   - Run synchronization checklist for all files (including governance verification items)
   - Validate Feature Matrix alignment (governance layers added)
   - Validate Packaging Architecture alignment (governance tier allocations documented)
4. Version preservation:
   - Tag 01-CORE-PRIMER.md as v2.4 reference (git tag) - NOTE: Pre-governance layers
   - Archive as "unified reference version"
   - Update version numbers in all new tier primers (v3.0? - includes governance integration)
5. Document refactor process:
   - Lessons learned (governance integration timeline)
   - Tier clarity maintenance protocol (governance-specific tracking)
   - Future refactor guidance (NISCL/USM evolution paths)
6. User acceptance testing:
   - Cash validates tier separation (governance implicit/documented/mastery progression acceptable)
   - Test framework modifications in T3 (Governance extensions, NISCL customization)
   - Confirm upgrade paths clear (T1→T2: "Learn governance", T2→T3: "Master governance + USM auto")

**Deliverables**:
- [ ] Validated tier primer set (02/03/04-TIER*-PRIMER.md)
- [ ] Version-tagged 01-CORE-PRIMER.md (preserved reference)
- [ ] Refactor completion report
- [ ] User acceptance sign-off

**Testing Checkpoint**:
- All tier primers load successfully
- No feature leakage between tiers (governance boundaries tested)
- **Governance tier boundaries validated**:
  - T1 users experience implicit NISCL/modes/"Being Heard" without documentation
  - T2 users understand governance through documentation (NISCL principles, mode semantics, Generic USM template)
  - T3 users demonstrate governance mastery (overrides work, mode orchestration functional, personalized USM auto-populated)
- Clear value proposition for each tier (governance progression visible in upgrade paths)
- Framework modifications testable in T3 (Governance Kernel extensions, NISCL customization, USM iterations validated)
- User satisfied with tier separation clarity

---

## 6. Risk Mitigation

### Identified Risks

#### Risk 1: Content Duplication Maintenance Burden

**Risk**: Shared content duplicated across 3 tier primers requires 3× update effort

**Mitigation**:
- Keep shared framework descriptions identical (CIP-E, DMP, VS, ARS)
- Use version control to track changes across files
- Establish validation checklist (Section 4) to catch drift
- Consider future: Extract truly universal content to shared include file if duplication becomes problematic

**Likelihood**: Medium  
**Impact**: Medium  
**Priority**: Monitor during Phase 6

#### Risk 2: Tier Feature Leakage

**Risk**: T1/T2 primers accidentally reference T2/T3 features, creating confusion (now includes governance layer leakage)

**Mitigation**:
- Explicit "What This Tier DOESN'T Have" sections
- **Governance-specific validation**: T1 no NISCL/mode documentation, T2 no advanced protocols/auto USM, T3 full access
- Testing checkpoints validate tier boundaries (governance sections tested)
- Synchronization checklist catches cross-references (includes governance verification items)
- AI session testing per tier validates experience (implicit vs documented vs mastery governance)

**Likelihood**: Medium  
**Impact**: High (user confusion, broken trust, governance layer leakage undermines tier value)  
**Priority**: Critical - validate thoroughly in Phase 6

#### Risk 3: Documentation Inconsistency

**Risk**: Tier primers diverge from CFP_Feature_Matrix.md or CFP-Tiered-Packaging-Architecture.md

**Mitigation**:
- Synchronization checklist requires cross-document validation
- Phase 5 specifically updates all architecture documents
- Version numbers kept aligned
- Future Enhancement sections track planned changes

**Likelihood**: Medium  
**Impact**: High (contradictory information)  
**Priority**: Critical - enforce checklist rigorously

#### Risk 4: User Confusion (Multiple Primers)

**Risk**: Users don't know which primer to load

**Mitigation**:
- Clear file naming (02-TIER1, 03-TIER2, 04-TIER3)
- 05-TIER-COMPARISON-MATRIX.md = decision guide
- Directory README.md explains structure
- Each primer header states target users explicitly

**Likelihood**: Low (with proper navigation)  
**Impact**: Medium  
**Priority**: Address in Phase 5 (comparison matrix)

#### Risk 5: LTF Testing Changes Break T3 Primer

**Risk**: Framework modifications in T3 testing make primer outdated

**Mitigation**:
- LTF Testing Ground section (T3) documents active tests
- Tier 3 primer expected to evolve (it's the testing tier)
- Version numbering reflects testing status
- Completed tests archived, failed tests documented as learnings

**Likelihood**: High (expected behavior)  
**Impact**: Low (intentional testing environment)  
**Priority**: Document clearly in T3 primer, manage expectations

#### Risk 6: Governance Layer Inconsistency

**Risk**: NISCL documented in T2 but implicit in T1 - accidental cross-references reveal governance mechanisms to T1 users prematurely

**Mitigation**:
- T1 primer: NO governance sections, NO NISCL documentation, NO mode semantics beyond basic Capture Protocol
- T2 primer: Governance Kernel section explicitly introduced, NISCL 5 principles documented, all 4 modes explained
- T3 primer: Governance mastery section with advanced controls
- Testing: Load T1 in fresh session, verify AI operates with NISCL but doesn't explain it
- Synchronization checklist includes "Governance tier allocations correct?" validation

**Likelihood**: Medium (easy to accidentally reference in shared content)  
**Impact**: High (undermines tier value proposition, T1 users shouldn't know governance exists)  
**Priority**: Critical - validate T1 has ZERO governance documentation

#### Risk 7: USM Component Confusion

**Risk**: T2 manual MCDL/CSTMs/HABSP/STP customization vs T3 auto-populated distinction unclear, users expect auto in T2

**Mitigation**:
- T2 primer: "Generic USM Template" section clearly states "manual customization" required
- T2 primer: "What Tier 2 DOESN'T Have" explicitly lists "Auto-populated USM from MO Journal (T3 only)"
- T3 primer: "Personalized User State Model" section explains MO Journal auto-population mechanism
- Testing: T2 users see template, understand manual work required; T3 users see auto-population
- Comparison Matrix: Clear column distinguishing "Manual template" (T2) vs "Auto-populated" (T3)

**Likelihood**: High (subtle distinction, valuable differentiator)  
**Impact**: High (broken expectations, tier value erosion)  
**Priority**: Critical - ensure T2/T3 USM documentation clarity

#### Risk 8: Mode Semantics Leakage

**Risk**: T1 users shouldn't see Editor/Rewrite/Structure-Lock documentation (Capture Mode only), accidental references leak T2 concepts

**Mitigation**:
- T1 primer: Capture Protocol section mentions verbatim output only, NO mode terminology
- T2 primer: New "Mode Semantics" section introduces all 4 modes explicitly
- T3 primer: Advanced mode orchestration, team coordination
- Testing: T1 session validates Capture works, no "Editor Mode" references visible
- Synchronization checklist: "Mode semantics correct tier allocation?" validation

**Likelihood**: Medium (shared Capture Protocol content might reference modes)  
**Impact**: Medium (confusing T1 users, undermines discovery learning)  
**Priority**: High - scrub T1 primer for mode terminology

---

## 7. Success Criteria

### Phase Completion Criteria

**Phase 1 (Preparation)**: 
- ✅ Design document complete (this file)
- ✅ Tier allocation matrix validated
- ✅ File structure decided
- ⏳ User approval received

**Phase 2 (T1 Primer)**:
- [ ] 02-TIER1-PRIMER.md created
- [ ] AI session test: Foundational protocols only
- [ ] **Governance validation**: NISCL operates but isn't documented, Capture Mode only, "Being Heard" implicit
- [ ] No T2/T3 feature references (including governance documentation)
- [ ] Clear upgrade path to T2

**Phase 3 (T2 Primer)**:
- [ ] 03-TIER2-PRIMER.md created
- [ ] Quick Prompts functional in AI session
- [ ] ARS adaptive recognition working
- [ ] **Governance validation**: NISCL 5 principles documented, all 4 modes explained, "Being Heard" 6 elements explicit, Generic USM template available
- [ ] No T3 feature references (no auto USM, no 11-dimension, no AdRP)

**Phase 4 (T3 Primer)**:
- [ ] 04-TIER3-PRIMER.md created
- [ ] Multi-user support testable
- [ ] **Governance validation**: Governance Kernel mastery section present, NISCL advanced overrides work, mode orchestration functional, "Being Heard" explicit validation checkpoints
- [ ] **USM validation**: Personalized USM auto-populated from MO Journal (MCDL/CSTMs/HABSP/STP)
- [ ] **Advanced Protocols validation**: 11-dimension Multi-Contextual, AdRP 4-tier, Unconscious Problem-Solving, Symbiotic Rhythm active
- [ ] Full LTF implementation documented (3-tier CSAC with USM components)
- [ ] User State Model integration working
- [ ] Framework modification testing documented (Governance extensions, NISCL customization, USM iterations)

**Phase 5 (Comparison Matrix)**:
- [ ] 05-TIER-COMPARISON-MATRIX.md complete (includes governance comparison columns)
- [ ] All cross-references working
- [ ] Architecture docs aligned (governance tier allocations added to Feature Matrix and Packaging Architecture)
- [ ] Navigation clear

**Phase 6 (Validation)**:
- [ ] All tier primers validated in AI sessions
- [ ] **Governance tier boundary validation**: T1 implicit only, T2 documented, T3 mastery confirmed
- [ ] Synchronization checklist passed (including governance verification items)
- [ ] Version preservation complete (01-CORE-PRIMER.md v2.4 tagged as pre-governance reference)
- [ ] User acceptance achieved

### Overall Success Metrics

**Tier Clarity**:
- User can identify which tier they need in <2 minutes (comparison matrix with governance progression visible)
- Each tier primer self-contained (no cross-file dependency hunting)
- **Governance boundaries clear**: T1 users don't know NISCL exists, T2 users understand governance, T3 users master governance
- No contradictions between tier primers and architecture docs (governance tier allocations aligned)

**User Experience**:
- T1 user experiences "Wow! I need more" moment (upgrade motivation, implicit governance works invisibly)
- T2 user sees clear automation value (Quick Prompts, preferences, governance awareness)
- T3 user can test LTF modifications without breaking production (Governance extensions, NISCL customization, USM iterations)

**Maintainability**:
- Future enhancements allocate to correct tier automatically (decision framework exists, includes governance tier progression)
- Synchronization checklist catches documentation drift (governance-specific items included)
- Testing checkpoints validate tier boundaries (governance implicit/documented/mastery validated)

**Framework Evolution**:
- T3 serves as effective testing ground (framework modifications documented and testable, governance extensions possible)
- Tier 1 preserved for discovery (no feature creep, implicit governance only)
- Tier 2 automation proven before T3 complexity added (documented governance before mastery)

**Governance Integration**:
- **NISCL tier allocations validated**: T1 implicit/undocumented, T2 documented with overrides, T3 advanced with team boundaries
- **Mode semantics tier boundaries clear**: T1 basic (Capture only), T2 documented (all 4), T3 advanced (orchestration)
- **USM component progression functional**: T1 none, T2 manual MCDL/CSTMs/HABSP/STP template, T3 auto-populated from MO Journal
- **"Being Heard" protocol consistent**: T1 implicit, T2 documented (6 elements), T3 explicit validation (checkpoints)
- **Advanced Protocols restricted correctly**: T3 only (11-dimension Multi-Contextual, AdRP 4-tier, Unconscious Problem-Solving, Symbiotic Rhythm)

---

## 8. Open Questions for User

### Design Decisions Requiring Input

1. **Version Numbering**:
   - Current: 01-CORE-PRIMER.md v2.4
   - Tier Primers: Should they start at v3.0 (major refactor) or v2.4 (content continuity)?
   - Recommendation: v3.0 (signals structural change)

2. **Content Duplication vs Inclusion**:
   - Current plan: Full duplication (each tier = complete primer)
   - Alternative: Inclusion references ("See Tier 1 for foundations...")
   - Recommendation: Full duplication (better UX, manageable with version control)

3. **Tier 3 Testing Ground Scope**:
   - How aggressively should T3 primer document experimental features?
   - Should failed tests be documented (learnings) or archived elsewhere?
   - Recommendation: Document all tests (active/completed/failed) for transparency

4. **Migration Path Documentation**:
   - Should each tier primer include explicit "How to Upgrade" sections?
   - Should upgrade paths reference pricing/licensing?
   - Recommendation: Yes to upgrade sections, link to CFP-Tiered-Packaging-Architecture.md for pricing

5. **Cross-Platform Compatibility**:
   - Tier primers currently reference "platform-dependent" features (file creation)
   - Should each tier have platform-specific variants (ChatGPT vs Claude vs Copilot)?
   - **Governance consideration**: Claude has explicit mode semantics, other platforms may differ
   - Recommendation: Keep unified, note platform variations in text (complexity vs value), document mode semantics as "Claude-native, may vary on other platforms"

### Governance-Specific Decisions

6. **NISCL Visibility in Tier 1**:
   - Should T1 primer mention NISCL at all, even implicitly?
   - Current plan: ZERO governance documentation in T1, operates invisibly
   - Alternative: Brief note "This tier includes intelligent safety guardrails (learn more in Tier 2)"
   - **Decision needed**: Complete invisibility (current) vs awareness hint?

7. **Generic USM Template Detail Level (Tier 2)**:
   - How explicit should T2 Generic USM template be about MCDL/CSTMs/HABSP/STP?
   - Option A: Section headers only ("## MCDL (Meta-Cognitive Directive Layer)" with blank template)
   - Option B: Section headers + brief examples ("MCDL signals: 'Let's zoom out', 'What's the pattern here?'")
   - Option C: Comprehensive guide with multiple examples per component
   - **Decision needed**: Minimal scaffolding (A) vs guided examples (B) vs comprehensive (C)?

8. **"Being Heard" Protocol Universal Inclusion**:
   - Should "Being Heard" protocol be in ALL tier primers with same 6 elements?
   - Current plan: T1 implicit (AI follows naturally), T2 documented (6 elements explicit), T3 explicit validation (checkpoints)
   - Alternative: Only document in T2/T3, keep completely invisible in T1
   - **Decision needed**: Implicit in T1 (current) vs completely undocumented in T1?

9. **Mode Semantics Platform Handling**:
   - Claude has 4 modes (Editor/Rewrite/Structure-Lock/Capture) explicitly
   - ChatGPT/Copilot may have different mode concepts or none
   - How to document in tier primers?
   - Option A: Document Claude modes, note "Platform-specific, may vary"
   - Option B: Document modes as "CFP Standard", request AI implement equivalent
   - Option C: Skip mode semantics documentation entirely, keep Capture Protocol only
   - **Decision needed**: Platform-specific caveat (A) vs CFP standard (B) vs minimal (C)?

10. **Advanced Protocols in Tier 3 - Explicit Invocation**:
    - Should T3 users need to explicitly invoke "Use 11-dimension Multi-Contextual Reflection"?
    - Or should AI automatically use when complexity warrants (based on USM)?
    - Current plan: Automatic based on personalized USM (STP + CSTMs detect complexity)
    - Alternative: Explicit user command required ("Use AdRP Tier 1 explicit check-in")
    - **Decision needed**: Automatic (USM-driven) vs explicit user invocation?

### Clarifications Needed

1. **Tier 1 Discovery Breadcrumbs**:
   - How explicit should T1 primer be about "upgrade to get Quick Prompts"?
   - Balance: Don't oversell, but make upgrade path clear
   - Current approach: "Tier 1 Discovery Breadcrumbs" section in Quick Prompts (T2)

2. **User State Model in T3**:
   - Should T3 primer include tier1_user_state_CASH.md as embedded example?
   - Or link to separate file for loading?
   - Recommendation: Link to separate file (easier to update, test with real User State Models)

3. **LTF Testing Documentation**:
   - Should Save-LTFContext v3.0, Resume-LTFContext v2 usage be in T3 primer?
   - Or keep in separate Integration Guide?
   - Recommendation: T3 primer references Integration Guide (avoid duplication, technical depth)

4. **Tier Comparison Matrix Content**:
   - Should 05-TIER-COMPARISON-MATRIX.md include pricing?
   - Or keep purely feature-focused?
   - Recommendation: Feature-focused with pricing link to CFP-Tiered-Packaging-Architecture.md

### Governance-Specific Clarifications

5. **Governance Kernel Section Placement (Tier 3)**:
   - Should Governance Kernel get its own dedicated section in T3 primer?
   - Or integrate governance concepts throughout existing sections?
   - Recommendation: Dedicated section for clarity, then reference in relevant sections (User State Model, LTF Implementation)

6. **NISCL Override Protocol Documentation (Tier 3)**:
   - How to document NISCL override for creative work (fiction, metaphor, artistic contexts)?
   - Level of detail: Simple "Use /creative-mode to disable NISCL temporarily"?
   - Or comprehensive: When to override, team implications, boundary restoration?
   - Recommendation: Comprehensive documentation (T3 = governance mastery, users need full context)

7. **USM Auto-Population Mechanism Transparency (Tier 3)**:
   - Should T3 primer explain HOW MO Journal auto-populates MCDL/CSTMs/HABSP/STP?
   - Or just state "Automatically populated from your MO Journal reflections"?
   - Technical depth: Pattern detection algorithms? Or abstracted "AI analyzes your MO entries"?
   - Recommendation: Abstracted explanation (implementation details in separate technical docs)

8. **Team Boundary Coordination Documentation (Tier 3)**:
   - NISCL team boundaries: How to document multi-user boundary sensitivity?
   - Example scenario: Team member A high HABSP sensitivity, Team member B low - how does T3 coordinate?
   - Should primer include team coordination examples or link to separate Team Admin Guide?
   - Recommendation: Brief overview in T3 primer, link to separate Team Admin Guide for details

---

## 9. Next Steps (Awaiting User Input)

**User (Cash) to Review**:
1. ✅ Section 1 (Current State Analysis) - Validate tier allocations match product vision (INCLUDING new governance layers)
2. ✅ Section 2 (File Structure) - Approve Option A (numbered tier files)
3. ✅ Section 3 (Content Allocation Matrix) - Confirm T1/T2/T3 feature mappings (INCLUDING governance rows)
4. ✅ Section 4 (Refactor Tracking System) - Validate tracking templates useful (INCLUDING governance tracking)
5. ✅ Section 5 (Implementation Roadmap) - Confirm phases/timeline acceptable (INCLUDING governance deliverables)
6. ✅ Section 6 (Risk Mitigation) - Validate governance-specific risks addressed
7. ⏳ Section 8 (Open Questions) - Provide decisions/clarifications (INCLUDING 5 governance-specific decisions)

**AI to Execute (After User Approval)**:
1. Create 05-TIER-COMPARISON-MATRIX.md (Phase 1)
2. Create 02-TIER1-PRIMER.md (Phase 2)
3. Create 03-TIER2-PRIMER.md (Phase 3)
4. Create 04-TIER3-PRIMER.md (Phase 4)
5. Update architecture documents (Phase 5)
6. Validate and test (Phase 6)

**Estimated Timeline**:
- Phase 1 (Preparation): 1-2 days (awaiting user approval)
- Phases 2-4 (Tier Primers): 1 week (sequential creation + testing)
- Phase 5 (Comparison Matrix): 2-3 days (documentation alignment)
- Phase 6 (Validation): 3-4 days (comprehensive testing)

**Total**: ~2 weeks (assumes approval + focused execution)

---

## 10. Summary

This design plan establishes a clear path to refactor the unified 01-CORE-PRIMER.md into tier-separated primers **with integrated governance layers** (Governance Kernel, NISCL, Mode Semantics, USM Components, "Being Heard", Advanced Protocols):

- **02-TIER1-PRIMER.md**: Free tier - Manual discovery, full frameworks, no automation, **implicit governance only**
- **03-TIER2-PRIMER.md**: Premium tier - Quick Prompts, preferences, professional automation, **documented governance** (NISCL principles, 4 modes, Generic USM template, "Being Heard" 6 elements)
- **04-TIER3-PRIMER.md**: Enterprise tier - Multi-user, full LTF, ecosystem development, testing ground, **governance mastery** (advanced NISCL overrides, mode orchestration, personalized USM auto-populated, 11-dimension Multi-Contextual, AdRP 4-tier, Unconscious Problem-Solving, Symbiotic Rhythm)
- **05-TIER-COMPARISON-MATRIX.md**: Quick reference for tier selection **with governance comparison columns**

**Key Design Principles**:
- ✅ Preserve 01-CORE-PRIMER.md as v2.4 reference (pre-governance layers)
- ✅ Each tier = complete standalone primer (no cross-file dependencies)
- ✅ Clear tier boundaries with explicit "What This Tier DOESN'T Have" sections
- ✅ **Governance progression**: Implicit (T1) → Documented (T2) → Mastery (T3)
- ✅ **NISCL tier allocations**: T1 invisible, T2 documented with overrides, T3 advanced with team boundaries
- ✅ **Mode semantics boundaries**: T1 basic (Capture only), T2 documented (all 4), T3 advanced (orchestration)
- ✅ **USM component progression**: T1 none, T2 manual MCDL/CSTMs/HABSP/STP, T3 auto-populated from MO Journal
- ✅ Tier 3 = LTF testing ground (User State Model, Save/Resume Context, framework mods, **Governance extensions, NISCL customization**)
- ✅ Future Enhancement sections track refactors and maintain tier clarity (**governance tracking included**)
- ✅ Synchronization checklist prevents documentation drift (**governance verification items added**)

**Major Architectural Integration** (Post-v2.4):
This refactor design now incorporates **6 new architectural layers** developed in Claude session 2025-11-12:
1. **Governance Kernel**: NISCL activation, boundary clarity, mode semantics, USM priorities
2. **NISCL** (Narrative Intent Safety & Clarity Layer): 5 principles (Human Primacy, Cognitive Clarity, Narrative Safety, Intent Overrides, Framework Neutrality)
3. **Mode Semantics**: 4 operational states (Editor/Rewrite/Structure-Lock/Capture)
4. **USM Components**: MCDL (meta-cognitive signals), CSTMs (cognitive transitions), HABSP (boundary sensitivity), STP (systemic thinking)
5. **"Being Heard" Protocol**: 6 elements (acknowledgment, confirmation, precision, structure, validation, never minimize)
6. **Advanced Collaboration Protocols**: 11-dimension Multi-Contextual Reflection, AdRP 4-tier, Unconscious Problem-Solving, Symbiotic Rhythm

**Awaiting User Decisions** (Section 8):
- Version numbering (v3.0 recommended - includes governance integration)
- **NISCL Visibility in Tier 1** (complete invisibility vs awareness hint)
- **Generic USM Template Detail Level** (minimal scaffolding vs guided examples vs comprehensive)
- **"Being Heard" Protocol Universal Inclusion** (implicit T1 vs completely undocumented)
- **Mode Semantics Platform Handling** (Claude-specific caveat vs CFP standard vs minimal)
- **Advanced Protocols Invocation** (automatic USM-driven vs explicit user commands)
- Tier 3 testing documentation scope
- Migration path explicitness
- Governance Kernel section placement (dedicated vs integrated)
- NISCL override protocol detail level
- USM auto-population transparency level
- Team boundary coordination documentation approach

**Integration Status**:
- ✅ Section 1 (Current State): New Architectural Layers section added, tier allocations updated with governance
- ✅ Section 3 (Content Matrix): Governance rows added (Governance Kernel, NISCL, Mode Semantics, "Being Heard", USM Components, Advanced Protocols)
- ✅ Section 4 (Refactor Tracking): Governance tracking protocol, enhancement template, synchronization checklist items added
- ✅ Section 5 (Implementation Roadmap): Governance deliverables added to all phases (T1 implicit validation, T2 documented governance, T3 mastery + advanced protocols, comparison matrix governance columns, validation governance boundaries)
- ✅ Section 6 (Risk Mitigation): 3 governance-specific risks added (Governance Layer Inconsistency, USM Component Confusion, Mode Semantics Leakage)
- ✅ Section 7 (Success Criteria): Governance validation criteria added to all phases, Governance Integration success metrics added
- ✅ Section 8 (Open Questions): 5 governance-specific decisions added, 4 governance-specific clarifications added

**Ready to Proceed**: Once user approves design (including governance integration) and answers open questions, AI can execute Phases 1-6 systematically.

---

**Document Status**: Updated with Governance Integration - Awaiting User Review  
**Last Updated**: 2025-11-13 (Integrated Governance Kernel, NISCL, Mode Semantics, USM Components, "Being Heard", Advanced Protocols)  
**Next Action**: User (Cash) reviews governance integration, provides approval/feedback, answers Section 8 governance decisions  
**AI Availability**: Ready to execute upon approval
