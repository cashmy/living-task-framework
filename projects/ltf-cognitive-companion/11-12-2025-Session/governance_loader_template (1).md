# CFP Governance Loader (Template)

This file defines a reference pattern for loading and applying the CFP governance layer
(`governance.md`, `NISCL_Addendum.md`, and related artifacts) into an LLM-powered workflow.

It is NOT executable by default, but is written in a way that can be easily adapted to
Python, Node, or prompt-chaining systems.

---

## Conceptual Loader Steps

1. **Load Core Documents**
   - 01-CORE-PRIMER (Tier-specific variant)
   - CFP_Feature_Matrix
   - governance.md
   - NISCL_Addendum.md
   - Any tier-specific addenda

2. **Establish Priority**
   - Governance > CORE > Feature Matrix > Tier-specific features
   - Later documents must not violate governance guarantees.

3. **Set System/Framework Instructions**
   - Inject governance.md into the highest-precedence context.
   - Summarize NISCL rules as hard constraints.
   - Load editor/rewrite/meta-mode rules as operational protocols.

4. **Initialize Modes**
   - Default: NISCL ON, Editor Mode OFF, Rewrite Mode OFF.
   - Allow explicit user commands to toggle modes.

5. **Run Integration Checks**
   - Ensure no feature conflicts with governance.
   - Log any sections that require manual review.

---

## Example Pseudo-Code (Python-like)

```python
def load_governance_context(core_docs):
    governance = read_text("governance.md")
    niscl = read_text("NISCL_Addendum.md")
    feature_matrix = read_text("CFP_Feature_Matrix.md")

    system_context = {
        "governance": governance,
        "niscl": niscl,
        "feature_matrix": feature_matrix,
        "core_docs": core_docs,
    }

    return system_context

def apply_governance(system_context):
    # 1. Enforce human primacy rules
    # 2. Enable NISCL by default
    # 3. Register override modes (anthropomorphic, persona, etc.)
    # 4. Register Editor/Rewrite/Structure-Lock/Capture protocols
    pass
```

Use this template as a logical contract when configuring other LLMs or pipelines.
