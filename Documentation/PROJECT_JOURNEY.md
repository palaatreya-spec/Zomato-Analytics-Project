# Zomato Analytics — Project Journey

## Purpose

A concise record of the important project-building decisions from raw data through the current SQL analysis. This is intentionally limited to steps that are useful for reproducibility, future learning and interview explanation.

## 1. Raw data

The project starts from a compressed restaurant-level CSV dataset. The raw source is preserved and is not overwritten during processing.

## 2. Source profiling

Python was used first to inspect:

- row and column counts
- data types
- missing values and missing percentages
- unique values

This established the initial data-quality picture before cleaning.

## 3. Python cleaning and standardization

The raw dataset was converted into an analyst-ready dataset.

Key decisions:

- invalid/non-rating placeholders are treated as missing ratings
- ratings outside 1–5 are treated as invalid
- cost-for-two is converted to numeric and non-positive values are treated as unavailable
- rating counts are cleaned and negative values treated as invalid
- coordinates are split into latitude/longitude and checked against India-focused bounds
- text fields are trimmed
- service fields are standardized to 0/1 where the source value is known
- `has_rating`, `has_cost` and `coordinate_valid` flags are created

## 4. Python EDA

Basic overall, city and cuisine summaries were generated along with descriptive statistics and a Pearson correlation matrix.

The Python stage intentionally remains straightforward Pandas-based analysis appropriate for an entry-level Data Analyst portfolio project.

## 5. Validation before SQL

A validation gate checks row-count preservation, required columns, service/quality flags, URL uniqueness, rating and cost ranges, coordinate validity, duplicate rows and expected analysis outputs.

SQL loading is intended to happen only after validation passes.

## 6. MySQL layer

The cleaned dataset is loaded into `zomato_restaurants_clean`.

A separate `zomato_unit_economics` table is used later for estimated operational/financial analysis.

## 7. Exploratory SQL Q1–Q18

The exploratory analysis progressed from simple profiling to intermediate analyst-level SQL:

1. Overall dataset overview
2. Restaurant distribution by city
3. City-level restaurant performance
4. Rating distribution
5. Rating band distribution
6. Rating vs customer engagement
7. Most reviewed restaurants
8. Most common cuisine listings
9. Cuisine performance
10. Most popular cuisine listings
11. Online ordering analysis
12. Online ordering by city
13. Online ordering vs restaurant characteristics
14. Online ordering vs financial performance
15. Revenue contribution by online ordering
16. City-level financial performance
17. City ranking by average estimated revenue
18. Table reservation vs restaurant characteristics

The full SQL is stored in `SQL/05_Exploratory_Analysis.sql`.

## 8. SQL learning progression

The queries introduced:

- aggregation and grouping
- percentages and scalar subqueries
- `CASE`
- conditional aggregation
- `HAVING`
- top-N analysis
- derived tables
- window functions with `RANK()`
- contribution/share-of-total calculations

The level is intentionally **intermediate/fresher interview level**, not advanced SQL.

## 9. Important analytical caveat

The original restaurant dataset does not contain verified transaction-level revenue or customer-level behaviour. Q14–Q18 use estimated metrics from `zomato_unit_economics`.

Therefore the project should describe these as **estimated revenue/contribution-margin analysis**, not actual restaurant revenue or profit analysis.

## 10. Current checkpoint

**Completed:** raw data → Python profiling → cleaning → EDA → validation → MySQL → exploratory SQL Q1–Q18 → results and learning documentation.

**Next:** continue with the next useful intermediate-level analytical question only when it adds a distinct interview-relevant SQL concept or business insight.
