# Plan: Adapt Workflow to Quarto-Only General-Purpose Template

**Status:** DRAFT
**Date:** 2026-03-28
**Context:** Converting forked Beamer+Quarto dual-format academic workflow to a Quarto-only, general-purpose template for lectures, papers, data projects, and websites. User works exclusively in Quarto + R.

---

## Why

The current architecture enforces Beamer `.tex` as the authoritative source, with Quarto as a derived artifact. This creates unnecessary friction — the user never uses Beamer/LaTeX directly. Flipping to Quarto-only removes ~30% of infrastructure (rules, skills, agents) and makes the template immediately usable without per-project cleanup.

---

## Phase 1: Delete Beamer-Only Infrastructure (Clean Cuts)

No dependencies — safe to remove outright.

### Files to DELETE:
| File | Reason |
|------|--------|
| `.claude/rules/beamer-quarto-sync.md` | Mandates Beamer→Quarto sync |
| `.claude/rules/no-pause-beamer.md` | Beamer overlay syntax ban |
| `.claude/rules/tikz-visual-quality.md` | TikZ-in-Beamer standards |
| `.claude/skills/compile-latex/SKILL.md` | XeLaTeX 3-pass compilation |
| `.claude/skills/extract-tikz/SKILL.md` | TikZ extraction from Beamer |
| `.claude/skills/translate-to-quarto/SKILL.md` | Beamer→Quarto translation |
| `.claude/agents/beamer-translator.md` | Beamer→Quarto translator agent |
| `.claude/agents/tikz-reviewer.md` | TikZ diagram reviewer agent |

### Directories to DELETE:
- `Slides/` (Beamer source directory)
- `Preambles/` (LaTeX headers directory)

---

## Phase 2: Rewrite Core Architecture Rules

Flip the "source of truth" from Beamer to Quarto.

### `.claude/rules/single-source-of-truth.md`
- **Quarto `.qmd` becomes authoritative** for all content
- Remove TikZ freshness protocol, Beamer environment parity
- New chain: `.qmd` → rendered HTML/PDF/DOCX (derived), `Bibliography_base.bib` (shared), `Figures/` (assets), `scripts/R/` (data source)
- Remove `Slides/**/*.tex` from `paths:` frontmatter

### `.claude/rules/verification-protocol.md`
- Remove "For LaTeX/Beamer Slides" section
- Remove "For TikZ Diagrams" section
- Remove stale-TikZ references from common pitfalls
- Add general "For rendered output" covering `quarto render` for any format
- Remove `Slides/**/*.tex` from `paths:` frontmatter

### `.claude/rules/quality-gates.md`
- Remove Beamer rubric table entirely
- Generalize `tikz_label_overlap` → `figure_quality_issue` in Quarto rubric
- Remove `.tex` from `paths:` frontmatter

### `.claude/rules/knowledge-base-template.md`
- Remove `Slides/**/*.tex` from `paths:` frontmatter (content is already generic)

---

## Phase 3: Adapt Skills and Agents

Make Quarto self-sufficient (no Beamer dependency).

### Skills to REWRITE:
| Skill | Change |
|-------|--------|
| `/create-lecture` | Quarto-first creation (remove .tex drafting, TikZ-in-Beamer, 3-pass compilation) |
| `/qa-quarto` | Standalone QA (remove "vs Beamer" comparison, quality standards become absolute) |
| `/deploy` | Remove TikZ SVG verification step, remove Beamer PDF copying reference |
| `/slide-excellence` | Remove TikZ Review agent and Content Parity vs .tex agent |

### Agents to REWRITE:
| Agent | Change |
|-------|--------|
| `quarto-critic` | Standalone quality auditor (not comparison-to-Beamer). Hard gates become absolute: no overflow, no broken citations, notation consistency, visual quality |
| `quarto-fixer` | Remove "copy from Beamer" fix patterns. Add "content completeness vs outline" |
| `verifier` | Remove `.tex` verification section, TikZ Freshness Check, Beamer cross-references |

### Agents to SCAN (remove incidental Beamer refs):
- `domain-reviewer.md`, `pedagogy-reviewer.md`, `proofreader.md`, `slide-auditor.md`

---

## Phase 4: Update Configuration and Scripts

### `CLAUDE.md`
- Remove "Single source of truth — Beamer" → "Single source of truth — Quarto"
- Remove `Slides/`, `Preambles/` from folder structure
- Remove LaTeX compilation commands, keep `quarto render` + deploy
- Remove `/compile-latex`, `/extract-tikz`, `/translate-to-quarto` from skills table
- Remove Beamer Custom Environments section entirely
- Update project state table: remove "Beamer" column

### `.claude/settings.json`
- Remove from `permissions.allow`: `xelatex`, `TEXINPUTS`, `BIBINPUTS`, `latexmk`, `bibtex`, `pdf2svg`

### `scripts/quality_score.py`
- Remove `BEAMER_RUBRIC` dictionary
- Remove `score_beamer()`, `check_latex_syntax()`, `check_overfull_hbox_risk()` methods
- Remove `.tex` branch from CLI `main()`
- Generalize `tikz_label_overlap` → `figure_quality_issue`

### `scripts/sync_to_docs.sh`
- Remove "Sync Beamer PDFs" section

### `.gitignore`
- Remove LaTeX artifact patterns (clean template)

### `README.md`
- Update agent/skill/rule counts and tables
- Remove Beamer-specific rows from all "What's Included" tables
- Update prerequisites (remove XeLaTeX, pdf2svg)
- Update descriptions for `/qa-quarto`, `/create-lecture`, `quarto-critic`

### `.claude/WORKFLOW_QUICK_REF.md`
- Remove LaTeX path convention reference

---

## Phase 5: Streamline Hooks

Keep only 2 hooks, remove 5 noisy/aggressive ones.

### Hooks to KEEP:
- `protect-files.sh` — Safety: blocks accidental edits to critical files. Nearly silent.
- `notify.sh` — OS desktop notifications. Zero context cost.

### Hooks to DELETE:
| Hook | Why remove |
|------|-----------|
| `pre-compact.py` | Plan-first workflow already saves state to disk |
| `post-compact-restore.py` | Paired with pre-compact; same reasoning |
| `context-monitor.py` | Fires frequently, verbose warnings fill context |
| `verify-reminder.py` | Fires on every .qmd/.R edit, redundant reminders |
| `log-reminder.py` | Blocks session end — too aggressive |

### `settings.json` hook config:
- Remove `PreCompact`, `SessionStart`, `Stop` hook entries entirely
- Remove `context-monitor.py` from `PostToolUse` (keep only protect-files in `PreToolUse`)
- Remove `verify-reminder.py` from `PostToolUse`

---

## Phase 6: Final Cleanup and Verification

### Verification steps:
1. `grep -ri "beamer\|xelatex\|latexmk\|bibtex" .claude/ scripts/ CLAUDE.md README.md` → zero hits (except generic "LaTeX math" in Quarto context)
2. `ls Slides/ Preambles/` → directories don't exist
3. `python3 scripts/quality_score.py --help` → no errors
4. `bash -n scripts/sync_to_docs.sh` → syntax OK
5. All YAML frontmatter in rules/skills/agents is valid
6. Hooks: only `protect-files.sh` and `notify.sh` referenced in settings.json

---

## File Change Summary

| Action | Count | Files |
|--------|-------|-------|
| DELETE | 15 | 3 rules, 3 skills, 2 agents, 2 directories, 5 hook scripts |
| REWRITE | 7 | 1 rule (SSOT), 4 skills, 2 agents (critic/fixer) |
| EDIT | 10 | 3 rules, 1 agent (verifier), CLAUDE.md, settings.json, quality_score.py, sync_to_docs.sh, .gitignore, README.md |
| SCAN | 5 | 4 agents, WORKFLOW_QUICK_REF.md |
| **Total** | **~37 files touched** | |

---

## Commit Strategy

3 commits for clean, reversible history:
1. **Phase 1 + 5:** "chore: remove Beamer/LaTeX infrastructure and noisy hooks"
2. **Phases 2-3:** "refactor: flip source of truth to Quarto, adapt skills and agents"
3. **Phases 4 + 6:** "chore: update config, scripts, and docs for Quarto-only workflow"
