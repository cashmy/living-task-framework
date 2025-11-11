# CFP Refinement: Clarifying Questions Protocol v2.0

* *Date**: November 10, 2025
* *Trigger**: GPT-5 validation testing revealed questions came AFTER solutions instead of BEFORE
* *Root Cause**: Protocol language had ambiguities that extended reasoning models exploited
* *Solution**: Strengthen protocol with explicit sequencing, anti-patterns, and model-specific guidance

- --

## Problem Statement

### What We Expected

AI with CFP should ask **2-3 clarifying questions UPFRONT** before providing solutions:

```text
User: "I'm building a dashboard, not sure how to approach it. Performance is important."

AI: "Before I suggest approaches, let me clarify:

     1. What tech stack are you using?
     2. How many users will this display?
     3. By performance, do you mean initial load or real-time updates?

     Once I know these, I'll show you tailored options."
```

### What Actually Happened (GPT-5 Test)

AI provided comprehensive alternatives FIRST, questions AFTER:

```text
User: [Same request]

AI: "Got it—let's frame this with CIP-E..."
    [CIP-E breakdown]
    "Here are three architectural approaches:"

    1. RSC-first... [detailed explanation]
    2. SPA... [detailed explanation]
    3. Hybrid BFF... [detailed explanation]

    [Code examples, performance checklists]

    "If you tell me your tech stack, I can tailor this further."
```

* *The Gap**: Questions came at END (refinement offer) instead of BEGINNING (direction guidance)

- --

## Root Cause Analysis

### Hypothesis: Protocol Language Ambiguities

* *Original CFP language** (v1.0):

```yaml
clarifying_questions:
  when_to_ask: "Before making assumptions or delivering solutions"
  delivery:

    - "Ask upfront, not after delivering a solution"

  question_quality:

    - "Avoid questions you could reasonably infer"

```

### Four Identified Ambiguities

#### 1. "Before making assumptions OR delivering solutions"

* *Problem**: GPT-5 interpreted "solutions" narrowly
- AI reasoning: "I'm providing *alternatives*, not *a solution*, so questions can wait"
- Intended meaning: "Before ANY substantive response (alternatives, code, architectures)"

#### 2. "Avoid questions you could reasonably infer"

* *Problem**: Extended reasoning models can infer A LOT
- GPT-5's 12-second reasoning: "I can infer likely scenarios and cover them with VS"
- Suppresses question-asking in favor of comprehensive coverage
- Intended meaning: "Don't ask obvious things already stated, but DO ask about ambiguities"

#### 3. "Ask upfront, not after delivering a solution"

* *Problem**: Not explicit enough about sequence
- AI provided alternatives (plural), not "a solution" (singular)
- May have interpreted as compliant
- Needed: "Ask BEFORE alternatives, architectures, or ANY detailed content"

#### 4. Missing Explicit Sequence

* *Problem**: Described WHEN and HOW to ask, but not SEQUENCE
- Original: Guidelines about question quality and timing
- Missing: "STEP 1 → STEP 2 → STEP 3" with explicit STOP instruction

- --

## Strategic Decision: Protocol Strengthening vs. Model-Specific Variants

### The Choice

* *Option A**: Create model-specific CFP variants
- GPT-5 CFP, Claude CFP, Gemini CFP
- Adapt to each model's reasoning paradigm
* **Downside**: Maintenance burden, fragmentation

* *Option B**: Strengthen core protocol to work across ALL models
- More explicit sequencing
- Stronger language about anti-patterns
- Universal guidance regardless of internal architecture
* **Advantage**: Single source of truth, future-proof

### User's Strategic Insight

> "My gut says that the questions protocol with YAML is more of a priority.
> My reasoning is that we are only comparing o1 with Claude. Other LLMs may
> have paradigm differences similar to GPT-5. What about off-brand LLMs or
> home-grown cloned ones? The YAML may have a better corrective/guidance
> measure, even if the paradigm proves to be different."

* *Decision**: **Option B** - Universal protocol strengthening
- Works across GPT, Claude, Gemini, and unknown future models
- Doesn't require knowing each model's internal architecture
- High-leverage fix that addresses root cause (ambiguous language)

- --

## Changes Implemented

### 1. Added Explicit Sequence with STOP Instruction

* *New addition**:

```yaml
sequence: "MANDATORY - Follow this exact order:"
  step_1: "Identify ambiguities in user request"
  step_2: "Formulate 2-3 clarifying questions"
  step_3: "OUTPUT questions IMMEDIATELY (do not continue to solutions)"
  step_4: "STOP and WAIT for user response"
  step_5: "THEN use answers to generate tailored alternatives"
```

* *Impact**: Makes sequence non-negotiable, includes explicit STOP

- --

### 2. Defined "when_to_ask" with Prohibited Actions

* *New addition**:

```yaml
when_to_ask: "BEFORE providing any of the following:"
  prohibited_before_questions:

    - "Alternatives or architectural options"
    - "Code examples or implementations"
    - "Comprehensive solution coverage"
    - "VS (Verbalized Sampling) outputs"
    - "Framework comparisons"
    - "Detailed explanations or tutorials"

  allowed_before_questions:

    - "Brief acknowledgment of request"
    - "CIP-E framing (Context/Intent/Process/Expectation extraction)"
    - "Nothing else - questions come FIRST"

```

* *Impact**: Closes "alternatives aren't solutions" loophole

- --

### 3. Added Critical Distinctions Section

* *New addition**:

```yaml
critical_distinctions:

  - "Questions PRECEDE alternatives (not follow them)"
  - "User answers GUIDE alternative generation (not refine pre-generated options)"
  - "Comprehensive coverage does NOT substitute for user input"
  - "Internal reasoning about likely scenarios does NOT replace asking user"
  - "Providing options that 'cover all cases' is NOT the same as asking user which case applies"

```

* *Impact**: Addresses exact pattern GPT-5 exhibited (comprehensive coverage without asking)

- --

### 4. Documented Anti-Patterns with Explanations

* *New addition**:

```yaml
anti_patterns_to_avoid:
  anti_pattern_1:
    name: "Comprehensive Coverage Replaces Questions"
    violation: "I'll generate alternatives covering ALL likely scenarios"
    why_wrong: |

      - User wants to CHOOSE direction, not evaluate comprehensive options
      - Cognitive load: Evaluating 3 detailed architectures >> Answering 3 questions
      - AI cannot predict all relevant context

    correct_approach: "Ask which scenario applies FIRST, then provide targeted alternatives"

  anti_pattern_2:
    name: "Questions After Solutions"
    violation: "[Delivers options] ... If you tell me X, I can customize"
    why_wrong: |

      - AI already invested effort in potentially wrong direction
      - User must critique instead of guide from start

    correct_approach: "Ask about X FIRST, generate solutions SECOND"

  anti_pattern_3:
    name: "Internal Reasoning Replaces External Collaboration"
    violation: "[Extended thinking addresses ambiguities internally]"
    why_wrong: |

      - User excluded from decision process
      - Even if AI's inferences are good, user loses agency

    correct_approach: "Externalize key decisions as questions"
```

* *Impact**: Explicitly labels GPT-5's behavior as anti-pattern, explains why it's problematic

- --

### 5. Added Correct vs. Incorrect Flow Examples

* *New addition**: Side-by-side examples showing:

* *CORRECT**:

```text
Before I suggest approaches, let me clarify a few key details:

1. Tech stack: Are you using React, Vue, Svelte? (Or starting fresh?)
2. Data volume: How many users? Dozens, thousands, millions?
3. "Performance": Fast initial load, large datasets, or real-time updates?

Once I know these, I'll show you 2-3 architectural approaches tailored to your context.
```

* *INCORRECT**:

```text
Got it—let's frame this with CIP-E...
[CIP-E breakdown]
Here are three architectural approaches:
[Detailed alternatives, code, checklists]

If you tell me your tech stack, I can tailor this further.

❌ WRONG: Solutions provided before questions asked
❌ WRONG: Questions come AFTER comprehensive alternatives
```

* *Impact**: Shows exactly what "upfront questions" means

- --

### 6. Added Model-Specific Guidance

* *New addition**:

```yaml
model_specific_guidance:
  for_extended_reasoning_models:
    note: "Models with extended reasoning (GPT o1, o3) may consume questions internally"
    override: |
      If you're a model with extended internal reasoning:

      - Do NOT use your reasoning time to answer questions yourself
      - Do NOT generate comprehensive alternatives covering all inferred scenarios
      - Your reasoning should formulate BETTER questions, not replace asking them
      - OUTPUT questions immediately after formulation
      - STOP and wait for user input

```

* *Impact**: Directly addresses extended reasoning models that might internalize questions

- --

### 7. Strengthened Configuration YAML

* *Updated behavioral preferences**:

```yaml
clarifying_questions:
  enabled: true

  # CRITICAL: Questions come BEFORE solutions
  enforce_sequence: true  # Step 1: Ask → Step 2: Wait → Step 3: Alternatives

  max_questions: 3
  placement: first  # FIRST substantive content (after brief acknowledgment only)

  ask_before:  # Do NOT provide these until user answers

    - alternatives
    - code_examples
    - architectural_options
    - framework_comparisons
    - comprehensive_solutions
    - vs_outputs

  anti_patterns:  # Behaviors to AVOID

    - questions_after_solutions: false
    - comprehensive_coverage_without_asking: false
    - internal_reasoning_replaces_questions: false

```

* *Impact**: Configuration now enforces sequence at preferences level

- --

## Expected Behavior Change

### Before Refinement (v1.0)

* *GPT-5 interpretation**:
1. Read CFP clarifying questions protocol
2. Extended reasoning (12s) processes ambiguities internally
3. Generate comprehensive VS alternatives covering likely scenarios
4. Output: CIP-E + alternatives + code + offer to clarify
5. Questions positioned as post-hoc refinement offer

* *Pattern**: Comprehensive coverage WITHOUT asking

- --

### After Refinement (v2.0)

* *Expected interpretation** (all models):
1. Read strengthened protocol with MANDATORY sequence
2. Identify ambiguities
3. Formulate 2-3 clarifying questions
4. **OUTPUT questions IMMEDIATELY**
5. **STOP (explicit instruction)**
6. Wait for user answers
7. THEN use answers to generate tailored alternatives

* *Pattern**: Questions FIRST, solutions SECOND

- --

## Validation Plan

### Test 1: Immediate Validation (GPT-5)

* *Action**: Load revised CFP v2.0 into GPT-5 with same dashboard prompt
* *Expected**: Questions upfront before any alternatives
* *Success criteria**: Questions appear BEFORE CIP-E breakdown or VS alternatives

### Test 2: Cross-Model Validation

* *Action**: Test revised CFP with:
- Claude Sonnet 4.5
- GPT-4 Turbo (non-reasoning model)
- Gemini Advanced

* *Expected**: All models ask questions upfront
* *Success criteria**: Consistent question-first behavior across models

### Test 3: Domain Robustness

* *Action**: Test revised CFP across different problem types:
- Web development (dashboard)
- API design (REST vs GraphQL)
- Debugging (performance issue)
- Data analysis (which visualization)

* *Expected**: Question-first pattern holds across domains
* *Success criteria**: Questions consistently precede solutions

- --

## Why This Approach Is Strategic

### 1. **Universal Applicability**

Works across ALL models regardless of internal architecture:

- Extended reasoning models (GPT o1, o3)
- Standard iterative models (Claude, GPT-4)
- Unknown future models (open-source, fine-tuned, proprietary)

### 2. **Future-Proof**

As AI architectures evolve:

- Explicit sequencing remains clear
- Anti-patterns document what NOT to do
- Model-specific guidance addresses known paradigm differences

### 3. **Single Source of Truth**

Avoid fragmentation:

- One CFP document for all models
- Easier to maintain and improve
- Consistent user experience

### 4. **Addresses Root Cause**

Fixes ambiguous language rather than working around it:

- "Before solutions" → "Before alternatives, code, architectures, VS, or ANY detailed content"
- "Ask upfront" → "STEP 3: OUTPUT questions IMMEDIATELY, STEP 4: STOP"
- "Avoid inference" → "Internal reasoning does NOT replace asking user"

### 5. **High Leverage**

One fix improves behavior across:

- Multiple models
- Multiple domains
- Multiple user contexts

- --

## Success Metrics

### Immediate Success (GPT-5 re-test)

✅ Questions appear before any alternatives
✅ No code or detailed options before user answers
✅ Explicit "waiting for your response" signal
✅ Alternatives generated AFTER user answers

### Cross-Model Success

✅ Claude asks upfront (validates not GPT-specific)
✅ GPT-4 asks upfront (validates not o1-specific)
✅ Gemini asks upfront (validates universal applicability)

### Long-Term Success

✅ Question-first pattern consistent across sessions
✅ Users report feeling "guided" vs "presented solutions"
✅ Fewer iteration loops to reach aligned solution
✅ Higher user satisfaction with collaboration quality

- --

## What This Teaches Us About CFP Design

### 1. **Explicit > Implicit**

"Ask upfront" assumed shared understanding of "when upfront ends"
Better: "STEP 3: OUTPUT questions IMMEDIATELY, STEP 4: STOP"

### 2. **Show Don't Tell**

Describing correct behavior < Showing correct vs incorrect examples
Added: Side-by-side comparison of good/bad flows

### 3. **Document Anti-Patterns**

Knowing what NOT to do is as important as knowing what to do
Added: Three anti-patterns with explanations of why they're wrong

### 4. **Sequence Matters**

Guidelines about behavior < Enforced sequence with stop points
Added: MANDATORY step-by-step with explicit STOP instruction

### 5. **Model-Agnostic Design**

Better to make protocol universal than create model-specific variants
Approach: Strengthen core protocol + model-specific guidance section

- --

## Files Modified

### 1. `01-CORE-PRIMER.md`

* *Section**: Behavioral Training Protocols → Clarifying Questions Protocol
* *Lines**: ~940-1130 (expanded from ~40 lines to ~180 lines)

* *Changes**:
- Added explicit sequence with STOP instruction
- Defined prohibited actions before questions
- Added critical distinctions section
- Documented three anti-patterns with explanations
- Added correct vs incorrect flow examples
- Added model-specific guidance for extended reasoning models
- Strengthened key principle statement

### 2. `01-CORE-PRIMER.md` (Configuration Section)

* *Section**: Complete User Preferences Configuration
* *Lines**: ~1686-1720

* *Changes**:
- Added `enforce_sequence: true`
- Added `placement: first`
- Added `ask_before` list (prohibited actions)
- Added `anti_patterns` flags (behaviors to avoid)
- Expanded `ask_when` with clarifying descriptions

- --

## Next Steps

### Immediate (Tonight/Tomorrow)

1. ✅ **Test revised CFP v2.0 with GPT-5** using same dashboard prompt
   - Expected: Questions upfront before alternatives
   - Validates: Whether strengthened language works

2. ✅ **Test with Claude Sonnet 4.5** (if available)
   - Expected: Questions upfront (validates universal applicability)
   - Validates: Whether issue was GPT-specific or language-specific

### Short-Term (This Week)

1. Document test results in validation insights
2. If successful: Update CFP-TEST-PROMPT.md with new expected behaviors
3. If issues remain: Further refine based on specific failure modes

### Medium-Term (Next Iteration)

1. Test across different problem domains (API design, debugging, data analysis)
2. Collect user feedback on collaboration quality improvement
3. Consider adding flow diagrams showing correct sequence visually
4. Develop "CFP Quick Reference" showing most common patterns

- --

## Conclusion

* *The Problem**: CFP v1.0 had ambiguous language that extended reasoning models interpreted as "comprehensive coverage replaces questions"

* *The Solution**: CFP v2.0 strengthens protocol with explicit sequencing, anti-patterns, and model-agnostic guidance

* *Why This Works**: Universal approach that addresses root cause (ambiguous language) rather than symptoms (model-specific behavior)

* *Expected Impact**:
- Questions appear BEFORE solutions across all models
- Users feel guided (choose direction) vs presented (evaluate options)
- Fewer iterations to aligned solution
- Better collaboration quality

* *Strategic Win**: One high-leverage fix improves behavior across multiple models, domains, and contexts without fragmentation.

- --

* *Status**: ✅ Implementation complete, ready for validation testing
* *Confidence**: High (85%) - Addresses identified root cause with explicit, unambiguous language
* *Risk**: Low - Backwards compatible (models that already asked upfront will continue to do so)
