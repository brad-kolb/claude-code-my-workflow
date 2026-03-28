---
name: visual-audit
description: Perform adversarial visual audit of Quarto slides checking for overflow, font consistency, box fatigue, and layout issues.
argument-hint: "[QMD filename]"
allowed-tools: ["Read", "Grep", "Glob", "Write", "Task"]
---

# Visual Audit of Slide Deck

Perform a thorough visual layout audit of a slide deck.

## Steps

1. **Read the slide file** specified in `$ARGUMENTS`

2. **Render the Quarto file:**
   - Render with `quarto render Quarto/$ARGUMENTS`
   - Open in browser to inspect each slide

3. **Audit every slide for:**

   **OVERFLOW:** Content exceeding slide boundaries
   **FONT CONSISTENCY:** Inline font-size overrides, inconsistent sizes
   **BOX FATIGUE:** 2+ colored boxes on one slide, wrong box types
   **SPACING:** Missing negative margins, missing fig-align
   **LAYOUT:** Missing transitions, missing framing sentences, semantic colors

4. **Produce a report** organized by slide with severity and recommendations

5. **Follow the spacing-first principle:**
   1. Reduce vertical spacing with negative margins
   2. Use columns (horizontal split)
   3. Consolidate lists
   4. Use tabsets (for 4+ related items)
   5. Move to speaker notes (instructor context)
   6. Reduce image width
   7. Last resort: font size reduction (never below 0.85em)
