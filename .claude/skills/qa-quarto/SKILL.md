---
name: qa-quarto
description: Adversarial Quarto QA. Critic finds issues, fixer applies fixes, loops until APPROVED (max 5 rounds).
argument-hint: "[LectureN]"
allowed-tools: ["Read", "Grep", "Glob", "Write", "Edit", "Bash", "Task"]
context: fork
---

# Adversarial Quarto QA Workflow

Standalone quality audit of Quarto slides using an iterative critic/fixer loop.

**Philosophy:** Quarto output must meet rigorous quality standards — no overflow, no broken citations, consistent notation, publication-ready visuals.

---

## Workflow

```
Phase 0: Pre-flight → Phase 1: Critic audit → Phase 2: Fixer → Phase 3: Re-audit → Loop until APPROVED (max 5 rounds)
```

## Hard Gates (Non-Negotiable)

| Gate | Condition |
|------|-----------|
| **Overflow** | NO content cut off |
| **Plot Quality** | Charts readable and properly sized |
| **Content Completeness** | No missing slides/equations/text vs outline |
| **Visual Quality** | Professional, publication-ready appearance |
| **Slide Centering** | Content centered, no jumping |
| **Notation Consistency** | All math consistent throughout deck |
| **Equation Formatting** | Proper display mode, alignment, line breaks |

## Phase 0: Pre-flight

1. Locate Quarto (.qmd/.html) files
2. Check freshness (re-render if QMD newer than HTML)
3. Verify all referenced figures exist

## Phase 1: Initial Audit

Launch the `quarto-critic` agent for comprehensive quality audit. Report saved to `quality_reports/[Lecture]_qa_critic_round1.md`.

## Phase 2: Fix Cycle

If not APPROVED, launch `quarto-fixer` agent to apply fixes (Critical → Major → Minor), re-render, and verify.

## Phase 3: Re-Audit

Re-launch critic to verify fixes. Loop back to Phase 2 if needed.

## Iteration Limits

Max 5 fix rounds. After that, escalate to user with remaining issues.

## Final Report

Save to `quality_reports/[Lecture]_qa_final.md` with hard gate status, iteration summary, and remaining issues.
