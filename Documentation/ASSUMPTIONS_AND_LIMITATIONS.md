# Zomato Analytics — Assumptions & Limitations

## Analytical assumptions

1. Metrics are project-level analytical outputs and must not be presented as Zomato's internal financial reporting.
2. Restaurant `rating` and review-level ratings are separate concepts; review-level averages are used only where explicitly defined.
3. Relationships between rating, ordering activity, pricing, reservations, or operating model are observational and do not establish causation.
4. `cost_for_two` is treated as a listed pricing proxy, not realized customer spend.
5. Restaurant comparisons should account for differences in location, cuisine mix, data coverage, and observation counts.
6. Missing, invalid, duplicate, and referential-integrity issues should be measured before transformation; cleaning rules are documented in the SQL layer.
7. Any profitability, contribution-margin, or revenue-estimation metric that is not directly present in the source data must be labelled as a derived assumption and accompanied by its formula.

## Source-data limitation

The repository contains a compressed restaurant source dataset at `Data/india_all_restaurants_details.csv.zst`. The GitHub connector can identify the file and its blob, but the compressed binary cannot be safely decoded through the repository text interface. Therefore, the source schema must be profiled locally before replacing the current relational SQL model with source-specific tables.

## Relational-model limitation

The SQL workflow currently demonstrates a relational analytics model containing restaurants, customers, orders, order items, and reviews. The base table definitions and loading scripts require those corresponding source files. The workflow should not be described as a reproducible transformation of the compressed restaurant dataset until those relationships are actually available or explicitly simulated.

## Reproducibility rule

Before making source-specific changes:

1. Decompress the `.zst` file.
2. Record the exact column names, data types, row count, null rates, duplicate rate, and representative values.
3. Map source columns to the analytical model.
4. Document any assumptions required for derived metrics.
5. Run data-quality checks before cleaning.
6. Re-run the downstream SQL/Power BI outputs after the model is aligned.

## Interpretation guidance

The project demonstrates an end-to-end analytics workflow: source profiling, validation, cleaning, SQL transformation, business analysis, and BI reporting. Findings should be presented as analysis of the project dataset, not as official Zomato business performance.
