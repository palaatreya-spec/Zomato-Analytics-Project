# KPI Reconciliation Rules

The same KPI must produce the same result across Python, SQL and Power BI, subject only to documented rounding.

| KPI | Python | SQL | Power BI |
|---|---|---|---|
| Restaurant Count | `nunique(zomato_url)` | `COUNT(DISTINCT zomato_url)` | `DISTINCTCOUNT(zomato_url)` |
| City Count | `nunique(city)` | `COUNT(DISTINCT city)` | `DISTINCTCOUNT(city)` |
| Area Count | `nunique(area)` | `COUNT(DISTINCT area)` | `DISTINCTCOUNT(area)` |
| Rated Restaurants | non-null `rating_clean` | non-null `rating_clean` | non-blank `rating_clean` |
| Average Rating | mean of valid ratings | `AVG(rating_clean)` | `AVERAGE(rating_clean)` |
| Online Order Adoption | mean boolean × 100 | `AVG(online_order) × 100` | `[Online Order Restaurants] / [Restaurant Count]` |
| Reservation Adoption | mean boolean × 100 | `AVG(table_reservation) × 100` | `[Reservation Restaurants] / [Restaurant Count]` |
| Delivery-only % | mean boolean × 100 | `AVG(delivery_only) × 100` | `[Delivery Only Restaurants] / [Restaurant Count]` |
| Median Cost | median of positive cleaned cost | validated percentile/median query | `MEDIAN(cost_for_two_clean)` |

## Reconciliation protocol

1. Run Python on the raw source.
2. Import the processed output into MySQL.
3. Run the SQL KPI views.
4. Connect Power BI to the same cleaned table.
5. Compare core KPIs using the same filters and grain.
6. Investigate any mismatch before publishing dashboard screenshots.

## Important

Rounding differences are acceptable only when the underlying unrounded values reconcile. Definition differences are not acceptable unless explicitly documented.

The primary grain is **one restaurant per `zomato_url`**. City and cuisine summaries are aggregations from that restaurant-level grain.
