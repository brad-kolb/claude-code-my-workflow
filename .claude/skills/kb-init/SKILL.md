---
name: kb-init
description: |
  Initialize a new knowledge base topic directory with the full raw/ + wiki/ scaffold.
  Use when user says "create a knowledge base", "new KB topic", "start a wiki on [topic]",
  "kb-init", or wants to begin collecting research on a new area.
argument-hint: "[topic-name in kebab-case]"
allowed-tools: ["Read", "Write", "Bash", "Glob"]
---

# Initialize Knowledge Base

Create a new knowledge base topic with the standard directory structure.

**Input:** `$ARGUMENTS` — a topic name in kebab-case (e.g., `causal-inference`, `climate-economics`).

---

## Steps

1. **Parse topic name** from `$ARGUMENTS`. Convert to kebab-case if not already. Validate it is a reasonable directory name (no spaces, no special characters beyond hyphens).

2. **Check if topic already exists:**
   - Glob for `kb/$TOPIC/META.md`
   - If exists, inform user and stop

3. **Check if this is the first KB topic:**
   - Glob for `kb/README.md`
   - If not found, create `kb/README.md` from `templates/kb-readme.md`
   - If not found, create `kb/.kb-config.md` from `templates/kb-config.md`

4. **Create directory scaffold:**
   ```
   kb/[topic]/
   ├── META.md
   ├── raw/
   │   └── .manifest.md
   └── wiki/
       ├── INDEX.md
       ├── concepts/
       ├── summaries/
       ├── connections/
       └── outputs/
   ```

   Use Bash to create directories:
   ```bash
   mkdir -p kb/[topic]/raw kb/[topic]/wiki/concepts kb/[topic]/wiki/summaries kb/[topic]/wiki/connections kb/[topic]/wiki/outputs
   ```

5. **Create META.md** from `templates/kb-meta.md`:
   - Replace `[TOPIC NAME]` with the formatted topic name (Title Case)
   - Replace `[DATE]` with today's date
   - Ask the user for a brief description if not obvious from the topic name

6. **Create raw/.manifest.md:**
   ```markdown
   # Source Manifest

   Auto-maintained by `/kb-ingest`. Do not edit manually.

   | # | Source | Type | Date Added | Summary |
   |---|--------|------|------------|---------|
   ```

7. **Create wiki/INDEX.md:**
   ```markdown
   # [Topic Name] — Knowledge Base Index

   *Auto-maintained by `/kb-compile` and `/kb-ingest`. Do not edit manually.*

   **Sources:** 0 | **Concepts:** 0 | **Connections:** 0 | **Last Updated:** [DATE]

   ## Concepts

   *No concepts yet. Use `/kb-ingest` to add source documents.*

   ## Sources

   *No sources yet.*

   ## Recent Changes

   - [DATE] — Knowledge base initialized
   ```

8. **Report to user:**
   - Confirm the KB was created
   - Show the directory structure
   - Suggest next steps: `/kb-ingest [file-or-url] [topic]`
