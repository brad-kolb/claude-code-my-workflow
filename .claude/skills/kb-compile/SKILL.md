---
name: kb-compile
description: |
  Compile or incrementally update the wiki from raw sources in a knowledge base topic.
  Use when user says "compile the wiki", "rebuild KB", "update knowledge base",
  "kb-compile", or after adding multiple sources and wanting a full recompilation.
argument-hint: "[topic-name] [--full|--incremental]"
allowed-tools: ["Read", "Write", "Edit", "Bash", "Glob", "Grep"]
context: fork
---

# Compile Knowledge Base Wiki

Full or incremental compilation of the wiki from raw sources.

**Input:** `$ARGUMENTS` — topic name and optional mode flag. Default: `--incremental`.

---

## Steps

### Phase 0: Setup

1. **Parse arguments** — extract topic name and mode (`--full` or `--incremental`).

2. **Verify the KB topic exists:**
   - Check for `kb/[topic]/META.md`
   - If not found, list available topics and stop

3. **Read the manifest** (`kb/[topic]/raw/.manifest.md`) to get the full source inventory.

4. **Read current INDEX.md** to understand what's already compiled.

### Phase 1: Identify Work

5. **Incremental mode (default):**
   - Compare manifest entries against existing summaries in `wiki/summaries/`
   - Identify sources that have no summary (new) or whose raw file is newer than the summary
   - Only process these sources

6. **Full mode (`--full`):**
   - Process ALL sources in the manifest
   - Regenerate all summaries, concept articles, and connections from scratch
   - Preserve `## Notes` sections from existing articles

### Phase 2: Process Sources

7. **For each source to process:**
   a. Read the raw source from `kb/[topic]/raw/`
   b. Generate or regenerate `wiki/summaries/[source-name].md` per `templates/kb-summary.md`
   c. Extract key concepts (3-10 per source)
   d. For each concept:
      - **New concept:** Create `wiki/concepts/[concept-name].md` per `templates/kb-concept.md`
      - **Existing concept:** Update with new information from this source. Add to Sources section. Preserve `## Notes`.
   e. Track all concept-to-concept and concept-to-source relationships

### Phase 3: Connections

8. **Analyze cross-cutting themes:**
   - Read all concept articles
   - Identify themes that span 3+ concepts
   - For each theme, create or update `wiki/connections/[theme-name].md`
   - Include: theme description, which concepts connect, how they relate, implications
   - Link back to relevant concept articles and source summaries

### Phase 4: Rebuild Index

9. **Regenerate `wiki/INDEX.md`:**

   ```markdown
   # [Topic Name] — Knowledge Base Index

   *Auto-maintained by `/kb-compile` and `/kb-ingest`. Do not edit manually.*

   **Sources:** [N] | **Concepts:** [N] | **Connections:** [N] | **Last Updated:** [DATE]

   ---

   ## Concepts

   | Concept | Category | Sources | Description |
   |---------|----------|---------|-------------|
   | [Name](concepts/name.md) | [cat] | [N] | [one-line] |
   ...

   ## Connections

   | Theme | Concepts Involved | Description |
   |-------|-------------------|-------------|
   | [Theme](connections/theme.md) | [list] | [one-line] |
   ...

   ## Sources

   | # | Source | Type | Date | Concepts |
   |---|--------|------|------|----------|
   | 1 | [Title](summaries/name.md) | [type] | [date] | [concept links] |
   ...

   ## Recent Changes

   - [DATE] — [Description of what changed]
   ...
   ```

### Phase 5: Report

10. **Report compilation results:**
    - Mode: incremental or full
    - Sources processed: [N new, M updated]
    - Concepts: [N new, M updated, total T]
    - Connections: [N new, M updated]
    - Any issues found (missing sources, broken references)
    - Suggest: `/kb-lint [topic]` for deeper health check

---

## Important Notes

- **Always preserve `## Notes` sections** — these contain human annotations
- In full mode, read existing `## Notes` before overwriting, and restore them after
- Use relative links throughout the wiki
- Keep concept articles focused — one concept per article
- Connection articles should add analytical value, not just list related concepts
- If a source is very long (>50 pages), summarize in sections rather than one monolithic summary
