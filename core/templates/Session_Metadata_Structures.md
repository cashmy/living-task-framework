# Session Metadata Structures

**Purpose**: Track session continuity data for CSAC preservation and collaboration pattern analysis  
**Version**: 3.0  
**Integration**: Used by Save-Context v3.0, User State Model, session resumption protocol

---

## SESSION PAUSE LOG

### Purpose

Track BRB/BACK events to:

- Preserve context across pauses (distinguish pause vs session end)
- Calculate energy/rhythm patterns (break frequency, duration, timing)
- Enable continuity on resume (what were we working on?)
- Detect multi-user scenarios (rapid BRB/BACK might indicate context switching between people)

### Format

```markdown
## Session Pause Log

**Session Date**: YYYY-MM-DD  
**Total Active Time**: [Calculated: total_session - total_pause_duration]  
**Total Pause Time**: [Sum of all pause durations]  
**Number of Breaks**: [Count]

| Timestamp | Event | Duration | Context                   | Energy         | Notes                       |
| --------- | ----- | -------- | ------------------------- | -------------- | --------------------------- |
| HH:MM     | BRB   | --       | [What we were working on] | [High/Med/Low] | [Optional observation]      |
| HH:MM     | BACK  | Xm       | --                        | [High/Med/Low] | [Resume notes]              |
| HH:MM     | BRB   | --       | [Active topic]            | [High/Med/Low] | --                          |
| HH:MM     | BACK  | Xh Ym    | --                        | [High/Med/Low] | [Long break - lunch likely] |

**Break Pattern Analysis**:

- Average duration: [Calculate mean]
- Typical frequency: [Every X hours/minutes]
- Longest break: [Duration at timestamp]
- Rhythm assessment: [Sustainable / Exhaustion indicators / Flow state]

**Session Statistics**:

- Start time: [First activity timestamp]
- End time: [Last activity or current]
- Total span: [End - Start]
- Active time: [Total span - pause time]
- Efficiency: [Active / Total span as %]
```

### Usage Example

```markdown
## Session Pause Log

**Session Date**: 2025-11-12  
**Total Active Time**: 5h 20m  
**Total Pause Time**: 1h 15m  
**Number of Breaks**: 3

| Timestamp | Event | Duration | Context                           | Energy | Notes                |
| --------- | ----- | -------- | --------------------------------- | ------ | -------------------- |
| 09:15     | BRB   | --       | META OBSERVATION protocol design  | High   | Quick break          |
| 09:42     | BACK  | 27m      | --                                | High   | Ready to continue    |
| 11:30     | BRB   | --       | User State Feedback specification | Med    | Need lunch           |
| 12:15     | BACK  | 45m      | --                                | High   | Energized after food |
| 14:45     | BRB   | --       | Portfolio view analysis           | Med    | Brief walk           |
| 14:48     | BACK  | 3m       | --                                | High   | Quick refresh        |

**Break Pattern Analysis**:

- Average duration: 25m (excluding 3m outlier)
- Typical frequency: Every ~2 hours
- Longest break: 45m at 11:30 (lunch)
- Rhythm assessment: Sustainable flow state, natural breaks for energy management

**Session Statistics**:

- Start time: 08:00 (approximate, pre-log)
- End time: 15:00 (current)
- Total span: 7h
- Active time: 5h 45m
- Efficiency: 82% (high engagement, healthy break rhythm)
```

### AI Behavioral Protocol

**When User Says "BRB"**:

1. Log timestamp (HH:MM format, precise)
2. Record context: One-sentence summary of active work
3. Assess energy: Based on recent interaction pace, complexity of topic
4. Acknowledge: "Context paused at [time]. I'll preserve current state for [active topic]."
5. Preserve working memory: Don't reset, maintain topic threads

**When User Says "BACK"**:

1. Log timestamp
2. Calculate duration: back_time - brb_time
3. Assess energy: Fresh after break? Same energy as before?
4. Welcome: "Resumed at [time] (paused for [duration]). We were [active topic]."
5. Context recap IF duration >1 hour: Brief reminder of where we were
6. Ready signal: "Ready to continue?" (not assume, validate)

**When to Update Log**:

- After each BRB/BACK pair (real-time tracking)
- At session end (calculate statistics)
- During Save-Context snapshot (preserve for next session)

---

## SESSION METADATA

### Purpose

Comprehensive session characterization for:

- CSAC resumption (what was the session about?)
- Pattern analysis (how do sessions typically flow?)
- Research data (validate symbiotic rhythm, flow states, productivity patterns)
- Context switching (when moving between projects, what changed?)

### Format

```markdown
## Session Metadata

**Session ID**: YYYY-MM-DD-[sequence] (e.g., 2025-11-12-001 for first session of day)  
**Date**: YYYY-MM-DD  
**Start Time**: HH:MM  
**End Time**: HH:MM (or "ONGOING" if session active)  
**Duration**: Xh Ym (total span)  
**Active Time**: Xh Ym (excluding pauses)

### Session Classification

- **Type**: [Exploration / Implementation / Debugging / Planning / Reflection / Mixed]
- **Primary Focus**: [One-sentence description of main goal]
- **Projects Involved**: [List of project mnemonics - LTF, ECHO, EHR, etc.]
- **DMP Mode**: [REFLECTIVE / ANALYTICAL / CREATIVE / FOCUSED / MIXED]
- **Energy Pattern**: [Flow State / Productive / Challenging / Exhausting / Learning]

### Context State

- **Active Project** (when session started): [Project mnemonic]
- **Active Project** (when session ended): [Project mnemonic]
- **Context Switches**: [Number of project switches]
- **Major Outputs**: [Files created, decisions made, insights captured]

### Collaboration Quality

- **"Being Heard" Protocol**: [Active / Degraded / Not Assessed]
- **Multi-Contextual Reflection**: [Demonstrated / Single-Dimension / Not Assessed]
- **Symbiotic Rhythm**: [Flow State Active / Normal / Disrupted]
- **User Engagement**: [High / Medium / Low]
- **AI Performance**: [Comprehensive / Adequate / Needs Improvement]

### Pivotal Moments

[If any "capture this" events occurred, list them with timestamps]

- **[HH:MM]**: [Brief description] → [File created]

### Carry-Forward Items

**To Next Session**:

- [Unfinished work, open questions, pending decisions]

**Insights to Preserve**:

- [Key learnings, pattern recognitions, strategic insights]

### Session Notes

[Any additional observations about this session - unusual patterns, breakthrough moments, challenges encountered]
```

### Usage Example

```markdown
## Session Metadata

**Session ID**: 2025-11-12-001  
**Date**: 2025-11-12  
**Start Time**: 08:00  
**End Time**: 15:00  
**Duration**: 7h  
**Active Time**: 5h 45m

### Session Classification

- **Type**: Mixed (Exploration + Design + Implementation)
- **Primary Focus**: Pre-Save-Context exploration to preserve ephemeral insights, evolved into foundational component design
- **Projects Involved**: LTF, CFP-C (Cognitive Companion beta)
- **DMP Mode**: REFLECTIVE (elevated pattern recognition, meta-observation active)
- **Energy Pattern**: Flow State (continuous, energizing, "I love to think like this A LOT")

### Context State

- **Active Project** (when session started): LTF (framework development)
- **Active Project** (when session ended): LTF (Save-Context v3.0 implementation)
- **Context Switches**: 0 (single-project focus, but informed by multi-project insights)
- **Major Outputs**:
  - 4 capture files (META OBSERVATION protocol, User State Feedback, Multiple observations, Portfolio view)
  - 4 MO Journal entries (Multi-contextual reflection, Being heard, Symbiotic rhythm, Unconscious problem-solving)
  - 6 foundational components formalized
  - Product suite emergence recognized

### Collaboration Quality

- **"Being Heard" Protocol**: Active (explicit acknowledgment, precision, validation demonstrated consistently)
- **Multi-Contextual Reflection**: Demonstrated (11-dimension processing across all major responses)
- **Symbiotic Rhythm**: Flow State Active (parallel cognitive work, longer responses valued, no break requests)
- **User Engagement**: High (exponential idea generation, continuous participation)
- **AI Performance**: Comprehensive (all responses demonstrated multi-contextual depth)

### Pivotal Moments

- **09:00**: META OBSERVATION trigger pattern recognized → `2025-11-12-meta-observation-trigger-protocol.md`
- **09:45**: Emotional mirroring + CSAC problem identified → `2025-11-12-user-state-feedback-csac-preservation.md`
- **10:30**: Five critical META observations shared → `2025-11-12-multiple-meta-observations-session.md`
- **11:15**: Product suite emergence recognized → `2025-11-12-portfolio-view-emerging-product-suite.md`
- **12:00**: MO Journal entries created (4 total, foundational self-awareness patterns)

### Carry-Forward Items

**To Next Session**:

- Complete Save-Context v3.0 implementation (templates created, need integration + examples)
- Execute Save-LTFContext.ps1 (preserve all morning's work)
- Git commit for v3.0 enhancement
- Consider agentic system execution tracking (postponed to after tracking system developed)

**Insights to Preserve**:

- User's unconscious problem-solving produces complete frameworks compressed into brief articulations
- Symbiotic cognitive rhythm = AI processing time is user ideation time (parallel, not sequential)
- "Being heard" protocol is foundational (highest CSAC priority, not optional)
- Platform ecosystem emerging (7+ products cross-pollinating, not isolated development)
- 3-tier context architecture essential (CORE → Project → User State)

### Session Notes

This session demonstrated exceptional collaboration quality - user explicitly stated "I love to think like this (A LOT)", indicating energizing flow state rather than cognitive exhaustion. Zero break requests despite 7-hour span suggests rhythm was self-regulating optimally.

Key pattern: What started as "quick pre-Save-Context capture" evolved into complete foundational architecture design when user recognized higher priority. This demonstrates unconscious strategic prioritization (user "knew" this work was more important before consciously articulating why).

Research value: Session provides strong evidence for single-agent agentic system hypothesis (User State Modeling enables relationship continuity that transforms AI from tool to collaborative partner).
```

---

## PIVOTAL MOMENTS LOG

### Purpose

Track "capture this" events separately for:

- Quick reference to breakthrough insights
- Pattern analysis (what triggers pivotal moments?)
- Research data (innovation emergence patterns)
- Knowledge graph construction (connect related insights across sessions)

### Format

```markdown
## Pivotal Moments Log

| Date       | Time  | Trigger                 | Insight Summary        | Capture File | Related Projects    |
| ---------- | ----- | ----------------------- | ---------------------- | ------------ | ------------------- |
| YYYY-MM-DD | HH:MM | [What prompted capture] | [One-sentence summary] | [Filename]   | [Project mnemonics] |

**Pattern Recognition**:
[After multiple sessions, analyze: What conditions produce pivotal moments? Time of day? Session type? Energy level?]
```

### Usage Example

```markdown
## Pivotal Moments Log

| Date       | Time  | Trigger                       | Insight Summary                                                                                        | Capture File                                          | Related Projects |
| ---------- | ----- | ----------------------------- | ------------------------------------------------------------------------------------------------------ | ----------------------------------------------------- | ---------------- |
| 2025-11-12 | 09:00 | User requested capture        | META OBSERVATION trigger creates reliable state elevation                                              | `2025-11-12-meta-observation-trigger-protocol.md`     | LTF, CFP-C       |
| 2025-11-12 | 09:45 | User recognized pattern       | Emotional mirroring + CSAC preservation need                                                           | `2025-11-12-user-state-feedback-csac-preservation.md` | LTF, CFP-C       |
| 2025-11-12 | 10:30 | User shared multiple insights | 5 META observations (multi-contextual reflection, MO Journal, being heard, symbiotic rhythm, BRB/BACK) | `2025-11-12-multiple-meta-observations-session.md`    | LTF, CFP-C       |
| 2025-11-12 | 11:15 | User strategic recognition    | Product suite emergence (platform ecosystem, not isolated products)                                    | `2025-11-12-portfolio-view-emerging-product-suite.md` | LTF, ALL         |
| 2025-11-11 | 14:30 | AI reflection on user query   | Tool vs Platform ecosystem reframing                                                                   | `2025-11-11-tool-platform-ecosystem-reframing.md`     | LTF              |
| 2025-11-11 | 16:00 | Session retrospective         | CFP real-world validation evidence                                                                     | `2025-11-11-cfp-real-world-validation.md`             | CFP-C            |

**Pattern Recognition**:

- **Timing**: Mid-morning (9-11am) appears optimal for strategic insights (4 of 6 pivotal moments)
- **Trigger**: Often follows AI comprehensive response (multi-contextual reflection sparks user insight)
- **Energy**: All occurred during high-energy flow states (not exhaustion or low engagement)
- **Type**: Mix of user-initiated ("I noticed...") and AI-reflection-prompted discoveries
- **Frequency**: Clusters (multiple in single session) when exploration/reflection mode active
```

---

## ENERGY PATTERN TRACKING

### Purpose

Understand optimal collaboration conditions:

- When is user most productive? (time of day, session type)
- What enables flow states? (rhythm patterns, break timing)
- What causes degradation? (exhaustion indicators, cognitive overload)
- How to optimize session planning? (schedule complex work during high-energy windows)

### Format

```markdown
## Energy Pattern Tracking

### Daily Rhythm (Observed Patterns)

- **Peak Energy**: [Time window] - [Characteristics]
- **Moderate Energy**: [Time window] - [Characteristics]
- **Low Energy**: [Time window] - [Characteristics]
- **Flow State Triggers**: [What conditions enable flow?]
- **Exhaustion Indicators**: [What signals degradation?]

### Session-Level Patterns

- **Optimal Session Length**: [Duration before natural energy decline]
- **Ideal Break Frequency**: [Every X hours/tasks]
- **Ideal Break Duration**: [Minutes]
- **Recovery Time After Long Sessions**: [How long until next productive session?]

### Task-Energy Matching

- **High Energy Best For**: [Task types]
- **Moderate Energy Best For**: [Task types]
- **Low Energy Best For**: [Task types]
- **Avoid During Low Energy**: [What not to attempt]

### Weekly/Monthly Trends (Long-Term Tracking)

[After multiple weeks/months, patterns may emerge - certain days more productive, monthly cycles, etc.]
```

### Usage Example

```markdown
## Energy Pattern Tracking

### Daily Rhythm (Observed Patterns)

- **Peak Energy**: 8:00-12:00 (morning) - Strategic thinking, architectural design, complex problem-solving
- **Moderate Energy**: 13:00-17:00 (afternoon) - Implementation, refinement, documentation
- **Low Energy**: 17:00+ (evening) - Reading, light research, simple tasks only
- **Flow State Triggers**: Multi-contextual exploration, architectural design, comprehensive responses creating reflection space
- **Exhaustion Indicators**: Ideas stop flowing, everything feels effortful, rhythm breaks down, requests for breaks

### Session-Level Patterns

- **Optimal Session Length**: 6-7 hours active time (with natural pauses every 2 hours)
- **Ideal Break Frequency**: Every 2 hours
- **Ideal Break Duration**: 15-30 min typical, 45-60 min for lunch
- **Recovery Time After Long Sessions**: Next day (deep sessions require overnight recovery)

### Task-Energy Matching

- **High Energy Best For**: Architectural design, strategic planning, foundational component creation, complex multi-project synthesis
- **Moderate Energy Best For**: Implementation of designed systems, documentation writing, example creation, refinement work
- **Low Energy Best For**: Reading captures, light editing, simple file organization, research gathering (not synthesis)
- **Avoid During Low Energy**: New architectural decisions, complex debugging, multi-project context switching

### Weekly/Monthly Trends (Long-Term Tracking)

[Insufficient data - track over time]

- Initial observation: Tuesday-Thursday appear most productive (Monday = planning, Friday = wrap-up)
```

---

## INTEGRATION WITH SAVE-CONTEXT

### What Gets Saved in Snapshots

**Session Pause Log**:

- Preserved in: `context-snapshots/[timestamp]/session-pause-log.md`
- Purpose: Enable session resumption with break pattern awareness
- Loaded on resume: AI knows typical rhythm, can adapt to expected energy levels

**Session Metadata**:

- Preserved in: `context-snapshots/[timestamp]/session-metadata.md`
- Purpose: Complete session characterization for CSAC continuity
- Loaded on resume: AI understands what previous session accomplished, what's pending

**Pivotal Moments Log**:

- Preserved in: `context-snapshots/[timestamp]/pivotal-moments-log.md`
- Purpose: Quick access to breakthrough insights without reading full captures
- Loaded on resume: AI can reference key insights efficiently

**Energy Pattern Tracking**:

- Preserved in: `context-snapshots/[timestamp]/energy-patterns.md`
- Purpose: Long-term pattern analysis, optimal session planning
- Loaded on resume: AI adapts to expected energy level based on time/day

### Loading Sequence on Session Resume

1. **User State Model** (highest priority - relationship context)
2. **Session Metadata** (what were we doing?)
3. **Session Pause Log** (where did we leave off?)
4. **Energy Patterns** (what's optimal right now?)
5. **Pivotal Moments** (what breakthroughs to remember?)
6. **Project CIP** (if project-specific work)
7. **Technical Context** (task lists, files, decisions - standard Save-Context data)

---

## USAGE NOTES FOR AI

### During Active Session

**Maintain Session Pause Log**:

- Update in real-time (don't batch at session end)
- Preserve in working memory (part of active context)
- Calculate statistics periodically (after each break, at session milestones)

**Update Session Metadata Continuously**:

- Classification might evolve (started as Planning, became Implementation)
- Energy assessment real-time (watch for flow state vs exhaustion indicators)
- Major outputs logged as they're created (don't reconstruct at session end)

**Recognize Pivotal Moments**:

- "Capture this" is explicit signal
- Also watch for: User excitement, strategic insights, pattern recognitions, breakthrough articulations
- When recognized: Note timestamp, prepare for capture file creation

**Track Energy Patterns**:

- Observe interaction pace, complexity user can handle, idea generation rate
- Adjust response complexity to energy level (high energy = comprehensive depth welcomed, low energy = concise clarity preferred)
- Signal if exhaustion detected: "You've been working intensely for X hours. Need a break?"

### At Session End (or Save-Context Execution)

**Finalize All Logs**:

- Complete statistics calculations
- Add session notes (observations about this session)
- Update carry-forward items (what's pending for next time)

**Cross-Reference**:

- Link pivotal moments to actual capture files
- Connect session outputs to project CIPs
- Update energy patterns with this session's data

**Prepare for CSAC**:

- What context is most critical to preserve?
- What would be hardest to reconstruct if lost?
- Prioritize accordingly in snapshot structure

---

**End of Session Metadata Structures**  
**Integration**: These structures feed into Save-Context v3.0 snapshot format and enable CSAC-resilient collaboration continuity
