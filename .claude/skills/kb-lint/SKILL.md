---
name: kb-lint
description: |
  Health check a knowledge base wiki for inconsistencies, missing data, broken links,
  and improvement opportunities. Use when user says "lint the KB", "check KB health",
  "audit knowledge base", "kb-lint", or wants to improve wiki quality.
argument-hint: "[topic-name]"
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash"]
---

# Lint Knowledge Base

Run a comprehensive health check on a knowledge base wiki.

**Input:** `$ARGUMENTS` — topic name. If omitted and only one KB exists, use that.

---

## Steps

### Phase 1: Structural Checks

1. **Verify topic exists** and read `META.md`, `.manifest.md`, and `INDEX.md`.

2. **Source coverage:**
   - Every entry in `.manifest.md` should have a corresponding file in `wiki/summaries/`
   - Flag any sources without summaries as **MISSING SUMMARY**

3. **Concept integrity:**
   - Every concept article in `wiki/concepts/` must have at least one entry in `## Sources`
   - Flag orphan concepts (no source backlinks) as **ORPHAN CONCEPT**

4. **Index accuracy:**
   - Every concept article should appear in INDEX.md `## Concepts` section
   - Every summary should appear in INDEX.md `## Sources` section
   - Counts in INDEX.md header should match actual file counts
   - Flag mismatches as **INDEX STALE**

### Phase 2: Link Checks

5. **Internal links:**
   - Grep all `.md` files in `wiki/` for markdown links `[text](path)`
   - Verify each linked file exists at the relative path
   - Flag broken links as **BROKEN LINK**

6. **Backlink completeness:**
   - For each summary, verify that every concept it lists in `## Concepts Extracted` has a corresponding link back in the concept's `## Sources`
   - Flag missing backlinks as **MISSING BACKLINK**

### Phase 3: Content Quality

7. **Consistency check:**
   - Look for the same concept referred to by different names across articles
   - Look for contradictory claims (same fact stated differently in different articles)
   - Flag as **INCONSISTENCY**

8. **Completeness check:**
   - Scan for concept names mentioned in article text that don't have their own concept article
   - Flag as **CANDIDATE CONCEPT** — suggest creating an article

9. **Stub detection:**
   - Identify concept articles with minimal content (e.g., only a definition, no key points or details)
   - Flag as **STUB** — suggest enriching from existing sources

### Phase 4: Connection Discovery

10. **Suggest new connections:**
    - Identify concepts that share multiple sources but aren't linked via a connection article
    - Identify concepts that appear in similar contexts but aren't cross-referenced
    - List as **SUGGESTED CONNECTION**

### Phase 5: Report

11. **Generate health report** saved to `kb/[topic]/wiki/outputs/lint-report-YYYY-MM-DD.md`:

    ```markdown
    # KB Health Report: [Topic]

    **Date:** [DATE]
    **Sources:** [N] | **Concepts:** [N] | **Connections:** [N]

    ## Summary

    - Critical issues: [N]
    - Warnings: [N]
    - Suggestions: [N]
    - Health score: [X/100]

    ## Critical Issues

    [MISSING SUMMARY, BROKEN LINK — must fix]

    ## Warnings

    [ORPHAN CONCEPT, INDEX STALE, MISSING BACKLINK, INCONSISTENCY — should fix]

    ## Suggestions

    [CANDIDATE CONCEPT, STUB, SUGGESTED CONNECTION — nice to have]

    ## Recommended Actions

    1. [Most impactful fix first]
    2. ...
    ```

12. **Present report to user:**
    - Summarize findings in conversation
    - Offer to auto-fix critical issues and warnings
    - Ask before acting on suggestions

---

## Health Score Rubric

| Score | Meaning |
|-------|---------|
| 90-100 | Excellent — no critical issues, minimal warnings |
| 70-89 | Good — some warnings, all sources have summaries |
| 50-69 | Fair — missing summaries or broken links |
| 0-49 | Poor — significant structural issues |
