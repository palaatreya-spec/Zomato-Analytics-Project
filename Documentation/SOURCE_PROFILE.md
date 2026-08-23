# Zomato Restaurant Source Profile

Profile of the `india_all_restaurants_details.csv.zst` source dataset used in the project.

> The figures below are the currently documented source-profile results. They should be rechecked against the local decompressed file before being used as final portfolio headline numbers.

## Dataset overview

| Metric | Result |
|---|---:|
| Rows | 224,520 |
| Columns | 18 |
| Cities | 83 |
| Areas | 2,501 |
| Unique Zomato URLs | 224,520 |
| Exact duplicate rows | 0 |

## Source columns

`Unnamed: 0`, `sno`, `zomato_url`, `name`, `city`, `area`, `rating`, `rating_count`, `telephone`, `cusine`, `cost_for_two`, `address`, `coordinates`, `timings`, `online_order`, `table_reservation`, `delivery_only`, `famous_food`

## Data-quality observations

### Ratings

The source contains numeric ratings as well as placeholder values such as `0`, `NEW` and `Nové`.

For analysis, these placeholder values are treated as missing rather than genuine ratings.

### Pricing

`cost_for_two` is stored as mixed text/numeric data. Values such as `1,000` need numeric standardization before aggregation.

This field represents **listed cost-for-two**, not revenue or actual customer spend.

### Digital attributes

The source includes fields for online ordering and table reservation. These are availability/listing indicators and should not be interpreted as completed transactions.

### Coordinates

Coordinates can be checked against a simple India geographic range of approximately latitude 6–38 and longitude 68–98. Records outside that range are flagged rather than silently used for geographic analysis.

## Key modelling conclusions

1. `zomato_url` is used as the practical restaurant-level identifier for this project.
2. `sno` is not assumed to be a unique restaurant identifier.
3. Ratings require explicit cleaning before calculating averages.
4. Cost-for-two requires numeric conversion before aggregation.
5. Repeated restaurant names are not automatically treated as duplicates because chains and repeated names can legitimately exist across locations.
6. The dataset supports restaurant-level, city-level, cuisine-level, rating, pricing and digital-adoption analysis.
7. The source does not provide verified customer-level transaction history, order-level revenue, order items or review-level records, so those metrics are outside the project scope.
