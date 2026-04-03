# Knowledge Bases

LLM-compiled knowledge bases for research topics. Inspired by [Karpathy's LLM Knowledge Base workflow](https://x.com/karpathy).

## How It Works

1. **Ingest** raw sources (papers, articles, URLs, images) into `kb/[topic]/raw/`
2. **Compile** — the LLM reads all sources and builds a markdown wiki with summaries, concept articles, cross-cutting connections, and a master index
3. **Query** — ask complex questions against the wiki; answers are synthesized from multiple articles and filed back into the wiki
4. **Lint** — run health checks to find inconsistencies, broken links, missing articles, and new connections

## Quick Start

```bash
# Initialize a new knowledge base
/kb-init causal-inference

# Add sources
/kb-ingest path/to/paper.pdf causal-inference
/kb-ingest https://example.com/article causal-inference

# Compile the wiki
/kb-compile causal-inference

# Ask questions
/kb-query "What are the main identification strategies?" --topic causal-inference

# Health check
/kb-lint causal-inference

# Browse in repoview
./scripts/kb/launch-viewer.sh causal-inference
```

## Directory Structure

```
kb/
├── README.md                    # This file
├── .kb-config.md                # Global conventions
├── [topic-name]/
│   ├── META.md                  # Topic metadata
│   ├── raw/                     # Source documents
│   │   └── .manifest.md         # Auto-maintained source inventory
│   └── wiki/                    # LLM-compiled wiki
│       ├── INDEX.md             # Master index (auto-maintained)
│       ├── concepts/            # Concept articles
│       ├── summaries/           # Source summaries
│       ├── connections/         # Cross-cutting themes
│       └── outputs/             # Query answers, slides, figures
```

## Conventions

- **Standard markdown links** — `[text](path.md)`, no wiki-style `[[links]]`
- **kebab-case** for all filenames
- **INDEX.md is auto-maintained** — do not edit manually
- **`## Notes` sections are preserved** across recompilation (add your own annotations there)
- Raw sources are gitignored by default (large/copyrighted); wiki is tracked

## Viewing

Use [repoview](https://github.com/nicholasgasior/repoview) to browse the wiki locally with a GitHub-like UI:

```bash
./scripts/kb/launch-viewer.sh [topic-name]
```
