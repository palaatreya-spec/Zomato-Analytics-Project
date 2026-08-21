# Repository Architecture

## Primary portfolio workflow

The recruiter-facing path is now:

```text
Data/
  raw restaurant source
       ↓
Python/
  profiling → cleaning → EDA → scoring
       ↓
SQL/
  source-backed table → analysis → scoring
       ↓
Power BI/
  semantic model → dashboard
       ↓
Documentation/
  findings → KPI definitions → interview story
```

## Legacy SQL

The original `SQL/01–09` workflow was built around a broader relational learning model containing customers, orders, order items and reviews. Those files are retained for historical learning context, but they are **not the primary source-backed workflow** until their source relationships are verified.

Do not reference legacy customer/order/revenue findings in the final portfolio narrative.

## Naming convention

- `01–04`: source profiling / cleaning / EDA Python workflow
- `13–15`: source-backed SQL analytics
- `Documentation/*`: business, metric, lineage and interview documentation

## Portfolio rule

A recruiter landing on the repository should be able to follow the source-backed path without needing to understand the legacy relational model.
