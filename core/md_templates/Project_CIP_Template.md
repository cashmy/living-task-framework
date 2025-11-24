# Project-Specific CIP Template (Context Layer 2)

**Purpose**: Provide project-specific context layer between CORE CFP (universal framework) and User State Model (human patterns)  
**Architecture**: 3-Layer Context Model - Context Layer 2: Project CIP (WHAT - project identity)  
**Version**: 3.0  
**Template Version**: 1.0  
**File Output**: `tier2_project_cip.md` (filename preserved for compatibility, semantic = Layer 2)

---

## PROJECT IDENTITY

### Basic Information

- **Project Name**: [Full project name]
- **Mnemonic**: [2-5 character code for file naming, quick reference]
  - Example: LTF, ECHO, EHR, CFP-C
  - Used in: File names (`CIP_Project_[MNEMONIC].md`), queries, context switching
- **Status**: [Ideation / Planning / Active Development / Maintenance / On Hold]
- **Start Date**: [YYYY-MM-DD]
- **Last Active**: [YYYY-MM-DD]

### Quick Context (One-Sentence Articulation)

[Single sentence capturing core vision - what is this project, why does it exist?]

Example: "EchoForge is an AI-powered thought capture tool that converts ephemeral audio snippets into structured insights using CFP principles."

---

## CORE CONCEPT

### Problem Statement

**User Pain Point / Market Gap**:
[What problem does this solve? Who experiences this problem? Why existing solutions insufficient?]

Example:

- **Problem**: Valuable thoughts occur during non-writing moments (driving, walking, cooking) and are lost
- **Who**: Knowledge workers, creators, researchers who think while moving
- **Gap**: Existing voice memos lack AI processing, note apps require typing, thought capture tools don't structure insights

### Vision & Inspiration

**Vision** (What success looks like):
[Describe the end state - what does this project enable that didn't exist before?]

**Inspiration** (Similar projects, what's missing):
[What inspired this? What similar solutions exist? What gap remains?]

Example:

- Inspired by: Voice memos, Notion quick capture, Obsidian daily notes
- Missing: AI-enhanced processing, automatic structuring, CFP integration

### Value Proposition

**Core Benefit**:
[Why would someone use this? What's the compelling value?]

**Differentiator**:
[What makes this unique vs alternatives?]

---

## DOMAIN CONTEXT

### Technologies & Stack

**Languages**: [Python, JavaScript, Solidity, etc.]  
**Frameworks**: [React, Next.js, FastAPI, Hardhat, etc.]  
**Infrastructure**: [Docker, AWS, local, blockchain, etc.]  
**Key Libraries**: [Major dependencies that shape architecture]

Example:

- Languages: TypeScript, Python
- Frameworks: Next.js (frontend), FastAPI (backend)
- Infrastructure: Docker containers, local development
- Key Libraries: Whisper (STT), OpenAI API, PostgreSQL

### Deployment & Environment

**Target Platform**: [Web, mobile, desktop, CLI, browser extension]  
**Hosting**: [Cloud provider, on-prem, hybrid]  
**Compliance Requirements**: [HIPAA, GDPR, SOC2, none, etc.]  
**Scalability Needs**: [Single user, team, enterprise, global]

### Domain Terminology

**Glossary Subset to Load**:
[Which LTF Glossary terms are relevant? Or project-specific terms to define?]

Options:

- "Use LTF Glossary (complete)" - Load all framework terms
- "Subset: [TOPF, DMP, CIP-E, VS Suite]" - Load specific terms
- "Project-specific terms: [define below]" - New terminology for this project

**Project-Specific Terms** (if any):
| Term | Definition | Usage Context |
|------|------------|---------------|
| [Term] | [Clear definition] | [When/where used] |

Example:
| Term | Definition | Usage Context |
|------|------------|---------------|
| Thought Snippet | 15-60 second audio capture of spontaneous insight | User-facing feature name |
| Insight Structuring | AI process converting audio → categorized note | Backend processing step |

---

## FUNCTIONAL GOALS

### Core Features (MVP Must-Haves)

[What MUST this project do to be viable? Minimum feature set?]

Example:

1. Voice recording (mobile + desktop)
2. Speech-to-text conversion (Whisper integration)
3. AI categorization (tags, project assignment)
4. Quick review interface (today's captures)
5. Export to note systems (Obsidian, Notion)

### User Roles & Workflows

**Who Uses This**:
[Primary user personas, roles, access levels]

**How They Use It**:
[Typical workflows, user journeys, interaction patterns]

Example:

- **Solo Creator**: Captures thoughts while walking → Reviews at desk → Exports to Obsidian vault
- **Team Lead**: Records meeting insights → AI assigns to projects → Team sees categorized notes
- **Researcher**: Captures paper ideas during reading → AI links to existing notes → Builds research thread

### Success Criteria

**How We Know It Works**:
[Measurable outcomes, qualitative indicators, validation methods]

Example:

- Quantitative: 80%+ transcription accuracy, <5 sec processing time, 50+ captures/week sustained
- Qualitative: Users report "I don't lose ideas anymore", reduced friction vs typing notes
- Behavioral: Users naturally reach for voice capture vs writing (habit formation)

---

## PROJECT RELATIONSHIPS & DEPENDENCIES

### Parent Projects

**This Project Builds On**:
[Which existing projects/frameworks does this depend on or extend?]

Format:

- **[Project Name]**: [What we inherit - architecture, patterns, technologies, methodologies]

Example:

- **CFP Framework**: Uses CFP methodology for thought organization, applies "being heard" protocol to UX design
- **LTF Ecosystem**: Houses project, uses standard tooling (Save-Context, git hooks, bootstrap scripts)

### Related Projects

**Shares Concepts / Technologies / Users**:
[Which projects have overlap - shared tech stack, similar users, related concepts?]

Format:

- **[Project Name]**: [Shared element] - [Implication for this project]

Example:

- **EHR Consent Platform**: Shares Whisper STT integration - can reuse audio processing patterns
- **CFP Cognitive Companion**: Shares target users (knowledge workers) - can cross-promote, bundle features

### Downstream Projects

**Projects That Depend on This**:
[Will other projects build on this? What do they expect from us?]

Format:

- **[Project Name]**: [Dependency] - [Responsibility/contract]

Example:

- **CFP Tier 3 Integration**: Will use EchoForge as capture mechanism - must provide API for external triggers
- **Personal Knowledge Graph**: Will ingest EchoForge outputs - must maintain consistent export format

### Knowledge Sharing

**Cross-Project Learning**:
[What insights from this project inform other work? What do we learn from other projects?]

Format:

- **From This Project**: [Insight] → [Which projects benefit]
- **To This Project**: [Insight] ← [Which project teaches us]

Example:

- **From EchoForge**: Audio UX patterns → EHR platform (patient voice consent), CFP Companion (voice commands)
- **To EchoForge**: "Being heard" protocol ← CFP framework (confirmation UX, explicit acknowledgment after capture)

### Context Switching Notes

**When Switching TO This Project**:
[What context should AI emphasize? What's important to remember?]

Example:

- Emphasize: Consumer UX (not enterprise), mobile-first design, speed over features
- Remember: Target users are capturing thoughts while moving (simplicity critical)
- Load: CFP Glossary subset (TOPF, DMP for thought categorization)

**When Switching FROM This Project**:
[What context carries over? What should AI preserve?]

Example:

- Carry over: Audio processing learnings (apply to other projects using Whisper)
- Preserve: UX insights about quick capture patterns (inform other quick command designs)
- Don't assume: EchoForge patterns apply to enterprise projects (different user needs)

---

## ARCHITECTURAL DECISIONS & CONSTRAINTS

### Design Principles

[Core architectural values guiding this project]

Example:

1. **Mobile-First**: Primary use case is capture while moving
2. **Speed Over Features**: 3-second capture flow > complex categorization
3. **Offline-Capable**: Must work without internet (sync when available)
4. **Privacy-Default**: User owns data, local processing preferred

### Key Technical Decisions

[Major choices that shape implementation]

Format:

- **[Decision]**: [Rationale] - [Implications]

Example:

- **Whisper Local (not cloud STT)**: Privacy + offline capability - Requires local compute power, limits mobile
- **PostgreSQL (not MongoDB)**: Relational data for project/tag relationships - More setup complexity, better queries
- **Next.js SSR (not SPA)**: Better mobile performance, SEO for landing - More complex deployment, server required

### Constraints & Trade-offs

[What limitations exist? What did we sacrifice for other gains?]

Example:

- **No real-time collaboration**: Simplifies architecture, faster MVP - limits team use cases
- **English-only (MVP)**: Whisper multilingual possible but adds complexity - blocks international users initially
- **60-second max recording**: Keeps processing fast, encourages atomic thoughts - frustrates long-form thinkers

---

## STRATEGIC CONTEXT

### How This Relates to Other Work

[Portfolio positioning - where does this fit in broader product ecosystem?]

Example:

- **Platform Strategy**: EchoForge = first consumer CFP application (validates framework for broader market)
- **Revenue Model**: Freemium (basic capture free, AI structuring premium) - tests monetization before CFP Companion launch
- **Research Value**: Validates "unconscious problem-solving" pattern (thought capture during symbiotic rhythm pauses)

### Pivotal Moments & Key Insights

[Critical decisions, breakthroughs, lessons learned that shaped this project]

Format:

- **[Date]**: [Insight/Decision] - [Impact]

Example:

- **2025-11-10**: Recognized thought capture during AI processing pauses (symbiotic rhythm) - shifted from "replace note-taking" to "augment thinking time"
- **2025-11-12**: Audio snippet = compressed unconscious solution - AI expansion makes it actionable - aligned with CFP cognitive complementarity model

### Out of Scope (Important)

[What are we explicitly NOT doing? Helps prevent scope creep]

Example:

- ❌ Full note-taking replacement (EchoForge captures, doesn't organize long-form)
- ❌ Meeting transcription tool (different use case, different features)
- ❌ Social sharing (private by default, no public thought feeds)
- ❌ Enterprise features in MVP (team workspaces, admin controls - later)

---

## CURRENT FOCUS & ACTIVE WORK

### Active Sprint / Current Milestone

[What are we working on RIGHT NOW?]

Example:

- **Current**: MVP development - core capture flow + basic AI categorization
- **Milestone**: First 10 beta testers using daily (target: 2025-12-01)
- **Blockers**: Whisper performance on mobile (exploring cloud hybrid approach)

### Next 3 Priorities

[What's queued up after current work?]

Example:

1. Export integration (Obsidian plugin, Notion API)
2. Tag suggestion improvements (learning user's categorization patterns)
3. Review interface polish (better browsing of past captures)

### Open Questions / Decisions Needed

[What needs resolution? What are we uncertain about?]

Example:

- Should we support video snippets (visual thoughts)? Or audio-only keeps scope manageable?
- Pricing model: Per-capture metering vs flat subscription? Need beta feedback.
- Platform priority: iOS first (bigger market) or Android (faster development)? TBD.

---

## INTEGRATION WITH CFP/LTF

### CFP Principles Applied

[How does this project implement CFP methodology?]

Example:

- **TOPF (Think-Organize-Plan-Focus)**: Audio captures = Think phase, AI categorization = Organize phase
- **DMP Modes**: Recognize user's DMP state from audio tone/content, adapt processing
- **"Being Heard" Protocol**: Confirmation after capture ("I heard: [summary]. Correct?"), explicit acknowledgment

### LTF Tooling Used

[Which LTF standard tools/scripts does this project use?]

Example:

- Save-Context snapshots (preserve project state across sessions)
- Git hooks (commit message standards)
- Bootstrap scripts (project setup automation)
- Project-Specific CIP (this file) - loaded on context switch

### How This Extends Framework

[What does this project add back to CFP/LTF?]

Example:

- **New Pattern**: Voice-first quick capture (extends CFP beyond text-based interaction)
- **Research Data**: Validates unconscious problem-solving pattern (thought snippets = compressed solutions)
- **UX Principles**: Mobile-first CFP (informs future mobile CFP applications)

---

## GLOSSARY QUICK REFERENCE (Project-Specific)

[If project uses specific terms frequently, define them here for quick AI loading]

**Core Terms**:

- **[Term]**: [Definition]

**Common Abbreviations**:

- **[Abbrev]**: [Full form] - [Usage]

**User-Facing Language**:

- **[What users call it]**: [What we call it internally] - [Why difference matters]

Example:

- **Thought Snippet**: 15-60 second audio capture (user-facing term, friendly/informal)
- **Capture Event**: Internal term for thought snippet + metadata (engineering term, precise)
- **Why Different**: Users think "snippet" (casual, low-friction), we track "event" (structured data object)

---

## VERSION HISTORY & EVOLUTION

### Major Milestones

[Track significant project phases]

Format:

- **[Date]**: [Version/Phase] - [What changed]

Example:

- **2025-11-08**: Ideation - Initial concept from "I lose thoughts while walking" pain point
- **2025-11-10**: Planning - Technical architecture designed, stack selected
- **2025-11-12**: Active Development - MVP sprint started, 10 beta testers identified

### Lessons Learned (Update as Project Evolves)

[What would we do differently? What worked well?]

Example:

- ✅ **Worked Well**: Starting with single-user simple flow (not team features) - faster iteration
- ⚠️ **Challenge**: Whisper local processing slow on mobile - hybrid cloud approach needed
- 🔄 **Pivot**: From "replace notes" to "augment thinking" - better product-market fit

---

## USAGE NOTES FOR AI

### When Loading This CIP

**Context to Emphasize**:
[What should AI focus on when this project becomes active context?]

Example:

- User experience simplicity (not technical complexity)
- Mobile-first design constraints (not desktop assumptions)
- Privacy/local-first architecture (not cloud-first patterns)

**Related CIPs to Consider Loading**:
[Which other project contexts might be relevant?]

Example:

- `CIP_Project_CFP.md` - Framework methodology this applies
- `CIP_Project_EHR.md` - Shares Whisper STT integration (technical patterns)

### When Context Switching Away

**What to Preserve**:
[What insights from this project should carry over to other work?]

Example:

- Audio UX patterns (apply to other voice-enabled features)
- Mobile-first constraints (inform other mobile projects)
- Quick capture philosophy (inform other "low-friction input" designs)

**What NOT to Carry Over**:
[What's specific to this project only?]

Example:

- Consumer UX expectations (don't apply to enterprise EHR project)
- Offline-first architecture (other projects might be cloud-native)
- Audio-specific processing (not all projects use voice input)

---

## TEMPLATE METADATA

**Template Version**: 1.0  
**Last Updated**: 2025-11-12  
**Created By**: CFP v3.0 Save-Context enhancement  
**Usage**: Copy template, rename to `CIP_Project_[MNEMONIC].md`, fill sections, save in `core/projects/` or project root

**Sections to Customize**:

- All bracketed placeholders `[like this]`
- Examples (replace with actual project content)
- Glossary (add project-specific terms)
- Keep section structure (enables consistent AI loading)

**When to Update**:

- Major architectural decisions made
- Pivotal moments occur (capture insights while fresh)
- Project status changes (Ideation → Planning → Active Development)
- Relationships with other projects evolve
- After significant milestones (document lessons learned)

---

**End of Project-Specific CIP Template**  
**Next Step**: Create example CIP files for LTF, EchoForge, EHR, new project to validate template design
