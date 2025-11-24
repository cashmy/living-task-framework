# GlossRP v2.1 -- Invariants

1.  **GlossRP Is the Canonical Source of Semantic Terms**

-   All term meanings, versions, embeddings, and category labels
    originate from GlossRP.
-   No other subsystem may reinterpret or extend a term's definition.

2.  **GlossRP Operates Entirely at ECL-BASE**

-   Provides semantic matter, not semantic structure.
-   Does not evolve, interpret, infer, compile, or graph anything.

3.  **GlossRP Is Deterministic and Stateless at Retrieval Time**

-   Identical inputs → identical outputs.
-   Retrieval modes strictly: Single Term, Vector Bundle, Category
    Retrieval.

4.  **GlossRP Does Not Create Relationships**

-   Stores only what TermSpecs explicitly define.
-   Must not infer or expand relationships.

5.  **GlossRP Owns the TermSpec Ingestion Pipeline**

-   Markdown TermSpecs are the human capture surface.
-   Ingestion parses and stores them in the DB.

6.  **GlossRP Exposes a Single Microservice Boundary**

-   Ingestion + storage + retrieval appear as one cohesive service.

7.  **Other Subsystems Must Access Terms Only Through GlossRP**

-   No subsystem touches the DB directly.

8.  **GlossRP Stores All Term Versions Explicitly**

-   Version is a first-class field.

9.  **GlossRP Is Non-Interpretive**

-   Forbidden to adjust meaning, compute drift, apply tier logic.

10. **GlossRP Must Be Implementation-Agnostic at the Interface Level**

-   Stable API; internal DB engine swappable.

11. **GlossRP Must Be DRY and Thin**

12. **GlossRP Must Not Implement Any ECL-CORE Behavior**

-   No transformations or contextualization.
