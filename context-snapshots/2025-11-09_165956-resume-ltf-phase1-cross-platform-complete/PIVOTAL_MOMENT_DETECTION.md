# Pivotal Moment Detection Prompt

* *Generated**: 2025-11-09 16:59:57
* *Purpose**: Detect potential pivotal moments in current AI session

- --

## Instructions

To detect pivotal moments from this session:

1. Copy the prompt below
2. Paste into **this same AI session** (where context exists)
3. Save the AI's YAML response
4. Create file: \  emp/session-buffers/session-2025-11-09_165956.yaml\
5. Paste the YAML response into that file
6. Re-run Save-LTFContext to review and approve moments

- --

## Detection Prompt

\\\plaintext
Analyze our conversation for **pivotal moments** - exchanges that represent:

- Breakthrough insights or "aha" moments
- Product/business opportunity emergence
- Paradigm shifts in thinking
- Important decisions or commitments
- Self-validating patterns or meta-observations
- User explicit capture requests ("save this", "remember this")

Reference the Pivotal Moment Capture design:
core/architecture/pivotal-moment-capture-design.md

For each potential pivotal moment detected, include:

1. **Confidence** (0.0-1.0 based on signal strength)
2. **Detected Signals**:
   - Emotional markers (user language like "reeling", "breakthrough", "wow")
   - Structural patterns (product emergence, paradigm shift, synthesis)
   - Explicit requests (user said "capture this")
3. **Context**:
   - User prompt that triggered it
   - AI response preview (first 100 chars)
   - Approximate timestamp or conversation point
4. **Classification**: product_emergence, paradigm_shift, synthesis, decision_point, design_validation
5. **Content**: Brief summary (2-3 sentences) of what happened

Format response as YAML following this structure:

\\\yaml
session_id: "session-2025-11-09_165956"
buffer_created: "2025-11-09T16:59:57Z"

buffered_moments:

  - id: "moment_001"

    timestamp: "[approximate time or conversation point]"
    confidence: [0.0-1.0]

    detected_signals:

      - type: "emotional_marker|structural_pattern|explicit_request"

        value: "[specific signal detected]"
        weight: [0.0-1.0]
        source: "[user_message|ai_response_analysis]"

    context:
      user_prompt: "[User's question/statement]"
      ai_response_preview: "[First 100 chars of AI response]"
      session_phase: "beginning|middle|end"

    suggested_classification: "[product_emergence|paradigm_shift|synthesis|decision_point|design_validation]"
    suggested_filename: "2025-11-09-[descriptive-name].md"
    suggested_tags: ["tag1", "tag2"]

    content_snippet: |
      [2-3 sentence summary of what made this pivotal]

metadata:
  total_buffered: [count]
  high_confidence: [count >= 0.8]
  medium_confidence: [count 0.5-0.79]
  explicit_requests: [count]
\\\

Only include moments with confidence >= 0.5.
If no pivotal moments detected, return empty buffered_moments array.
\\\

- --

## After Detection

1. Save AI's YAML response to: \  emp/session-buffers/session-2025-11-09_165956.yaml\
2. Re-run: \.\tools\context\Save-LTFContext-v2.ps1\
3. Review interface will present detected moments
4. Approve/reject/edit each moment
5. Approved moments saved to \eflections/pivotal-moments/\

- --

* *Note**: Phase 3.5+ will integrate AI API to automate this detection.
