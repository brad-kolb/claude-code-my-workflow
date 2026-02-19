# CLAUDE.MD -- Academic Project Development with Claude Code

**Project:** [YOUR PROJECT NAME]
**Institution:** [YOUR INSTITUTION]
**Branch:** main

---

## Core Principles

- **Plan first** -- enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** -- run analysis and confirm output at the end of every task
- **Single source of truth** -- define your authoritative file here (e.g., manuscript PDF, R script, Quarto slides)
- **Quality gates** -- nothing ships below 80/100
- **[LEARN] tags** -- when corrected, save `[LEARN:category] wrong → right` to MEMORY.md

---

## Folder Structure

```
[your-repo-name]/
├── CLAUDE.md                         # This file
├── .claude/                          # Rules, skills, agents, hooks
├── Bibliography_base.bib             # Centralized bibliography
├── Figures/                          # Figures and images
├── Slides/                           # Beamer slides (if applicable)
├── Quarto/                           # Quarto slides (if applicable)
├── Preambles/                        # LaTeX preambles (if applicable)
├── manuscripts/                      # Manuscript files (if applicable)
├── docs/                             # GitHub Pages (auto-generated)
├── scripts/                          # Utility scripts
├── quality_reports/                  # Plans, session logs, merge reports
├── explorations/                     # Research sandbox (see rules)
├── templates/                        # Session log, quality report templates
└── master_supporting_docs/
    ├── supporting_papers/            # Reference papers, manuscript drafts
    ├── supporting_code/              # Analysis scripts (R, Python, etc.)
    │   └── artifacts/                # Model outputs, figures
    └── supporting_slides/            # Supporting slide decks
```

---

## Commands

```bash
# R Analysis (if applicable)
cd master_supporting_docs/supporting_code && Rscript run.R

# Quarto render (if applicable)
quarto render manuscript.qmd --to docx
quarto render supplement.qmd --to pdf

# LaTeX compilation (if applicable)
# xelatex, bibtex (see /compile-latex skill)

# Quality score
python scripts/quality_score.py path/to/manuscript.qmd

# Deploy to GitHub Pages (if applicable)
bash scripts/sync_to_docs.sh
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

Mark skills **[USE]** or **[N/A]** for your project type.

| Command | What It Does |
|---------|-------------|
| `/review-paper [file]` | Manuscript review |
| `/data-analysis [dataset]` | End-to-end R/Python analysis |
| `/review-r [file]` | R code quality review |
| `/lit-review [topic]` | Literature search + synthesis |
| `/research-ideation [topic]` | Research questions + strategies |
| `/interview-me [topic]` | Interactive research interview |
| `/validate-bib` | Cross-reference citations |
| `/proofread [file]` | Grammar/typo review |
| `/commit [msg]` | Stage, commit, PR, merge |
| `/compile-latex [file]` | 3-pass XeLaTeX + bibtex |
| `/deploy [LectureN]` | Render Quarto + sync to docs/ |
| `/extract-tikz [LectureN]` | TikZ → PDF → SVG |
| `/visual-audit [file]` | Slide layout audit |
| `/pedagogy-review [file]` | Narrative, notation, pacing review |
| `/qa-quarto [LectureN]` | Adversarial Quarto vs Beamer QA |
| `/slide-excellence [file]` | Combined multi-agent review |
| `/translate-to-quarto [file]` | Beamer → Quarto translation |
| `/devils-advocate` | Challenge slide design |
| `/create-lecture` | Full lecture creation |

---

## Slide Environments

Configure here if using Beamer/Quarto slides. Leave blank if manuscript-only project.

---

## Current Project State

| Component | File | Status | Notes |
|-----------|------|--------|-------|
| [Component 1] | `path/to/file` | [Status] | [Notes] |
| [Component 2] | `path/to/file` | [Status] | [Notes] |
