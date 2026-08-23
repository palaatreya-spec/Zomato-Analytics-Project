# Data Cleaning Principles

The project uses Python/Pandas to create a cleaned restaurant-level dataset from the raw source.

## Cleaning approach

1. **Profile before cleaning** — inspect rows, columns, missing values and data types first.
2. **Keep the raw source unchanged** — cleaning is performed on a working DataFrame and saved as a separate processed CSV.
3. **Clean ratings** — values such as `0`, `NEW` and `Nové` are treated as unavailable ratings and converted to missing values.
4. **Clean cost-for-two** — remove formatting such as commas and convert the field to numeric.
5. **Clean rating counts** — convert rating counts to numeric where possible.
6. **Clean text fields** — trim fields such as restaurant name, city, area and cuisine.
7. **Create analysis-friendly flags** — convert online-order and table-reservation availability into simple 1/0 fields.
8. **Validate coordinates** — create a basic flag for coordinates within a reasonable India geographic range.
9. **Create quality flags** — keep simple indicators such as `has_rating` and `has_cost` so missing/invalid values remain visible.

## What we do not do

- No arbitrary deletion of restaurants based only on missing ratings.
- No revenue or customer metrics are created from pricing fields.
- No ML-based imputation is used.
- No advanced scoring model is applied.

## Validation principle

After cleaning, the project checks row counts, unique restaurant identifiers, missing important fields, rating validity, cost validity and duplicate URLs through the SQL data-quality script.

The goal is a clean, explainable dataset that can be used consistently by Python, MySQL and Power BI.
