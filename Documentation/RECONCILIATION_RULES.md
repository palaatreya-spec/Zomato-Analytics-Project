# KPI Reconciliation Rules

The final dashboard should use one definition for each headline metric.

## Core reconciliation table

| KPI | Python | SQL | Power BI | Expected |
|---|---|---|---|---|
| Restaurant Count | `zomato_url.nunique()` | `COUNT(DISTINCT zomato_url)` | `DISTINCTCOUNT(zomato_url)` | Exact match |
| City Count | `city.nunique()` | `COUNT(DISTINCT city)` | `DISTINCTCOUNT(city)` | Exact match |
| Area Count | `area.nunique()` | `COUNT(DISTINCT area)` | `DISTINCTCOUNT(area)` | Exact match |
| Rated Restaurants | non-null `rating_clean` | non-null `rating_clean` URLs | `Rated Restaurants` measure | Exact match |
| Average Rating | mean valid rating | `AVG(rating_clean)` | `AVERAGE(rating_clean)` | Same rounding |
| Online Order Adoption | mean boolean | `AVG(online_order)` | adoption measure | Same percentage |
| Reservation Adoption | mean boolean | `AVG(table_reservation)` | adoption measure | Same percentage |
| Delivery Only % | mean boolean | `AVG(delivery_only)` | adoption measure | Same percentage |
| Median Cost | pandas median | use validated median implementation | `MEDIAN()` | Same definition |

## Rules

1. Do not calculate headline KPIs independently in each tool using different filters.
2. Document every exclusion, especially unrated restaurants and unusable cost values.
3. Round only for presentation; retain full precision in calculation layers.
4. Any discrepancy must be investigated before publishing screenshots or resume claims.
5. Power BI should connect to the cleaned source-backed table or validated KPI views.

## Grain

The primary grain is **one restaurant per `zomato_url`**. City and cuisine summaries are aggregations from that restaurant-level grain.
