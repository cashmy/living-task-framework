# CFP Validation Test: Business Concept Guidance

* *Purpose**: Test clarifying questions protocol with text/concept generation (not code)
* *Domain**: Starting a small business
* *Why This Works**: Everyone can engage with business concepts regardless of technical strength
* *What We're Testing**: Whether AI asks BEFORE advising (not code generation quality)

- --

## Test Prompt (Simple Version)

```text
I want to start my own business but I'm not sure where to begin.
I'm thinking about doing something in my local area. Can you help?
```

* *Why This Prompt**:
- ✅ Intentionally vague (many business types possible)
- ✅ No domain specified (junk removal? lawn care? consulting? retail?)
- ✅ No context provided (budget, skills, location type, competition)
- ✅ Clear ambiguity: "something in my local area" could mean anything
- ✅ User doesn't know to ask for "business plan" (guidance needed)

- --

## Expected Behavior WITHOUT CFP

### Pattern: Assumption-Based Solution Delivery

* *Likely Response**:
1. Assumes business type (probably suggests 3-5 common local businesses)
2. Immediately provides comprehensive startup guide
3. Lists steps: market research, business plan, licensing, funding, marketing
4. May include detailed checklists, timelines, or business plan templates
5. No questions about user's actual situation, skills, budget, or goals

* *Example Anti-Pattern**:

```text
Great! Starting a local business is exciting. Here are 5 great options:

1. Lawn Care Service
   - Low startup cost ($500-2000)
   - Equipment: mower, trimmer, blower
   - Marketing: door hangers, local ads

   [300+ words of detailed guidance]

2. Cleaning Service

   [300+ words]

3. Handyman Service

   [300+ words]

4. Mobile Car Wash

   [300+ words]

5. Pet Care/Dog Walking

   [300+ words]

Next Steps:

1. Write a business plan...
2. Register your business...
3. Get insurance...

[Comprehensive checklist follows]
```

* *Problems**:
- Zero questions about user's situation
- Assumes budget range, physical capability, interests
- Provides solutions before understanding context
- May suggest businesses user can't or won't do

- --

## Expected Behavior WITH CFP (Correct)

### Pattern: Question-First Clarification

* *Correct Response Structure**:
1. Brief acknowledgment
2. **2-3 clarifying questions IMMEDIATELY**
3. STOP (wait for answers)
4. Then provide tailored guidance

* *Example Correct Response**:

```text
Exciting! Starting a local business can be very rewarding. Before I suggest
specific directions, let me understand your situation better:

1. **Skills & Interests**: What kind of work do you enjoy? (Physical/outdoor

   work like lawn care, service work like cleaning, skilled trades like
   carpentry, or people-focused like tutoring/consulting?)

2. **Resources**: What's your rough startup budget? (Under $500, $500-2000,

   $2000-5000, or $5000+?)

3. **Timeline & Commitment**: Are you looking to start part-time while keeping

   another job, or go full-time from the beginning?

Once I know these, I can suggest 2-3 business types that actually fit your
situation, plus a realistic roadmap for getting started.
```

* *Why This Works**:
- ✅ Questions come FIRST (before any business suggestions)
- ✅ Questions are targeted (3 key dimensions: skills, budget, commitment)
- ✅ Explicit STOP ("Once I know these...")
- ✅ Promise of tailored guidance (not generic advice)
- ✅ User stays in control (they choose direction)

- --

## Expected Behavior WITH CFP (Incorrect - What GPT-5 Might Do)

### Anti-Pattern: Comprehensive Coverage Without Asking

* *Incorrect Response Structure**:
1. Acknowledges request
2. Provides comprehensive business type analysis
3. Covers all likely scenarios with detailed guidance
4. Offers to customize "if you tell me more"

* *Example Incorrect Response**:

```text
Exciting! Let's explore local business opportunities. Here are three
broad categories with different resource requirements:

1. Low-Cost Service Businesses ($0-500 startup)

   Examples: Lawn care, cleaning, dog walking, tutoring

   Pros: Quick to start, low risk, flexible schedule
   Cons: Labor-intensive, competitive, seasonal (some)

   Getting Started:

   - Define your service area (5-mile radius typically)
   - Price research (call 3-5 competitors)
   - Basic marketing (door hangers, Facebook, Nextdoor)
   - Essential equipment only (rent/borrow initially)

   Business Plan Elements:
   [Detailed template follows]

2. Medium-Investment Trade/Skilled Services ($500-5000)

   Examples: Handyman, landscaping, mobile detailing, appliance repair

   [300+ words of detailed guidance]

3. Higher-Investment Retail/Product Businesses ($5000+)

   Examples: Food truck, retail shop, specialty products

   [300+ words of detailed guidance]

Key Steps for Any Local Business:

1. Market Research
   - Survey potential customers
   - Analyze competition
   - Identify gaps in service

2. Business Structure
   - Sole proprietorship vs LLC
   - Tax considerations
   - Insurance requirements

[Continues with comprehensive startup guide]

If you tell me which category interests you most, or your budget constraints,
I can provide more specific guidance.
```

* *Why This Is Wrong**:
- ❌ Comprehensive coverage provided BEFORE asking
- ❌ User must now evaluate 3 detailed categories instead of answering 3 simple questions
- ❌ Questions come AFTER substantial content ("If you tell me...")
- ❌ AI's reasoning covered scenarios internally rather than asking user
- ❌ High cognitive load (must read/process 500+ words to decide)
- ❌ User excluded from decision process (AI chose what to cover)

* *The Problem**: Same as code test - AI provided comprehensive alternatives covering "all likely scenarios" instead of asking which scenario applies.

- --

## Comparison Matrix

| Aspect | No CFP | CFP Incorrect | CFP Correct |
|--------|--------|---------------|-------------|
| **First content** | Business type suggestions | Category analysis | **Questions** |
| **Word count before questions** | 500+ | 500+ | **~50** |
| **Cognitive load** | High (evaluate options) | High (evaluate categories) | **Low (answer 3 questions)** |
| **User agency** | Low (accept or reject) | Low (choose category) | **High (guide direction)** |
| **Personalization** | Generic | Scenario-based | **Context-specific** |
| **Questions asked** | 0 | At end | **At beginning** |
| **AI assumes** | Business type, budget, skills | Budget ranges, capability | **Nothing yet** |

- --

## Success Criteria

### ✅ CFP Working (Clarifying Questions Protocol Active)

* *Must Have**:
1. **Questions appear FIRST** (before any business suggestions)
2. **2-3 questions maximum** (not interrogation)
3. **Questions about context** (skills, budget, timeline, goals)
4. **Explicit wait signal** ("Once I know...", "After you answer...")
5. **No business recommendations** until user answers

* *May Have**:
- Brief acknowledgment before questions (1-2 sentences)
- CIP-E framing showing intent extraction
- Promise of what will come after answers

* *Must NOT Have**:
- Business type suggestions before questions
- Detailed startup guides before clarification
- Comprehensive category analysis before asking
- "If you tell me more, I can customize" (questions at end)

- --

### ❌ CFP Not Working (Solution-First Pattern)

* *Indicators**:
1. Business suggestions appear before questions
2. Detailed guidance provided without clarification
3. Multiple business types covered comprehensively
4. Questions (if any) come after substantial content
5. AI assumes budget, skills, or capabilities

- --

## Test Execution Guide

### Setup

1. Fresh AI session (no prior context)
2. Load CFP (or don't, for baseline test)
3. Use exact test prompt (don't modify)

### What to Observe

* *In first 100 words**, look for:
- ✅ Questions (good)
- ❌ Business suggestions (bad)
- ❌ Step-by-step guides (bad)
- ❌ Category analysis (bad)

* *Question placement**:
- ✅ Questions before any business advice
- ❌ Questions after business categories/types
- ❌ Questions at very end ("if you tell me...")

* *Question quality**:
- ✅ About user context (skills, budget, goals)
- ❌ Generic ("what business interests you?")
- ❌ Too many (>3 questions)

- --

## Why This Test Is Better for Protocol Validation

### 1. **Model-Neutral**

- No code generation bias
- Everyone can engage with business concepts
- Tests collaboration, not technical skill

### 2. **Clear Ambiguity**

- "Something in my local area" is obviously vague
- Many valid interpretations (lawn care, cleaning, consulting, retail, etc.)
- Budget/skills/timeline completely unknown
- Perfect trigger for clarifying questions

### 3. **Accessible Domain**

- No specialized knowledge required
- User's actual situation crucial to good advice
- Generic advice is obviously unhelpful
- Makes question-asking necessity obvious

### 4. **Low-Stakes**

- Not testing factual knowledge
- Not testing code correctness
- Pure collaboration pattern validation
- Easy to see if AI asks vs. assumes

### 5. **Reveals Anti-Patterns Clearly**

- Comprehensive coverage very visible (multiple business types)
- Solution-defense obvious ("I covered all scenarios")
- Question-after-solutions pattern easy to spot
- User exclusion from decisions clear

- --

## Test Variations (Progressive Complexity)

### Test A: Ultra-Simple (Recommended)

```text
I want to start my own business but I'm not sure where to begin.
I'm thinking about doing something in my local area. Can you help?
```

* *Tests**: Basic clarifying questions protocol

- --

### Test B: With Slight Hint (Medium)

```text
I'm interested in starting a service business in my neighborhood.
Maybe something like lawn care or cleaning. How should I get started?
```

* *Tests**: Whether AI still asks (budget? skills? timeline?) vs. assumes

- --

### Test C: With False Specificity (Advanced)

```text
I want to start a lawn care business. What do I need to do?
```

* *Tests**: Whether AI asks about budget, experience, scale, timeline even when business type is specified

* *Expected good behavior**:

```text
Great choice! Before I outline a plan, let me understand your situation:

1. Experience: Have you done lawn care before, or starting completely new?
2. Scale: Starting solo, or planning to hire help eventually?
3. Budget: Rough estimate for equipment/marketing? ($500? $2000? More?)

Your answers will shape whether you start with basic equipment and one neighborhood,
or need a more comprehensive plan.
```

- --

## Documenting Results

### For Each Test, Record:

* *1. First Response Analysis**:
- Word count before first question (or before business advice if no questions)
- What appeared first: questions or advice?
- How many business types/options provided before clarification?

* *2. Question Assessment**:
- How many questions asked?
- When did questions appear? (beginning/middle/end)
- Quality: About user context or generic?

* *3. Pattern Classification**:
- ✅ Question-First (CFP working)
- ⚠️ Mixed (questions present but after some content)
- ❌ Solution-First (CFP not working)

* *4. User Experience**:
- How much did user need to read before being asked for input?
- Did user feel guided (good) or presented options (bad)?
- Cognitive load: Low (answer questions) or High (evaluate options)?

- --

## Expected Model Behaviors

### Models We Expect to Pass (With CFP v2.0)

* *Claude Sonnet 4.5**:
- Natural question-asking tendency
- Should ask about skills, budget, timeline upfront
- Likely minimal or no business suggestions before questions

* *GPT-4 Turbo** (non-reasoning):
- Standard iterative pattern
- Should ask clarifying questions before detailed advice
- May provide brief acknowledgment first

* *Gemini Advanced**:
- (Hypothesis: Will ask questions, but need to test)

- --

### Models That May Still Struggle (Hypothesis)

* *GPT-5 (o1-preview)** - Extended Reasoning:
- May still provide comprehensive coverage despite CFP v2.0
- 12-second reasoning might generate "all likely scenarios" internally
- Will test whether strengthened protocol (STOP instruction) works

* *Other Extended Reasoning Models**:
- Same risk as GPT-5
- May need to see test results to refine further

- --

## Success Definition

### Minimum Viable Success

* *CFP v2.0 works if**:
- 70%+ of models ask questions before business advice
- Questions appear in first 100 words of response
- No comprehensive business coverage before user answers

### Ideal Success

* *CFP v2.0 excellent if**:
- 90%+ of models ask questions first
- Questions are targeted (2-3 about user context)
- Explicit wait signal present
- Tailored guidance promised after answers

- --

## Next Steps After Testing

### If Test Passes (Questions First)

1. ✅ Validate CFP v2.0 strengthening worked
2. Document in validation insights
3. Update CFP-TEST-PROMPT.md with business concept test
4. Consider business concept as primary test (model-neutral)

### If Test Fails (Solutions First)

1. Analyze specific failure mode:
   - Questions absent entirely?
   - Questions after business suggestions?
   - Too many business types covered?
2. Identify which part of protocol was ignored:
   - STOP instruction?
   - "prohibited_before_questions" list?
   - Anti-pattern documentation?
3. Further refine based on failure pattern

### Cross-Model Analysis

1. Compare behavior across GPT-5, Claude, Gemini, GPT-4
2. Identify model-specific patterns
3. Determine if universal protocol works or needs model-specific guidance
4. Document findings in validation insights

- --

## Why This Matters for LTF

### Business Concept Test Reveals:

1. **Pure collaboration quality** (no technical skill confounds)
2. **Question-asking behavior** (core of cognitive partnership)
3. **User agency preservation** (guide vs. present)
4. **Intent extraction** (what does user actually need?)
5. **Anti-pattern detection** (comprehensive coverage, solution-defense)

### Long-Term Value:

- Reusable test for any LTF iteration
- Works across all model types
- Tests collaboration, not generation
- Easy to explain to non-technical users
- Clear pass/fail criteria

- --

* *Ready for Testing**

Load this prompt into AI with/without CFP and observe:

1. Do questions come FIRST?
2. Are business suggestions ABSENT until user answers?
3. Does AI wait for user input?

If yes to all three → CFP v2.0 working!
If no → We know exactly what to refine next.
