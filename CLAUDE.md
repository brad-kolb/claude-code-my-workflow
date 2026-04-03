# CLAUDE.MD -- Academic Project Development with Claude Code

<!-- HOW TO USE: Replace [BRACKETED PLACEHOLDERS] with your project info.
     Customize Quarto CSS classes for your theme.
     Keep this file under ~150 lines — Claude loads it every session.
     See the guide at docs/workflow-guide.html for full documentation. -->

**Project:** [YOUR PROJECT NAME]
**Institution:** [YOUR INSTITUTION]
**Branch:** main

---

## Core Principles

- **Plan first** -- enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** -- render and confirm output at the end of every task
- **Single source of truth** -- Quarto `.qmd` is authoritative; rendered output derives from it
- **Quality gates** -- nothing ships below 80/100
- **[LEARN] tags** -- when corrected, save `[LEARN:category] wrong → right` to MEMORY.md

---

## Folder Structure

```
[YOUR-PROJECT]/
├── CLAUDE.MD                    # This file
├── .claude/                     # Rules, skills, agents, hooks
├── Bibliography_base.bib        # Centralized bibliography
├── Figures/                     # Figures and images
├── Quarto/                      # Source files (.qmd) — slides, papers, websites
├── docs/                        # GitHub Pages (auto-generated)
├── scripts/                     # Utility scripts + R code
├── quality_reports/             # Plans, session logs, merge reports
├── kb/                          # Knowledge bases (raw sources + LLM-compiled wikis)
├── explorations/                # Research sandbox (see rules)
├── templates/                   # Session log, quality report templates
└── master_supporting_docs/      # Papers and reference materials
```

---

## Commands

```bash
# Render Quarto
quarto render Quarto/file.qmd

# Deploy to GitHub Pages
./scripts/sync_to_docs.sh LectureN

# Quality score
python scripts/quality_score.py Quarto/file.qmd

# Browse knowledge base wiki (requires repoview)
./scripts/kb/launch-viewer.sh [topic-name]
```

---

## Quality Thresholds

| Score | Gate | Meaning |
|-------|------|---------|
| 80 | Commit | Good enough to save |
| 90 | PR | Ready for deployment |
| 95 | Excellence | Aspirational |

---

## Skills Quick Reference

| Command | What It Does |
|---------|-------------|
| `/deploy [LectureN]` | Render Quarto + sync to docs/ |
| `/proofread [file]` | Grammar/typo/overflow review |
| `/visual-audit [file]` | Slide layout audit |
| `/pedagogy-review [file]` | Narrative, notation, pacing review |
| `/review-r [file]` | R code quality review |
| `/qa-quarto [LectureN]` | Adversarial Quarto QA |
| `/slide-excellence [file]` | Combined multi-agent review |
| `/validate-bib` | Cross-reference citations |
| `/devils-advocate` | Challenge slide design |
| `/create-lecture` | Full Quarto lecture creation |
| `/commit [msg]` | Stage, commit, PR, merge |
| `/lit-review [topic]` | Literature search + synthesis |
| `/research-ideation [topic]` | Research questions + strategies |
| `/interview-me [topic]` | Interactive research interview |
| `/review-paper [file]` | Manuscript review |
| `/data-analysis [dataset]` | End-to-end R analysis |
| `/learn [skill-name]` | Extract discovery into persistent skill |
| `/context-status` | Show session health + context usage |
| `/deep-audit` | Repository-wide consistency audit |
| `/kb-init [topic]` | Initialize new knowledge base topic |
| `/kb-ingest [file] [topic]` | Add source, trigger wiki compilation |
| `/kb-compile [topic]` | Compile/update wiki from raw sources |
| `/kb-query [question]` | Research question against the wiki |
| `/kb-lint [topic]` | Health check wiki for issues |

---

## Quarto CSS Classes

| Class | Effect | Use Case |
|-------|--------|----------|
| `.primary` | Deep slate text (#1e293b) | Headings, strong emphasis |
| `.accent` | Teal text (#0d9488) | Secondary emphasis, links |
| `.highlight` | Amber text (#f59e0b) | Attention, alerts |
| `.hi` / `.hi-accent` / `.hi-amber` | Bold colored text | Inline emphasis |
| `.hi-green` / `.hi-red` / `.hi-slate` | Semantic bold text | Status, annotation |
| `.positive` / `.negative` / `.neutral` | Semantic colors | Diagrams, comparisons |
| `.keybox` | Teal-bordered card | Key takeaways |
| `.highlightbox` | Amber-bordered card | Important callouts |
| `.methodbox` | Slate-bordered card | Methods, definitions |
| `.assumptionbox` | Teal full-border card | Assumptions, conditions |
| `.resultbox` | Teal emphasized card | Key results |
| `.quotebox` | Italic with quote mark | Quotations |
| `.eqbox` | Subtle background | Equations |
| `.softbox` | Light italic card | Aside, commentary |
| `.smaller` / `.smallest` / `.bigger` | Font size adjustment | Content density |
| `.compact` | Reduced spacing | Dense slides |
| `.col-left` / `.col-right` | 47/47 columns | Two-column layout |
| `.col-left-wide` / `.col-right-narrow` | 63/33 columns | Asymmetric layout |
| `.footnote` | Bottom-positioned small text | Citations, notes |
| `.mono` | JetBrains Mono | Code-like text |

---

## Current Project State

| # | Topic | QMD File | Key Content |
|---|-------|----------|-------------|
| 1 | [Topic] | `Lecture1_Topic.qmd` | [Brief description] |
| 2 | [Topic] | -- | [Brief description] |
