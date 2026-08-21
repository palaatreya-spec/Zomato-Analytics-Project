# Source-to-SQL Mapping

## Why this document exists

A portfolio analytics project should make the lineage between source fields and analytical metrics explicit. The repository currently contains a compressed restaurant source file, while the SQL schema defines a broader transactional model.

## Current source artifact

`Data/india_all_restaurants_details.csv.zst`

The compressed file is stored in GitHub, but its binary contents cannot be decoded through the repository text interface. Therefore the exact source columns are **not guessed here**.

## Current SQL model

The SQL schema currently defines:

- `restaurants`
- `customers`
- `orders`
- `order_items`
- `reviews`

The schema is explicitly defined in `SQL/01_Create_Database_And_Table.sql`, and the loading script expects five corresponding CSV files. fileciteturn68file0L2-L6 fileciteturn69file0L2-L6

## Mapping status

| Analytical entity | Source mapping | Status |
|---|---|---|
| Restaurants | Compressed restaurant dataset | **Needs profiling** |
| Customers | No verified source file | **Unverified** |
| Orders | No verified source file | **Unverified** |
| Order items | No verified source file | **Unverified** |
| Reviews | No verified source file | **Unverified** |

## Rule for the final portfolio version

Only source-backed fields should be used for final findings. If customer/order/review data are intentionally retained as a separate demonstration dataset, they must be explicitly labelled as an extended/synthetic relational layer rather than implied to come from the compressed restaurant source.

## Required next step

Profile the compressed source locally and record:

- row count
- exact column names
- inferred data types
- null percentage
- duplicate count
- unique counts for identifiers/categories
- numeric ranges
- representative categorical values

Then replace this mapping table with the verified source-to-model mapping.
