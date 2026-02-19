# CLAUDE.MD -- Academic Project Development with Claude Code

**Project:** Ordinal Treatment Effect of Mechanical Thrombectomy
**Institution:** Rush University Medical Center, Department of Neurosurgery
**Branch:** main

---

## Core Principles

- **Plan first** -- enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** -- run analysis and confirm output at the end of every task
- **Single source of truth** -- manuscript PDF is current state; R code is authoritative for analysis
- **Quality gates** -- nothing ships below 80/100
- **[LEARN] tags** -- when corrected, save `[LEARN:category] wrong → right` to MEMORY.md

---

## Folder Structure

```
thrombectomy-meta/
├── CLAUDE.md                         # This file
├── .claude/                          # Rules, skills, agents, hooks
├── Bibliography_base.bib             # Centralized bibliography
├── Figures/                          # Figures and images
├── Slides/                           # Not used — manuscript project
├── Quarto/                           # Not used — manuscript project
├── Preambles/                        # Not used — manuscript project
├── docs/                             # GitHub Pages (auto-generated)
├── scripts/                          # Utility scripts
├── quality_reports/                  # Plans, session logs, merge reports
├── explorations/                     # Research sandbox (see rules)
├── templates/                        # Session log, quality report templates
└── master_supporting_docs/
    ├── supporting_papers/manuscript.pdf   # Current manuscript (needs Stroke revision)
    └── supporting_code/                   # R analysis home
        ├── run.R                          # Main analysis (4 Bayesian models, 4 figures)
        ├── functions.R                    # Helper functions
        ├── data.csv                       # 30 RCTs, 8,100 patients
        └── artifacts/                     # Model outputs, figures (PDF + SVG)
```

---

## Commands

```bash
# R Analysis
cd master_supporting_docs/supporting_code && Rscript run.R

# Install poppler for PDF reading (needed once)
brew install poppler

# Quality score (if manuscript drafted as .qmd)
python scripts/quality_score.py path/to/manuscript.qmd

# Not used — manuscript project (no slides):
# xelatex, bibtex, quarto render, sync_to_docs.sh
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

Skills marked **[USE]** are relevant for this manuscript/R project.
Skills marked **[N/A]** are for slide-based projects only.

| Command | What It Does | Relevance |
|---------|-------------|-----------|
| `/review-paper [file]` | Manuscript review | **[USE]** |
| `/data-analysis [dataset]` | End-to-end R analysis | **[USE]** |
| `/review-r [file]` | R code quality review | **[USE]** |
| `/lit-review [topic]` | Literature search + synthesis | **[USE]** |
| `/research-ideation [topic]` | Research questions + strategies | **[USE]** |
| `/interview-me [topic]` | Interactive research interview | **[USE]** |
| `/validate-bib` | Cross-reference citations | **[USE]** |
| `/proofread [file]` | Grammar/typo review | **[USE]** |
| `/commit [msg]` | Stage, commit, PR, merge | **[USE]** |
| `/compile-latex [file]` | 3-pass XeLaTeX + bibtex | [N/A] |
| `/deploy [LectureN]` | Render Quarto + sync to docs/ | [N/A] |
| `/extract-tikz [LectureN]` | TikZ → PDF → SVG | [N/A] |
| `/visual-audit [file]` | Slide layout audit | [N/A] |
| `/pedagogy-review [file]` | Narrative, notation, pacing review | [N/A] |
| `/qa-quarto [LectureN]` | Adversarial Quarto vs Beamer QA | [N/A] |
| `/slide-excellence [file]` | Combined multi-agent review | [N/A] |
| `/translate-to-quarto [file]` | Beamer → Quarto translation | [N/A] |
| `/devils-advocate` | Challenge slide design | [N/A] |
| `/create-lecture` | Full lecture creation | [N/A] |

---

## Slide Environments

Not used — manuscript project (no slides).

---

## Current Project State

| Component | File | Status | Notes |
|-----------|------|--------|-------|
| R analysis | `master_supporting_docs/supporting_code/run.R` | Complete | 4 Bayesian models, 4 figures |
| Manuscript | `master_supporting_docs/supporting_papers/manuscript.pdf` | Needs revision | Target: Stroke journal |
| Bibliography | `Bibliography_base.bib` | Needs update | Add thrombectomy guidelines |
| Data | `master_supporting_docs/supporting_code/data.csv` | Complete | 30 RCTs, 8,100 patients |
