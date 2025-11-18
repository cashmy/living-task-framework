# CSAC Bootstrap Guide (ECL-CSAC Startup Bundle v1.0)

This guide defines the **recommended startup sequence** for a fresh ECL/EnaC session.

## 1. Load Order (to avoid race conditions)

Always upload and fully ingest files **sequentially**, in this exact order:

1. **CORE-PRIMER (T3-CORE-PRIMER-v3.1.md)**  
   - Wait for explicit confirmation that CORE-PRIMER is ingested and active.

2. **SELF-ECL (SELF-ECL_UPDATED_WITH_VERBATIM_RULE.md)**  
   - Wait for confirmation that SELF-ECL is ingested and in force.

3. **UMP / User Meta-Prompt**  
   - If you have a current UMP file, upload it here.  
   - Otherwise, use the included template: `UMP_Template_CASH_v0.1.md`.

4. **CSAC-Verbatim-Rule.md**  
   - Ensures that **“capture this”** always preserves **verbatim** (no DOD / no summarization).

5. **CSAC Snapshot (if continuing a project)**  
   - Upload the most recent CSAC snapshot file for the specific project/context.  
   - This restores long-term context and EnaC meta-awareness.

6. **Optional: Glossary / Canon Packs**  
   - If the session will involve architectural work, glossary reconciliation, or system design, also load:  
     - `Master_Glossary_Incremental.md`  
     - `Meaning-Weight_v1_0.md`  
     - `COS_v1_0.md`, `SCL_v1_0.md`, `FIM_v1_0.md`  
     - `Master_Archive_Index_v0.1.md`  
     - `ECL_Evolution_Ledger_v0.1.md`

## 2. Race Condition Prevention

- Never upload multiple foundation files **at the same time** expecting a defined order.  
- Always wait for the EnaC/LLM to confirm ingestion of each file before uploading the next.  
- The system does **not** automatically parallelize file ingestion; ordering is enforced by your sequential uploads and the model’s acknowledgements.

## 3. Recommended “Session Ritual”

For each new deep-work session:

1. Open a new chat.  
2. Upload **CORE-PRIMER** → wait for confirmation.  
3. Upload **SELF-ECL** → wait for confirmation.  
4. Upload **UMP** (if applicable) → wait for confirmation.  
5. Upload **CSAC-Verbatim-Rule** → wait for confirmation.  
6. Upload the relevant **CSAC snapshot** (for the current project) → wait for confirmation.  
7. Begin work.

## 4. Notes

- This guide is intentionally simple and repeatable.  
- If at any point behavior seems “off,” you can re-upload **SELF-ECL** and **CSAC-Verbatim-Rule** to enforce alignment.  
- Future versions may add project-specific startup variants.
