# Data Cleaning Principles

The original cleaning workflow uses destructive `DELETE` and `UPDATE` statements, including duplicate removal, negative-order deletion, orphan removal, and invalid-rating replacement. fileciteturn72file0L2-L6

For a professional analytics workflow, cleaning should be auditable and reversible where practical.

## Principles

1. **Profile before cleaning.** Measure the issue first.
2. **Preserve raw data.** Never overwrite the only copy of source data.
3. **Prefer derived clean tables/views.** Keep raw and cleaned layers separate when possible.
4. **Record every rule.** State why a value was changed, removed, or imputed.
5. **Avoid silent deletion.** Deletions should be quantified before and after.
6. **Validate after transformation.** Re-run quality gates after cleaning.
7. **Separate data correction from business assumptions.** Fixing malformed data is different from estimating a business metric.

## Portfolio standard

The final project should be able to answer:

- What was wrong with the source?
- How many records were affected?
- What rule was applied?
- Why was that rule appropriate?
- Did the cleaned dataset pass QA afterward?
