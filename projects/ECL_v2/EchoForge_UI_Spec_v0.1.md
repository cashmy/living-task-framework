# EchoForge UI Specification

## Version 0.1 --- Human Interaction Layer

### Status: Draft (Architecture-Aligned, Tier-Blended UI/UX)

------------------------------------------------------------------------

# 1. PURPOSE

The EchoForge UI provides the **human interaction layer** for navigating
the cognition-to-architecture flow.\
Its purpose is to allow the human user to:

-   Capture thoughts (audio/text/file)\
-   Review and curate entries\
-   Understand meaning through classifications\
-   Choose actions (feedback, reframing, tasking, LTF, MxVA, coding)\
-   Navigate concepts and categories fluidly\
-   Maintain a seamless ECL-SKY → CORE → BASE integration

The UI intentionally **blends tiers** (T1--T3) to ensure a frictionless
cognitive workflow while preserving architectural purity in the
underlying system.

------------------------------------------------------------------------

# 2. HIGH-LEVEL UI STRUCTURE

    Left Navigation       Main Workspace                  Right Panel
    ────────────────      ───────────────────────────     ───────────────────────────
    EchoForge             Entries Table /                 Entry Preview /
      • Inbox/Entries       Classification Browser /       Concept Detail /
      • Concepts            Concept Workspace              Action Options
      • Actions

The UI supports three core modes:

1.  **Entries Mode**\
2.  **Classification/Concept Mode**\
3.  **Concept/Action Workspace Mode**

All three are visually consistent and navigable via tabs or left-nav.

------------------------------------------------------------------------

# 3. ENTRIES MODE (Entry = "what came in")

## 3.1 Entries Table

A spreadsheet-like UI for managing inbound material.

### Columns

-   Status icon (new, normalized, analyzed, actioned)\
-   Timestamp\
-   Source type (audio/text/file icons)\
-   Summary preview (1--2 lines)\
-   Category (if classified)\
-   Concept count\
-   Last action

### Row Interactions

-   Click row → opens preview in right panel\
-   Hover actions:
    -   Edit summary\
    -   Reprocess source\
    -   Re-run SCS classification\
    -   Open in Concept Workspace

### CRUD

-   **New Entry**
    -   Record audio\
    -   Paste text\
    -   Upload file\
    -   Import from watched folder\
-   **Update**: edit metadata, re-trigger pipeline\
-   **Delete/Archive**: soft delete

### Preview Panel (Right Side)

Displays:

-   Summary\
-   Short description\
-   Verbatim text (expandable)\
-   Audio playback\
-   Source file links\
-   Reprocess button

------------------------------------------------------------------------

# 4. CLASSIFICATION MASTER MODE

(Concept = "what it means")

## 4.1 Category Browser

A tree or tile-based dashboard of all classification groups.

### Category Tile Elements

-   Category name\
-   Icon\
-   Short description\
-   Number of concepts\
-   Number of linked entries

### Category Interactions

-   Drill down into subcategories\
-   Expand classification hierarchy\
-   Edit category\
-   Create new category\
-   Merge / delete categories

## 4.2 Concept Cards

Displayed when a category is selected.

Each card includes:

-   Title\
-   Summary\
-   Tags\
-   Evolution status (via LTF)\
-   Link: "Show related entries"\
-   Link: "Open in Concept Workspace"

## 4.3 Concept Detail Side Panel

Shows:

-   Full metadata\
-   Keywords\
-   Icon/image\
-   Semantic neighbors\
-   Small relationship graph

------------------------------------------------------------------------

# 5. CONCEPT/ACTION WORKSPACE

(Actions = "what we might do")

### Layout

    ┌──────────────────────┬─────────────────────────┬─────────────────────────────┐
    │ Source & Summary     │ Concept Metadata        │ Action Options              │
    └──────────────────────┴─────────────────────────┴─────────────────────────────┘

------------------------------------------------------------------------

## 5.1 Source & Summary Panel (Left)

-   Title (editable)\
-   Summary (editable)\
-   Verbatim text viewer\
-   Original file links\
-   Key phrase highlights

------------------------------------------------------------------------

## 5.2 Concept Metadata (Center)

-   Category\
-   Topic type\
-   Tags\
-   Keywords\
-   Icon / image preview\
-   Related concepts list\
-   Semantic mini-graph

Future LTF-enhanced display:

-   Evolution timeline\
-   Linked threads\
-   Framework participation

------------------------------------------------------------------------

## 5.3 Action Options Panel (Right)

A stack of **Action Cards** grouped into six sections:

### A. Feedback & Clarification

-   Ask clarifying questions\
-   Assess clarity/completeness\
-   Identify missing components

### B. Reframing & Insight

-   Atomic reframe (tight scope)\
-   Cross-context reframe (vector-based)\
-   Silver-thread insight

### C. Research

-   Build research brief\
-   Generate structured inquiry

### D. Tasks & External Systems

-   Create ToDo (Notion/Trello/GitHub)\
-   Assign due dates\
-   Attach subtasks\
-   Link to relevant entries

### E. Evolution / LTF

-   Add to LTF evolution queue\
-   Create new thread\
-   Connect to existing thread

### F. Architecture / MxVA / Coding

-   Send to MxVA Architecture Review\
-   Generate coding spike (C2CB)\
-   Prepare prompt bundle for coding LLM

Each card includes:

-   Description\
-   Preview of generated prompt\
-   "Execute" button

------------------------------------------------------------------------

# 6. SEARCH & VECTOR UX

### Global Search Bar

Supports: - Keyword search\
- Natural-language search\
- Concept-like search ("find that idea about...")

### Result Grouping

-   Entries\
-   Concepts\
-   Actions / decisions

### Filters

-   Category\
-   Timespan\
-   Source type\
-   Concept evolution status

### Special Search

"Show evolution of this idea" → LTF timeline view.

------------------------------------------------------------------------

# 7. MINI-ECL WITHIN UI

The UI explicitly manifests:

    BASE  → Entries
    CORE  → Concepts (via SCS)
    SKY   → Actions (via LTF/MxVA)

This ensures:

-   intuitive human flow\
-   cognitive resonance\
-   minimal context-switching cost\
-   seamless movement across tiers

------------------------------------------------------------------------

# 8. FUTURE FEATURES

-   Vector-based Concept Map\
-   AI-assisted category merging\
-   Session-level context views\
-   Cross-system dashboards\
-   Voice-controlled UI mode

------------------------------------------------------------------------

# 9. STATUS

EchoForge UI Specification v0.1 provides:

-   complete structural layout\
-   component walls\
-   user flows\
-   interface responsibilities

This is ready for decomposition into wireframes or direct front-end
prototyping by a coding LLM.
