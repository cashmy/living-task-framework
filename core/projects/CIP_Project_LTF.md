# Project-Specific CIP: LTF Framework Development
**Mnemonic**: LTF  
**Status**: Active Development  
**Last Updated**: 2025-11-12

---

## PROJECT IDENTITY

### Basic Information
- **Project Name**: Living Task Framework (LTF)
- **Mnemonic**: LTF
- **Status**: Active Development
- **Start Date**: 2024-Q4 (approximate - evolved from earlier work)
- **Last Active**: 2025-11-12

### Quick Context
The Living Task Framework (LTF) is a meta-framework ecosystem that houses CFP (Cognitive Framework for Prompting) and enables organic evolution of multiple related frameworks, tools, and products through adaptive, user-driven refinement.

---

## CORE CONCEPT

### Problem Statement
**User Pain Point**: 
Existing productivity frameworks are rigid, tool-centric, or disconnected from actual cognitive workflows. AI collaboration lacks structure for preserving relationship context across sessions (CSAC problem).

**Who Experiences This**: 
Knowledge workers, developers, creators, researchers who collaborate extensively with AI but experience context loss, relationship degradation, and need to "re-train" AI each session.

**Gap**: 
No framework exists that combines task management + cognitive scaffolding + AI collaboration continuity + cross-session relationship preservation.

### Vision & Inspiration
**Vision**: 
A living, breathing framework that adapts to users' actual work patterns while preserving the cognitive and relational context that makes AI collaboration truly effective (not just transactional).

**Inspiration**:
- GTD (Getting Things Done): Task capture, but too rigid
- PARA (Projects, Areas, Resources, Archives): Organization, but no cognitive layer
- Zettelkasten: Knowledge connection, but no AI integration
- **Missing**: Relationship context, CSAC preservation, cognitive pattern recognition

---

## DOMAIN CONTEXT

### Technologies & Stack
**Languages**: Markdown (documentation), PowerShell (tooling), Python (future automation)  
**Frameworks**: Git (version control), VS Code (primary editor), GitHub (repository)  
**Infrastructure**: Local-first (user owns data), git-based (version history), file-based (no databases)  
**Key Libraries**: None currently (pure scripting + markdown)

### Deployment & Environment
**Target Platform**: Local development environment (Windows, Mac, Linux compatible)  
**Hosting**: GitHub (public repository), user's local machine (primary)  
**Compliance Requirements**: None (open-source, user data stays local)  
**Scalability Needs**: Single-user initially, multi-user patterns considered for future

### Domain Terminology
**Glossary**: Use LTF Glossary (complete) - `core/taxonomy/Glossary.md`

**Key Terms in Active Use**:
- TOPF (Think-Organize-Plan-Focus)
- DMP (Dynamic Mode Preference): REFLECTIVE, ANALYTICAL, CREATIVE, FOCUSED
- CIP-E (Contextual Intelligence Protocol - Enhanced)
- VS Suite (Validation Suite)
- ARS (Adaptive Response System)
- META State (elevated processing mode)
- CSAC (Cross-Session AI Context Switching)
- CFP (Cognitive Framework for Prompting)

---

## FUNCTIONAL GOALS

### Core Features (Current)
1. **CFP Framework** (v2.2): Complete cognitive methodology for AI collaboration
2. **Save-Context System**: Snapshot mechanism for session preservation
3. **Git Integration**: Hooks, commit standards, version tracking
4. **Glossary Management**: Complete terminology reference
5. **Capture Protocol**: Enhanced pivotal moment documentation
6. **User State Model**: Relationship context preservation (NEW - v3.0)
7. **Project CIP System**: Project-specific context layers (NEW - v3.0)

### User Roles & Workflows
**Who Uses This**:
- **Primary User** (currently): Framework developer (creator/maintainer)
- **Future Users**: Beta testers (diverse domains), contributors, adopters

**How They Use It**:
- Load framework context at session start (Save-Context)
- Work on projects using CFP methodology
- Capture pivotal moments as they occur
- Commit changes with semantic versioning
- Execute Save-Context at session end (preserve state)

### Success Criteria
**Quantitative**:
- CSAC recovery time <60 seconds (context fully restored)
- "Being heard" protocol validation pass rate 100% (relationship quality maintained)
- Beta tester retention >80% after 30 days (framework provides value)

**Qualitative**:
- Users report "AI understands me across sessions" (CSAC preservation working)
- Collaboration feels like partnership, not tool usage (relationship quality)
- Framework enables multi-project work without context loss (project CIP system effective)

**Behavioral**:
- Users naturally execute Save-Context (habit formation)
- Users create Project CIPs for new work (template adoption)
- Users contribute MO Journal entries (self-awareness tool engagement)

---

## PROJECT RELATIONSHIPS & DEPENDENCIES

### Parent Projects
- **None** (LTF is foundational meta-framework)

### Related Projects
- **CFP Cognitive Companion**: Commercial productization of CFP - shares methodology, beta testing insights inform framework refinement
- **EchoForge**: First consumer application using CFP principles - validates framework for broader market, UX insights feed back to LTF
- **EHR Consent Platform**: Demonstrates LTF's multi-project support capability - context switching patterns inform Project CIP system design

### Downstream Projects
- **CFP Cognitive Companion**: Depends on LTF for framework methodology, tooling, templates
- **All LTF-housed projects**: Inherit Save-Context system, git hooks, bootstrap scripts, terminology
- **Future frameworks**: Will be housed in LTF ecosystem (same meta-structure)

### Knowledge Sharing
**From LTF to Other Projects**:
- CFP methodology → All projects (TOPF, DMP, "being heard" protocol)
- Save-Context system → All projects (session preservation)
- User State Model → CFP Companion (Tier 3 features), EchoForge (personalization)
- Project CIP template → All projects (context layer standardization)

**To LTF from Other Projects**:
- EchoForge: Audio UX patterns, mobile-first constraints, quick capture philosophy
- EHR Platform: Multi-stakeholder complexity, architecture documentation value, HIPAA rigor
- CFP Companion: Beta tester feedback, domain diversity insights, monetization validation

### Context Switching Notes
**When Switching TO LTF**:
- Emphasize: Meta-framework thinking, architectural decisions, cross-project synthesis
- Remember: Changes here affect ALL downstream projects (ripple effects)
- Load: Full Glossary, CORE PRIMER, recent captures (historical context important)

**When Switching FROM LTF**:
- Carry over: CFP methodology, "being heard" protocol, multi-contextual reflection
- Preserve: LTF architectural insights (might inform specific project design)
- Don't assume: LTF patterns always apply (some projects have domain-specific needs)

---

## ARCHITECTURAL DECISIONS & CONSTRAINTS

### Design Principles
1. **Local-First**: User owns data, no cloud dependencies, version control via git
2. **File-Based**: Markdown + scripts (human-readable, future-proof, no proprietary formats)
3. **Adaptive**: Framework evolves through use (not rigid methodology)
4. **Relationship-Centric**: Preserve human-AI collaboration context (not just technical data)
5. **Modular**: Components compose (CFP + Project CIPs + User State = complete system)

### Key Technical Decisions
- **Markdown for all documentation**: Human-readable, version-controllable, tool-agnostic → Enables git-based evolution, accessible without special tools
- **PowerShell for tooling**: Cross-platform (PowerShell Core), native to Windows, scriptable → Some users prefer bash (consider dual implementation)
- **Git as version backbone**: Industry standard, free, powerful → Requires users learn git basics (barrier for non-technical users)
- **No databases**: Files only → Simpler, more portable, but harder to query complex relationships
- **3-Tier Context Model** (NEW v3.0): CORE → Project → User State → Complete preservation architecture, but more complex loading sequence

### Constraints & Trade-offs
- **No real-time collaboration**: Single-user focus simplifies architecture → Blocks paired programming, team scenarios (addressed via multi-user User State Model later)
- **Git required**: Powerful versioning, but learning curve → Future: Abstract git behind simpler commands for non-technical users
- **Local storage**: User privacy, ownership → Harder to sync across devices (future: consider encrypted sync)
- **Markdown limitations**: Great for documents, less ideal for structured data → Accept trade-off for human readability

---

## STRATEGIC CONTEXT

### How This Relates to Other Work
**Platform Strategy**: 
LTF is the foundational layer enabling multiple product streams simultaneously (not sequential single-product development). Strong foundation → parallel product emergence (CFP Companion, EchoForge, books, research, tools).

**Revenue Model**: 
LTF itself = open-source (free). Monetization via downstream products (CFP Companion Tier 2/3, EchoForge premium, consulting, books). LTF credibility drives commercial product adoption.

**Research Value**: 
Validates single-agent agentic system hypothesis (User State Modeling enables AI to maintain relationship continuity without multi-agent complexity). Academic papers, thought leadership, conference talks.

### Pivotal Moments & Key Insights
- **2025-11-10**: Recognized "capture this" moments worthy of dedicated protocol → Enhanced Capture Protocol (CFP v2.1 → v2.2)
- **2025-11-11**: Tool vs Platform ecosystem reframing → LTF houses multiple products, not just CFP
- **2025-11-12**: META OBSERVATION trigger formalized → Reliable state elevation mechanism
- **2025-11-12**: CSAC problem identified → User State & Collaboration Feedback Protocol (Tier 3 feature)
- **2025-11-12**: Project-Specific CIP concept → 3-tier context architecture (CORE → Project → User State)
- **2025-11-12**: Product suite emergence recognized → Platform ecosystem dynamics manifesting (7+ products cross-pollinating)

### Out of Scope (Important)
- ❌ Enterprise team features (initially) - Focus on individual user excellence first
- ❌ Cloud hosting/sync (initially) - Local-first keeps data ownership clear
- ❌ Mobile app (initially) - Desktop/terminal-based, mobile later if validated
- ❌ Proprietary formats - Markdown + git only (future-proof, open)
- ❌ Rigid methodology - Framework adapts to user, not user to framework

---

## CURRENT FOCUS & ACTIVE WORK

### Active Sprint / Current Milestone
**Current**: Save-Context v3.0 Enhancement  
**Milestone**: Complete 3-tier context architecture implementation (target: 2025-11-12)  
**Status**: Phase 5 of 6 (creating example Project CIPs to validate template design)

### Next 3 Priorities
1. **Execute Save-LTFContext** with v3.0 enhancements (preserve all morning's foundational work)
2. **Git commit** for CFP v2.2 → v3.0 (Save-Context enhancement, 6 foundational components)
3. **Beta tester acquisition** via LinkedIn (10-15 users, domain diversity, platform agnostic)

### Open Questions / Decisions Needed
- **Agentic system execution tracking**: Postpone until after tracking system developed (avoid ad-hoc documentation), or capture retrospectively as case study?
- **Interactive CIP builder** (`/qp new project`): Tier 2 or Tier 3 feature? (Socratic interview protocol designed, automation TBD)
- **MO Journal automation**: When to implement `/qp mo-journal` command? (Manual template working, Tier 3 priority)
- **Project CIP location**: `core/projects/` or individual project roots? (Centralized vs distributed - TBD based on usage patterns)

---

## INTEGRATION WITH CFP/LTF

### CFP Principles Applied
**LTF IS the CFP meta-framework**, so all CFP principles are native:
- TOPF framework (Think-Organize-Plan-Focus)
- DMP modes (REFLECTIVE for architecture, ANALYTICAL for debugging, etc.)
- "Being heard" protocol (foundational to all LTF work)
- Multi-contextual reflection (11-dimension processing standard)
- META OBSERVATION triggers (elevated processing on demand)
- CSAC preservation (User State Model + Project CIPs + Session metadata)

### LTF Tooling Used
**LTF PROVIDES the tooling**:
- Save-LTFContext.ps1 (session snapshot mechanism)
- Bootstrap scripts (project setup automation)
- Git hooks (commit message standards)
- Apply-RepoLabels (GitHub integration)
- Make.ps1 (PowerShell-based task runner)

### How This Extends Framework
**LTF IS the framework being extended**:
- Each new component (User State Model, Project CIP, Session metadata) becomes part of LTF
- Iterative refinement through use (current session demonstrates this)
- Research insights feed back into framework design (unconscious problem-solving pattern, symbiotic rhythm, etc.)

---

## GLOSSARY QUICK REFERENCE

**See**: `core/taxonomy/Glossary.md` (complete reference)

**Most Frequently Used**:
- **TOPF**: Think-Organize-Plan-Focus (core CFP cycle)
- **DMP**: Dynamic Mode Preference (REFLECTIVE, ANALYTICAL, CREATIVE, FOCUSED)
- **CSAC**: Cross-Session AI Context Switching (ephemeral context loss problem)
- **CIP**: Contextual Intelligence Protocol (now includes Project-Specific CIP files)
- **META State**: Elevated processing mode (triggered by META OBSERVATION)
- **Being Heard Protocol**: Foundational collaboration requirement (explicit acknowledgment, precision, validation)

---

## VERSION HISTORY & EVOLUTION

### Major Milestones
- **2024-Q4**: LTF concept emerged (meta-framework housing CFP)
- **2025-Q1**: CFP v1.0 formalized (TOPF, DMP, basic protocols)
- **2025-11-10**: CFP v2.1 → v2.2 (Enhanced Capture Protocol with prompt/META state tracking)
- **2025-11-11**: Tool → Platform reframing (LTF ecosystem recognition)
- **2025-11-12**: CFP v2.2 → v3.0 (Save-Context enhancement, 6 foundational components integrated)

### Lessons Learned
✅ **Worked Well**:
- Iterative refinement ("implement concept and refine as we use") - Faster learning than over-planning
- Capture Protocol - Pivotal moments documented immediately (no reconstruction needed)
- User State Model - Relationship context preservation critical (higher priority than technical context)
- 3-tier architecture - Clear separation (CORE → Project → User State) enables modular loading

⚠️ **Challenges**:
- Git learning curve - Barrier for non-technical users (future: abstract complexity)
- Context loading complexity - 3-tier model powerful but harder to explain (documentation critical)
- Summarization time growing - CSAC indicator (need to execute Save-Context, fresh session)

🔄 **Pivots**:
- From "task framework" → "cognitive collaboration framework" (bigger scope, clearer value)
- From "tool-centric" → "relationship-centric" (CSAC preservation highest priority)
- From "rigid methodology" → "adaptive meta-framework" (evolves through use)

---

## USAGE NOTES FOR AI

### When Loading This CIP
**Context to Emphasize**:
- Meta-framework thinking (architectural decisions affect all downstream projects)
- Historical evolution (LTF grew organically, understanding history informs current design)
- Cross-project synthesis (insights from multiple projects feed back into LTF)
- Relationship-centric design (User State Model is foundational, not optional)

**Related CIPs to Consider Loading**:
- All project CIPs potentially relevant (LTF houses all projects)
- Prioritize based on user's stated focus (if working on CFP Companion, load that CIP too)

### When Context Switching Away
**What to Preserve**:
- CFP methodology (applies to all projects)
- "Being heard" protocol (universal requirement)
- Multi-contextual reflection (core collaboration quality)
- 3-tier context model (architectural principle for all work)

**What NOT to Carry Over**:
- Meta-framework abstraction level (specific projects are more concrete)
- LTF-specific terminology (unless project uses LTF Glossary)
- Historical evolution details (not relevant to project-specific work)

---

## TEMPLATE METADATA

**Based On**: `core/templates/Project_CIP_Template.md` v1.0  
**Customizations**: 
- LTF is meta-framework (no parent projects, all others are downstream)
- Integration section references self (LTF IS the framework)
- Heavy emphasis on architectural decisions (ripple effects to all projects)

**Next Update**: After Save-Context v3.0 execution (capture usage patterns, refinement insights)
