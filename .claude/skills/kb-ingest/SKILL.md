---
name: kb-ingest
description: |
  Add source documents to a knowledge base and trigger incremental wiki compilation.
  Use when user says "add this to the KB", "ingest [file]", "add to knowledge base",
  "kb-ingest", or provides a paper/URL/file to add to a topic.
argument-hint: "[file-path or URL] [topic-name]"
allowed-tools: ["Read", "Write", "Edit", "Bash", "Glob", "Grep", "WebFetch"]
---

# Ingest Source into Knowledge Base

Add a source document and incrementally compile it into the wiki.

**Input:** `$ARGUMENTS` — a file path or URL, and a topic name. If topic is omitted and only one KB exists, use that one. If ambiguous, ask.

---

## Steps

### Phase 1: Source Acquisition

1. **Parse arguments** — identify the source (file path or URL) and target topic.

2. **Verify the KB topic exists:**
   - Check for `kb/[topic]/META.md`
   - If not found, suggest running `/kb-init [topic]` first

3. **Acquire the source based on type:**

   **URL:**
   - Use WebFetch with Jina Reader: `https://r.jina.ai/[url]` for clean markdown
   - If Jina fails, fall back to direct WebFetch and clean up the HTML
   - Save as `kb/[topic]/raw/[slugified-title].md`
   - Download any key images referenced in the article to `kb/[topic]/raw/`

   **PDF (local file):**
   - Use Read tool to read the PDF (up to 20 pages per call; loop for longer docs)
   - Save extracted text as `kb/[topic]/raw/[filename].md`
   - Keep the original PDF in `raw/` too (for reference)

   **Local markdown/text file:**
   - Copy directly to `kb/[topic]/raw/[filename].md`

   **Other files (images, data, code):**
   - Copy to `kb/[topic]/raw/`
   - Note the type in the manifest

4. **Update the manifest** (`kb/[topic]/raw/.manifest.md`):
   - Add a row: `| # | [source name] | [type] | [today's date] | [one-line description] |`
   - Increment the row number

### Phase 2: Incremental Compilation

5. **Generate source summary:**
   - Read the acquired source content
   - Create `kb/[topic]/wiki/summaries/[source-name].md` following `templates/kb-summary.md`
   - Include: type, authors, key takeaways, detailed summary, methodology, limitations, BibTeX if applicable

6. **Extract concepts:**
   - Identify 3-10 key concepts from the source
   - For each concept, check if `kb/[topic]/wiki/concepts/[concept-name].md` exists:
     - **If new:** Create the concept article from `templates/kb-concept.md`
     - **If exists:** Read existing article, add this source to the `## Sources` section, update Key Points and Details if the new source adds information. **Preserve the `## Notes` section.**

7. **Identify connections:**
   - Check if this source connects concepts that weren't previously linked
   - If a significant cross-cutting theme emerges (spanning 3+ concepts), create or update a connection article in `kb/[topic]/wiki/connections/`

8. **Update INDEX.md:**
   - Read current `kb/[topic]/wiki/INDEX.md`
   - Add new concepts to the `## Concepts` section (alphabetical, with one-line descriptions)
   - Add the source to the `## Sources` section
   - Update counts (Sources, Concepts, Connections)
   - Add entry to `## Recent Changes`
   - Update `Last Updated` date

### Phase 3: Report

9. **Report to user:**
   - Source added: [name, type]
   - Summary created: [path]
   - Concepts created/updated: [list with paths]
   - Connections identified: [if any]
   - Current KB stats: [X sources, Y concepts, Z connections]
   - Suggest: "Add more sources with `/kb-ingest` or compile the full wiki with `/kb-compile`"

---

## Important Notes

- Always preserve `## Notes` sections when updating existing articles
- Use relative links between wiki articles (e.g., `../concepts/foo.md`)
- Keep summaries factual — attribute claims to their source
- If a PDF is too long to read in one pass, read it in chunks and synthesize
- For BibTeX: extract from the paper if available, otherwise construct from metadata
