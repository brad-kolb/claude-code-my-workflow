---
name: kb-query
description: |
  Ask questions against a compiled knowledge base wiki. LLM researches answers using
  the wiki index and source documents. Use when user says "what does the KB say about",
  "search the knowledge base", "KB query", "ask the wiki", "kb-query".
argument-hint: "[question] [--topic topic-name] [--output markdown|slides|figure]"
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash"]
---

# Query Knowledge Base

Research a question against the compiled wiki and produce a structured answer.

**Input:** `$ARGUMENTS` — a question, with optional `--topic` filter and `--output` format.

---

## Steps

### Phase 1: Parse and Discover

1. **Parse arguments:**
   - Extract the question text
   - Extract `--topic` if provided; otherwise search across all KB topics
   - Extract `--output` format: `markdown` (default), `slides`, or `figure`

2. **Identify available knowledge bases:**
   - Glob for `kb/*/wiki/INDEX.md`
   - If `--topic` specified, verify it exists
   - If no KBs exist, inform user and suggest `/kb-init`

3. **Read the index(es):**
   - Read `wiki/INDEX.md` for the target topic(s)
   - Identify which concept articles, summaries, and connections are most relevant to the question

### Phase 2: Research

4. **Read relevant wiki articles:**
   - Start with the most relevant concept articles identified from the index
   - Follow links to related concepts and source summaries
   - Read connection articles if the question spans multiple concepts
   - Read source summaries for deeper detail when concept articles are insufficient
   - Aim for comprehensive coverage — read 5-15 articles depending on question complexity

5. **If the wiki is insufficient:**
   - Note gaps in the answer
   - Suggest specific sources the user could ingest to fill the gaps
   - Do NOT make up information — only synthesize from what's in the wiki

### Phase 3: Synthesize

6. **Compose the answer** based on `--output` format:

   **markdown (default):**
   - Title: the question
   - Structured answer with headers, bullet points, and inline citations
   - Citations link back to wiki articles: `[concept](../concepts/name.md)`, `[source](../summaries/name.md)`
   - End with: "Based on [N] sources and [M] concept articles"
   - Save to `kb/[topic]/wiki/outputs/[question-slug].md`

   **slides:**
   - Generate a Quarto RevealJS `.qmd` file
   - Follow the project's Quarto CSS conventions (see CLAUDE.md)
   - 5-10 slides covering the answer
   - Include speaker notes with source citations
   - Save to `kb/[topic]/wiki/outputs/[question-slug].qmd`

   **figure:**
   - Generate an R or Python script that creates a visualization
   - Could be: concept map, timeline, comparison table, data plot
   - Save script + output to `kb/[topic]/wiki/outputs/`

### Phase 4: File Back

7. **Update INDEX.md:**
   - Add the output to the `## Recent Changes` section
   - Note: "Query answered: [question summary]"

8. **Report to user:**
   - Display the answer directly in conversation
   - Note where the full output was saved
   - If gaps were found, suggest sources to ingest
   - Suggest related follow-up questions

---

## Important Notes

- **Never fabricate** — only synthesize from wiki content. If the wiki doesn't cover something, say so.
- Cross-topic queries (no `--topic` flag) search all KB indexes and synthesize across topics.
- For very broad questions, suggest breaking into sub-questions.
- The output is filed back into the wiki, making the KB self-enhancing over time.
