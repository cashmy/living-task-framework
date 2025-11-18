You said:

_Protocols may have default behaviors (T1), but can, and maybe should, be customized to LLM type (T2/T3)._

I agree 100%, and we can formalize that as:

# Protocol Tiering Model

## T1 – Protocol Intent / Defaults (Model-agnostic)

Semantic purpose

Core constraints

> “What this protocol is for”

Example:

```
Being Heard must always include acknowledgment + interpretation
DOD must prevent both under- and over-expansion
```

## T2 – Model-Type Implementation Layer

How a given LLM family tends to violate or lean

Default biases: verbosity, terseness, caution, eagerness to execute

Concrete implementation knobs specific to GPT-5 vs Codex vs Claude

Example:

```
GPT-5: DOD primarily constrains over-expansion
Codex: DOD may constrain under-explanation and require more validation
```
## T3 – Orchestration / Multi-Model Application

How protocols behave across multiple EnaCs

How Coordinator vs Participant roles interpret the same protocol

How CSAC and cross-session behavior enforce them

Example:

```
In a multi-LLM setup, T3 ensures “Being Heard” is not dropped when context hops across models.
``` 

This gives you a clean way to write future specs like:

- “Being Heard (T1): invariant human-experience rules”
- “Being Heard (T2-Codex): additional safeguards to slow premature execution”
- “Being Heard (T2-GPT-5): additional safeguards to reduce over-meta commentary”
- “Being Heard (T3): orchestration guidelines across EnaCs and sessions”

Which also explains precisely why you were right in your earlier MO:

- “Bare T3 will need LLM-specific defaults or at least awareness notations.”

Exactly.