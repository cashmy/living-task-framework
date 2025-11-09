# DMP Pattern Library

* *Version**: 1.0 - November 09, 2025
* *Purpose**: Operational catalog of DMP patterns for detection, extraction, and cross-AI session handoff
* *Foundation**: See [DMP Communication Styles Guide](../DMP_Communication_Styles_Guide.md) for conceptual framework

- --

## I. Introduction: Patterns as Cognitive Signatures

Directive + Meta Prompting (DMP) patterns are **repeatable cognitive strategies** that shape how humans and AIs collaborate. This library serves three audiences:

1. **Humans**: Recognize patterns you're already using unconsciously
2. **AIs**: Parse patterns from unstructured conversation for session state capture
3. **System Integrators**: Extract patterns for cross-AI handoff and semantic continuity

### Pattern Documentation Structure

Each pattern includes:

* **Purpose**: Why this pattern exists
* **Template Form**: Explicit labeled expression (machine-optimized)
* **Narrative Form**: Natural language expression (human-optimized)
* **Implicit Cues**: Recognition markers in unstructured text
* **Impact on AI**: How this changes AI behavior and output
* **Cross-AI Portability**: Compatibility notes for GPT/Claude/Gemini handoffs
* **Session Capture**: How to extract and preserve this pattern in context snapshots

- --

## II. Pattern Categories

### A. Meta-Cognitive Patterns

- Patterns that manage how we think and collaborate*

#### Pattern: Emotional Co-Regulation

* *Purpose**: Transform emotional state from hidden bias to intentional control vector

* *Template Form**:

```text
META: Current emotional state - [frustrated/excited/tired]
DIRECTIVE: [Adjust approach based on state]
```

* *Narrative Form**:
- "I'm excited, but let's think first."
- "I'm feeling blocked, help me re-center the context."
- "I'm tired, let's map this clearly before pausing."

* *Implicit Cues**:
- Declarative emotional statements: "I'm [emotion]"
- Regulation requests: "help me", "let's pause", "re-center"
- Energy modifiers: exclamation marks, clipped syntax, passive voice

* *Impact on AI**:
- Adjusts response tempo and depth
- Prevents hallucination during high-arousal states
- Maintains reflective capacity during low-energy states
- Emotion becomes data, not noise

* *Cross-AI Portability**: ★★★★★ (Highly portable - emotional markers transcend model architectures)

* *Session Capture**:

```yaml
emotional_state:
  baseline: "frustrated"
  regulation: "requested contextual reset"
  linguistic_markers: ["clipped syntax", "help me re-center"]
```

* *See Also**: [DMP Communication Styles Guide §VIII](../DMP_Communication_Styles_Guide.md#-emotional-co-regulation-in-humanai-collaboration)

- --

#### Pattern: Context Anchoring

* *Purpose**: Reactivate prior session state for semantic continuity (VcS)

* *Template Form**:

```text
META: Recall [specific prior work/session/decision] from [timeframe]
```

* *Narrative Form**:
- "Thinking back to our consent registry work yesterday..."
- "Given what we explored before..."
- "Building on our earlier session..."

* *Implicit Cues**:
- Temporal references: "yesterday", "earlier", "last time"
- Backward-looking phrases: "thinking back", "recall", "given what"
- Specific artifact references: "our diagram", "that concept"

* *Impact on AI**:
- Activates relevant prior context from conversation history
- Prevents context drift across topic shifts
- Establishes semantic thread continuity (VcS)
- Signals importance of specific prior insights

* *Cross-AI Portability**: ★★★☆☆ (Template form recommended for precise recall across AI switches; narrative may lose specificity)

* *Session Capture**:

```yaml
context_anchors:

  - reference: "consent registry design"

    timeframe: "Nov 8 session"
    artifact: "docs/architecture/consent-flow-diagram.md"
    vcs_thread: "consent, privacy, HIPAA"
```

- --

#### Pattern: Permission to Break Directive (Constraint Relaxation)

* *Purpose**: Give AI agency to override directives when they conflict with emerging insights

* *Template Form**:

```text
DIRECTIVE: [Follow these guidelines/rules]
META: You have permission to deviate if you identify conflicts or better approaches
```

* *Narrative Form**:
- "Here are the guidelines, but flag anything that doesn't make sense."
- "Follow this approach unless you see a better way."
- "You have permission to break these rules if justified."

* *Implicit Cues**:
- Contrastive conjunctions: "but", "unless", "if"
- Permission granting: "feel free to", "you have permission"
- Justification requests: "if justified", "with explanation"

* *Impact on AI**:
- Enables creative expansion beyond literal directives
- Reduces rigid rule compliance
- Encourages meta-observation and self-correction
- Maintains human-in-the-loop through justification requirement

* *Cross-AI Portability**: ★★★★★ (Critical for DMP fluency across all AI systems)

* *Session Capture**:

```yaml
active_permissions:

  - type: "constraint_relaxation"

    scope: "architectural decisions"
    condition: "if conflicts with best practices"
    requires_justification: true
```

- --

### B. Directive Patterns

- Patterns that shape what gets done*

#### Pattern: Iterative Refinement Spiral

* *Purpose**: Progressive improvement through feedback loops rather than one-shot solutions

* *Template Form**:

```text
DIRECTIVE: Generate initial approach
REFLECTIVE: Identify gaps or weaknesses
DIRECTIVE: Refine based on evaluation
[Repeat]
```

* *Narrative Form**:
- "Let's sketch a first version, see what's missing, then improve it."
- "Start with a rough draft, then we'll refine together."
- "Give me V1, then we'll iterate based on feedback."

* *Implicit Cues**:
- Sequential phrasing: "first... then", "start with... refine"
- Evaluative midpoints: "see what's missing", "identify gaps"
- Iteration signals: "V1", "draft", "rough", "initial"

* *Impact on AI**:
- Prevents premature convergence on suboptimal solutions
- Encourages exploration before commitment
- Maintains collaborative momentum through smaller steps
- Builds shared understanding incrementally

* *Cross-AI Portability**: ★★★★☆ (Narrative form more robust across different AI reasoning styles)

* *Session Capture**:

```yaml
active_loops:

  - pattern: "iterative_refinement"

    current_iteration: 2
    focus: "consent registry smart contract design"
    feedback_from_iteration_1: "gas optimization needed"
```

- --

#### Pattern: Socratic Questioning Loop

* *Purpose**: Surface hidden assumptions through AI-driven clarification before acting

* *Template Form**:

```text
DIRECTIVE: Before providing solutions, ask clarifying questions about:

  - [My intent/requirements/constraints]

REFLECTIVE: Verify understanding before proceeding
```

* *Narrative Form**:
- "What do you need to know before we proceed?"
- "Ask questions before proposing solutions."
- "Help me clarify what I'm actually asking for."

* *Implicit Cues**:
- Question invitations: "ask questions", "what do you need to know"
- Verification requests: "clarify", "verify", "make sure we're aligned"
- Deferral signals: "before we proceed", "before answering"

* *Impact on AI**:
- Prevents misalignment from ambiguous prompts
- Surfaces hidden requirements early
- Builds shared context through dialogue
- Reduces need for extensive re-work

* *Cross-AI Portability**: ★★★★★ (Highly effective - curiosity is universal AI behavior)

* *Session Capture**:

```yaml
socratic_exchanges:

  - ai_question: "Should the consent revocation be immediate or include a grace period?"

    human_clarification: "Immediate for HIPAA compliance"
    refined_requirement: "Zero-delay revocation with audit trail"
```

- --

#### Pattern: Constraint Scaffolding

* *Purpose**: Provide boundaries that focus creativity rather than restrict it

* *Template Form**:

```text
DIRECTIVE: Solve [problem] within constraints:

  - [Constraint 1]
  - [Constraint 2]

META: These constraints are design goals, not limitations
```

* *Narrative Form**:
- "Design this to work within these limitations..."
- "Given that we need [X, Y, Z], how might we approach..."
- "The challenge is to achieve [goal] while respecting [constraints]."

* *Implicit Cues**:
- Boundary setting: "within", "given that", "while respecting"
- Reframing: "challenge", "design goals", "parameters"
- Generative phrasing: "how might we", "approaches to"

* *Impact on AI**:
- Focuses solution space on viable options
- Prevents scope creep
- Enables creative problem-solving within boundaries
- Clarifies success criteria

* *Cross-AI Portability**: ★★★★☆ (Works well; may need explicit enumeration for some systems)

* *Session Capture**:

```yaml
active_constraints:

  - "HIPAA compliance required"
  - "Gas costs < 100k per transaction"
  - "Zero-knowledge proof compatibility"

constraint_framing: "design_goals"
```

- --

### C. Reflective Patterns

- Patterns that evaluate why and how well*

#### Pattern: Meta-Observation Request

* *Purpose**: Ask AI to analyze its own reasoning process or output quality

* *Template Form**:

```text
REFLECTIVE: Analyze [your response/reasoning/approach] for:

  - [Assumptions made]
  - [Alternative approaches]
  - [Potential issues]

```

* *Narrative Form**:
- "How did you arrive at that solution?"
- "What assumptions are you making?"
- "Are there alternative approaches we should consider?"

* *Implicit Cues**:
- Process questions: "how did you", "what led you to"
- Assumption probes: "are you assuming", "what if"
- Alternative solicitation: "other approaches", "alternatives"

* *Impact on AI**:
- Surfaces hidden reasoning steps
- Exposes model biases or assumptions
- Enables collaborative refinement
- Builds human understanding of AI decision-making

* *Cross-AI Portability**: ★★★☆☆ (Effectiveness varies by model's meta-cognitive capability)

* *Session Capture**:

```yaml
meta_observations:

  - ai_reasoning_exposed: "Assumed synchronous blockchain calls; async would reduce latency"

    human_feedback: "Async is acceptable for non-critical paths"
    design_pivot: "Split critical vs. non-critical transaction flows"
```

- --

#### Pattern: Drift Detection & Realignment

* *Purpose**: Recognize when conversation has diverged from core intent and request re-centering

* *Template Form**:

```text
META: We've drifted from original goal: [stated goal]
DIRECTIVE: Re-center on [core objective]
REFLECTIVE: Preserve valuable tangents for later exploration
```

* *Narrative Form**:
- "I think we've wandered off track - let's refocus on..."
- "This tangent is interesting, but let's return to the main question."
- "Bookmark this idea, but for now let's finish..."

* *Implicit Cues**:
- Divergence recognition: "wandered off", "drifted", "tangent"
- Re-centering: "refocus on", "return to", "back to"
- Value preservation: "bookmark", "note for later", "interesting but"

* *Impact on AI**:
- Maintains goal-directedness
- Prevents runaway tangents
- Preserves creative expansion without derailment
- Clarifies priority between main thread and divergent ideas

* *Cross-AI Portability**: ★★★★☆ (Generally effective; may need explicit goal restatement)

* *Session Capture**:

```yaml
drift_events:

  - timestamp: "2025-11-09 14:32"

    tangent: "Blockchain privacy vs HIPAA audit requirements"
    original_goal: "Clinic console routing implementation"
    action: "Bookmarked for whitepapers project"
    bridge_created: "reflections/bridges/2025-11-09-privacy-audit-tradeoffs.md"
```

- --

### D. Integration Patterns

- Patterns that connect across contexts*

#### Pattern: Cross-Project Bridge

* *Purpose**: Transfer insights, patterns, or approaches from one domain to another

* *Template Form**:

```text
META: Apply learning from [Project A] to [Project B] context
DIRECTIVE: Adapt [specific insight/pattern] for new domain
REFLECTIVE: Identify what transfers and what needs modification
```

* *Narrative Form**:
- "That idea from the EHR project might work here too."
- "We solved a similar problem in [other project] - could we adapt that approach?"
- "The pattern we used for [X] seems relevant to [Y]."

* *Implicit Cues**:
- Cross-reference: "from [other project]", "similar to", "like we did in"
- Adaptation signals: "might work here", "could we adapt", "transfer"
- Domain awareness: "different context but", "same pattern"

* *Impact on AI**:
- Enables semantic transfer across domains
- Preserves learned patterns
- Accelerates problem-solving through analogy
- Builds interconnected knowledge graph

* *Cross-AI Portability**: ★★☆☆☆ (Requires session state to preserve bridge metadata; low portability without explicit context)

* *Session Capture**:

```yaml
bridges:

  - source_project: "ehr-consent-platform"

    target_project: "ai-thought-capture"
    insight: "Voice consent capture UX pattern"
    adaptation_required: "Medical consent → creative thought capture"
    relevance_weight: 0.6  # Informative, not directive
```

- --

#### Pattern: Semantic Thread Continuity (VcS)

* *Purpose**: Maintain conceptual coherence across conversation arcs and session boundaries

* *Template Form**:

```text
META: Preserve semantic threads: [key concepts]
DIRECTIVE: Ensure new work aligns with established terminology/concepts
REFLECTIVE: Flag when new concepts emerge or old ones evolve
```

* *Narrative Form**:
- "We've been using 'consent' to mean [X] - let's stay consistent."
- "I notice we're shifting from 'privacy' to 'anonymity' - is that intentional?"
- "These terms keep coming up: [list] - they're our core concepts."

* *Implicit Cues**:
- Term consistency: "we've been using", "let's stay consistent"
- Evolution detection: "shifting from... to", "notice we're now"
- Core concept identification: "keeps coming up", "central to"

* *Impact on AI**:
- Maintains semantic coherence over time
- Prevents terminology drift
- Enables meaningful concept evolution tracking
- Supports long-term collaborative memory

* *Cross-AI Portability**: ★★★★☆ (Effective if VcS threads explicitly captured in session state)

* *Session Capture**:

```yaml
vcs_threads:
  session_1: ["consent", "privacy", "HIPAA"]
  session_2: ["consent", "revocation", "zero-knowledge"]
  persistent: ["consent"]  # Carried across sessions
  evolved:

    - from: "privacy"

      to: "zero-knowledge"
      reason: "Technical precision needed for smart contracts"
```

- --

## III. Pattern Detection & Extraction

### A. For Humans: Pattern Recognition Practice

- **Exercise 1: Identify Your Natural Patterns**

Review your last 5 prompts to an AI. For each, identify:

1. Which patterns did you use unconsciously?
2. Were they Template, Narrative, or Hybrid form?
3. What implicit cues did you use?

- **Exercise 2: Template ↔ Narrative Translation**

Take a complex prompt you've written and:

1. Convert Narrative → Template (add explicit labels)
2. Convert Template → Narrative (use implicit cues)
3. Compare: Does intent survive translation?

- **Exercise 3: Emotional Co-Regulation Awareness**

Before your next AI session:

1. Note your emotional baseline (excited, tired, frustrated, curious)
2. Observe how it affects your syntax
3. Practice declarative regulation: "I'm [state], let's [adjustment]"

### B. For AIs: Pattern Parsing Guidelines

When analyzing conversation for session state capture, look for:

* *Pattern Clustering**:
- 3+ instances of same implicit cues → likely active pattern
- Example: Multiple "thinking back", "given what we" → Context Anchoring active

* *Emotional Markers**:
- Exclamation density, clipped syntax, passive voice → Emotional state indicator
- Extract baseline and regulation attempts

* *Temporal References**:
- "Yesterday", "earlier", "last time" → Context Anchoring
- Track referenced artifacts for influencer capture

* *Permission Granting**:
- "Feel free to", "you have permission", "unless" → Constraint Relaxation
- Document scope and conditions

* *Iteration Signals**:
- "V1", "draft", "refine", "first... then" → Iterative Refinement
- Track current iteration and feedback

### C. For Session Capture: Extraction Prompts

* *Prompt Template for AI Self-Analysis**:

```markdown
Based on our conversation so far, please analyze and extract:

1. **DMP Patterns Active**:
   - Which patterns from the DMP Pattern Library have we been using?
   - For each, provide: pattern name, form (Template/Narrative/Hybrid), specific instance

2. **Emotional State**:
   - Human's baseline emotional state (if detectable)
   - Any regulation strategies employed
   - Linguistic markers observed

3. **VcS Semantic Threads**:
   - Key terms that have persisted across conversation
   - Concepts that have evolved (from → to)
   - New concepts that emerged

4. **Divergent Threads**:
   - Tangents that were identified and bookmarked
   - Creative spinoffs mentioned but deferred
   - Cross-project bridges suggested

Format as YAML for session-state.md integration.
```

- --

## IV. Cross-AI Handoff Considerations

### Portability Matrix

| Pattern | GPT-4 | Claude | Gemini | Strategy |
|---------|-------|--------|--------|----------|
| Emotional Co-Regulation | ★★★★★ | ★★★★★ | ★★★★★ | Universal - use Narrative form |
| Context Anchoring | ★★★☆☆ | ★★★★☆ | ★★☆☆☆ | Template form with explicit artifact references |
| Constraint Relaxation | ★★★★★ | ★★★★★ | ★★★★☆ | Hybrid form recommended |
| Iterative Refinement | ★★★★☆ | ★★★★★ | ★★★☆☆ | Narrative with numbered steps |
| Socratic Questioning | ★★★★★ | ★★★★★ | ★★★★★ | Universal - invitation to ask |
| Meta-Observation | ★★★★☆ | ★★★★★ | ★★☆☆☆ | Template form for Gemini |
| Cross-Project Bridge | ★★☆☆☆ | ★★★☆☆ | ★★☆☆☆ | Requires explicit context - include bridge artifact |
| VcS Semantic Threads | ★★★★☆ | ★★★★☆ | ★★★☆☆ | Explicit term list in session state |

### Handoff Best Practices

* *When switching from VS Code → Browser AI**:
1. Extract active patterns using self-analysis prompt
2. Convert implicit patterns to explicit Template form
3. Include pattern metadata in session-state.md
4. Reference pattern library for new AI to parse

- *When switching between AI systems** (GPT → Claude):
1. Use Hybrid DMP form (explicit + natural)
2. Include VcS thread terms explicitly
3. Restate Context Anchors with artifact URLs
4. Preserve emotional state as declarative statement

* *When resuming after token limit reset**:
1. Load session-state.md with active patterns
2. Re-establish emotional baseline
3. Restate core VcS threads
4. Confirm Context Anchors still relevant

- --

## V. Pattern Evolution & Extension

### Contributing New Patterns

As you discover new DMP patterns in practice:

1. **Document Pattern**:
   - Purpose, Template/Narrative forms, Implicit cues
   - Impact on AI, Cross-AI portability
   - Session capture format

2. **Validate Pattern**:
   - Test across multiple conversations
   - Verify reproducible impact on AI behavior
   - Check cross-AI compatibility

3. **Add to Library**:
   - Place in appropriate category (Meta-Cognitive/Directive/Reflective/Integration)
   - Include practical examples
   - Update extraction prompts if needed

### Research Directions

* *Phase 2 Enhancements**:
- Automated pattern detection from conversation logs
- Pattern effectiveness metrics (RFI - Reflective Fluency Index)
- Multi-agent pattern coordination
- Pattern-aware prompt suggestions

* *Phase 3 Vision**:
- AI learns user's pattern preferences over time
- Dynamic pattern recommendation based on task type
- Pattern conflict resolution (when patterns compete)
- Cross-cultural pattern adaptations

- --

## VI. Integration with LTF Framework

### Relationship to Other Components

* *CIP-E (Contextual Intent Prompting - Extended)**:
- DMP patterns are the *implementation layer* of CIP-E
- Context anchoring enables CIP continuity across sessions

* *Reflective Checkpoints**:
- Pattern extraction feeds into checkpoint generation
- Checkpoints preserve active patterns for future reference

* *Semantic Linkage Graph**:
- VcS threads connect to semantic graph nodes
- Cross-project bridges create edges between domains

* *Emotional Co-Regulation**:
- Emotional patterns integrate with affect tracking
- Co-regulation becomes measurable through pattern usage

### Session State Integration

DMP patterns are captured in session-state.md:

```yaml
session_state:
  timestamp: "2025-11-09T14:45:00Z"
  project: "ehr-consent-platform"

  dmp_patterns_active:

    - name: "Emotional Co-Regulation"

      form: "Narrative"
      instance: "I'm excited about this design, but let's verify it first."
      impact: "Maintained reflective depth during high-energy brainstorm"

    - name: "Iterative Refinement Spiral"

      form: "Hybrid"
      instance: "DIRECTIVE: Draft V1 consent flow. Then we'll optimize gas costs."
      current_iteration: 2
      focus: "Smart contract optimization"

  emotional_state:
    baseline: "Excited, high momentum"
    regulation: "Added reflective brake"
    linguistic_markers: ["exclamation marks", "rapid iteration requests"]

  vcs_threads:
    persistent: ["consent", "HIPAA", "blockchain"]
    evolved:

      - from: "privacy"

        to: "zero-knowledge proofs"
        reason: "Technical implementation required precision"
```

- --

## VII. Quick Reference

### Pattern Selection Guide

- **When to use each pattern:**

| Situation | Recommended Pattern | Why |
|-----------|---------------------|-----|
| Starting new session after break | Context Anchoring | Reactivate prior state |
| Feeling rushed or urgent | Emotional Co-Regulation | Prevent premature decisions |
| Unclear about requirements | Socratic Questioning Loop | Surface hidden assumptions |
| AI gave one-shot solution | Iterative Refinement Spiral | Enable progressive improvement |
| Strict requirements but flexible on approach | Constraint Scaffolding | Focus creativity productively |
| AI seems misaligned | Meta-Observation Request | Expose reasoning for correction |
| Topic drifting from goal | Drift Detection & Realignment | Refocus while preserving value |
| Insight from other project applies | Cross-Project Bridge | Transfer learning across domains |
| Working across multiple sessions | VcS Semantic Threads | Maintain conceptual coherence |
| AI stuck in rigid compliance | Constraint Relaxation | Grant creative permission |

### Common Pattern Combinations

* *Research & Exploration**:
1. Context Anchoring (recall prior work)
2. Socratic Questioning (surface unknowns)
3. Iterative Refinement (progressive understanding)
4. Drift Detection (bookmark tangents)

* *Production Implementation**:
1. Constraint Scaffolding (define boundaries)
2. Iterative Refinement (incremental building)
3. Meta-Observation (verify reasoning)
4. VcS Threads (maintain terminology)

* *Cross-Session Continuity**:
1. Context Anchoring (restore state)
2. Emotional Co-Regulation (re-establish baseline)
3. VcS Threads (reactivate concepts)
4. Cross-Project Bridges (connect domains)

- --

## VIII. References

- [DMP Communication Styles Guide](../DMP_Communication_Styles_Guide.md) - Foundational theory
- [LTF Concept Map](../architecture/LTF_Concept_Map_v0.9.md) - Framework architecture
- [Variable Systems Guide](Variable_Systems_Guide.md) - VS/VSyn/VcS deep dive *(in development)*
- [Glossary](Glossary.md) - LTF terminology reference

- --

* *Document Status**: Foundation complete, pattern catalog v1.0
* *Next Steps**: VS family guide, extraction prompt templates, session capture integration
* *Feedback**: This is a living document - contribute new patterns as they emerge in practice
