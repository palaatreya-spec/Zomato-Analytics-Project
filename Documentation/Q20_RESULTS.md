# Q20 — Delivery-Only Restaurants vs Performance

## Business question

Do delivery-only restaurants show a different customer and financial profile compared with restaurants that are not classified as delivery-only?

## SQL approach

The analysis groups `zomato_unit_economics` using `delivery_only` after normalizing text with `LOWER(TRIM())`. It compares restaurant count, rating, rating activity, cost for two, estimated revenue and contribution margin.

### SQL concepts used

- `CASE` for business-friendly categories
- `LOWER()` and `TRIM()` for text normalization
- `GROUP BY`
- Conditional `AVG()` for rating activity
- `COUNT()` and aggregate comparison

## Validated result

| Delivery status | Restaurant count | Avg rating | Avg rating count | Avg cost for two | Avg estimated revenue | Avg contribution margin |
|---|---:|---:|---:|---:|---:|---:|
| Not Delivery Only | 210,442 | 3.49 | 153 | ₹419 | ₹40,323 | ₹31,649.10 |
| Delivery Only | 14,078 | 3.50 | 95 | ₹404 | ₹13,166 | ₹9,637.51 |

## Key findings

- Delivery-only restaurants represent **14,078 of 224,520 records (~6.27%)** in this grouped result, while the non-delivery-only group represents the remaining majority.
- Average ratings are almost identical: **3.50** for delivery-only versus **3.49** for not delivery-only.
- Delivery-only restaurants have lower observed rating activity: **95 vs 153 average ratings**.
- Average cost for two is slightly lower for delivery-only restaurants: **₹404 vs ₹419**.
- Average estimated revenue is substantially lower for delivery-only restaurants: **₹13,166 vs ₹40,323**, about **67% lower**.
- Average contribution margin is also substantially lower: **₹9,637.51 vs ₹31,649.10**, about **70% lower**.

## Interpretation

The result suggests that delivery-only restaurants have a broadly similar average rating but lower observed customer engagement and much lower estimated financial performance than restaurants not classified as delivery-only.

This is an **observational association**, not proof that delivery-only status causes lower revenue or margin. Other factors such as restaurant type, scale, location, pricing, order volume and dataset assumptions may contribute to the difference.

## Data / query caveat

The query uses `CASE WHEN LOWER(TRIM(delivery_only)) = 'true' THEN 'Delivery Only' ELSE 'Not Delivery Only' END`. Therefore every value other than normalized `true` is included in `Not Delivery Only`, including any `false`, null, blank or unexpected text values if present. This should be checked if a stricter binary comparison is needed later.

The financial metrics are **estimated/modelled metrics**, not actual Zomato financial statements or transaction revenue.

## Interview explanation

> "I compared delivery-only and other restaurants across rating, customer engagement, pricing and estimated financial performance. The ratings were almost identical, but delivery-only restaurants had lower average rating activity and substantially lower estimated revenue and contribution margin. I would present this as an observed association rather than a causal relationship because the dataset does not establish causality."

## Project status

**Q20 validated from the MySQL result provided during the project workflow.**

Power BI has intentionally **not** been updated from this result yet. The dashboard and screenshots will be rebuilt after the SQL analysis stage is finalized, using the finalized SQL findings as the source of truth.
