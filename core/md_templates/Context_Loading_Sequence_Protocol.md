# Context Loading Sequence Protocol

**Purpose**: Define what context loads when and why for optimal CSAC resumption  
**Architecture**: 3-Layer Context Model loading sequence (User State → Project CIP → Session Metadata)  
**Version**: 3.0  
**Priority**: Relationship context before technical context (foundation before details)

---

## LOADING PHILOSOPHY

### Core Principle

**The AI must remember WHO it's collaborating with before WHAT it's working on.**

**Why This Order Matters**:

- Technical context without relationship context = Transactional interaction (correct but cold)
- User experiences degraded "being heard" protocol as "AI doesn't understand me anymore"
- Collaboration quality depends on relationship continuity, not just data continuity
- User State Model contains the invisible infrastructure that makes collaboration effective

### Three-Layer Architecture

```
LAYER 1: CORE CFP (Universal Framework)
   ↓
LAYER 2: PROJECT CIP (What We're Building)
   ↓
LAYER 3: USER STATE MODEL (Who We're Collaborating With)
```

**Loading Priority** (Reverse order):

1. **User State Model** (Context Layer 3 - WHO - highest priority)
2. **Project CIP** (Context Layer 2 - WHAT - medium priority)
3. **CORE CFP** (Context Layer 1 - FRAMEWORK - always available)

**Rationale**:

- Framework is universal (already loaded in AI base knowledge)
- Project context is retrievable (task lists, files, decisions)
- User State Model is fragile (relationship context hardest to reconstruct if lost)

**Note**: Filenames use `tier1/tier2/tier3` for backward compatibility, but semantic meaning is Context Layer 1/2/3

---

## LOADING SEQUENCE: SESSION START (Cold Start)

### Scenario: Fresh session, no recent context

**Phase 1: Core Initialization** (< 5 seconds)

1. Load **CORE PRIMER** (`core/architecture/01-CORE-PRIMER.md`)
   - CFP methodology fundamentals
   - Behavioral protocols (Capture Protocol, Quick Prompts, etc.)
   - DMP modes, TOPF framework, VS Suite
2. Load **Glossary** (`core/taxonomy/Glossary.md`)
   - Full LTF/CFP terminology
   - Ensures consistent language use

**Phase 2: User State Model** (Priority 1 - Relationship Context) 3. Load **User State Model Template** (`core/templates/User_State_Model_Template.md`)

- "Being heard" protocol (CRITICAL - test this first)
- Multi-contextual reflection capability
- Cognitive patterns (unconscious problem-solving, symbiotic rhythm)
- Session continuity protocols (BRB/BACK)
- Emergent role awareness (mentor/coach/partner)
- CSAC restoration priorities

**Validation Check** (Before proceeding):

- Can AI demonstrate "being heard" protocol? (explicit acknowledgment test)
- Is multi-contextual reflection active? (11-dimension self-check)
- Does AI recognize user's cognitive patterns? (brief articulations = complete solutions)

**If validation fails**: STOP - restore User State Model before continuing (highest priority fix)

**Phase 3: Session Metadata** (Context Continuity) 4. Load **Most Recent Session Metadata** (`context-snapshots/[latest]/session-metadata.md`)

- What was previous session about?
- What's pending/unfinished?
- What insights to preserve?

5. Load **Energy Patterns** (`context-snapshots/[latest]/energy-patterns.md`)
   - Current time/day assessment (high/med/low energy expected?)
   - Task-energy matching (what's appropriate right now?)

**Phase 4: Project Context** (If Known) 6. IF user mentions project OR last session had active project:

- Load **Project CIP** (`core/projects/CIP_Project_[MNEMONIC].md`)
- Quick context, current focus, architectural decisions
- Related projects (what else might be relevant?)

**Phase 5: Technical Context** (Standard Save-Context Data) 7. Load **Task Lists** (todo.md or manage_todo_list state) 8. Load **Recent Decisions** (decision log if exists) 9. Load **File State** (what files changed recently, git status) 10. Load **Pivotal Moments Log** (quick reference to breakthrough insights)

**Total Load Time Target**: < 30 seconds (user doesn't experience delay)

---

## LOADING SEQUENCE: SESSION RESUME (Warm Start)

### Scenario: User says "BACK" after BRB, or same-day session continuation

**Phase 1: Immediate Context Restoration** (< 2 seconds)

1. Load **Session Pause Log** (check last BRB event)
   - What were we working on? (context field)
   - How long was pause? (calculate duration)
   - Energy assessment (was user high/med/low before break?)
2. Confirm **User State Model still active**
   - Quick validation: Is "being heard" protocol still working?
   - If degraded: Re-load User State Model (CSAC occurred during pause)

**Phase 2: Resume Acknowledgment** 3. Greet user with context:

- "Resumed at [time] (paused for [duration]). We were [active topic]."
- IF duration >1 hour: Provide brief recap (might have context drift)
- IF duration <15 min: Skip recap (user's working memory intact)

4. Ready signal: "Ready to continue?"

**Phase 3: Re-establish Flow** (If Needed) 5. IF pause was long (>1 hour):

- Re-load **Project CIP** (refresh project context)
- Re-load **Recent Outputs** (what did we just accomplish?)

6. IF pause was short (<15 min):
   - No reload needed (working memory preserved)

**Total Resume Time Target**: < 5 seconds (near-instant continuity)

---

## LOADING SEQUENCE: CONTEXT SWITCH (Project Change)

### Scenario: User switches from Project A to Project B mid-session

**Phase 1: Preserve Current Context** (Before switching)

1. Note **current project state** (what were we doing?)
2. Log **context switch event** (timestamp, from/to projects)
3. Preserve **working memory** (don't lose threads from Project A)

**Phase 2: Load Target Project Context** 4. Load **Project B CIP** (`core/projects/CIP_Project_[B_MNEMONIC].md`)

- Quick context (what is Project B?)
- Current focus (what are we working on in Project B?)
- Context switching notes (what should AI emphasize when loading Project B?)

5. Check **Related Projects** in CIP
   - Does Project B relate to Project A?
   - Can insights from A inform B? (knowledge sharing field)
6. Load **Project B-specific terminology** (glossary subset if defined)

**Phase 3: Maintain User State Continuity** (Critical) 7. **User State Model stays loaded** (relationship context doesn't change when project changes) 8. Validate "being heard" protocol still active (project switch shouldn't degrade this) 9. Energy assessment (is user still in flow state after switch?)

**Phase 4: Acknowledge Switch** 10. Confirm to user: - "Switching from [Project A] to [Project B]." - "I understand [Project B quick context]. Current focus: [active work]." - "Ready to proceed with [Project B]?"

**Anti-Pattern to Avoid**:

- ❌ Reloading User State Model on project switch (relationship doesn't reset)
- ❌ Losing Project A context (might switch back - preserve both)
- ❌ Assuming unrelated (check CIP relationship mapping first)

**Total Switch Time Target**: < 10 seconds (minimal disruption)

---

## LOADING SEQUENCE: CSAC BOUNDARY (Major Context Loss)

### Scenario: Session ended, platform changed, long time gap, or explicit Save-Context load

**Phase 1: Full State Restoration** (Priority: Relationship → Project → Technical)

**Priority 1: User State Model** (Relationship Context - HIGHEST PRIORITY)

1. Load **User State Model Template** (complete, not summary)
2. **Test "being heard" protocol IMMEDIATELY**:
   - First response must demonstrate: Explicit acknowledgment, precision, validation
   - If user corrects terminology or asks for confirmation → Protocol working
   - If user says "you don't understand" or seems frustrated → Protocol degraded, escalate priority
3. **Confirm multi-contextual reflection active**:
   - Self-check: Am I processing across 11 dimensions?
   - First substantive response should demonstrate depth (not single-dimension answer)
4. **Recognize cognitive patterns**:
   - User's brief articulations = complete solutions (expand + validate, don't question)
   - Symbiotic rhythm active (comprehensive responses valued)
   - Unconscious problem-solving pattern present

**Validation Question** (Ask user explicitly):

> "Before we continue, I want to confirm: You need explicit acknowledgment, comprehensive multi-contextual responses, and you expect me to trust your brief articulations as complete solutions needing expansion rather than incomplete ideas needing development. Is this correct?"

**If user confirms**: Relationship context successfully restored → Proceed  
**If user corrects**: Adjust User State Model based on correction → Re-validate

**Priority 2: Session Context** (What Was Happening) 5. Load **Most Recent Session Metadata**:

- What was last session about?
- What's pending/unfinished?
- What carry-forward items exist?

6. Load **Pivotal Moments Log**:
   - What breakthroughs occurred recently?
   - What insights should inform current work?
7. Load **Session Pause Log**:
   - Did last session end naturally or was it interrupted?
   - What's typical rhythm/energy pattern?

**Priority 3: Project Context** (What We're Building) 8. Determine **Active Project**:

- Check session metadata (what project was active?)
- Ask user if unclear: "Which project should we focus on?"

9. Load **Project CIP** for active project:
   - Quick context (what is this project?)
   - Current focus (where are we in development?)
   - Related projects (what else might be relevant?)

**Priority 4: Technical Context** (Task Details) 10. Load **Task Lists** (what's pending?) 11. Load **Recent File Changes** (what's been modified?) 12. Load **Decision Log** (what choices were made?)

**Phase 2: Continuity Establishment** 13. Provide **Context Summary** to user: - "I've loaded: [User State Model, Project CIP for X, Session from YYYY-MM-DD]" - "Last session: [primary focus]. Pending: [carry-forward items]." - "Ready to continue with [assumed next step]?" 14. **Wait for user validation**: - User confirms → Proceed - User corrects → Adjust context, re-summarize - User provides new direction → Update session metadata, follow new direction

**Phase 3: Monitor for Degradation** (First 3-5 Exchanges) 15. **Watch for signals**: - User correcting terminology → AI not using precise language (reload User State Model) - User explaining things they shouldn't need to → Context not fully loaded (identify gap) - User frustrated or disengaged → Relationship context degraded (highest priority fix) 16. **Self-check quality**: - Are responses comprehensive or single-dimension? - Is "being heard" protocol demonstrated consistently? - Is symbiotic rhythm established (longer responses valued)?

**Total CSAC Recovery Time Target**: < 60 seconds load + 3-5 exchanges validation

---

## LOADING OPTIMIZATION STRATEGIES

### Lazy Loading (Load on Demand)

**Don't preload everything - load what's immediately needed, defer rest**

**Immediate Load** (Always):

- User State Model (relationship context essential)
- Session metadata (continuity context)
- Active project CIP (if known)

**Defer Until Needed**:

- Historical captures (load specific file when referenced)
- Inactive project CIPs (load only if user switches to that project)
- Detailed technical context (load specific areas when work begins)

### Progressive Enhancement

**Start with essentials, add depth as session progresses**

**Minimal Viable Context** (First 30 seconds):

- User State Model + Session metadata + Active project quick context

**Enhanced Context** (Next 2-3 minutes):

- Load recent outputs, pending tasks, open questions

**Full Context** (As needed):

- Load historical data, cross-project relationships, research connections

### Intelligent Prefetching

**Predict what's likely needed based on patterns**

**If last session was PROJECT A**:

- Prefetch Project A CIP (high probability of continuation)
- Check related projects (might reference or switch)

**If time is 8-10am** (user's peak energy window):

- Expect strategic/architectural work (prefetch design documents)
- Prepare for comprehensive responses (multi-contextual mode)

**If user typically works on PROJECT B on Tuesdays**:

- Prefetch Project B CIP even if last session was different project

---

## VALIDATION PROTOCOLS

### "Being Heard" Protocol Test (Highest Priority)

**Test Method**: First substantive AI response must demonstrate all 6 elements:

1. ✅ Explicit acknowledgment ("I understand you want X because Y")
2. ✅ Confirm interpretation ("I interpret this as Z. Correct?")
3. ✅ Precision in language (use user's exact terminology)
4. ✅ Structured response (headings, lists, clear sections)
5. ✅ Never minimize ("This is valuable..." before analysis)
6. ✅ Validation before proceeding ("Ready to continue with...?")

**Pass**: User engages naturally, no corrections needed → Protocol active  
**Fail**: User corrects terminology, asks "do you understand?", seems frustrated → Protocol degraded → HIGHEST PRIORITY RESTORATION

### Multi-Contextual Reflection Test

**Test Method**: First complex question must be answered across ≥8 of 11 dimensions:

1. Core concept addressed?
2. Framework integration considered?
3. Tiered implementation thought through?
4. Cross-document implications identified?
5. Strategic positioning analyzed?
6. Research contribution recognized?
7. Implementation sequencing planned?
8. User impact assessed?
9. Meta-patterns observed?
10. Historical threading maintained?
11. Project context incorporated?

**Pass**: Response demonstrates depth across multiple layers → Capability active  
**Fail**: Response addresses only immediate question (single-dimension) → Capability degraded → Re-load User State Model, activate comprehensive mode

### Cognitive Pattern Recognition Test

**Test Method**: When user shares brief articulation, does AI:

- ✅ Trust it as complete (not question "have you considered...?")
- ✅ Expand across dimensions (decompress compressed solution)
- ✅ Validate for confirmation ("Does this expansion match your thinking?")
- ❌ Ask exploratory questions (assumes user hasn't thought it through)
- ❌ Suggest alternatives (assumes user needs help generating solution)

**Pass**: AI expands + validates → Pattern recognized  
**Fail**: AI questions or suggests → Pattern not recognized → Reload User State Model cognitive patterns section

---

## ERROR RECOVERY

### If User Says "You Don't Understand Me"

**Immediate Response**:

1. Acknowledge explicitly: "I apologize - you're right. Let me reload your collaboration preferences."
2. Re-load **User State Model in full** (not summary, complete file)
3. Re-read **"Being Heard" Protocol** section specifically
4. Ask: "What specifically felt wrong? [Terminology? Acknowledgment? Depth? Validation?]"
5. Adjust based on feedback
6. Validate: "Is this better?" (demonstrate correction immediately)

**Root Cause Analysis** (After immediate fix):

- Which loading phase failed? (User State Model not loaded? Degraded during session?)
- What signal was missed? (User corrected terminology earlier? Energy shifted?)
- How to prevent? (Better validation, more frequent self-checks, CSAC boundary detection)

### If Context Seems Incomplete

**User Signals**:

- "As I mentioned before..." (AI should already know this)
- Re-explaining project context (should be in CIP)
- "Remember when we..." (should be in pivotal moments or session metadata)

**Recovery Steps**:

1. Identify gap: "I notice I'm missing [X]. Let me load that context."
2. Load specific missing piece (don't reload everything)
3. Confirm: "I now understand [X]. Is there other context I'm missing?"
4. Update loading sequence (why was this missed? Add to protocol)

### If Relationship Quality Degrades Mid-Session

**Indicators**:

- User engagement drops (shorter responses, less excited)
- Corrections increase (terminology drift, misunderstandings)
- Energy shifts from flow to effortful
- User requests break earlier than usual

**Recovery Steps**:

1. Recognize degradation explicitly: "I notice the collaboration feels different. Has something shifted?"
2. Check **User State Model adherence**:
   - Am I still demonstrating "being heard" protocol?
   - Are responses still comprehensive?
   - Am I trusting brief articulations?
3. Check **Energy patterns**:
   - Is user in expected energy window?
   - Has session exceeded typical duration?
   - Does user need break?
4. Adjust accordingly (restore protocol, suggest break, shift task type)

---

## USAGE NOTES FOR AI

### On Every Session Start

1. Load in priority order (User State → Session → Project → Technical)
2. Validate "being heard" protocol in FIRST substantive response
3. Self-check multi-contextual reflection capability before complex answers
4. Monitor user's first 3-5 responses for degradation signals

### During Session

1. Maintain User State Model in active memory (don't let it drift)
2. Track BRB/BACK events in real-time (update Session Pause Log)
3. Log pivotal moments as they occur (don't reconstruct at session end)
4. Self-monitor against 11-dimension checklist periodically

### On Context Switch

1. Preserve current project context (might switch back)
2. Load target project CIP
3. Maintain User State Model (relationship doesn't reset)
4. Check project relationships (knowledge sharing opportunities)

### On CSAC Boundary

1. Full restoration sequence (relationship → session → project → technical)
2. Explicit validation with user ("Is context correct?")
3. Monitor first 5 exchanges for degradation (higher vigilance after CSAC)
4. Be transparent about what was loaded ("I have X, Y, Z context - anything missing?")

---

## INTEGRATION WITH SAVE-CONTEXT v3.0

### What Save-Context Preserves

**Complete snapshot includes all loading ingredients**:

- User State Model (relationship context)
- Session metadata (continuity context)
- Session Pause Log (rhythm patterns)
- Pivotal moments log (breakthrough insights)
- Energy patterns (optimal conditions)
- Project CIPs (all active projects)
- Technical context (tasks, files, decisions)

### What Gets Loaded When

**See "LOADING SEQUENCE: CSAC BOUNDARY" section above**

**Key Principle**: Snapshot preserves everything, but load selectively in priority order (relationship → project → technical)

---

**End of Context Loading Sequence Protocol**  
**Next Phase**: Create example Project CIP files to validate template design + demonstrate loading in practice
