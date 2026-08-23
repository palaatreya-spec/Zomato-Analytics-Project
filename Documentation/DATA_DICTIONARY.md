# Zomato Analytics — Data Dictionary

## Purpose

This document describes the main fields used in the cleaned restaurant-level dataset and the SQL/Power BI analysis.

## Restaurant fields

| Column | Type | Description |
|---|---|---|
| `zomato_url` | TEXT | Restaurant-level identifier used to count unique restaurants |
| `name` | TEXT | Restaurant name |
| `city` | TEXT | City/location label |
| `area` | TEXT | Area/locality |
| `cuisine` | TEXT | Cuisine information from the source |
| `rating_clean` | DECIMAL | Cleaned restaurant rating; placeholder values are treated as missing |
| `rating_count` | INT | Number of ratings listed in the source |
| `cost_for_two_clean` | DECIMAL | Cleaned listed cost-for-two |
| `online_order` | INT | 1 if online ordering is listed, otherwise 0 |
| `table_reservation` | INT | 1 if table reservation is listed, otherwise 0 |
| `latitude` | DECIMAL | Parsed latitude from the source coordinates |
| `longitude` | DECIMAL | Parsed longitude from the source coordinates |

## Data-quality fields

| Column | Description |
|---|---|
| `has_rating` | Indicates whether a usable restaurant rating is available |
| `has_cost` | Indicates whether a positive numeric cost-for-two value is available |
| `coordinate_valid` | Basic check that latitude/longitude fall within India's expected geographic range |

## Derived analysis fields

The analysis may create simple categories such as:

- **Price Band:** Budget, Mid, Premium and Luxury based on listed cost-for-two.
- **Rating Band:** Groups valid ratings into simple ranges such as `<3.0`, `3.0–3.4`, `3.5–3.9`, `4.0–4.4` and `4.5+`.

## Important metric notes

- `cost_for_two_clean` is a listed pricing field, not restaurant revenue.
- `rating_clean` excludes placeholder values such as `0`, `NEW` and `Nové` from valid-rating calculations.
- `online_order` and `table_reservation` are availability indicators from the source data, not completed transaction measures.
- The dataset does not contain customer-level orders, revenue, profit or retention data.
- `zomato_url` is used as the practical restaurant-level identifier for this analysis.
