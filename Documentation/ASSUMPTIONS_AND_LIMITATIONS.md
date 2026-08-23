# Zomato Analytics — Assumptions & Limitations

## Analytical assumptions

1. The analysis describes the project dataset and is not Zomato's internal business or financial reporting.
2. `rating_clean` represents the restaurant rating field after removing placeholder values; it is not a customer-review-level metric.
3. `cost_for_two_clean` is treated as a listed pricing measure, not realized revenue or customer spend.
4. `online_order` and `table_reservation` indicate whether the option is listed for a restaurant; they do not represent completed orders or bookings.
5. Differences between cities or cuisines are descriptive observations and do not prove causation.
6. Missing and invalid values are handled through explicit cleaning rules rather than being silently treated as valid observations.
7. Restaurant-level comparisons should consider differences in city, cuisine mix and data availability.

## Statistical interpretation

- Mean and median are used as simple measures of central tendency.
- Standard deviation is used as a basic measure of spread.
- Pearson correlation is used only to describe linear association between selected numeric fields.
- Correlation does not imply causation.
- The project does not perform predictive modelling or machine learning.

## Source-data limitations

The dataset is restaurant-level and does not provide verified customer-level transactions, order-level revenue, profit, retention or customer lifetime value.

Therefore, these metrics are outside the project scope.

## Reproducibility

1. Decompress the `.zst` source file locally.
2. Place the CSV in the `Data/` folder.
3. Run `Python/run_pipeline.py`.
4. Review the generated files in `Data/processed/`.
5. Load the cleaned CSV into MySQL using `SQL/01_Table_Setup.sql`.
6. Run the SQL quality checks and analysis scripts.
7. Use the same definitions when building the Power BI dashboard.

## Interpretation guidance

Findings should be presented as analysis of the project dataset. They should not be described as official Zomato business performance or as causal business conclusions.
