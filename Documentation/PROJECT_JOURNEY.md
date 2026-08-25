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

A schema-validation lesson was captured during Q18: `zomato_restaurants_clean` uses `zomato_url` as its primary key and does not contain `restaurant_id`, while `zomato_unit_economics` contains `RESTAURANT_ID`. We therefore do not assume a join key without checking the actual schema.

## 7. Exploratory SQL Q1–Q19

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
19. Restaurant cost vs estimated financial performance

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
- business segmentation using cost bands

The level is intentionally **intermediate/fresher interview level**, not advanced SQL.

## 9. Q19 — Cost-band financial comparison

Q19 grouped restaurants into cost bands and compared restaurant count, average estimated revenue, average contribution margin and average rating.

| Cost band | Restaurant count | Avg estimated revenue | Avg contribution margin | Avg rating |
|---|---:|---:|---:|---:|
| Under 300 | 76,739 | ₹2,678 | ₹1,211 | 3.39 |
| 300 - 599 | 101,746 | ₹15,390 | ₹10,381 | 3.46 |
| 600 - 999 | 29,529 | ₹66,170 | ₹50,496 | 3.57 |
| 1000 - 1499 | 7,267 | ₹224,024 | ₹183,715 | 3.76 |
| 1500+ | 5,591 | ₹593,412 | ₹506,202 | 3.95 |

The query used 220,872 restaurants with positive/non-null cost values, about 98.38% of the 224,520-row financial dataset.

**Useful finding:** The supplied results show a strong monotonic association: as the cost band increases, average estimated revenue, contribution margin and rating also increase. The `1500+` group has about 222× the average estimated revenue and about 418× the average contribution margin of the `Under 300` group.

**Interpretation:** This indicates that higher-cost restaurants have a substantially different observed financial profile in this model. It does **not** prove that charging more causes higher revenue or margin; restaurant type, positioning, city, demand, scale and other factors may contribute.

## 10. Important Q19 schema problem and resolution

The first Q19 attempt failed because `cost_for_two_clean` belongs to `zomato_restaurants_clean`, while the query was written against `zomato_unit_economics`.

The schema was checked and the query was corrected to use `COST_FOR_TWO`, the actual unit-economics field.

This is a relevant project-learning point because it reinforces the rule: **verify the schema of the table being queried before assuming a column exists.**

## 11. Important analytical caveats

The original restaurant dataset does not contain verified transaction-level revenue or customer-level behaviour. Q14–Q19 use estimated metrics from `zomato_unit_economics`.

Therefore the project should describe these as **estimated revenue/contribution-margin analysis**, not actual restaurant revenue or profit analysis.

Several outputs also require careful label validation. For example, supplied Q14/Q15 result tables duplicated the `Online Order Not Available` label even though the restaurant counts correspond to the available and unavailable groups. This is documented as a data-output labeling issue rather than silently treated as a new business finding.

## 12. Power BI status

The repository currently contains an earlier Power BI dashboard and screenshots, but these are **not considered the final project output**.

The Python EDA/validation work and SQL pipeline have since evolved. The Power BI model, measures, visuals and screenshots will be corrected/rebuilt **after the SQL analysis is complete and the final findings are validated**.

This avoids building the final dashboard on an outdated analytical pipeline.

## 13. Documentation approach

GitHub is being used as the project's persistent working record, not only as a code repository.

Only useful/relevant information is documented:

- meaningful project steps and decisions
- problems that affected the workflow
- how important problems were solved
- SQL/Python learning points
- validated results and business findings
- assumptions and limitations
- interview explanations
- deferred work and next steps

Routine conversation, repeated executions and irrelevant troubleshooting are intentionally not recorded.

## 14. Current checkpoint

**Completed:** raw data → Python profiling → cleaning → EDA → validation → MySQL → exploratory SQL Q1–Q19 → results and learning documentation.

**Deferred intentionally:** final Power BI rebuild and replacement screenshots.

**Not yet final:** public README and final portfolio presentation.

## 15. Next stage

Continue with useful intermediate-level SQL questions only when they add a distinct business insight or interview-relevant SQL concept. After the SQL analysis is finalized, rebuild Power BI from the reconciled pipeline, replace outdated screenshots, and then finalize the README/interview story.
