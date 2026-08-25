# SQL Learning Notes — Exploratory Analysis Q1–Q18

## Purpose

This file records the SQL concepts used in the exploratory analysis so the project can be revised later and explained naturally in interviews.

## Query progression

| Q | Topic | Main SQL concepts | Interview learning |
|---|---|---|---|
| 1 | Overall dataset overview | `COUNT`, `COUNT(DISTINCT)` | Basic dataset profiling directly in SQL |
| 2 | Restaurant distribution by city | `GROUP BY`, scalar subquery, percentage calculation, `ORDER BY` | Compare category volume with overall dataset |
| 3 | City-level restaurant performance | `COUNT`, `AVG`, `HAVING`, derived coverage % | Combine volume, data availability and quality metrics |
| 4 | Rating distribution | `WHERE`, `GROUP BY`, subquery | Distribution of a numeric metric |
| 5 | Rating band distribution | `CASE`, `GROUP BY`, `MIN` | Turn a continuous metric into business-friendly bands |
| 6 | Rating vs customer engagement | `CASE`, conditional `COUNT`, conditional `AVG` | Compare engagement across rating groups |
| 7 | Most reviewed restaurants | filtering, `ORDER BY`, `LIMIT` | Top-N analysis |
| 8 | Most common cuisine listings | `COUNT`, percentage subquery, text filtering | Category mix analysis |
| 9 | Cuisine performance | conditional metrics, `HAVING` | Compare performance while avoiding very small groups |
| 10 | Most popular cuisine listings | `HAVING`, `ORDER BY`, `LIMIT` | Popularity vs representation |
| 11 | Online ordering analysis | `CASE`, grouping binary fields | Convert coded fields into business labels |
| 12 | Online ordering by city | conditional `SUM`, percentage calculation, `HAVING` | Compare adoption across markets |
| 13 | Online ordering vs restaurant characteristics | conditional aggregation, `AVG` | Compare operational characteristics between groups |
| 14 | Online ordering vs financial performance | second-table analysis, grouping | Introduce estimated unit-economics metrics |
| 15 | Revenue contribution by online ordering | `SUM`, window function, nested aggregation | Calculate each group's contribution to the total |
| 16 | City-level financial performance | `GROUP BY`, `SUM`, `AVG`, `HAVING` | Compare average and total financial metrics |
| 17 | City ranking by restaurant revenue | subquery/derived table, `RANK() OVER` | First practical window-function use |
| 18 | Table reservation vs restaurant characteristics | `CASE`, conditional `AVG`, grouping | Compare restaurant characteristics by reservation availability |

## Important concepts to understand

### `COUNT(*)` vs `COUNT(column)`

- `COUNT(*)` counts rows.
- `COUNT(column)` counts non-null values.
- Q3 uses this difference to calculate rating coverage.

### `GROUP BY`

Used whenever the question asks for a metric by a category such as city, cuisine, rating band or service availability.

### `HAVING`

Used after grouping to keep sufficiently large groups. Examples include the city/cuisine analyses where a minimum restaurant count is applied.

### `CASE`

Used to create business-friendly categories such as rating bands and online-order status.

### Conditional aggregation

Examples include `SUM(online_order = 1)` and conditional `AVG(...)`. The purpose is to calculate group-specific counts or averages without creating separate queries.

### Scalar subqueries

Used in Q2, Q4, Q5, Q8 and Q10 to compare a grouped count with an overall denominator.

### Window function — `RANK()`

Q17 calculates the city-level average first and then applies `RANK() OVER (ORDER BY avg_estimated_revenue DESC)` to rank cities.

The important learning is that aggregation happens in the inner query, while ranking happens in the outer query.

### Windowed total contribution

Q15 uses:

```sql
SUM(SUM(estimated_revenue)) OVER ()
```

The inner `SUM` creates the group total and the window `SUM` calculates the overall total across those grouped results.

## SQL difficulty level

The current analysis is intentionally **intermediate/fresher interview level**, not advanced SQL. It demonstrates practical analyst skills without unnecessary complexity.

The most advanced concepts currently introduced are:

- conditional aggregation
- derived tables/subqueries
- window functions (`RANK`)
- percentage-of-total calculations

## Interview rule

Do not memorize the queries line by line. Be able to explain:

**business question → grouping/filtering → metric → why the SQL structure was chosen → result interpretation.**

## Data-model caution

Q14–Q18 use `zomato_unit_economics`, which contains estimated financial metrics. These are analytical estimates/model outputs, not verified transaction-level restaurant revenue or profit.
