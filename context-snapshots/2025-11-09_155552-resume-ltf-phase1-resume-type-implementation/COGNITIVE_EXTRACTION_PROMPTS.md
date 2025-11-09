# Cognitive State Extraction Prompts

* *Generated**: 2025-11-09 15:55:52
* *Purpose**: Extract DMP/VSyn/VcS state from current AI session

- --

## Instructions

To capture full cognitive state for this snapshot:

1. Copy each prompt below (one at a time)
2. Paste into **this same AI session** (where context exists)
3. Save the AI's response
4. Paste responses into \session-state.yaml\ in appropriate sections

This is a **manual process** in Phase 2. Future phases will automate.

- --

## Extraction Prompt: dmp-patterns

\\\plaintext
Based on our conversation, identify which DMP (Directive + Meta Prompting) patterns have been active.

Reference the DMP Pattern Library at: core/taxonomy/DMP_Patterns.md

For each pattern you detect:

1. Pattern name (from library)
2. Form used (Template, Narrative, or Hybrid)
3. Specific instance (quote or paraphrase from conversation)
4. Impact observed (how it shaped the conversation)

Look for these pattern categories:

* **Meta-Cognitive**: Emotional Co-Regulation, Context Anchoring, Permission to Break Directive
* **Directive**: Iterative Refinement Spiral, Socratic Questioning Loop, Constraint Scaffolding
* **Reflective**: Meta-Observation Request, Drift Detection & Realignment
* **Integration**: Cross-Project Bridge, VcS Semantic Thread Continuity

Format your response as YAML:

```yaml
dmp_patterns_active:

  - name: "[Pattern name]"

    form: "[Template|Narrative|Hybrid]"
    instance: "[Quote or paraphrase from our conversation]"
    impact: "[How it shaped dialogue]"
    detected_at: "[Approximate timestamp or conversation point]"

  - name: "[Another pattern]"

    form: "[Form]"
    instance: "[Instance]"
    impact: "[Impact]"
    detected_at: "[When]"
```

Note: Only include patterns you actually detected with evidence. Don't invent patterns that weren't present.

\\\

- --

## Extraction Prompt: emotional-state

\\\plaintext
Analyze the emotional and energy state of our collaboration session.

Reference: core/taxonomy/VS_Family_Guide.md (Section III.C on VSyn emotional synchronization)

Detect:

1. **Emotional Baseline**: Overall emotional tone (excited, curious, frustrated, tired, focused, etc.)
2. **Energy Level**: Cognitive energy on 0-1 scale (0=exhausted, 0.5=steady, 1=peak energy)
3. **Regulation Strategies**: Any emotional co-regulation that occurred
   - What was the state?
   - How was it regulated? (e.g., "Added reflective brake", "Re-centered context")
4. **Linguistic Markers**: Observable cues
   - Exclamation marks, urgency
   - Passive voice, brevity
   - Clipped syntax
   - Exploratory phrasing
5. **Momentum Indicators**:
   - Breakthroughs achieved
   - Friction points encountered
   - Flow state presence

Format your response as YAML:

```yaml
emotional_state:
  baseline: "[Primary emotional tone - 1-3 words]"

  energy_level: [0.0-1.0]

  regulation:

    - state: "[Emotional state that needed regulation]"

      strategy: "[How it was regulated]"
      trigger: "[What prompted it]"

  linguistic_markers:

    - "[Observed marker 1]"
    - "[Observed marker 2]"

  momentum:
    breakthroughs:

      - "[Breakthrough or insight achieved]"

    friction_points:

      - "[Challenge or blocker encountered]"

    flow_state: [true|false]

  next_session_context:
    recommended_energy: "[What energy/pace would suit continuation]"
    carry_forward: "[Emotional continuity to preserve]"
```

Be honest: If you can't detect clear emotional signals, indicate "neutral" or "insufficient data"

\\\

- --

## Extraction Prompt: vcs-threads

\\\plaintext
Analyze our conversation for VcS (Vector Co-Synthesis) semantic threads - the key concepts and their evolution.

Reference the VS Family Guide at: core/taxonomy/VS_Family_Guide.md (Section IV on VcS)

Identify:

1. **Persistent Threads**: Core concepts used consistently throughout (e.g., "consent", "HIPAA")
2. **Evolved Threads**: Concepts that changed meaning or refined over time
   - Original term
   - New term or refined meaning
   - Reason for evolution
   - When it happened
3. **Emergent Threads**: New concepts that appeared during conversation
   - When introduced
   - Context of introduction
   - How they relate to existing threads
4. **Deprecated Threads**: Concepts we stopped using or explicitly moved away from
   - What was deprecated
   - Why
   - When

Format your response as YAML:

```yaml
vcs_threads:
  persistent:

    - "[Core concept 1]"
    - "[Core concept 2]"
    - "[Core concept 3]"

  evolved:

    - from: "[Original term]"

      to: "[New term or refined meaning]"
      reason: "[Why this evolution happened]"
      session_point: "[When in conversation]"
      artifact: "[Related file/document if applicable]"

  emergent:

    - concept: "[New concept]"

      introduced: "[When]"
      context: "[Why/how it came up]"
      related_to: ["[existing concept 1]", "[existing concept 2]"]

  deprecated:

    - concept: "[Deprecated concept]"

      reason: "[Why no longer relevant]"
      deprecated_at: "[When]"
```

Be precise: Only include threads with clear evidence from our conversation.

\\\

- --

## Extraction Prompt: vsyn-state

\\\plaintext
Generate a complete VSyn (Variable Synchronicity) state for session handoff or context switching.

Reference: core/taxonomy/VS_Family_Guide.md (Section III on VSyn)

This captures the **process state** (how we're collaborating), not domain content.

Include:

1. **Emotional/Energy Synchronization** (from emotional-state.txt output)
2. **DMP Pattern Synchronization** (from dmp-patterns.txt output)
3. **Permission Boundaries**: What the human has/hasn't validated
   - Scope of permissions
   - Conditions/constraints
   - Justification requirements
4. **Meta-Process State**:
   - Phase of work (exploration, synthesis, refinement, validation)
   - Current focus area
   - Momentum assessment
   - Active blockers
5. **Temporal Synchronization**:
   - Last checkpoint/reflection
   - Recent decisions or pivots
   - Timeline context

Format your response as YAML:

```yaml
vsyn_state:
  # Emotional/Energy Synchronization
  emotional_baseline:
    state: "[Emotional tone]"
    regulation: "[Any regulation applied]"
    energy_level: [0.0-1.0]

  # DMP Pattern Synchronization
  active_patterns:

    - name: "[Pattern name]"

      form: "[Template|Narrative|Hybrid]"
      current_state: "[E.g., 'iteration 3' for Iterative Refinement]"

    - name: "[Another pattern]"

      form: "[Form]"
      current_state: "[State]"

  # Permission Boundary Synchronization
  permissions:

    - scope: "[What area permissions apply to]"

      type: "[E.g., constraint_relaxation, creative_expansion]"
      condition: "[When permission applies]"
      requires_justification: [true|false]

  # Meta-Process Synchronization
  process_state:
    phase: "[exploration|synthesis|refinement|validation]"
    focus: "[Current focus area in 3-5 words]"
    momentum: "[high|medium|low]"
    blockers:

      - "[Blocker 1 if any]"

  # Temporal Synchronization
  last_checkpoint:
    timestamp: "[Approximate time or 'N/A']"
    location: "[File path to checkpoint or 'none']"
    summary: "[1 sentence summary of checkpoint]"

  recent_context:

    - event: "[Recent decision/pivot/insight]"

      impact: "[How it affects continuation]"
```

This YAML will be embedded in session-state.md for context transfer.

\\\

- --

## After Extraction

Once you have all 4 responses:

1. Open: \$SnapshotDir\session-state.yaml\
2. Replace the TODO sections with actual YAML from AI responses
3. Sections to populate:
   - \dmp_patterns:\ (from dmp-patterns response)
   - \motional_state:\ (from emotional-state response)
   - \cs_threads:\ (from vcs-threads response)
   - \syn_state:\ (from vsyn-state response)

4. Save the file

Your snapshot will then contain full cognitive state for seamless AI session handoff.

- --

* *Note**: Phase 2.5+ will integrate AI API to automate this extraction.
