# SQL Execution Guide

## Recommended execution order

The repository currently contains two analytical concepts that should not be mixed without validation:

### A. Source-backed restaurant analysis

Use this path after profiling the compressed restaurant source and mapping its actual columns:

1. `01_Create_Database_And_Table.sql`
2. `02_Data_Loading.sql`
3. `03_Data_Quality_Checks.sql`
4. `04_Data_Cleaning.sql`
5. `05_Feature_Engineering.sql`
6. `06_Analytical_Views.sql`
7. `07_Case_Study_Analysis.sql`
8. `08_Advanced_Business_Queries.sql`
9. `09_Business_Insights.sql`
10. `10_Portfolio_Analysis.sql`
11. `11_Data_Quality_Report.sql`

### B. Relational demonstration layer

Some existing queries use customers, orders, order items and reviews. These should only be executed when the corresponding tables and source files have been loaded and validated.

## QA gates

Before moving to the next stage, confirm:

- row counts are plausible
- required columns exist
- null rates are understood
- duplicate keys are investigated
- numeric ranges are valid
- foreign-key relationships are valid where applicable
- derived metrics have documented formulas

## Analyst rule

A query should only be used in the final portfolio narrative when its source fields and assumptions are traceable. Unsupported queries should be labelled as demonstrations or removed.
