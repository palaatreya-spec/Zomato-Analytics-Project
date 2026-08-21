-- Zomato Analytics — Analyst Quality Gates
-- Run after loading/cleaning the relational model.
-- These checks are intentionally non-destructive: they report issues rather than deleting data.

USE zomato_analytics;

-- 1. Primary-key uniqueness / population
SELECT 'restaurants' AS table_name,
       COUNT(*) AS rows_checked,
       COUNT(restaurant_id) AS non_null_ids,
       COUNT(DISTINCT restaurant_id) AS distinct_ids
FROM restaurants
UNION ALL
SELECT 'customers', COUNT(*), COUNT(customer_id), COUNT(DISTINCT customer_id) FROM customers
UNION ALL
SELECT 'orders', COUNT(*), COUNT(order_id), COUNT(DISTINCT order_id) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*), COUNT(order_item_id), COUNT(DISTINCT order_item_id) FROM order_items
UNION ALL
SELECT 'reviews', COUNT(*), COUNT(review_id), COUNT(DISTINCT review_id) FROM reviews;

-- 2. Restaurant KPI readiness
SELECT
    COUNT(*) AS restaurants,
    SUM(name IS NULL OR TRIM(name) = '') AS missing_name,
    SUM(location IS NULL OR TRIM(location) = '') AS missing_location,
    SUM(cuisine IS NULL OR TRIM(cuisine) = '') AS missing_cuisine,
    SUM(rating IS NULL) AS missing_rating,
    SUM(cost_for_two IS NULL) AS missing_cost
FROM restaurants;

-- 3. Transaction KPI readiness
SELECT
    COUNT(*) AS orders,
    SUM(order_date IS NULL) AS missing_order_date,
    SUM(total_amount IS NULL) AS missing_amount,
    SUM(total_amount < 0) AS negative_amounts,
    SUM(total_amount = 0) AS zero_amounts
FROM orders;

-- 4. Referential-integrity gate
SELECT
    (SELECT COUNT(*) FROM orders o LEFT JOIN customers c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL) AS orphan_customer_orders,
    (SELECT COUNT(*) FROM orders o LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id WHERE r.restaurant_id IS NULL) AS orphan_restaurant_orders,
    (SELECT COUNT(*) FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id WHERE o.order_id IS NULL) AS orphan_order_items,
    (SELECT COUNT(*) FROM reviews rv LEFT JOIN restaurants r ON rv.restaurant_id = r.restaurant_id WHERE r.restaurant_id IS NULL) AS orphan_reviews;

-- 5. Rating validity gate
SELECT
    SUM(rating < 1 OR rating > 5) AS invalid_restaurant_ratings
FROM restaurants;

SELECT
    SUM(rating < 1 OR rating > 5) AS invalid_review_ratings
FROM reviews;

-- 6. Metric grain reminder
-- Restaurant-level KPIs: restaurant_performance / restaurants
-- Order-level KPIs: orders / order_details
-- Customer-level KPIs: customer_insights / customers
-- Do not combine denominators across grains without an explicit aggregation step.
