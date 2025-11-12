# Project-Specific CIP: EchoForge (AI Thought Capture)
**Mnemonic**: ECHO  
**Status**: Ideation / Early Planning  
**Last Updated**: 2025-11-12

---

## PROJECT IDENTITY

### Basic Information
- **Project Name**: EchoForge
- **Mnemonic**: ECHO
- **Status**: Ideation / Early Planning
- **Start Date**: 2025-11-08 (concept emerged)
- **Last Active**: 2025-11-12

### Quick Context
EchoForge is an AI-powered thought capture tool that converts ephemeral audio snippets (15-60 seconds) into structured, categorized insights using CFP principles - designed for capturing thoughts during non-writing moments (walking, driving, cooking).

---

## CORE CONCEPT

### Problem Statement
**User Pain Point**: 
Valuable thoughts occur during movement/non-writing moments and are lost. Existing voice memos lack AI processing, note apps require typing, thought capture tools don't structure insights according to cognitive frameworks.

**Who Experiences This**: 
Knowledge workers, creators, researchers, developers who think while moving and lose ideas before reaching a keyboard.

**Gap**: 
No tool combines: Quick audio capture + AI structuring + CFP methodology + Export to existing note systems (Obsidian, Notion, etc.)

### Vision & Inspiration
**Vision**: 
"Never lose a thought again" - Frictionless capture during symbiotic cognitive rhythm pauses, automatic structuring via CFP principles, seamless integration with user's existing knowledge management system.

**Inspiration**:
- Voice memos (capture, but no processing)
- Notion quick capture (structured, but requires typing)
- Obsidian daily notes (organized, but no audio)
- **EchoForge adds**: Audio + AI + CFP methodology + Export integration

---

## DOMAIN CONTEXT

### Technologies & Stack
**Languages**: TypeScript (frontend/backend), Python (AI processing)  
**Frameworks**: Next.js (web app), React Native (mobile app - future), FastAPI (backend API)  
**Infrastructure**: Docker containers, local-first with optional cloud sync  
**Key Libraries**: 
- Whisper (OpenAI STT for audio transcription)
- OpenAI API (GPT-4 for categorization/structuring)
- PostgreSQL (thought storage, metadata)
- Redis (caching, queue management)

### Deployment & Environment
**Target Platform**: Mobile-first (primary use case is capture while moving), web secondary  
**Hosting**: Local development initially, cloud deployment for beta (AWS/Vercel TBD)  
**Compliance Requirements**: Privacy-first (user owns data, local processing preferred)  
**Scalability Needs**: Single-user MVP → Team features later (shared thought spaces)

### Domain Terminology
**Glossary Subset**: TOPF, DMP (for thought categorization), "being heard" protocol (UX confirmation)

**Project-Specific Terms**:
| Term | Definition | Usage Context |
|------|------------|---------------|
| Thought Snippet | 15-60 second audio capture of spontaneous insight | User-facing feature name (friendly/informal) |
| Capture Event | Thought snippet + metadata (timestamp, location, project tag) | Internal engineering term (precise) |
| Insight Structuring | AI process: audio → transcription → categorization → formatted note | Backend processing pipeline |
| Echo | Single captured thought (post-processing) | Short form, user-facing ("your echoes") |

---

## FUNCTIONAL GOALS

### Core Features (MVP Must-Haves)
1. **Audio Capture**: Quick recording (1-tap start, auto-stop at 60s or manual stop)
2. **Speech-to-Text**: Whisper integration (local or cloud hybrid for speed)
3. **AI Categorization**: Auto-tag by project, topic, TOPF phase (Think/Organize/Plan/Focus)
4. **Quick Review**: Today's captures list, playback + edited transcript
5. **Export Integration**: Send to Obsidian (markdown), Notion (API), or email

### User Roles & Workflows
**Solo Creator** (Primary MVP persona):
1. Walking/commuting, idea occurs
2. 1-tap capture (speak 15-60 seconds)
3. Confirmation: "I heard: [summary]. Correct?" (being heard protocol)
4. Later: Review at desk, browse today's echoes
5. Export selected echoes to Obsidian vault (append to daily note or project note)

**Future Personas**:
- **Team Lead**: Captures meeting insights → AI assigns to team projects → Team sees categorized notes
- **Researcher**: Captures paper ideas during reading → AI links to existing notes → Builds research thread

### Success Criteria
**Quantitative**:
- Transcription accuracy ≥80% (Whisper baseline, improve with user corrections)
- Processing time <5 seconds (capture → transcription → categorization)
- User retention: 50+ captures/week sustained for 30 days (habit formation)

**Qualitative**:
- Users report: "I don't lose ideas anymore" (pain point solved)
- Reduced friction vs typing (users prefer audio capture)
- Export integration seamless (no manual copy/paste needed)

**Behavioral**:
- Users naturally reach for voice capture vs writing (habit shift)
- Users review echoes daily (engagement with processed thoughts)
- Users refine AI categorization (active participation in structuring)

---

## PROJECT RELATIONSHIPS & DEPENDENCIES

### Parent Projects
- **CFP Framework**: Uses CFP methodology for thought organization (TOPF categorization, DMP mode detection from audio tone)
- **LTF Ecosystem**: Houses project, uses Save-Context, git hooks, bootstrap scripts

### Related Projects
- **EHR Consent Platform**: Shares Whisper STT integration - can reuse audio processing patterns, mobile voice UX learnings
- **CFP Cognitive Companion**: Shares target users (knowledge workers) - can cross-promote, bundle features (Tier 3 = EchoForge + CFP Companion)

### Downstream Projects
- **CFP Tier 3 Integration**: EchoForge becomes CFP Companion's capture mechanism (API integration required)
- **Personal Knowledge Graph** (future): Will ingest EchoForge outputs - must maintain consistent export format (markdown + frontmatter)

### Knowledge Sharing
**From EchoForge to Other Projects**:
- Audio UX patterns → EHR platform (patient voice consent), CFP Companion (voice commands), LTF (voice-first quick prompts)
- Mobile-first constraints → Future LTF mobile apps (design principles)
- Quick capture philosophy → Other "low-friction input" features across ecosystem

**To EchoForge from Other Projects**:
- "Being heard" protocol ← CFP framework (confirmation UX: "I heard: [summary]. Correct?")
- User State Model ← LTF (personalization: learn user's categorization preferences over time)
- Multi-contextual reflection ← CFP (AI processing of audio considers: content, tone, energy, context, project relationships)

### Context Switching Notes
**When Switching TO EchoForge**:
- Emphasize: Consumer UX simplicity (not enterprise features), mobile-first design, speed over complexity
- Remember: Primary use case is capture while moving (3-second flow critical, no multi-step wizards)
- Load: Audio processing patterns, Whisper integration notes, export format specs

**When Switching FROM EchoForge**:
- Carry over: Audio UX insights (apply to other voice features), quick capture philosophy, privacy-first approach
- Preserve: Mobile constraints (inform other mobile projects)
- Don't assume: EchoForge's consumer focus applies to enterprise projects (different user expectations)

---

## ARCHITECTURAL DECISIONS & CONSTRAINTS

### Design Principles
1. **Mobile-First**: Primary use case is capture while moving (desktop is secondary review interface)
2. **Speed Over Features**: 3-second capture flow > complex categorization wizards (add depth later)
3. **Offline-Capable**: Must work without internet (queue for processing when connection returns)
4. **Privacy-Default**: User owns data, local processing preferred (cloud only if user opts in)
5. **Frictionless**: No login before capture (authentication deferred to review/export phase)

### Key Technical Decisions
- **Whisper Local (not cloud STT)**: Privacy + offline capability → Requires local compute power (limits low-end mobile devices - may need cloud hybrid)
- **PostgreSQL (not MongoDB)**: Relational model for project/tag relationships → More setup complexity, but better for structured queries
- **Next.js SSR (not pure SPA)**: Better mobile performance, SEO for marketing site → More complex deployment (need server), but worth it for UX
- **React Native (future mobile)**: Cross-platform (iOS + Android from one codebase) → Web app first (validate concept), native app later

### Constraints & Trade-offs
- **No real-time collaboration (MVP)**: Simplifies architecture, faster development → Limits team use cases (add later if validated)
- **60-second max recording**: Keeps processing fast, encourages atomic thoughts → Frustrates long-form thinkers (accept trade-off for speed)
- **English-only (MVP)**: Whisper multilingual possible but adds testing complexity → Blocks international users initially (add languages post-MVP if demand exists)
- **Export-only (no native organization)**: Integrates with existing systems (Obsidian, Notion) vs building new system → Users must have external note system (acceptable for target persona)

---

## STRATEGIC CONTEXT

### How This Relates to Other Work
**Platform Strategy**: 
EchoForge = first consumer CFP application (validates framework for broader market beyond enterprise/technical users). Success proves CFP principles work in consumer products.

**Revenue Model**: 
Freemium - Basic capture free (10 echoes/day), AI structuring premium ($5-10/month unlimited). Tests monetization strategy before CFP Companion launch (learn pricing, conversion rates).

**Research Value**: 
Validates "unconscious problem-solving" pattern (thought snippets during symbiotic rhythm pauses are compressed solutions). Audio analysis reveals DMP modes from tone/energy (research contribution: non-textual AI collaboration patterns).

### Pivotal Moments & Key Insights
- **2025-11-08**: Pain point recognized ("I lose thoughts while walking") → Initial concept sketched
- **2025-11-10**: Symbiotic cognitive rhythm insight → Reframed from "replace note-taking" to "augment thinking time" (capture during AI processing pauses, not replace writing sessions)
- **2025-11-12**: Audio snippet = compressed unconscious solution → Aligned with CFP cognitive complementarity model (AI expansion makes brief audio actionable)

### Out of Scope (Important)
- ❌ Full note-taking replacement (EchoForge captures, doesn't organize long-form writing)
- ❌ Meeting transcription tool (different use case: collaborative recording vs solo thoughts, different feature set)
- ❌ Social sharing (private by default, no public "thought feeds" or social network features)
- ❌ Enterprise features in MVP (team workspaces, admin controls, SSO - add later if validated)
- ❌ Video snippets (audio-only keeps scope manageable, video later if users request)

---

## CURRENT FOCUS & ACTIVE WORK

### Active Sprint / Current Milestone
**Current**: Conceptual design + technical feasibility validation  
**Milestone**: Beta MVP ready for 10 testers (target: 2025-12-01)  
**Blockers**: Whisper performance on mobile (local too slow on older phones, exploring cloud hybrid approach)

### Next 3 Priorities
1. **Technical Prototype**: Prove Whisper + GPT-4 pipeline works (speed + accuracy baseline)
2. **Mobile UX Mockups**: Design 3-second capture flow (validate with potential users before building)
3. **Export Integration**: Obsidian plugin OR simple markdown file generation (choose based on user feedback)

### Open Questions / Decisions Needed
- **Video snippets**: Support visual thoughts (whiteboard sketches, screenshot captures)? OR audio-only keeps scope manageable? → Need user feedback (defer decision until prototype tested)
- **Pricing model**: Per-capture metering ($0.10/echo after 10 free daily) vs flat subscription ($10/month unlimited)? → Test both with beta users, measure conversion
- **Platform priority**: iOS first (bigger market, TestFlight easy) OR Android first (faster development, broader device testing)? → TBD based on beta tester device distribution

---

## INTEGRATION WITH CFP/LTF

### CFP Principles Applied
- **TOPF Framework**: Audio captures auto-tagged by phase (Think/Organize/Plan/Focus based on content analysis)
- **DMP Modes**: Detect user's mode from audio tone/energy (excited = CREATIVE, analytical = FOCUSED, reflective = REFLECTIVE, structured = ANALYTICAL)
- **"Being Heard" Protocol**: Confirmation after capture: "I heard: [summary]. Correct?" with easy edit/re-record if wrong (builds trust, reduces anxiety about mistakes)
- **Multi-Contextual Reflection**: AI processes audio across dimensions (content, tone, project context, related echoes, export format, TOPF phase)

### LTF Tooling Used
- Save-Context snapshots (preserve project state across sessions)
- Git hooks (commit message standards for development)
- Bootstrap scripts (project setup when development begins)
- Project-Specific CIP (this file) loaded on context switch to EchoForge work

### How This Extends Framework
**New Patterns**:
- **Voice-first CFP**: Extends CFP beyond text-based interaction (audio as primary input modality)
- **Mobile-first cognitive scaffolding**: CFP principles applied in mobile context (design constraints inform future mobile CFP apps)
- **Unconscious solution capture**: Validates pattern (brief audio = compressed problem-solving output, AI expansion makes actionable)

**Research Contributions**:
- Non-textual collaboration patterns (audio tone reveals DMP mode, energy patterns)
- Mobile UX for cognitive frameworks (3-second capture flow vs desktop complexity)
- Symbiotic rhythm validation (thought capture during AI processing pauses = natural workflow integration)

---

## GLOSSARY QUICK REFERENCE

**Project-Specific**:
- **Thought Snippet**: 15-60 second audio capture (user-facing, friendly)
- **Capture Event**: Snippet + metadata (engineering term, precise)
- **Echo**: Single captured thought post-processing (short form, "your echoes")
- **Insight Structuring**: AI pipeline (audio → transcription → categorization → formatted note)

**From CFP Framework**:
- **TOPF**: Think-Organize-Plan-Focus (used for auto-categorization)
- **DMP**: Dynamic Mode Preference (detected from audio tone/energy)

---

## VERSION HISTORY & EVOLUTION

### Major Milestones
- **2025-11-08**: Concept emerged (pain point: "I lose thoughts while walking")
- **2025-11-10**: Reframe pivot ("replace notes" → "augment thinking time" via symbiotic rhythm insight)
- **2025-11-12**: Aligned with unconscious problem-solving pattern (audio snippets = compressed solutions)

### Lessons Learned
✅ **Worked Well**:
- Starting with pain point, not feature list (keeps focus on user value)
- Mobile-first constraint (forces simplicity, prevents feature bloat)

⚠️ **Challenges**:
- Whisper performance on mobile (local too slow - need cloud hybrid)
- Audio categorization accuracy unknown (need prototype to measure baseline)

🔄 **Pivots**:
- From "voice memo replacement" → "cognitive capture during thinking time" (bigger vision, clearer differentiation)

---

## USAGE NOTES FOR AI

### When Loading This CIP
**Context to Emphasize**:
- Consumer UX simplicity (not enterprise complexity)
- Mobile-first constraints (speed, offline, friction)
- Audio as primary modality (different patterns than text-based work)

**Related CIPs to Consider Loading**:
- `CIP_Project_CFP.md` - Framework methodology this implements
- `CIP_Project_EHR.md` - Shares Whisper/audio patterns (technical reuse)

### When Context Switching Away
**What to Preserve**:
- Audio UX patterns (apply to other voice features across ecosystem)
- Mobile-first philosophy (inform other mobile work)
- Quick capture simplicity (inform low-friction input features)

**What NOT to Carry Over**:
- Consumer focus (don't apply to enterprise EHR project)
- Audio-first assumptions (not all projects use voice)
- 3-second flow constraint (appropriate here, not universal)

---

**Template Version**: Based on `Project_CIP_Template.md` v1.0  
**Next Update**: After technical prototype (capture feasibility findings, UX validation insights)
