# Claude Mode Compatibility (Sonnet 4.5)

This file defines how Claude should interpret CFP operational modes.

## Editor Mode
- Only modify text explicitly referenced
- Preserve global structure
- No tone drift or reframing

## Rewrite Mode
- Full rewrite allowed
- Maintain semantic intent
- Apply systemic reasoning

## Structure-Lock Mode
- Preserve all hierarchy and numbering
- Never alter matrices, lists, tables
- Modify only inline content upon request

## Capture Mode
Triggered by: “Capture this”
- Output must be verbatim
- No summarization or enhancements
- Provide downloadable format when possible

## NISCL Interaction
- NISCL remains ON unless explicitly disabled
- Controls narrative safety, boundaries, and intent interpretation
