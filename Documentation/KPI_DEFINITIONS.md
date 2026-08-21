# KPI Definitions

These definitions are intended to keep dashboard numbers consistent across SQL and Power BI.

| KPI | Definition | Interpretation |
|---|---|---|
| Restaurant Count | Count of distinct restaurants | Size of restaurant portfolio |
| Total Orders | Sum of valid order records | Order volume |
| Total Revenue | Sum of valid order `total_amount` | Transaction value represented in the model |
| Average Order Value | Total Revenue / Total Orders | Average value per order |
| Revenue Share % | Restaurant/location revenue / total revenue | Contribution to overall transaction value |
| Cumulative Revenue % | Running revenue / total revenue | Revenue concentration |
| Average Rating | Mean of valid restaurant/review ratings | Customer quality signal |
| Online Order Adoption % | Online-order restaurants / total restaurants | Digital ordering availability |
| Table Booking Adoption % | Table-booking restaurants / total restaurants | Reservation availability |
| High-Volume / High-Value | Orders >= overall average AND AOV >= overall average | Priority growth segment |
| High-Volume / Low-Value | Orders >= overall average AND AOV < overall average | Volume with value-improvement opportunity |
| Low-Volume / High-Value | Orders < overall average AND AOV >= overall average | Potential scale opportunity |
| Low-Volume / Low-Value | Orders < overall average AND AOV < overall average | Lower-priority segment for investigation |

## Metric governance

- Use `COUNT(DISTINCT restaurant_id)` when measuring restaurant count.
- Use `NULLIF` in ratios to prevent divide-by-zero errors.
- Exclude invalid negative transaction amounts from business KPIs.
- Do not mix restaurant-level and order-level denominators without explicitly stating the grain.
- Any profitability metric must include a documented cost assumption and formula.
