# Knowledge Base Configuration

## Link Format

Use standard markdown links only:

```markdown
[Concept Name](../concepts/concept-name.md)
[Source Title](../summaries/source-name.md)
```

## File Naming

- All files: `kebab-case.md`
- Concepts: `wiki/concepts/[concept-name].md`
- Summaries: `wiki/summaries/[source-name].md`
- Connections: `wiki/connections/[theme-name].md`
- Outputs: `wiki/outputs/[descriptive-name].md`

## Article Standards

### Concept Articles

Must include: definition, key points, sources (backlinks), related concepts, last updated date.

### Source Summaries

Must include: source type, authors/origin, key takeaways, concepts extracted, BibTeX (if applicable).

### Connection Articles

Must include: theme description, which concepts are connected, how they relate, implications.

## Index Maintenance

INDEX.md is rebuilt automatically by `/kb-compile` and `/kb-ingest`. It contains:

- Alphabetical concept listing with one-line descriptions
- Category groupings
- Source manifest (count + recent additions)
- Recent changes log

## Preserved Sections

When recompiling, any `## Notes` section in an article is preserved. Use this for human annotations that should survive recompilation.
