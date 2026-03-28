---
paths:
  - "Quarto/**/*.qmd"
  - "docs/**"
---

# Task Completion Verification Protocol

**At the end of EVERY task, Claude MUST verify the output works correctly.** This is non-negotiable.

## For Quarto Output (Slides, Papers, Websites):
1. Run `quarto render <file>` to render the output
2. For slides/HTML: open in browser via `open docs/slides/<file>.html` (macOS) or `xdg-open` (Linux)
3. Verify images display by reading 2-3 image files to confirm valid content
4. Check for overflow by scanning dense slides or pages
5. Verify all CSS classes in the QMD have definitions in the theme SCSS
6. Report verification results

## For Deployment:
1. Run `./scripts/sync_to_docs.sh` (or `./scripts/sync_to_docs.sh <project>`) to render and deploy
2. Open deployed HTML to confirm paths resolve correctly in `docs/`

## For R Scripts:
1. Run `Rscript scripts/R/filename.R`
2. Verify output files (PDF, RDS, PNG, SVG) were created with non-zero size
3. Spot-check estimates for reasonable magnitude

## Common Pitfalls:
- **Relative paths**: `../Figures/` works from `Quarto/` but not from `docs/slides/` — use `sync_to_docs.sh`
- **Assuming success**: Always verify output files exist AND contain correct content
- **Stale renders**: Source changed but output not re-rendered — always render before verifying

## Verification Checklist:
```
[ ] Output file created successfully
[ ] No compilation/render errors
[ ] Images/figures display correctly
[ ] Paths resolve in deployment location (docs/)
[ ] Opened in browser/viewer to confirm visual appearance
[ ] Reported results to user
```
