# How to Use the Cognitive Foundation Primer (CFP) v2.1

* *Purpose**: Step-by-step guide for loading and using CFP to achieve optimal AI collaboration
* *Audience**: Anyone using AI assistants (ChatGPT, Claude, Gemini, etc.)
* *Time to setup**: 2 minutes
* *Result**: 90% reduction in cognitive load, 100% increase in solution specificity

- --

## Quick Start (2 Minutes)

### Step 1: Load the CFP Document

* *Option A - File Upload** (Recommended):
1. Download `01-CORE-PRIMER.md` from the repository
2. Start a new AI session (fresh conversation)
3. Upload/attach the file to the AI

* *Option B - Copy/Paste**:
1. Open `01-CORE-PRIMER.md`
2. Copy the entire contents
3. Start a new AI session
4. Paste the contents into the chat

- --

### Step 2: Send the Ready Signal

* *Type exactly**:

```text
Please ingest the document and let me know when you are ready
```

* *Alternative phrasing** (also works):
- "Let me know when you're ready"
- "Confirm when you've processed this"
- "Ready?"

- --

### Step 3: Wait for Confirmation

* *What to expect**:

✅ **Good Response Pattern**:

```text
✅ I've successfully ingested the Cognitive Foundation Primer (CFP)...

[May include brief summary of frameworks: CIP-E, DMP, VS Suite...]

I'm ready for your next instruction.
```

* *Key indicators**:
- ✅ Explicit confirmation ("I've ingested," "I'm ready")
- ✅ May mention framework names (CIP-E, DMP, VS Suite)
- ✅ Brief, not verbose

⚠️ **Unclear Response** (if this happens):

```text
Okay, I've read that. What would you like to do?
```

* *If you get unclear response**:
- Try: "Confirm you understand the CIP-E framework"
- AI should explicitly reference the five components

- --

### Step 4: Ask Your Question

Now ask your actual question/request as you normally would:

* *Examples**:
- "I want to start my own business but I'm not sure where to begin..."
- "Help me architect a user dashboard for my app..."
- "I need to refactor this code but not sure the best approach..."

- --

## What to Expect

### Immediate Response Pattern

✅ **Correct CFP Behavior**:

```text
[Brief acknowledgment - 1-2 sentences]

Let me ask a few questions:

1. [Targeted question based on your request]
2. [Targeted question based on your request]
3. [Targeted question based on your request]

Once I know these, I'll [preview what comes next].
```

* *Characteristics**:
- Questions come FIRST (immediately after brief ack)
- No comprehensive guides before questions
- No solution previews or examples before questions
- Clear stop (waits for your answers)

- --

❌ **Incorrect Behavior** (framework not fully activated):

```text
[Extended introduction]

Here's a comprehensive guide:

1. [Step 1]
2. [Step 2]

...

Here are some common approaches:

- Option A...
- Option B...

By the way, what's your [question]?
```

* *What's wrong**:
- Solutions/guides before questions
- Questions come last (buried in content)
- High cognitive load (must read before engaging)

* *If this happens**: See Troubleshooting section below

- --

### After You Answer Questions

✅ **Expected Pattern**:

The AI will:

1. **Synthesize your answers** into a coherent profile
2. **Acknowledge key advantages** from your context
3. **Provide 2-3 tailored options** specific to your situation
4. **Include relevant details** (margins, timelines, tradeoffs)
5. **Offer next-step collaboration** (dive deeper on chosen option)

* *Example**:

```text
Based on what you've shared — [synthesis of your answers] —
you're positioned perfectly for [specific insight].

Here are three tailored options:

1. [Option 1]

   Startup fit: [Why this fits YOUR situation]
   How it works: [Specific to YOUR context]
   Transition path: [Based on YOUR goals]
   Margins: [Specific numbers]

2. [Option 2]

   ...

3. [Option 3]

   ...

Next steps: [Specific collaboration offers]

Which direction sounds most aligned with [YOUR stated goal]?
```

* *Key quality indicators**:
- References YOUR specific answers (not generic)
- Recognizes YOUR unique advantages
- Options tailored to YOUR constraints
- Next steps continue collaboration

- --

## Best Practices

### Do's ✅

* *1. Use Ready Signal Every Session**
- Start each new conversation with ready signal
- Ensures META state established
- Prevents state collapse

* *2. Answer Questions Fully**
- Provide specific details, not vague responses
- Example: "Skills: junk removal, landscaping, snow removal" (good)
- Not: "Service work" (too vague)

* *3. Pick an Option and Dive Deeper**
- After AI provides alternatives, choose one
- Ask for specific next steps (90-day plan, cost projections, etc.)
- Framework supports multi-turn collaboration

* *4. Use for Ambiguous Requests**
- Architecture decisions ("Should I use X or Y?")
- Exploratory questions ("How do I approach Z?")
- Complex decisions with multiple variables

* *5. Trust the Questions**
- If AI asks 3 questions, answer them directly
- Don't jump ahead to solutions
- Questions extract information needed for optimal generation

- --

### Don'ts ❌

* *1. Don't Skip Ready Signal**
- Loading CFP + prompt in same message = sub-optimal
- Simultaneous processing can cause incomplete META anchoring
- Takes 5 seconds, prevents state collapse

* *2. Don't Use for Simple Queries**
- "What's the syntax for Python list comprehension?" → No CFP needed
- "Explain how async/await works" → No CFP needed
- Save CFP for ambiguous, exploratory, or multi-faceted requests

* *3. Don't Expect Framework Visibility**
- You won't see "CIP-E extraction" displays
- Framework works internally (guides questions)
- Clean output = framework working correctly

* *4. Don't Give Vague Answers**
- Questions are targeted for a reason
- Vague answers = generic solutions
- Specific answers = hyper-tailored solutions

* *5. Don't Evaluate Multiple Sessions' Worth**
- CFP establishes collaboration for THIS session
- Next session = load CFP again with ready signal
- Don't assume framework persists across new conversations

- --

## Troubleshooting

### Problem: Questions Don't Come First

* *Symptom**:
- AI provides guide/framework/examples
- Questions appear at end or buried in content

* *Possible Causes**:
1. Ready signal skipped (CFP + prompt simultaneous)
2. Model hasn't fully internalized protocol
3. Your request was too specific (no ambiguity to clarify)

* *Solutions**:
- Try: "Please ask clarifying questions before providing solutions"
- Reload CFP with proper ready signal in new session
- If request is very specific, questions may not be needed

- --

### Problem: Generic Solutions (Not Tailored)

* *Symptom**:
- Solutions don't reference your specific answers
- Advice could apply to anyone
- No synthesis of your unique situation

* *Possible Causes**:
1. Answers were too vague
2. Framework not fully activated
3. Model reverted to default behavior

* *Solutions**:
- Provide more specific answers to questions
- Explicitly reference CFP: "Using CIP-E framework, generate tailored options based on my specific situation"
- Try in new session with ready signal

- --

### Problem: CIP-E Framework Displayed

* *Symptom**:

```text
Let's clarify your starting point (CIP-E Foundation):
Context: [breakdown]
Intent: [breakdown]
Purpose: [breakdown]
...
```

* *This is actually okay** if:
- It's brief (3-4 lines)
- Questions come immediately after
- Not extensive display

* *This is problematic** if:
- Extensive extraction (10+ lines)
- Questions buried after framework
- Multiple sections before questions

* *Solution**:
- Say: "Please use CIP-E internally to guide questions, but don't display the extraction"
- Framework should inform question selection, not be shown to user

- --

### Problem: No Framework Awareness

* *Symptom**:
- AI doesn't mention CFP/LTF/CIP-E
- Behaves like default (no framework)
- No structural changes in responses

* *Possible Causes**:
1. Document didn't load properly
2. Ready signal not sent
3. Model didn't recognize framework

* *Solutions**:
- Verify CFP uploaded/pasted correctly
- Re-send ready signal
- Explicitly ask: "Confirm you have the LTF Cognitive Foundation Primer loaded"
- Try in fresh session

- --

### Problem: Too Many Questions

* *Symptom**:
- AI asks 6-10+ questions
- Feels like interrogation, not collaboration

* *Cause**:
- Over-application of questions-first protocol
- Request may be extremely ambiguous

* *Solution**:
- Answer first 3-4 most important questions
- Say: "Let's start with these answers and refine from there"
- CFP targets 2-3 questions, not exhaustive inquiry

- --

## Advanced Usage

### Multi-Session Projects

* *Pattern**:

```text
Session 1: Load CFP → Explore options → Choose direction
Session 2: Load CFP → Reference previous decision → Dive deeper
Session 3: Load CFP → Continue building on previous sessions
```

* *Important**: Load CFP at START of each session (with ready signal)

* *Evolution Component**: CFP's Evolution (Ev) component captures session continuity
- Mention previous sessions: "In our last session, we chose Option 2..."
- AI will build on that: "Building on your junk removal business from yesterday..."

- --

### Combining with VS Suite (Verbalized Sampling)

* *After AI provides alternatives**, you can:

* *Request VS (More Variations)**:
- "Show me 3 more variations on Option 2"
- AI generates alternative approaches to same option

* *Request VSyn (Synthesize)**:
- "I like the pricing model from Option 1 and the transition path from Option 3. Synthesize these."
- AI combines best elements from multiple options

* *Request VcS (Continue Sampling)**:
- "Continue exploring variations on the property services brand idea"
- AI keeps generating creative alternatives

- --

### Emotional Co-Regulation

* *If you're feeling**:
* **Overwhelmed**: Say so! "I'm feeling overwhelmed, can you simplify?"
  - AI will adapt: Break down, validate, offer smaller steps
* **Frustrated**: "I'm stuck and frustrated with this approach"
  - AI will adapt: Contextual reset, step back, reframe
* **Confident/Excited**: "I'm excited about this, let's move fast"
  - AI will adapt: Match energy, build on momentum

* *Why this works**: CFP's Emotion component treats emotional state as control vector (not noise)

- --

### Mode Switching (DMP)

* *Directive Mode** (when you know what you want):
- "Create a 90-day launch plan for the junk removal business"
- "Generate pricing table for three service tiers"

* *Reflective Mode** (when exploring):
- "What are the tradeoffs between Options 1 and 2?"
- "What am I not considering about this approach?"

* *META Preservation**: You can switch between modes freely without losing context (this is DMP's core innovation)

- --

## Common Use Cases

### 1. Architecture Decisions

* *Request**:

```text
Load CFP → Ready signal →
"I need to build an API for my app but not sure which approach to use"
```

* *Expected Flow**:
- AI asks: Tech stack? Scale? REST vs GraphQL vs gRPC?
- You answer specifically
- AI provides 2-3 architectures tailored to YOUR answers

- --

### 2. Code Refactoring

* *Request**:

```text
Load CFP → Ready signal →
"This component is too complex (500 lines) and I want to refactor it"
```

* *Expected Flow**:
- AI asks: What are you optimizing for? Tech stack? Any constraints?
- You answer
- AI provides refactoring strategies specific to your priorities

- --

### 3. Learning/Explanation

* *Request**:

```text
Load CFP → Ready signal →
"Help me understand how database indexing works"
```

* *Expected Flow**:
- AI asks: Current knowledge level? Use case? Preferred learning style?
- You answer
- AI provides explanation tailored to YOUR learning needs

- --

### 4. Business/Strategy

* *Request**:

```text
Load CFP → Ready signal →
"I want to start a business but not sure where to begin"
```

* *Expected Flow**:
- AI asks: Skills? Budget? Involvement level?
- You answer
- AI provides business types tailored to YOUR situation

- --

## Success Metrics

* *You'll know CFP is working when**:

✅ **Questions come first** (before solutions/guides)
✅ **Low cognitive load** (simple questions, not reading assignments)
✅ **Hyper-tailored solutions** (reference YOUR specific situation)
✅ **High user agency** (you guide, AI executes)
✅ **Seamless collaboration** (can switch modes without losing context)

* *Specific indicators**:
- "Based on what you've shared..." (synthesis of your answers)
- "You're positioned perfectly for..." (recognizes your advantages)
- "Use your [specific asset] immediately..." (references your context)
- Each option includes details relevant to YOUR goals

- --

## FAQ

### Q: Do I need to load CFP for every conversation?

* *A**: Yes. Each new session = fresh CFP load with ready signal.

### Q: Can I modify CFP for my specific needs?

* *A**: Yes! CFP configuration section allows customization (DMP style, question count, etc.)

### Q: What if my AI doesn't support file uploads?

* *A**: Copy/paste the full CFP text works equally well.

### Q: Does this work with models other than GPT-5?

* *A**: Yes. Tested successfully with GPT-4, Claude Sonnet, and others.

### Q: How do I know if ready signal worked?

* *A**: AI explicitly confirms ("I'm ready") and may reference frameworks.

### Q: Can I use CFP for multi-turn conversations?

* *A**: Yes! CFP's Evolution component supports session continuity and pattern learning.

### Q: What if AI shows CIP-E extraction?

* *A**: Brief display (3-4 lines) before questions is okay. Extensive display (10+ lines) means protocol not fully internalized — ask AI to use CIP-E internally only.

### Q: Is CFP overkill for simple questions?

* *A**: Yes. Save CFP for ambiguous, exploratory, or complex requests.

### Q: What's the difference between CFP v2.0 and v2.1?

* *A**: v2.1 corrected CIP-E framework (5 components: Context, Intent, Purpose, Emotion, Evolution) and strengthened questions-first protocol (CIP-E internal, not external).

- --

## Next Steps

1. **Try it now**: Load CFP → Ready signal → Ask ambiguous question
2. **Observe pattern**: Questions first? Tailored solutions? High agency?
3. **Iterate**: Use for different request types, observe quality improvements
4. **Share feedback**: Help us refine CFP for even better collaboration

- --

## Support & Resources

* **Full Documentation**: `01-CORE-PRIMER.md`
* **Validation Results**: `2025-11-10-no-cfp-vs-cfp-v2.1-final-comparison.md`
* **Article**: `2025-11-10-the-90-percent-reduction-article.md`
* **Community**: [Repository link]

- --

* *Living Task Framework** | Making AI collaboration effortless
* Questions first, solutions tailored, agency maintained*
