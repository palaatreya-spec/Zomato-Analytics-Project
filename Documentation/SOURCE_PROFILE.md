# Zomato Restaurant Source Profile

Profiled from the uploaded `india_all_restaurants_details.csv.zst` source on 2026-08-21.

## Dataset overview

| Metric | Result |
|---|---:|
| Rows | 224,520 |
| Columns | 18 |
| Cities | 83 |
| Areas | 2,501 |
| Unique Zomato URLs | 224,520 |
| Exact duplicate rows | 0 |
| Duplicate name + city rows | 53,584 |
| Duplicate name + area + city rows | 9,152 |

## Source columns

`Unnamed: 0`, `sno`, `zomato_url`, `name`, `city`, `area`, `rating`, `rating_count`, `telephone`, `cusine`, `cost_for_two`, `address`, `coordinates`, `timings`, `online_order`, `table_reservation`, `delivery_only`, `famous_food`

## Missingness

| Column | Missing |
|---|---:|
| `famous_food` | 76.61% |
| `timings` | 1.32% |
| `address` | 0.80% |
| All other columns | 0% |

## Rating quality

The source contains three important rating states:

- Numeric ratings from 1.8 to 4.9
- `0`, which appears in 52,052 rows and should be treated as an unrated/placeholder value rather than a genuine zero-star rating
- `NEW` / `Nové`, appearing in 27,733 rows, which should be treated as unrated

After excluding unrated values, **144,735 restaurants have a usable 1–5 rating** and the average valid rating is approximately **3.49**.

## Pricing quality

`cost_for_two` is stored as mixed text/numeric data. Comma-formatted values such as `1,000` require numeric standardization.

After numeric parsing:

- 3,648 rows have a zero cost value
- 47 rows have cost-for-two above ₹5,000
- Median positive cost-for-two: **₹300**
- 75th percentile: **₹500**
- 95th percentile: **₹1,000**
- 99th percentile: **₹2,000**

These values are a **listed pricing proxy**, not realized customer spend or revenue.

## Digital / operating attributes

| Attribute | True | Share |
|---|---:|---:|
| Online ordering | 111,310 | 49.58% |
| Table reservation | 6,621 | 2.95% |
| Delivery only | 14,078 | 6.27% |

Approximately 1.72% of restaurants have both online ordering and table reservation enabled.

## Location quality

The source contains 83 cities. The largest city groups are:

1. Delhi NCR — 38,699
2. Mumbai — 25,692
3. Bengaluru — 20,283
4. Pune — 15,430
5. Hyderabad — 12,393
6. Chennai — 11,917
7. Kolkata — 9,571
8. Ahmedabad — 6,432
9. Jaipur — 5,367
10. Chandigarh — 4,278

## Coordinate quality

Coordinates are populated, but **12,869 rows fall outside a reasonable India bounding box (latitude 6–38, longitude 68–98)**. These should be flagged as invalid rather than silently used for geographic analysis.

## Key modelling conclusions

1. `zomato_url` is a strong candidate for a source-level unique business key because it is unique across all 224,520 rows.
2. `sno` should **not** be assumed to be a unique restaurant identifier because it has only 136,397 unique values.
3. `rating` requires explicit normalization before analysis.
4. `cost_for_two` requires numeric parsing before analysis.
5. Restaurant name duplication is common and should not automatically be treated as erroneous because chains and repeated names can legitimately occur across locations.
6. The dataset is suitable for restaurant-level, location-level, cuisine-level, pricing-proxy, rating, and digital-adoption analysis.
7. The dataset does **not** contain verified customer-level transaction history, order-level revenue, order items, or review-level records in the uploaded source. Those should not be presented as source-backed findings from this dataset.
