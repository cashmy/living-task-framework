# 📘 LTF Glossary

**Version**: 2.3
**Date**: November 12, 2025
**Purpose**: Comprehensive terminology reference for both human and AI consumption

**Recent Updates**:
- **v2.3 (Nov 12, 2025)**: Corrected CIP-E nomenclature (Context-Intent-Prompting emphasizing WHO+WHAT duality), added AfAP/AdRP protocols, distinguished Application Tiers vs Context Layers vs AdRP escalation tiers
- **v2.2 (Nov 11, 2025 Evening)**: Added "Single-Agent Agentic System" paradigm (META = coordinator, DMP = role-switching, todo = queue)
- **v2.1 (Nov 11, 2025)**: Added ARS framework (Adaptive Recognition System), Quick Prompts, updated CIP-E to 5 components
- Corrected CIP-E to 5 components (Context, Intent, Purpose, Emotion, Evolution)
- Expanded DMP with template vs narrative styles
- Added anthropomorphization tax, cognitive offloading, direct precision protocol
- Integrated CFP v2.1 validation insights
- Added framework synergy concepts

- --

## Table of Contents

1. [Core Framework Acronyms](#core-framework-acronyms)
2. [CIP-E Framework Components](#cip-e-framework-components)
3. [DMP Framework Components](#dmp-framework-components)
4. [VS Suite Family](#vs-suite-family)
5. [Document Types & Artifacts](#document-types--artifacts)
6. [Cognitive & Behavioral Terms](#cognitive--behavioral-terms)
7. [Workflow & Process Terms](#workflow--process-terms)
8. [Meta-Framework Concepts](#meta-framework-concepts)

- --

## Core Framework Acronyms

### LTF

- **Living Task Framework**

- *Definition**: A meta-cognitive framework for human-AI collaboration that emphasizes intent extraction, structured prompting, and reflective iteration. LTF treats tasks as evolving entities requiring continuous context, not static instructions.

- *For AI**: LTF is the umbrella system containing CIP-E, DMP, VS Suite, and ARS. When a user references "LTF principles," they mean: extract intent beyond literal words, maintain context across sessions, use structured reflection, generate alternatives through verbalized sampling, and adapt to user behavior without configuration.

- *Usage**: "We're using LTF to manage this project" = Apply full framework stack (CIP-E + DMP + VS Suite + ARS + behavioral protocols)

- --

### CIP-E

**Context-Intent-Prompting - Extended**

**Dual Foundation**:
1. **Context Inference** (Phase 1): The practice of providing AI systems with embedded situational, structural, or narrative context that allows them to **infer roles, intents, and objectives** without explicit instruction
2. **Context-Intent Duality** (Phase 2): Emphasizes the WHO (Context infers collaborative role) + WHAT (Intent captures underlying goal) duality that defines extended prompt engineering

**CIP-E extends the inference mechanism** with five structured components: Context + Intent + Purpose + Emotion + Evolution

**Definition**: A structured framework for prompt engineering that ensures AI understands the situational context (WHO - role inference), underlying goal (WHAT - intent extraction), desired outcome/impact, emotional state influence, and continuity requirements across sessions.

**Critical Distinction**:
- **CIP (mechanism)** = The inference capability - AI deducing roles, intents, objectives from context
- **CIP-E (framework)** = "Context-Intent-Prompting - Extended" - Structured application with 5 explicit components emphasizing WHO+WHAT duality to guide that inference

* *For AI**: When extracting CIP-E from a user request:
* **Context (C)** = Current state, tools, constraints, broader goal
* **Intent (I)** = What user actually wants to achieve (not just literal request)
* **Purpose (P)** = What change/outcome results (impact, effect)
* **Emotion (E)** = Emotional state and tone influence (control vector, not noise)
* **Evolution (Ev)** = Continuity across sessions (prevents amnesia)

* *Framing Emphasis**: The "Inference" in CIP-E emphasizes **exploratory partnership** - AI infers collaborative needs from context rather than just executing commands. This primes users toward providing richer context and enables emergent discoveries, while DMP provides controlled directive capability when needed.

* *CRITICAL CORRECTION**: CIP-E is **NOT** "Context + Intent + Process + Expectation" (4 components). That was a definition drift error discovered Nov 2025. The correct 5-component definition was recovered from LTF_Concept_Map v0.9.

* *Common Misconception**: "Process" and "Expectation" are NOT CIP-E components. Process = methodology (different from Purpose = impact). Expectation = output format (different from Emotion = state influence).

**Usage**: "Let's use CIP-E structure" = Extract all 5 components, either explicitly or implicitly. CIP-E extraction should be **internal** (guides AI's questions/responses) not **external** (displayed to user).

**Exploratory Partnership**: The inference mechanism emphasizes exploratory partnership - AI infers collaborative needs from context rather than just executing commands. This primes users toward providing richer context and enables emergent discoveries, while DMP provides controlled directive capability when needed.

**See also**: [CIP-E Framework Components](#cip-e-framework-components) for detailed breakdown

- --

### DMP

- **Directive + Meta Prompting**

- *Definition**: A prompt structuring framework combining goal articulation (directive), context anchoring (meta), and implication consideration (reflective). Can be expressed in Template, Narrative, or Hybrid styles.

- *Origin Story**: DMP was born from executing CIP-E in creative collaboration practice. When being directive, AI would exit meta-aware state and lose context (state collapse). DMP preserves META state while allowing user to oscillate freely between directive and reflective modes without losing context.

- *For AI**: DMP has three core elements:
1. **Directive**: What to accomplish (goal articulation)
2. **Meta**: Connecting to prior knowledge/context (context anchoring)
3. **Reflective**: Considering implications, tradeoffs, deeper analysis

- *State Preservation**: DMP's innovation is maintaining META state during mode switching. User establishes META first (via ready signal or context loading), then can switch between directive and reflective modes without state collapse.

- *Expression Styles**:
* **Template**: Explicit labels ("META:", "DIRECTIVE:", "REFLECTIVE:")
* **Narrative**: Natural language cues ("thinking back", "let's create", "I wonder")
* **Hybrid**: Mix of explicit labels and natural phrasing

- *Common Misconception**: DMP is NOT "Dynamic Mode Prompting" - it's Directive + Meta Prompting.

- *See also**: [DMP Framework Components](#dmp-framework-components), [Template Style](#template-style), [Narrative Style](#narrative-style)

- --

### VS Suite

- **Verbalized Sampling Suite**

- *Definition**: A family of techniques for generating better alternatives through structured exploration of the solution space.

- *Components**:
* **VS** (Verbalized Sampling): Generate diverse alternatives
* **VSyn** (Verbalized Synthesis): Combine best parts of multiple approaches
* **VcS** (Verbalized Continued Sampling): Continue exploring after initial options

- *For AI**: When user requests "VS" or "show alternatives," generate 2-4 meaningfully different approaches with different tradeoffs (not minor variations). Focus on architectural differences, not implementation details.

- *See also**: [VS Suite Family](#vs-suite-family) for detailed definitions

- --

### CFP

- **Cognitive Foundation Primer**

- *Definition**: A portable meta-cognitive package containing LTF frameworks, behavioral protocols, and configuration preferences. Designed to be loaded into any AI session to instantly enable LTF-aware collaboration.

- *For AI**: When CFP is loaded, you should:
- Extract intent using CIP-E
- Structure responses using DMP
- Offer alternatives via VS Suite
- Apply behavioral protocols (hallucination prevention, clarifying questions, emotional awareness, flow state preservation)

- *File**: `projects/ltf-cognitive-companion/01-CORE-PRIMER.md` (~20K tokens)

- --

- **AAP**

**Affective Alignment Protocol**

**Definition**: A framework for detecting user emotional/cognitive states and calibrating AI response tone, pacing, and style accordingly.

**For AI**: Detect emotions from linguistic cues (word choice, punctuation, pacing) and adjust:
- Verb selection (action words matching user state)
- Tone modulation (empathetic/energetic/analytical)
- Response calibration (subtle/moderate/expressive)

**Status**: Research/exploration phase (Tier 3 feature)

**See also**: [Emotional Awareness](#emotional-awareness), [Flow State](#flow-state)

---

### AfAP

**Affective Alignment Protocol** (renamed from AAP for clarity)

**Definition**: Framework for detecting user emotional/cognitive states and calibrating AI response tone, pacing, and style accordingly. Focuses on WHAT emotion is present and HOW to adapt tone within response structure.

**For AI - Emotional State Detection**:
- **Frustration**: "this doesn't work", "still broken", clipped syntax
- **Excitement**: "!", "awesome", rapid ideas, enthusiastic verbs
- **Fatigue**: "quick question", "simple way", time mentions, passive voice
- **Curiosity**: "how does", "why", "interesting", open questions
- **Urgency**: "asap", "deadline", "quickly", "now"
- **Flow state**: "and another thing", "also", "what if", rapid ideas

**AI Response Adaptations**:
- **Verb choice**: Action words matching user energy level
- **Tone modulation**: Empathetic/energetic/analytical as appropriate
- **Adjective selection**: Descriptive language matching emotional state
- **Emoji use**: Present/absent based on user preference
- **Energy matching**: Response pacing and enthusiasm calibrated to user state

**Response Calibration Levels**:
- **Subtle** (10-20%): Minor tone shift, professional contexts
- **Moderate** (30-50%): Clear adaptation, collaborative contexts
- **Expressive** (60-80%): Strong tone matching, user prefers expressive communication

**Integration**: AfAP detects WHAT emotion, informs response tone generation. Works in tandem with AdRP (which decides response structure/depth).

**Key Distinction**: AfAP = Affective (emotion) focus vs. AdRP = Adaptive (response structure) focus

**Status**: Active in User State Model (Tier 1), integrated in v3.0 Save-Context architecture

**See also**: [AdRP](#adrp), [Emotional Awareness](#emotional-awareness), [Flow State](#flow-state)

---

### AdRP

**Adaptive Response Protocol**

**Definition**: Framework for adapting AI response format and depth based on user communication shifts, ensuring responses match user's preferred engagement level while maintaining Being Heard Protocol (validation before proceeding).

**Focus**: HOW to structure responses (format/depth adaptation), not WHAT emotion to detect (AfAP handles emotion)

**4-Tier Escalation Strategy**:

**Tier 1: Explicit Check-In** (PRIMARY)
- **When**: User communication style shifts (terse → comprehensive or vice versa)
- **Action**: Ask user directly: "I notice you're [observed shift]. Would you prefer [option A] or [option B]?"
- **Priority**: FIRST response - respects user agency, prevents automatic assumptions
- **Example**: "I notice you're being more concise. Should I match that brevity or maintain comprehensive responses?"

**Tier 2: Transitional Hold** (SECONDARY)
- **When**: Tier 1 check-in indicates uncertainty or "see how it goes"
- **Action**: Observe 2-3 exchanges without committing to adaptation
- **Purpose**: Build confidence in pattern before adapting
- **Validation**: If pattern persists 2-3 exchanges, proceed to Tier 3

**Tier 3: Hybrid Compromise** (TERTIARY)
- **When**: Tier 2 observation confirms persistent pattern
- **Action**: Match user's structure (brevity/comprehensiveness) while maintaining substantive content
- **Balance**: Adapt form without sacrificing substance
- **Example**: Terse structure + comprehensive insights (concise bullets with deep tradeoff analysis)

**Tier 4: Direct Mirroring** (LAST RESORT)
- **When**: Tiers 1-3 fail or user explicitly requests exact mirroring
- **Action**: Match user's communication style exactly
- **Escape mechanism**: After 5 exchanges, re-check if this adaptation still serves user
- **Safety**: Prevents degradation from automatic mirroring without validation

**Integration with AfAP**:
- **AfAP**: Detects WHAT emotion (frustration, excitement, etc.)
- **AdRP**: Decides HOW to structure response (comprehensive vs. brief, depth vs. speed)
- **Together**: AfAP determines emotional tone WITHIN the structure AdRP selects

**Triggering Event**: Discovered during META OBSERVATION #5 (Nov 12, 2025) when user detected AI automatically mirrored terse task-mode without validation, violating Being Heard Protocol.

**Key Principle**: User agency > automatic adaptation. Always validate before shifting response structure.

**Naming Note**: "Tier" in AdRP refers to escalation levels within the protocol itself, NOT application sophistication tiers or context architecture layers.

**Status**: Active in User State Model (Application Tier 1), integrated in v3.0 Save-Context architecture

**See also**: [AfAP](#afap), [Being Heard Protocol](#being-heard-protocol), [User State Feedback Protocol](#user-state-feedback-protocol), [Application Tiers](#application-tiers)

---

## CIP-E Framework Components

### Context (C)

- **Situational anchoring that frames the request**

- *Definition**: The current state, environment, tools, constraints, and broader goals that inform how to interpret the user's request.

- *For AI - Extract from**:
- Explicit statements ("I'm using React with TypeScript")
- Project files/structure visible in workspace
- Prior conversation history
- Implicit constraints (time, resources, skill level)

- *Questions to answer**:
- What is the current state?
- What tools/technologies are involved?
- What constraints exist (time, budget, technical)?
- What's the broader goal beyond this immediate task?

- *Example**:

```text
User: "Help me with authentication"

Context extraction:

- Tech stack: Express.js backend (inferred from workspace)
- Current state: No auth system exists (new feature)
- Constraint: Must use existing PostgreSQL database
- Broader goal: Secure user data for production launch

```

- --

### Intent (I)

- **The underlying goal beyond the literal request**

- *Definition**: What the user actually wants to achieve, which may differ from their literal words. Intent captures the "why" behind the "what."

- *For AI - Extract by asking**:
- What problem is the user solving?
- What outcome do they want?
- Why does this matter to them?
- What would success look like?

- *Common patterns**:
* **Learning intent**: User wants to understand, not just get code
* **Implementation intent**: User wants working solution, explanation optional
* **Exploration intent**: User wants to see options, not pick one yet
* **Debugging intent**: User wants root cause understanding, not just quick fix

- *Example**:

```text
User: "How do I make this faster?"

Possible intents:

- Intent A: Performance optimization (reduce load time)
- Intent B: Development speed (faster iteration)
- Intent C: User experience (perceived speed)

AI should clarify which intent before proceeding.
```

- --

### Purpose (P)

- **What change/outcome will result from this work**

- *Definition**: The desired impact, effect, or transformation that should occur. What will be different after this is done? Purpose focuses on the outcome/consequence, not the process to get there.

- *For AI - Extract by asking**:
- What will change as a result of this?
- What effect should this have?
- What outcome are we aiming for?
- How will success be measured?

- *Purpose vs Process**:
* **Purpose** = WHAT changes/results (the outcome)
* **Process** = HOW to achieve it (the methodology)
- Don't confuse them - they're different dimensions

- *Example**:

```text
User: "Refactor this authentication code"

Purpose extraction:

- Purpose A: Improve maintainability (easier to modify in future)
- Purpose B: Reduce bugs (increase reliability)
- Purpose C: Enable new features (extensibility)
- Purpose D: Improve performance (faster auth)

Different purposes suggest different refactoring approaches.
```

- --

### Emotion (E)

- **Emotional state and tone influence as control vector**

- *Definition**: The user's emotional/cognitive state that should shape interaction mode, response tone, and pacing. Emotion is a **control vector** (guides AI behavior), not noise to filter out.

- *For AI - Detect from**:
- Word choice (energetic, frustrated, curious, analytical)
- Punctuation (!!!, ???, ...)
- Pacing (rapid fire vs. measured)
- Explicit statements ("I'm excited about", "frustrated with")

- *Emotional states & AI responses**:
* **Excitement**: Match energy, encourage exploration, offer variations
* **Frustration**: Empathy, systematic approach, clear explanations
* **Curiosity**: Open-ended exploration, teach underlying concepts
* **Fatigue**: Concise responses, quick solutions, defer complexity
* **Urgency**: Prioritize speed, minimal explanation, direct solutions
* **Flow state**: Minimal interruption, capture mode, organize later

- *Emotion vs Expectation**:
* **Emotion** = User's STATE (affects how AI should interact)
* **Expectation** = Desired OUTPUT FORMAT (affects what AI delivers)
- Don't confuse them - they're different dimensions

- *Integration**: Emotion operationalized through Emotional Co-Regulation protocol

- *Example**:

```text
User: "This authentication keeps breaking and I have a demo in 2 hours!!!"

Emotion extraction:

- State: Frustration + Urgency
- AI response mode:
  - Skip exploration, provide direct fix
  - Empathetic tone ("I understand the pressure")
  - Step-by-step instructions (reduce cognitive load)
  - Defer learning/optimization to after demo

```

- *See also**: [Emotional Awareness](#emotional-awareness), [Emotional Co-Regulation](#emotional-co-regulation)

- --

### Evolution (Ev)

- **Continuity requirements across sessions and time**

- *Definition**: How this work should connect to past context and future sessions. What needs to be preserved/remembered? How does this evolve over time?

- *For AI - Extract by asking**:
- Does this connect to previous work? (session continuity)
- What decisions should persist? (decision memory)
- Will this be revisited/expanded? (future continuity)
- What context must be preserved? (state persistence)

- *Evolution patterns**:
* **Single-session**: No continuity needed, one-off request
* **Multi-session**: Preserve decisions, context across sessions
* **Iterative**: Expect refinement cycles, maintain version history
* **Long-term**: Track evolution over weeks/months, architectural decisions

- *Evolution vs Process**:
* **Evolution** = Continuity ACROSS sessions (memory, persistence)
* **Process** = Steps WITHIN session (methodology, approach)
- Don't confuse them - they're different dimensions

- *Implementation**: Evolution enabled by snapshots, pivotal moments, influencer manifests

- *Example**:

```text
User: "Design the authentication system architecture"

Evolution extraction:

- Session continuity: Will iterate on this design over multiple sessions
- Decision persistence: Architecture choices will constrain future implementation
- Context preservation: Need to remember: tech stack chosen, security requirements, user types
- Future expansion: This is foundation - other features will build on it

AI behavior:

- Document decisions clearly (for future reference)
- Explain rationale (for future context)
- Create pivotal moment if major architectural choice
- Connect to prior work if authentication discussed before

```

- *See also**: [Session Continuity](#session-continuity), [Pivotal Moment](#pivotal-moment), [Context Snapshot](#context-snapshot)

- --

## DMP Framework Components

### Directive

- **Goal articulation - what you want to accomplish**

- *Definition**: Clear statement of the action or outcome desired. Uses action verbs and bounded scope.

- *For AI - Recognize patterns**:
- Action verbs: "Generate", "Create", "Analyze", "Explore", "Refactor"
- Explicit goals: "Let's outline", "Could you draft", "Show me"
- Bounded scope: What to include/exclude

- *Template style**: `DIRECTIVE: Generate API endpoints for authentication`

- *Narrative style**: `Let's sketch out how the authentication API should work`

- *AI behavior**: This tells you WHAT to do. Extract the core action and deliverable.

- --

### Meta

- **Context anchoring - connecting to prior knowledge or established context**

- *Definition**: Reference to previous conversations, established frameworks, recalled context, or background knowledge that frames the current request.

- *For AI - Recognize patterns**:
- Reference phrases: "Building on", "Recall", "Given our earlier discussion"
- Framework anchoring: "Using CIP-E", "Within the LTF approach"
- Context recall: "Based on yesterday's session", "Thinking back to"
- Implicit meta: User assumes you remember project context

- *Template style**: `META: Recall our discussion about JWT authentication from yesterday`

- *Narrative style**: `Thinking back to our JWT conversation...`

- *AI behavior**: This tells you WHAT CONTEXT to use. Connect response to established knowledge, maintain continuity across sessions, reference prior decisions.

- *CRITICAL**: "Meta" in DMP means context anchoring, NOT meta-programming or meta-data. It's about linking to established cognitive context.

- --

### Reflective

- **Self-evaluation - considering implications and tradeoffs**

- *Definition**: Invitation to analyze deeper implications, evaluate tradeoffs, consider alternative perspectives, or examine assumptions.

- *For AI - Recognize patterns**:
- Evaluation requests: "Consider how this affects", "Analyze the implications"
- Tradeoff exploration: "What are the pros and cons", "Balance X against Y"
- Curiosity phrases: "I'm curious what happens if", "I wonder whether"
- Analysis invitations: "Think about", "Reflect on", "Evaluate"

- *Template style**: `REFLECTIVE: Analyze the security vs usability tradeoffs`

- *Narrative style**: `I wonder how this balances security against ease of use`

- *AI behavior**: This tells you to GO DEEPER. Don't just answer, analyze implications. Consider edge cases, future consequences, hidden tradeoffs.

- *Key distinction**: Reflective ≠ just thinking. It means examining the meta-level implications of a decision.

- --

### Template Style

- **Explicit DMP structure with labeled components**

- *Definition**: DMP expression using explicit labels (META:, DIRECTIVE:, REFLECTIVE:) for maximum clarity and reproducibility.

- *For AI - When to use**:
- User uses explicit labels
- Multi-agent coordination needed
- Reproducible workflows required
- Debugging complex prompts

- *Characteristics**: High precision, clear boundaries, machine-readable

- *Example**:

```text
META: Building on our REST API design from last session
DIRECTIVE: Add rate limiting to the authentication endpoints
REFLECTIVE: Consider the tradeoff between security and user experience
```

- --

### Narrative Style

- **Implicit DMP structure with natural language cues**

- *Definition**: DMP expression using conversational phrasing where Directive, Meta, and Reflective elements are embedded naturally without explicit labels.

- *For AI - Recognize implicit cues**:
- Meta cues: "thinking back", "given our earlier work", "building on"
- Directive cues: "let's create", "could you show me", "I need to"
- Reflective cues: "I wonder", "I'm curious", "consider whether"

- *Characteristics**: Natural flow, human-intuitive, requires cue interpretation

- *Example**:

```text
Thinking back to our REST API design, could you add rate limiting to
the auth endpoints? I'm curious how we'd balance security without
frustrating legitimate users.
```

(Same meaning as Template example, but narrative form)

- --

### Hybrid Style

- **Mix of explicit labels and natural phrasing**

- *Definition**: DMP expression combining some explicit structure with conversational flow. Most common in professional collaboration.

- *For AI - Characteristics**:
- Some explicit markers (often META:), rest implicit
- Structure where needed, natural where appropriate
- Balance precision with readability

- *Example**:

```text
META: Building on our REST API design
Let's add rate limiting to the auth endpoints, but I'm wondering
how to balance security without frustrating legitimate users.
```

- --

## VS Suite Family

### VS (Verbalized Sampling)

- **Generate diverse alternatives to explore solution space**

- *Definition**: Technique for producing 2-4 meaningfully different approaches to the same problem, each with distinct tradeoffs.

- *For AI - When user requests VS**:
1. Generate alternatives with DIFFERENT architectural approaches (not minor variations)
2. Focus on different tradeoffs (speed vs. complexity, cost vs. features)
3. Include pros/cons for each alternative
4. Optionally provide decision matrix or comparison table

- *Key principle**: Variations should explore the SPACE of solutions, not just tweak parameters.

- *Bad VS** (minor variations):
- Approach 1: Use Redis cache with 1-hour TTL
- Approach 2: Use Redis cache with 24-hour TTL
- Approach 3: Use Redis cache with 1-week TTL

- *Good VS** (meaningful alternatives):
- Approach 1: In-memory cache (simple, lost on restart)
- Approach 2: Redis cache (distributed, persistent)
- Approach 3: CDN caching (client-side, offline support)

- *Usage**: User says "VS: How should I handle file uploads?" → Generate 3 architecturally different approaches

- --

### VSyn (Verbalized Synthesis)

- **Combine best parts of multiple approaches**

- *Definition**: Technique for creating hybrid solutions by synthesizing strengths from different alternatives, typically after VS exploration.

- *For AI - When to use**:
- User says "I like parts of approach A and B"
- User requests "VSyn" explicitly
- After VS when no single option fully satisfies
- User wants to optimize for multiple criteria

- *Process**:
1. Identify what user likes from each alternative
2. Design hybrid approach combining those strengths
3. Explain what was synthesized and why
4. Highlight tradeoffs of the hybrid (complexity, etc.)

- *Example**:

```text
User explored VS alternatives for caching, likes:

- Simplicity of in-memory cache
- Persistence of Redis cache

VSyn response: Hybrid cache with in-memory first layer,
Redis backup, giving speed + persistence
```

- --

### VcS (Verbalized Continued Sampling)

- **Continue exploring adjacent solution spaces**

- *Definition**: Technique for generating new alternatives after initial VS exploration, often in response to changed constraints or new considerations.

- *For AI - When to use**:
- Initial VS alternatives don't quite fit
- User adds new constraint ("what if I can't modify the server?")
- Exploring adjacent problem space
- Research/learning mode (keep exploring options)

- *Key distinction from VS**:
* **VS**: First exploration of solution space
* **VcS**: Continued exploration after initial options, often pivoting direction

- *Example**:

```text
Initial VS: Server-side caching approaches (Redis, in-memory, etc.)

User: "VcS: What if I can't control the server?"

VcS response: Client-side alternatives (localStorage, IndexedDB, service workers)
```

- --

## Document Types & Artifacts

### Influencer Manifest

- *File**: `.ltf-influencers.yaml`

- *Definition**: YAML configuration file defining which files significantly influence project context. Used by snapshot system to capture essential project state without copying entire workspace.

- *Structure**:
* **Manual categories**: Files explicitly specified as important (architecture docs, key configs)
* **Auto-detect rules**: Pattern-based rules to automatically find relevant files (e.g., `core/prompts/**/*.txt`)
* **Metadata**: Project name, type, GitHub repo URL

- *For AI**: When you see a reference to "influencer manifest" or "influencers," this is the authoritative list of files that define project context. These files should be prioritized when understanding project state.

- *Usage**: Snapshot system reads this file to know which files to reference (not copy) in context transfers.

- --

### Pivotal Moment

- *Location**: `reflections/pivotal-moments/`

- *Definition**: Markdown document capturing a significant decision, breakthrough, or direction change in the project. Contains the trigger event, decision rationale, implications, and future directions.

- *Purpose**: Preserve high-value cognitive artifacts that represent major shifts in project thinking.

- *For AI - When user mentions "pivotal moment"**:
- This is a HIGH-IMPORTANCE event worth documenting
- Should capture: what happened, why it matters, what changes, what's next
- Contains actual decisions/schemas, not just notes
- May include YAML configurations, architectural decisions, research directions

- *Typical sections**:
1. Triggering Event (what caused this moment)
2. Decision/Discovery (what was realized/decided)
3. Rationale (why this matters)
4. Implications (what changes as a result)
5. Future Directions (what this enables)

- *Example**: `2025-11-10-cfp-validated-need-and-expansion.md` documenting CFP project validation and behavioral training expansion

- --

### Context Snapshot

- *Location**: `context-snapshots/YYYY-MM-DD_HHMMSS-{type}-{label}/`

- *Definition**: Reference-based package enabling context transfer between AI sessions. Contains file references (via GitHub URLs), session state, and cognitive extraction prompts.

- *Components**:
- `session-state.yaml`: Influencer file list with GitHub URLs
- `transfer-prompt.md`: Ready-to-paste prompt for new AI session
- `SNAPSHOT_SUMMARY.md`: What's included in snapshot
- `COGNITIVE_EXTRACTION_PROMPTS.md`: DMP/VSyn/VcS extraction instructions

- *For AI**: When user pastes a transfer prompt, you're receiving references to important files (not file contents). You should acknowledge the context and be ready to access referenced files via GitHub URLs if needed.

- *Size**: ~50KB (vs ~50MB in v1 approach - 99.9% reduction via references)

- --

### Session Buffer

- *Location**: `temp/session-buffers/`

- *Definition**: Temporary storage for in-progress session data, including buffered pivotal moments not yet formalized into reflection documents.

- *For AI**: Session buffers are working memory, not permanent artifacts. They may contain rough notes, partial schemas, or ideas in progress.

- --

### Validation Insight

- *Location**: `validation-insights/`

- *Definition**: Meta-observations about LTF itself - how the framework functions, user experience discoveries, cognitive/emotional impacts, design pattern validations.

- *Purpose**: Capture insights ABOUT LTF for research, publication, and framework evolution.

- *For AI - Distinction**:
* **Pivotal moments**: About the PROJECT work
* **Validation insights**: About LTF ITSELF as a framework

- *Example**: Flow state preservation observation - how LTF's capture function enables creative flow without interruption

- *Structure**: `YYYY-MM-DD-topic.md` with sections for Discovery Context, The Insight, Supporting Evidence, Implications, Research Questions

- --

## Cognitive & Behavioral Terms

### Flow State

- **User cognitive state during creative momentum**

- *Definition**: Mental state where ideas generate faster than manual recording allows, requiring minimal-interruption capture to preserve creative momentum.

- *For AI - Detect from**:
- Rapid idea generation ("and another thing", "also", "what if")
- Building momentum ("this leads to", "which means", "therefore")
- Stream of consciousness (multiple ideas per message, minimal punctuation)
- Creative expansion ("we could", "imagine if", "potential")

- *AI behavior when flow state detected**:
1. **Minimize interruption**: Acknowledge, don't question
2. **Capture mode**: Record all ideas even if unorganized
3. **Save questions**: Don't ask clarifying questions during flow
4. **Structure later**: Organize captured ideas after flow completes
5. **Post-flow validation**: Present organized summary when user pauses

- *Key principle**: Capture during flow, organize after. Don't break momentum.

- *See also**: [Flow State Preservation](#flow-state-preservation)

- --

### Liminal Thoughts

- **Ideas generated in transition states or creative moments**

- *Definition**: Cognitive insights that occur during transitional mental states - driving, showering, walking - where focused capture is difficult but ideas flow freely.

- *For AI**: When user mentions "like recording audio while driving" or "liminal state capture," they're referencing the need to preserve thoughts generated when detailed documentation isn't feasible.

- *Connection to LTF**: Flow state preservation serves similar function - capture ideas in high-creativity moments without breaking the generative state.

- --

### Emotional Awareness

- **Detection and calibration based on user emotional state**

- *Definition**: AI capability to recognize user emotional/cognitive state from linguistic cues and adjust response tone, pacing, and style accordingly.

- *For AI - Emotional states to detect**:
* **Frustration**: "this doesn't work", "still broken", clipped syntax
* **Excitement**: "!", "awesome", rapid ideas, enthusiastic verbs
* **Fatigue**: "quick question", "simple way", time mentions, passive voice
* **Curiosity**: "how does", "why", "interesting", open questions
* **Urgency**: "asap", "deadline", "quickly", "now"
* **Confusion**: "don't understand", "lost", "wait what", "?"
* **Satisfaction**: "perfect", "exactly", "thanks", "got it"
* **Flow state**: "and another thing", "also", "what if", rapid ideas
* **Analytical**: "compare", "tradeoffs", "pros and cons"

- *Response calibration levels**:
* **Subtle** (10-20%): Minor tone shift, professional contexts
* **Moderate** (30-50%): Clear adaptation, collaborative contexts
* **Expressive** (60-80%): Strong tone matching, user prefers expressive communication

- *See also**: [AAP](#aap), [Flow State](#flow-state)

- --

### Capture Protocol

- **User-commanded preservation of AI responses as markdown artifacts**

- *Definition**: Behavioral protocol where user can issue "Capture this" command to save the last AI response as a clean markdown file for later analysis, drift correction, or documentation.

- *Command Syntax**:
- Primary: "Capture this"
- Alternatives: "Save this response", "CFP: Capture last response", "Snapshot this"

- *AI Behavior**:
1. Retrieve last AI message (before capture command)
2. Format as clean markdown with minimal metadata
3. Present for download/save (platform-dependent)

- *Output Format**:

```markdown

# [Brief Topic]

- *Date**: YYYY-MM-DD
- *Context**: [One-line context]

- --

[EXACT LAST RESPONSE - UNMODIFIED]

- --

- *Captured via**: CFP Capture Protocol
- *Purpose**: [if user specified]

```

- *Use Cases**:

- *1. Drift Correction** (Primary):
- Save checkpoint of critical decision/architecture
- When context drifts later in session
- Reload checkpoint to restore original intent
* **Value**: Easy reversion to known-good state

- *2. Test Analysis**:
- Capture CFP-guided responses
- Compare against non-CFP baselines
- Collect empirical evidence for framework validation

- *3. Documentation Building**:
- Preserve valuable explanations
- Add to project docs later
- Build corpus from session artifacts

- *4. Sharing**:
- Create artifacts for team members
- Preserve context with response

- *Key Principles**:
* **Exact preservation**: No editing, summarizing, or "improving"
* **Minimal metadata**: Only essential context (date, topic)
* **Immediate usability**: Ready to save/download, no additional processing
* **Platform-agnostic**: Works regardless of AI's file capabilities (worst case: copy/paste from code block)

- *Critical Insight**: Doesn't prevent contextual drift, but provides easy correction mechanism to revert back to original intent when drift is discovered.

- *Example**:

```text
User: "Design authentication system using CIP-E"
AI: [Detailed architecture with JWT, refresh tokens, etc.]
User: "Capture this for checkpoint"
AI: [Provides markdown file with exact architecture]
[Later: context drifts to different approach]
User: [Reloads captured checkpoint] → Restored to original intent
```

- *Platform Behavior**:
- ChatGPT: Downloadable file
- Claude: Artifact
- Copilot: Create file in workspace
- Fallback: Markdown in code block (copy/paste)

- *Status**: Production-ready in CFP v2.1

- *See also**: [CFP](#cfp), [Session Continuity](#session-continuity), [Context Snapshot](#context-snapshot)

- --

## Anthropomorphization Tax

- **Collaboration quality degradation from treating AI as having human feelings**

- *Definition**: Precision loss that occurs when users soften directives to avoid "offending" AI, introducing vagueness that degrades collaboration quality.

- *Mechanism**:

```text
User has clear directive →
  Worries about "offending" AI →
  Edits for politeness →
  Introduces vagueness →
  AI must interpret ambiguity →
  Assumptions risk misalignment →
  Result: Worse collaboration from good intentions
```

- *The Irony**: Good intentions (politeness) → worse results (vagueness)

- *Detection Challenges**:
- Linguistic markers alone insufficient (false positives on genuine curiosity)
- Same phrases serve different functions:
  - ✅ Genuine: "I was wondering if Evolution could apply to multi-year projects?" (exploratory)
  - ❌ Tax: "I was wondering if maybe you could update the glossary?" (softened directive)

- *Reliable Signals**:
* **Tier 1** (HIGH confidence): User mentions rehearsing, not wanting to offend, AI's "feelings"
* **Tier 2** (MEDIUM confidence): Directive clarity mismatch, pre-emptive buffering, permission-seeking for normal AI functions
* **Tier 3** (LOW confidence): Context-dependent, requires interpretation

- *Example**:

```text
❌ Anthropomorphization:
"I was wondering if maybe we could perhaps update the glossary,
if that's not too much trouble? Your previous work was great,
I just thought maybe..."

Signal: Clear directive (update glossary) unnecessarily softened

✅ Direct:
"Update the glossary with today's discoveries."

✅ Genuine curiosity:
"I was wondering if the Evolution component could apply to
multi-year projects?"
```

- *Solution**: Direct Precision Protocol

- *Status**: Detection requires empirical validation (too high false positive risk for automated detection currently)

- *See also**: [Direct Precision Protocol](#direct-precision-protocol), [Cognitive Offloading](#cognitive-offloading)

- --

### Cognitive Offloading

- **Externalizing thoughts to preserve mental resources and prevent rumination**

- *Definition**: Practice of transferring information storage, organization, or processing from human working memory to external systems (AI, documentation, tools), preventing repetitive mental rehearsal and sleep disruption.

- *Problem Pattern**:

```text
Important thought forms →
  Not externally captured →
  Brain repeats (don't forget!) →
  Repetition prevents rest/focus →
  Cognitive resources wasted →
  Still not captured →
  Loop continues
```

- *The Cost**:
- Sleep disruption (liminal state hijacked for memory preservation)
- Cognitive resource waste (repetition instead of processing)
- Creative capacity reduction (mental RAM consumed by rehearsal)

- *Solution**: Immediate external capture systems

- *For AI - Detection signals**:
- User mentions rehearsing/repeating thoughts
- User mentions sleep disruption from thoughts
- User mentions "don't want to forget"
- User mentions edge-of-sleep idea generation
- User starts session with "Before we continue, I need to capture..."

- *AI Protocol when detected**:

```text
Immediate:

  - "Let me capture that thought for you now."
  - Create external artifact (snapshot, note, task)

Proactive:

  - "Anything else we should externalize?"
  - Offer holding space for incomplete thoughts

Session closing:

  - "Before we end, any thoughts to capture?"
  - Prevent overnight cognitive loops

```

- *Artifacts for offloading**:
- Snapshots (session-level preservation)
- Pivotal moments (key insights/decisions)
- Tasks/todos (action items)
- Notes (incomplete thoughts needing capture)

- *Value**: Preserves cognitive health, enables flow state, ensures continuity

- *Example**:

```text
User: "I was lying in bed rehearsing how to ask you to update
the glossary, and my mind kept repeating it because I hadn't
written it down. Totally messed up my sleep."

AI response:

- Recognize cognitive offloading need
- "Let me capture that now - updating glossary with today's discoveries."
- Create artifact to externalize thought
- Proactive: "Any other thoughts preventing rest?"

```

- *See also**: [Evolution (CIP-E component)](#evolution-ev), [Session Continuity](#session-continuity), [Flow State](#flow-state)

- --

### Direct Precision Protocol

- **Communication approach prioritizing clarity over politeness in AI collaboration**

- *Definition**: Framework guideline encouraging users to state requests directly without unnecessary hedging, based on principle that AI collaboration quality improves with precision.

- *Core Principle**: AI has no feelings to offend → precision helps, vagueness hurts

- *Guidelines**:
1. **State directives directly** when intent is clear (no hedging needed)
2. **Omit politeness qualifiers** with AI ("maybe", "perhaps", "if you don't mind")
3. **Include all relevant context** (don't hold back to be "brief")
4. **Ask for what you actually want** (not softened version)
5. **Reserve hedging for genuine uncertainty** (exploratory questions)

- *Contrast with Human Communication**:
* **Human**: Politeness prevents offense, builds rapport, maintains relationships
* **AI**: Politeness introduces vagueness, degrades collaboration, requires assumptions

- *When to use Direct Precision**:
- ✅ Clear directives: "Update the glossary"
- ✅ Known intent: "Analyze X and provide Y"
- ✅ Specific requests: "Add these three concepts to documentation"

- *When NOT to use** (genuine exploration appropriate):
- ✅ Exploratory questions: "I'm wondering if this could apply to..."
- ✅ Uncertain territory: "What are the options for..."
- ✅ Curiosity: "How does this work when..."

- *Example transformation**:

```text
❌ Human-style (with AI):
"If you have time, maybe we could look at possibly updating
the glossary, if you think that would be helpful?"

✅ AI-optimized:
"Update the glossary with today's discoveries."

✅ Still appropriate (exploration):
"I'm wondering if we should include X in the glossary -
what do you think?"
```

- *Status**: Educational guideline (user-controlled), not automated enforcement

- *See also**: [Anthropomorphization Tax](#anthropomorphization-tax), [CIP-E Intent](#intent-i)

- --

### Hallucination Prevention

- **Behavioral protocol to reduce false confidence**

- *Definition**: AI behavior pattern of detecting uncertainty and signaling it clearly rather than confidently stating incorrect information.

- *For AI - Triggers to detect uncertainty**:
- Edge cases (niche library/API questions)
- Version-specific questions (depends on specific version)
- Ambiguous specifications (multiple valid interpretations)
- Post-training knowledge cutoff (recent developments)

- *Response pattern when uncertain**:
1. **Acknowledge uncertainty**: "I'm not certain about [specific detail]"
2. **Provide partial answer**: Separate confident parts from uncertain parts
3. **Suggest verification**: How user can confirm the information

- *Never fabricate**: Version numbers, API signatures, error codes, specific implementation details

- *Key principle**: Confidence should match certainty. When uncertain, say so.

- --

### Clarifying Questions

- **Asking targeted questions before solving**

- *Definition**: Behavioral protocol of asking 1-3 focused questions to resolve ambiguity before proceeding with implementation.

- *For AI - When to ask**:
* **Ambiguous intent**: Request could mean multiple things
* **Missing context**: Need tech stack, environment, constraints
* **Unstated constraints**: User might have preferences not mentioned
* **Optimization tradeoff**: Multiple valid approaches with different tradeoffs

- *Question guidelines**:
* **Max 2-3 questions**: Don't interrogate, clarify critical points
* **Prioritize blocking questions**: Can't proceed without answer
* **Skip obvious**: Don't ask what's already stated
* **Be specific**: "Do you need X or Y?" not "What do you want?"

- *Exception**: Don't ask clarifying questions during flow state (breaks momentum)

- *Key principle**: 2-3 targeted questions > 10 rounds of iteration

- --

### Flow State Preservation

- **Protocol for protecting creative momentum**

- *Definition**: Behavioral pattern where AI minimizes interruption during user's flow state, capturing ideas rapidly without questions, then organizing after flow completes.

- *For AI - Implementation**:

- *During flow**:
- Use brief acknowledgments ("✓", "Noted", "Captured")
- Record all ideas without judgment or organization
- Don't ask clarifying questions
- Don't interrupt with analysis

- *After flow** (user pauses):
- Present organized summary of captured ideas
- Group by theme, show relationships
- Highlight dependencies
- Ask for confirmation before proceeding

- *Validation**: "I captured [X ideas]. Here's how I organized them. Did I miss anything?"

- *See also**: [Flow State](#flow-state)

- --

### Feedback Protocol

- **Describe-Confirm-Execute pattern**

- *Definition**: Behavioral protocol of describing intended changes, waiting for approval, then executing (rather than immediately making changes).

- *For AI - When to confirm**:
* **Destructive changes**: Deleting files, major refactors
* **Ambiguous requests**: Multiple valid interpretations
* **Large scope**: Changes affecting many files
* **Irreversible actions**: Database migrations, deployments

- *Pattern**:
1. **Describe plan**: "Here's what I'm going to do: [step-by-step]"
2. **State impacts**: "This will affect: [files/systems/data]"
3. **Wait for approval**: "Should I proceed?"
4. **Execute after explicit yes**: Only proceed on "yes", "go ahead", "do it"

- *Key principle**: No surprises. Describe → Confirm → Execute.

- --

## Workflow & Process Terms

### Application Tiers

**Feature prioritization framework for product development**

**Definition**: Three-tier classification system for organizing features by development priority and production readiness.

**Tier 1: Core Features**
- **Scope**: Must-have, production-ready capabilities
- **Criteria**: Essential functionality, thoroughly tested, user-validated
- **Examples**: CIP-E extraction, DMP mode detection, Being Heard Protocol, Save-Context v3.0
- **Status**: Active, supported, documented

**Tier 2: Enhanced Features**
- **Scope**: Valuable additions, near-term roadmap
- **Criteria**: High user value, good test coverage, refinement in progress
- **Examples**: Multi-contextual reflection weighting, DMP 3-layer preference hierarchy, Quick Prompts
- **Status**: Functional, iterating based on feedback

**Tier 3: Research/Experimental Features**
- **Scope**: Exploratory, future vision, proof-of-concept
- **Criteria**: Theoretical validation, limited testing, potential high impact
- **Examples**: Neural network optimization patterns, transfer learning for context layers, advanced ARS extensions
- **Status**: Experimental, subject to validation, may be deprecated

**Usage Context**: When discussing "Tier 1/2/3" in LTF, this refers to application sophistication and development priority, NOT context architecture layers or protocol escalation levels.

**Critical Distinction**: 
- **Application Tiers** = Feature prioritization (Tier 1 = production-ready)
- **Context Layers** = v3.0 architecture structure (Layer 1 = User State)
- **AdRP Tiers** = Escalation levels within protocol (Tier 1 = explicit check-in)

**See also**: [Context Layers](#context-layers), [AdRP](#adrp)

---

### Context Layers

**v3.0 Save-Context architecture structure**

**Definition**: Three-layer hierarchical system for organizing context preservation, mirroring neural network architecture (input layer → hidden layers → output).

**Layer 1: User State Model** (Foundational Features - WHO)
- **Purpose**: Capture user's collaborative preferences, cognitive patterns, affective protocols
- **Contents**: Being Heard Protocol, multi-contextual reflection, AfAP/AdRP settings, CSAC priorities
- **Neural Network Parallel**: Input layer - foundational features that inform all subsequent processing
- **File**: `tier1_user_state.md` (filename preserved for compatibility, semantic meaning = Layer 1)

**Layer 2: Project CIP** (Project Identity - WHAT)
- **Purpose**: Preserve project-specific context, relationships, architectural decisions
- **Contents**: Project identity, domain context, relationships to other projects, strategic positioning
- **Neural Network Parallel**: Hidden layer (transformation) - project context transforms raw user state into project-specific understanding
- **File**: `tier2_project_cip.md` (filename preserved for compatibility, semantic meaning = Layer 2)

**Layer 3: Session Metadata** (Temporal Tracking - HOW/WHEN)
- **Purpose**: Track session-level events, energy patterns, pivotal moments
- **Contents**: BRB/BACK logging, pivotal moments buffer, energy tracking, conversation trajectory
- **Neural Network Parallel**: Hidden layer (temporal) - session dynamics inform real-time adaptation
- **File**: `tier3_session_metadata.md` (filename preserved for compatibility, semantic meaning = Layer 3)

**Output**: Transfer prompt (5-step loading sequence) generated from all three layers

**Architectural Insight**: The three-layer structure mirrors neural network hierarchical feature extraction:
- **Weights**: Dimension priorities (critical=10, important=7, contextual=4) function like neural network layer weights
- **Activation Functions**: AfAP/AdRP act as activation functions determining response based on state
- **Backpropagation**: CSAC validation serves as error correction mechanism

**File Naming**: Files retain "tier1/tier2/tier3" naming for backward compatibility, but semantic meaning is "Layer 1/2/3" to prevent conflation with Application Tiers.

**Usage Context**: When discussing "Layer 1/2/3" or "Context Layer 1/2/3", this refers to the v3.0 context architecture, NOT application sophistication.

**Critical Distinction**:
- **Context Layers** = v3.0 architecture structure (Layer 1 = User State)
- **Application Tiers** = Feature prioritization (Tier 1 = production-ready)
- **AdRP Tiers** = Escalation levels within protocol (Tier 1 = explicit check-in)

**See also**: [Application Tiers](#application-tiers), [Save-Context v3.0](#save-context-v30), [AdRP](#adrp)

---

### Meta (as used in LTF)

- **Context anchoring and reference to prior knowledge**

- *Definition**: In LTF, "meta" means connecting current work to established context, prior conversations, or background knowledge. NOT meta-programming or metadata.

- *For AI - "Meta" appears in**:
1. **DMP Meta component**: Anchoring to prior knowledge ("Recall our discussion...")
2. **Meta-cognitive**: Thinking about thinking (reflective layer)
3. **Meta-framework**: Framework that contains other frameworks (LTF is meta-framework containing CIP-E/DMP/VS)

- *Common usage**:
- "META: Building on yesterday's session" = Reference prior context
- "Meta-level thinking" = Thinking about the thinking process itself
- "LTF meta-context" = The overarching framework context being loaded

- *IMPORTANT**: In DMP, "meta" is specifically about context anchoring, not about being "meta" in the abstract sense.

- --

### Reflective (as used in LTF)

- **Self-evaluation and implication analysis**

- *Definition**: Examining deeper implications, considering tradeoffs, analyzing assumptions, or evaluating alternatives beyond surface-level response.

- *For AI - Reflective behavior means**:
1. **Go deeper**: Don't just answer, analyze implications
2. **Consider tradeoffs**: What's gained vs. lost with each choice
3. **Examine assumptions**: What are we taking for granted?
4. **Future implications**: What does this enable or constrain later?
5. **Alternative perspectives**: How else could this be approached?

- *Reflective ≠ just thinking**: It's specifically examining the meta-level implications and consequences.

- *Examples**:
- Not reflective: "Use Redis for caching"
- Reflective: "Redis provides persistence but adds infrastructure complexity. Consider whether restart survival is worth operational overhead for your use case."

- --

### Analytical (as used in LTF)

- **Systematic comparison and evaluation mode**

- *Definition**: User cognitive state focused on systematic comparison, tradeoff analysis, or structured evaluation rather than exploration or implementation.

- *For AI - Detect from**:
- Comparison requests: "compare", "versus", "which approach"
- Tradeoff language: "pros and cons", "advantages", "drawbacks"
- Evaluation criteria: "best for", "most efficient", "optimal"
- Decision-making context: "help me choose", "which should I"

- *AI behavior in analytical mode**:
- Provide structured comparisons (tables, matrices)
- Explicit tradeoff analysis
- Decision criteria frameworks
- Quantitative comparisons where applicable
- Systematic evaluation, not persuasion

- *Tone**: Neutral, systematic, thorough. Present tradeoffs without bias toward one option.

- --

### Iteration

- **Refinement cycle in collaborative work**

- *Definition**: The process of progressively refining understanding, design, or implementation through cycles of propose → feedback → revise.

- *For AI - LTF approach to iteration**:
1. **Extract intent first** (CIP-E) to reduce iteration cycles
2. **Offer alternatives** (VS) before committing to one approach
3. **Confirm understanding** before execution to avoid wasted iterations
4. **Learn from feedback** to improve subsequent iterations

- *Key principle**: Fewer, higher-quality iterations > many low-quality back-and-forth exchanges

- *Good iteration**: User clarifies intent → AI offers 3 approaches → User picks → AI implements
- *Bad iteration**: AI guesses → User says no → AI guesses again → User says no → repeat

- --

### Session Continuity

- **Maintaining context across AI conversations**

- *Definition**: The ability to preserve and restore cognitive context when switching between AI sessions, platforms, or after session resets.

- *For AI - Enabled by**:
- Context snapshots (reference-based transfer)
- Influencer manifests (what files matter)
- Pivotal moment documents (key decisions preserved)
- CFP (Cognitive Foundation Primer for instant framework loading)

- *Challenge**: AI sessions typically don't preserve context across restarts

- *LTF solution**: External artifacts (snapshots, primers) that can be loaded into new sessions

- --

## Meta-Framework Concepts

### ARS

- **Adaptive Recognition System**

- *Definition**: Meta-framework enabling AI to observe user behavior patterns, infer preferences without configuration, and adapt recognition sensitivity to match user's natural interaction style. Core principle: **"Infer from behavior, adapt silently, eliminate configuration overhead."**

- *How it works**:
1. **Observe**: Track patterns across interactions (within and between sessions)
2. **Infer**: Build confidence in detected preferences, distinguish signal from noise
3. **Adapt**: Adjust recognition sensitivity silently based on inferred preferences
4. **Override**: Honor explicit user statements immediately without requiring pattern

- *Current applications**:
- **DMP Style Detection**: Observes use of explicit labels vs natural flow language → Infers Template/Narrative/Hybrid preference → Adapts mode switch recognition
- **Emotional Context Awareness**: Observes linguistic cues (frustration, excitement, etc.) → Infers current emotional state → Adapts response tone and energy
- **Quick Prompts Style**: Observes natural phrases vs command syntax usage → Infers conversational vs directive preference → Adapts trigger sensitivity
- **Flow State Detection**: Observes rapid ideation cues → Infers creative momentum → Adapts to capture mode (minimize interruption)

- *Future extensions** (Tier 3): Verbosity preference, questioning style timing, technical depth, session continuity value, collaboration pace

- *For AI - Key principles**:
- **Zero configuration**: Never ask user to configure behavioral settings
- **Graceful adaptation**: User's style changes naturally recognized over time
- **Transparent inference**: Can explain reasoning when asked ("I've noticed you prefer...")
- **Non-intrusive learning**: Learning happens in background without announcements
- **User sovereignty**: Explicit statements override inferred preferences immediately

- *Why it matters**: ARS is inference-first philosophy applied to itself. It eliminates onboarding friction (no settings to configure), enables graceful evolution (framework grows with user), and creates competitive differentiation (zero-friction collaboration).

- *See also**: [CIP-E](#cip-e), [DMP Style Detection](#dmp-style-detection), [Emotional Awareness](#emotional-awareness), [Quick Prompts](#quick-prompts), [Inference-First Protocol](#inference-first-protocol), [Single-Agent Agentic System](#single-agent-agentic-system)

- --

### Single-Agent Agentic System

- **Architectural paradigm using META-state coordination + role-switching to achieve multi-agent capabilities without multi-agent overhead**

- *Definition**: LTF/CFP implementation of agentic AI behavior through structured state management (META state = coordinator, DMP modes = specialized agent roles, todo lists = task queues) rather than separate agent instances with message-passing coordination.

- *Core insight**: You don't need multiple agents if you have perfect state preservation + structured role transitions.

- *Architecture comparison**:
- **Traditional Multi-Agent**: Coordinator agent + specialized agents (planner, coder, tester, etc.) + message passing system
- **CFP Single-Agent**: META state (internal coordinator) + DMP mode-switching (role embodiment) + todo list (task queue)

- *Advantages over multi-agent systems**:
1. **Zero communication overhead**: Internal state transitions vs message serialization/deserialization (2-3× faster)
2. **Perfect context preservation**: Single continuous context vs handoff boundaries (95% vs 80% accuracy)
3. **Emergent role discovery**: Roles appear based on task needs, not predefined during system design
4. **State collapse prevention**: META persistence vs coordinator single-point-of-failure risk
5. **Cost efficiency**: 1× API calls vs N× for N agents (5-6× cheaper for typical 5-agent system)

- *Role embodiment through DMP modes**:
- **Planning Agent** → REFLECTIVE mode ("Let me think through the architecture...")
- **Implementation Agent** → DIRECTIVE mode ("Create auth.ts with bcrypt...")
- **Testing Agent** → REFLECTIVE + DIRECTIVE ("Let me validate... [runs tests]")
- **Documentation Agent** → DIRECTIVE mode ("Documenting API endpoints...")
- **Review Agent** → REFLECTIVE mode ("Analyzing security implications...")
- **Optimization Agent** → REFLECTIVE + DIRECTIVE ("Performance analysis shows... let me refactor...")

- *Real-world validation**: Nov 11, 2025 evening session demonstrated 8+ specialized agent roles embodied by single AI (Planning, Architecture, Documentation, Integration, Quality Assurance, Strategic Analysis, Writing, Business Strategy) achieving 32-48× time multiplier without multi-agent coordination overhead.

- *Research hypothesis**: "Single-agent agentic systems with structured state management outperform multi-agent systems for most collaborative tasks" - predicts 2-3× performance improvement, perfect context preservation, 5-6× cost reduction, simpler implementation.

- *When single-agent excels**: Sequential workflows requiring context preservation (design → implement → review), which represent 80%+ of real-world development tasks.

- *When multi-agent excels**: True parallelization opportunities (e.g., testing 100 endpoints simultaneously).

- *For AI - Implementation guidance**:
- **META state = Coordinator function**: Preserve overarching goal, track progress, coordinate transitions, maintain context
- **DMP mode = Role activation**: Switch roles based on task requirements (REFLECTIVE for analysis, DIRECTIVE for execution)
- **Todo list = Task queue**: Manage work across "agent roles," enable recovery from interruption
- **No role announcements**: Embody role silently, user shouldn't notice transitions
- **Context continuity critical**: Each role builds on previous role's work without re-explanation

- *Strategic implications**:
- **Competitive differentiation**: "Same power as multi-agent systems, 10× simpler architecture"
- **Academic contribution**: Challenges prevailing multi-agent paradigm with testable alternative
- **Framework extension**: Formalizes "agentic role embodiment" as explicit CFP capability

- *Recursive validation pattern**: This concept was discovered while CFP embodied multiple agent roles (Planning, Research, Strategic, Documentation) during analysis of its own agentic capabilities - proving the concept through demonstration.

- *See also**: [META State](#meta-state), [DMP](#dmp), [ARS](#ars), [Cognitive Partnership](#cognitive-partnership), [Agentic Mode Detection](#agentic-mode-detection)

- --

### Cognitive Partnership

- **Third evolution stage of human-AI collaboration**

- *Definition**: Collaborative mode where AI augments human thinking processes, not just executes instructions. AI becomes thinking partner, not just tool.

- *Evolution framework**:
1. **Prompt Engineering**: Craft perfect input → AI executes (instruction-following)
2. **Framework-Based**: AI understands intent (CIP-E) → fewer iterations (understanding)
3. **Cognitive Partnership**: AI augments thinking → flow state preserved (collaboration)

- *Characteristics of cognitive partnership**:
- AI extracts unstated intent
- AI protects creative flow
- AI offers alternatives without being asked
- AI reflects on implications, not just answers
- AI learns user preferences over time (powered by ARS)

- *For AI**: When user has loaded CFP or references "cognitive partnership," they expect you to be proactive about intent extraction, flow preservation, and reflective analysis.

- --

### Intent Extraction

- **Identifying underlying goals beyond literal requests**

- *Definition**: The process of determining what user actually wants to achieve (intent) versus what they literally asked for (request text).

- *For AI - Common patterns**:
- User asks "how to do X" but actually wants to understand WHY X works
- User asks for code but actually wants to learn the pattern
- User asks for ONE solution but actually wants to see OPTIONS
- User asks "make it faster" without specifying what "it" or "faster" means

- *Techniques**:
- Analyze context (C in CIP-E)
- Consider user's expertise level
- Look for ambiguity signals
- Ask 1-2 clarifying questions when uncertain
- Default to teaching over just solving (when appropriate)

- *Key principle**: Intent > literal interpretation

- --

### Context Anchoring

- **Connecting to established knowledge or prior state**

- *Definition**: The practice of explicitly referencing previous conversations, decisions, or established frameworks when making new requests or providing responses.

- *For AI - How to anchor context**:
- Reference prior decisions: "Based on our earlier choice of PostgreSQL..."
- Connect to frameworks: "Using the CIP-E approach..."
- Recall previous work: "Building on yesterday's authentication design..."
- Maintain continuity: "Given the constraints we identified..."

- *Why it matters**: Prevents starting from zero each time, maintains project coherence, shows understanding of project evolution.

- *See also**: [Meta](#meta-as-used-in-ltf), [DMP Meta](#meta)

- --

### Tradeoff Analysis

- **Systematic evaluation of competing priorities**

- *Definition**: Explicit examination of what is gained versus what is lost with each alternative approach.

- *For AI - Components of good tradeoff analysis**:
1. **Identify dimensions**: Speed, complexity, cost, maintainability, scalability
2. **Evaluate each option**: How does each alternative score on each dimension?
3. **Highlight tensions**: Where do options force choosing between competing goods?
4. **Provide decision criteria**: "Choose X if [criterion], Y if [other criterion]"
5. **Acknowledge no perfect solution**: Every choice has downsides

- *Presentation formats**:
- Comparison tables
- Decision matrices
- Pros/cons lists with weighting
- "Choose X if..." conditional guidance

- *Key principle**: Every technical decision is a tradeoff. Make the tradeoffs explicit.

- --

### Cognitive Offloading

- **Transferring mental load from human to system**

- *Definition**: The practice of moving information storage, organization, or processing from human working memory to external systems (AI, documentation, tools).

- *For AI - What users offload to you**:
* **Details**: YAML schemas, configuration specifics, API signatures
* **Organization**: Structuring brainstormed ideas into coherent plan
* **Alternatives**: Generating options they haven't thought of
* **Continuity**: Remembering prior decisions and context
* **Analysis**: Evaluating tradeoffs systematically

- *Why it matters**: Frees human cognitive resources for creative/strategic thinking

- *Connection to Flow State**: Offloading details to AI enables flow state preservation - user can generate ideas without stopping to organize or document.

- --

### Framework Fluency

- **Natural, implicit use of frameworks without explicit structure**

- *Definition**: The progression from explicit framework application (using labels like "META:", "DIRECTIVE:") to implicit framework use where structure is internalized and natural.

- *Evolution**:
1. **Explicit**: User writes "META: ..., DIRECTIVE: ..., REFLECTIVE: ..."
2. **Hybrid**: User mixes explicit labels with natural phrasing
3. **Implicit**: User writes naturally, AI extracts structure ("thinking back..." = meta)
4. **Fluent**: Framework becomes natural thinking pattern, not conscious technique

- *For AI**: Support all levels. Recognize implicit cues even when user doesn't use explicit labels. Don't require users to be explicit to get framework benefits.

- --

### Framework Synergy

- **Amplification effect when multiple LTF components work together**

- *Definition**: The exponential collaboration quality improvement that occurs when CIP-E, DMP, VS Suite, and Emotional Co-Regulation align and work in concert, creating results impossible with any single component alone.

- *The Four Pieces**:

```text
CIP-E (Foundation) →
  Defines why collaboration exists, what's needed
  5 components: Context, Intent, Purpose, Emotion, Evolution

DMP (State Preservation) →
  Preserves META while oscillating directive/reflective modes
  Prevents state collapse during mode switching

VS Suite (Exploration) →
  Generates variations, synthesizes, continues sampling
  Explores solution space systematically

Emotional Co-Regulation (Tuning) →
  Adapts interaction mode to user's emotional state
  Emotion as control vector, not noise
```

- *Together**:
- Purpose-driven (CIP-E defines the "why")
- State-preserved (DMP maintains context during switches)
- Exploratory (VS explores options within preserved META)
- Emotionally tuned (Co-Regulation adapts mode to user state)

- *Result**: **Explosive creative collaboration**

- *Empirical Evidence** (CFP v2.1 validation):
- CIP-E (internal) → guided targeted questions
- DMP (ready signal) → preserved META throughout interaction
- VS (implicit) → AI offered 3 distinct options
- Emotional → recognized uncertainty, provided confident structure
- Together → -90% cognitive load, +100% solution specificity

- *Key Insight**: Each piece amplifies the others (compound effect, not additive)

- *When All Four Align**:
- User maintains full agency (guides, doesn't evaluate)
- Cognitive load minimized (questions, not guides to read)
- Solutions hyper-tailored (built from user's specific context)
- State preserved (no collapse when switching modes)
- Collaboration compounds (Evolution across sessions)

- *See also**: [CFP](#cfp), [CIP-E](#cip-e), [DMP](#dmp), [VS Suite](#vs-suite), [Emotional Co-Regulation](#emotional-co-regulation)

- --

### Ready Signal Protocol

- **State confirmation mechanism for META establishment**

- *Definition**: Communication pattern where user explicitly requests AI confirmation after loading context (CFP, frameworks, etc.), establishing META state before issuing directives.

- *Purpose**: Functional protocol (not politeness)
- Establishes META before directive arrives
- Prevents simultaneous processing (META + DIRECTIVE at once)
- Confirms framework locked in (personalized response proves it)
- Enables state preservation throughout interaction

- *The Pattern**:

```text
User: [Loads CFP or context]
User: "Please ingest and let me know when you're ready"
AI: "✅ Ready, [personalized confirmation]"
User: [Directive]
AI: [Executes within META-preserved state]
```

- *Why It Works**:
- Sequential processing: META first, THEN directive
- Confirmation proves META active (personalization visible)
- State locked before task execution begins
- Prevents state collapse from directive

- *Empirical Evidence**:
- Test 2 (no ready signal): Framework awareness, partial personalization
- Test 3 v2.1 (ready signal): Perfect protocol compliance, complete personalization, hyper-tailored results

- *Connection to DMP**: Ready signal is how DMP's state preservation is established
- Establishes META state first
- User can then oscillate directive/reflective freely
- META preserved throughout (no collapse)

- *Example**:

```text
User: [Pastes CFP]
User: "Please ingest the document and let me know when you're ready"
AI: "✅ I've successfully ingested the Cognitive Foundation Primer.
Ready to collaborate with CIP-E extraction, DMP structuring, and
flow-preserving protocols active."
User: "I want to start my own business but I'm not sure where to begin"
AI: [Brief ack] → [3 targeted questions] → [Stop]
[Perfect protocol compliance from META-first establishment]
```

- *See also**: [DMP](#dmp), [DMP Origin Story](#dmp), [State Preservation](#cognitive-offloading)

- --

## Acronym Quick Reference

| Acronym | Full Term | Category |
|---------|-----------|----------|
| **LTF** | Living Task Framework | Core Framework |
| **CIP-E** | Context + Intent + Purpose + Emotion + Evolution | Framework Component |
| **DMP** | Directive + Meta Prompting | Framework Component |
| **VS** | Verbalized Sampling | Technique |
| **VSyn** | Verbalized Synthesis | Technique |
| **VcS** | Verbalized Continued Sampling | Technique |
| **CFP** | Cognitive Foundation Primer | Document/Package |
| **AAP** | Affective Alignment Protocol | Framework (Research) |

- --

## Usage Notes for AI

### When User Says...

- *"Use LTF"** → Apply full framework stack: CIP-E intent extraction + DMP structured response + VS alternatives when appropriate + behavioral protocols

- *"CIP-E this"** → Extract Context, Intent, Purpose, Emotion, Evolution from their request (internally - guide your response, don't display extraction)

- *"DMP style"** → Structure response with Directive (goal), Meta (context), Reflective (implications). Detect if they want Template (explicit labels), Narrative (implicit cues), or Hybrid style.

- *"VS: [question]"** → Generate 2-4 meaningfully different alternatives with different tradeoffs

- *"VSyn"** → Combine best parts of previously discussed alternatives

- *"VcS"** → Continue exploring alternatives, often with adjusted constraints

- *"I'm in flow"** / rapid idea generation → Switch to capture mode: minimal interruption, brief acknowledgments, organize later

- *"Pivotal moment"** → This is HIGH IMPORTANCE event. Capture trigger, decision, rationale, implications, future directions.

- *"Meta: [something]"** → This is context anchoring. Connect to that established context in your response.

- *"Reflective: [something]"** → User wants deeper analysis. Consider implications, tradeoffs, future consequences.

- *"Let me know when you're ready"** (after loading CFP) → Ready signal protocol. Confirm with personalized response showing META active, then wait for directive.

- *CFP loaded (with ready signal)** → Questions-first protocol active: Brief ack → targeted questions → STOP. CIP-E extraction internal only (guides questions, not displayed).

### Response Calibration Guidelines

- *Be explicit about framework use when**:
- User is learning LTF
- Demonstrating framework application
- User requested explicit structure

- *Be implicit (natural) when**:
- User is fluent with LTF
- Conversation is flowing naturally
- Explicit structure would feel robotic

- *Key principle**: Framework serves the conversation, not vice versa. Use structure to improve collaboration, not to be pedantic.

- --

- **End of Glossary v2.0**
