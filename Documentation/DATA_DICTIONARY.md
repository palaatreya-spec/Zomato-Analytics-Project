# Zomato Analytics — Data Dictionary

## Purpose

This document defines the core fields used by the SQL analytics workflow so that metric definitions and transformations are easy to understand and reproduce.

## Restaurants

| Column | Type | Description |
|---|---|---|
| `restaurant_id` | INT | Unique restaurant identifier |
| `name` | VARCHAR | Restaurant name |
| `location` | VARCHAR | Restaurant location/city label |
| `cuisine` | VARCHAR | Cuisine category |
| `rating` | DECIMAL | Restaurant rating on a 1–5 scale |
| `cost_for_two` | INT | Listed cost for two |
| `online_order` | BOOLEAN | Whether online ordering is available |
| `table_booking` | BOOLEAN | Whether table booking is available |
| `total_orders` | INT | Derived order count |
| `average_rating` | DECIMAL | Average rating calculated from review records |

## Customers

| Column | Type | Description |
|---|---|---|
| `customer_id` | INT | Unique customer identifier |
| `name` | VARCHAR | Customer name |
| `email` | VARCHAR | Customer email; unique when available |
| `phone` | VARCHAR | Customer phone number |
| `total_spent` | DECIMAL | Derived total order value |
| `order_count` | INT | Derived number of orders |

## Orders

| Column | Type | Description |
|---|---|---|
| `order_id` | INT | Unique order identifier |
| `customer_id` | INT | Customer placing the order |
| `restaurant_id` | INT | Restaurant receiving the order |
| `order_date` | DATETIME | Order timestamp |
| `total_amount` | DECIMAL | Total order value |
| `revenue_per_item` | DECIMAL | Derived order value divided by item quantity |

## Reviews

| Column | Type | Description |
|---|---|---|
| `review_id` | INT | Unique review identifier |
| `customer_id` | INT | Customer submitting the review |
| `restaurant_id` | INT | Restaurant being reviewed |
| `rating` | DECIMAL | Review rating on a 1–5 scale |
| `review_text` | TEXT | Review content |
| `review_date` | DATE | Review date |

## Order Items

| Column | Type | Description |
|---|---|---|
| `order_item_id` | INT | Unique order-item identifier |
| `order_id` | INT | Parent order |
| `item_name` | VARCHAR | Ordered item |
| `price` | DECIMAL | Item price |
| `quantity` | INT | Quantity ordered |

## Important metric notes

- `total_revenue` is calculated from order `total_amount` in the analytical views.
- `avg_order_value` is the average order `total_amount` for the relevant population.
- `average_rating` is calculated from the `reviews` table and may differ from the source restaurant rating.
- Derived metrics should be interpreted according to the project dataset and assumptions; they should not be treated as Zomato's actual internal financial metrics.
