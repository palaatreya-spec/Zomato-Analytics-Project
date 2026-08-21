-- Zomato Restaurant Analytics
-- Extended data-quality checks for the relational model.
-- Results should be reviewed before downstream analysis.

USE zomato_analytics;

-- 1. Row counts
SELECT 'restaurants' AS table_name, COUNT(*) AS row_count FROM restaurants
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;

-- 2. Restaurant completeness
SELECT
    COUNT(*) AS total_restaurants,
    SUM(name IS NULL OR TRIM(name) = '') AS missing_name,
    SUM(location IS NULL OR TRIM(location) = '') AS missing_location,
    SUM(cuisine IS NULL OR TRIM(cuisine) = '') AS missing_cuisine,
    SUM(rating IS NULL) AS missing_rating,
    SUM(cost_for_two IS NULL) AS missing_cost_for_two
FROM restaurants;

-- 3. Restaurant value-range checks
SELECT
    SUM(rating < 1 OR rating > 5) AS invalid_rating_count,
    SUM(cost_for_two < 0) AS negative_cost_count
FROM restaurants;

-- 4. Duplicate restaurant candidates
SELECT
    name,
    location,
    COUNT(*) AS duplicate_count
FROM restaurants
GROUP BY name, location
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 5. Referential integrity checks
SELECT
    COUNT(*) AS orphaned_orders
FROM orders o
LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

SELECT
    COUNT(*) AS orphaned_customer_orders
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT
    COUNT(*) AS orphaned_order_items
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 6. Transaction validity
SELECT
    SUM(total_amount IS NULL) AS missing_order_amount,
    SUM(total_amount < 0) AS negative_order_amount,
    SUM(order_date IS NULL) AS missing_order_date
FROM orders;

-- 7. Review validity
SELECT
    SUM(rating IS NULL) AS missing_review_rating,
    SUM(rating < 1 OR rating > 5) AS invalid_review_rating
FROM reviews;

-- 8. Data-quality scorecard
SELECT
    'Restaurant names populated' AS check_name,
    CASE WHEN SUM(name IS NULL OR TRIM(name) = '') = 0 THEN 'PASS' ELSE 'REVIEW' END AS status
FROM restaurants
UNION ALL
SELECT
    'Restaurant ratings within expected range',
    CASE WHEN SUM(rating < 1 OR rating > 5) = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM restaurants
UNION ALL
SELECT
    'Restaurant costs non-negative',
    CASE WHEN SUM(cost_for_two < 0) = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM restaurants
UNION ALL
SELECT
    'Orders have valid restaurant references',
    CASE WHEN (
        SELECT COUNT(*)
        FROM orders o
        LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id
        WHERE r.restaurant_id IS NULL
    ) = 0 THEN 'PASS' ELSE 'REVIEW' END;
