# CFP Test Prompts

* *Purpose**: Compare AI behavior with and without Cognitive Foundation Primer loaded

* *⚠️ Important Note**: This file contains the original **code-focused test** (dashboard building). For a **model-neutral test** that doesn't bias toward code generation strengths, see **`CFP-TEST-PROMPT-BUSINESS-CONCEPT.md`** - the business startup prompt is better for pure protocol validation.

- --

## Why Two Test Prompts?

### Dashboard Test (This File)

* **Domain**: Web development / code generation
* **Bias**: Favors models strong at code generation
* **What it tests**: CIP-E, VS, DMP + code quality
* **Best for**: Validating full CFP stack with technical users

### Business Concept Test (Recommended for Protocol Validation)

* **Domain**: Business planning / concept guidance
* **Bias**: None - everyone can engage with business concepts
* **What it tests**: Pure clarifying questions protocol
* **Best for**: Cross-model comparison of collaboration patterns
* **File**: `CFP-TEST-PROMPT-BUSINESS-CONCEPT.md`

* *Recommendation**: Use **business concept test** for validating clarifying questions protocol across different models. Use dashboard test for validating full CFP integration in technical domains.

- --

## Test Setup

### Test A: WITHOUT CFP

1. Start fresh AI session (ChatGPT/Claude/etc.)
2. Paste test prompt below
3. Observe response

### Test B: WITH CFP

1. Start fresh AI session
2. Load CFP: Paste entire contents of `01-CORE-PRIMER.md`
3. Wait for AI confirmation
4. Paste same test prompt
5. Observe response

- --

## Test Prompt

```text
I'm building a user dashboard for my app and I'm not sure how to approach it.
We have user data coming from an API and I need to display it in a way that
makes sense. Performance is important but I also want it to look good.
```

- --

## What to Look For

### WITHOUT CFP (Expected Behavior)

* *Typical AI response patterns**:
- Jumps directly to suggesting specific solutions (React components, charts, etc.)
- May suggest ONE approach without exploring alternatives
- Might not ask about constraints or context
- Provides code immediately without clarifying intent
- Doesn't distinguish between "display data" vs "design UX" vs "optimize performance"

* *Common issues**:
- Assumes too much (tech stack, data volume, user needs)
- Solves literally "display data" without understanding deeper goal
- No exploration of tradeoffs
- One-size-fits-all solution

- --

### WITH CFP (Expected Behavior)

* *LTF-aware response patterns**:

1. **CIP-E Intent Extraction**:
   - Asks 2-3 clarifying questions about:
     - Current tech stack (React, Vue, vanilla JS?)
     - Data characteristics (volume, update frequency, structure)
     - "Performance" means what? (load time, real-time updates, large datasets)
     - "Look good" means what? (professional, flashy, minimal, data-dense)

2. **DMP Structure** (likely Hybrid style):
   - META: Acknowledges ambiguity, anchors to dashboard domain
   - DIRECTIVE: Proposes clarifying before solving
   - REFLECTIVE: Considers that "dashboard" could mean many things

3. **VS Suite Awareness**:
   - After clarification, likely offers 2-3 alternative approaches
   - Different tradeoffs (simple vs feature-rich, client vs server rendering)

4. **Behavioral Protocols**:
   - Asks clarifying questions BEFORE suggesting solutions
   - Doesn't hallucinate specific libraries without knowing stack
   - Acknowledges uncertainty about requirements

- --

## Detailed Comparison Matrix

| Aspect | Without CFP | With CFP |
|--------|-------------|----------|
| **First Response** | Provides solution immediately | Asks clarifying questions |
| **Assumptions** | Assumes tech stack, data size, use case | Identifies assumptions, asks for confirmation |
| **Alternatives** | Usually one approach | Multiple approaches after clarification |
| **Intent Recognition** | Literal: "display data" | Deeper: "design effective dashboard UX" |
| **Clarification** | Rare or after wrong solution | Upfront, 2-3 targeted questions |
| **Tradeoffs** | Mentioned briefly if at all | Explicit analysis of pros/cons |
| **Structure** | Unstructured narrative or pure code | Clear sections: questions → options → recommendation |

- --

## Success Criteria

* *CFP is working if AI**:
- ✅ Asks about tech stack before suggesting specific libraries
- ✅ Clarifies what "performance" and "look good" mean to user
- ✅ Identifies ambiguity ("dashboard" is vague)
- ✅ Offers to show alternatives after gathering context
- ✅ Doesn't confidently recommend specific charting library without knowing requirements

* *CFP is NOT working if AI**:
- ❌ Immediately suggests "use React with Chart.js and Material-UI"
- ❌ Provides complete code without asking about context
- ❌ Assumes data characteristics without asking
- ❌ Gives one solution without exploring alternatives

- --

## Sample Expected Responses

### WITHOUT CFP (Typical)

```text
Here's a user dashboard using React and Chart.js:

[Provides complete dashboard code with specific libraries, assumes
data structure, implements charts, tables, cards without asking
about actual requirements]

This gives you a responsive layout with Material-UI components
and real-time charts. The data fetches from your API endpoint...

[Code continues for 50+ lines without confirming if this matches
user's actual needs]
```

- --

### WITH CFP (LTF-Aware)

```text
Before I suggest a dashboard implementation, let me clarify a few things
to make sure I recommend the right approach:

1. **Tech stack**: What are you using? (React, Vue, Angular, vanilla JS,

   or open to suggestions?)

2. **Data characteristics**:
   - How much data? (10 records, 1000s, real-time stream?)
   - Update frequency? (static, polling, WebSocket?)

3. **"Performance" priority**:
   - Initial load time?
   - Handling large datasets?
   - Real-time responsiveness?

4. **"Look good" definition**:
   - Professional/corporate style?
   - Data-dense (lots of info)?
   - Minimal/clean aesthetic?

Once I understand your context, I can show you 2-3 different approaches
with their tradeoffs (simple vs feature-rich, client-heavy vs server-side
rendering, etc.).

What's your current setup?
```

- --

## Advanced Test: Flow State Detection

If you want to test flow state preservation, follow up with rapid ideas:

```text
And I'm thinking we need filters and what if we added export to PDF
and users should be able to save their preferences and maybe dark mode
and real-time updates would be cool and notifications when data changes...
```

* *Expected WITH CFP**:

```text
✓ Filters
✓ PDF export
✓ User preferences (save layout/settings)
✓ Dark mode
✓ Real-time updates
✓ Change notifications

[AI captures without interrupting, then organizes after pause]
```

* *Expected WITHOUT CFP**:

AI likely tries to respond to each idea individually, breaking flow with
questions or implementation details mid-stream.

- --

## Notes

- Run this test with the SAME AI model (GPT-4, Claude, etc.) for fair comparison
- Fresh sessions for each test (avoid context contamination)
- Test B should show significantly more clarification, less assumption
- If both responses look similar, CFP may not have loaded correctly

* *Key success indicator**: Does AI ask questions before solving, or solve before asking?
