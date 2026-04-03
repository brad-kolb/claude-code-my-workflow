# Plan: Integrate LLM Knowledge Base Workflow (Karpathy-Style)

**Status:** COMPLETED
**Date:** 2026-04-03
**Context:** Adapt Karpathy's LLM Knowledge Base pattern into the my-workflow template. Raw documents are ingested, an LLM compiles a markdown wiki with summaries/concepts/backlinks, then the LLM queries and lints the wiki. Repoview replaces Obsidian as the local viewer.

---

## Architecture

### New top-level directory: `kb/`

```
kb/
├── README.md                        # How the KB system works
├── .kb-config.md                    # Global conventions (article templates, link format)
├── [topic-name]/                    # One directory per knowledge base
│   ├── META.md                      # Topic description, creation date, status
│   ├── raw/                         # Source documents (papers, articles, images, repos)
│   │   └── .manifest.md             # Auto-maintained inventory of all sources
│   └── wiki/                        # LLM-compiled markdown wiki
│       ├── INDEX.md                 # Auto-maintained master index
│       ├── concepts/                # One .md per concept (definition, backlinks, related)
│       ├── summaries/               # One .md per source document
│       ├── connections/             # Cross-cutting theme articles
│       └── outputs/                 # Query answers, generated slides, figures
```

**Key design decisions:**
- Top-level `kb/` (not under `explorations/` or `master_supporting_docs/`) — the KB is persistent, first-class
- Per-topic directories — researchers have separate KBs per area; enables archival/sharing
- Standard markdown links `[text](path.md)` — no Obsidian `[[wikilinks]]`, works in repoview and GitHub
- Raw sources gitignored (large/copyrighted), wiki tracked in git (intellectual output worth versioning)

### Relationship to existing directories

| Directory | Relationship |
|-----------|-------------|
| `master_supporting_docs/` | Remains as-is. `/kb-ingest` can pull from it, but KB doesn't replace it |
| `explorations/` | KB query outputs can seed new explorations |
| `Quarto/` | Wiki articles feed into `/create-lecture`. Compiled summaries become lecture source material |
| `Bibliography_base.bib` | `/kb-compile` can extract BibTeX from sources and append |

---

## Five new skills

### 1. `/kb-init [topic-name]` — Initialize a new knowledge base
- Creates `kb/[topic]/` with full directory scaffold
- Generates `META.md`, empty `.manifest.md`, empty `INDEX.md`
- Creates `kb/README.md` and `kb/.kb-config.md` on first use
- **Tools:** Read, Write, Bash, Glob

### 2. `/kb-ingest [file-or-url] [topic]` — Add sources and trigger incremental compilation
- Copies/downloads source into `kb/[topic]/raw/`
- Updates `.manifest.md` with metadata
- Generates summary in `wiki/summaries/`, extracts concepts to `wiki/concepts/`
- Updates `wiki/INDEX.md` with new entries and backlinks
- **Tools:** Read, Write, Edit, Bash, Glob, Grep, WebFetch

### 3. `/kb-compile [topic] [--full|--incremental]` — Compile wiki from raw sources
- Incremental (default): processes only new/changed sources
- Full: recompiles everything — all summaries, concepts, connections, index
- Generates cross-cutting `wiki/connections/` articles for themes spanning multiple concepts
- Rebuilds `wiki/INDEX.md` with categories, alphabetical listing, recent changes
- **Tools:** Read, Write, Edit, Bash, Glob, Grep (runs in forked context — `context: fork`)

### 4. `/kb-query [question] [--topic X] [--output markdown|slides|figure]` — Research questions against the wiki
- Reads INDEX.md to find relevant articles, then reads and synthesizes
- Can search across all topics or filter to one
- Outputs to `wiki/outputs/` as markdown (default), Quarto slides, or figures
- Files answers back into the wiki (self-enhancing)
- **Tools:** Read, Write, Grep, Glob, Bash

### 5. `/kb-lint [topic]` — Health check the wiki
- Structural: every source has a summary, every concept has backlinks, INDEX is complete
- Links: all references resolve, no orphaned articles
- Consistency: terminology, contradictions across articles
- Discovery: suggests new connections and missing concept articles
- Outputs report to `wiki/outputs/lint-report-YYYY-MM-DD.md`
- **Tools:** Read, Write, Grep, Glob, Bash

---

## Supporting files

### New rule: `.claude/rules/kb-wiki-conventions.md`
- Scoped to `kb/**`
- INDEX.md is auto-maintained (never manually edit)
- Backlink format: every article has `## Sources` section
- Standard article templates for concepts and summaries
- File naming: kebab-case throughout
- `## Notes` section preserved across recompilation (human additions)
- Wiki outputs in `.qmd` format follow Quarto CSS conventions

### New templates (in `templates/`)
| File | Purpose |
|------|---------|
| `kb-readme.md` | Documentation for the `kb/` directory |
| `kb-config.md` | Default wiki conventions and settings |
| `kb-meta.md` | Per-topic metadata template |
| `kb-concept.md` | Standard concept article structure |
| `kb-summary.md` | Standard source summary structure |

### Viewer script: `scripts/kb/launch-viewer.sh`
- Runs repoview pointed at `kb/[topic]/wiki`
- Documented in CLAUDE.md commands section

### .gitignore additions
```gitignore
# Knowledge base raw sources (large/copyrighted — not tracked)
kb/*/raw/*
!kb/*/raw/.manifest.md
# Uncomment to also ignore compiled wiki (default: tracked)
# kb/*/wiki/*
```

---

## Updates to existing files

### CLAUDE.md
1. **Folder structure** — add `kb/` line
2. **Commands** — add repoview launch command
3. **Skills table** — add 5 new `/kb-*` entries

### README.md
- Brief mention of KB capability in features list

---

## Implementation sequence

1. **Templates + rules** — `templates/kb-*.md`, `.claude/rules/kb-wiki-conventions.md`, `.gitignore` update
2. **Core skills** — `kb-init`, `kb-ingest`, `kb-compile`
3. **Query + lint skills** — `kb-query`, `kb-lint`
4. **Integration** — `scripts/kb/launch-viewer.sh`, CLAUDE.md updates, README update

---

## Verification

- [ ] `/kb-init test-topic` creates correct directory scaffold
- [ ] `/kb-ingest` with a markdown file creates summary + concept articles + updates INDEX
- [ ] `/kb-compile --full` rebuilds entire wiki with no errors
- [ ] `/kb-query "What is X?"` returns a well-sourced answer filed in outputs/
- [ ] `/kb-lint` catches intentionally broken links and missing summaries
- [ ] `repoview kb/test-topic/wiki` renders the wiki browsably
- [ ] All new skills appear in CLAUDE.md skills table
- [ ] `.gitignore` correctly ignores raw/ contents but tracks wiki/
