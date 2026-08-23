# Source-to-SQL Mapping

## Purpose

This document shows how the cleaned restaurant dataset flows from Python into MySQL.

## Source dataset

`Data/india_all_restaurants_details.csv.zst`

The compressed source is decompressed locally before the Python pipeline is run.

## Transformation flow

```text
Raw source columns
      ↓
Python / Pandas cleaning
      ↓
zomato_restaurants_clean.csv
      ↓
MySQL: zomato_restaurants_clean
      ↓
SQL analysis and KPIs
```

## Main field mapping

| Source field | Cleaned field | SQL field | Transformation |
|---|---|---|---|
| `zomato_url` | `zomato_url` | `zomato_url` | Used as restaurant-level identifier |
| `name` | `name` | `name` | Trim whitespace |
| `city` | `city` | `city` | Trim whitespace |
| `area` | `area` | `area` | Trim whitespace |
| `cusine` | `cuisine` | `cuisine` | Rename + trim whitespace |
| `rating` | `rating_clean` | `rating_clean` | Convert to numeric; placeholders become missing |
| `rating_count` | `rating_count` | `rating_count` | Remove comma formatting + numeric conversion |
| `cost_for_two` | `cost_for_two_clean` | `cost_for_two_clean` | Remove comma formatting + numeric conversion |
| `online_order` | `online_order` | `online_order` | `Yes/No → 1/0` |
| `table_reservation` | `table_reservation` | `table_reservation` | `Yes/No → 1/0` |
| `coordinates` | `latitude`, `longitude` | `latitude`, `longitude` | Split into two numeric fields |

## Quality fields created in Python

| Cleaned field | Purpose |
|---|---|
| `has_rating` | Identifies rows with a usable rating |
| `has_cost` | Identifies rows with a positive numeric cost |
| `coordinate_valid` | Basic geographic validity check |

## Analytical scope

The SQL layer uses the cleaned restaurant table for:

- restaurant counts
- city analysis
- rating analysis
- pricing analysis
- cuisine analysis
- online-order adoption
- table-reservation adoption
- basic data-quality checks

No customer, order, revenue, profit or retention model is created because those fields are not present in the source dataset.
