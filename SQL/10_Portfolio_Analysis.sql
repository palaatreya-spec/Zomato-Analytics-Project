-- Zomato Restaurant Analytics
-- Portfolio analysis using the relational SQL model.
-- Run after the base tables and analytical views have been created.

USE zomato_analytics;

-- 1. Revenue concentration: contribution of each restaurant to total revenue
WITH restaurant_revenue AS (
    SELECT
        restaurant_id,
        name,
        location,
        cuisine,
        COALESCE(total_revenue, 0) AS total_revenue
    FROM restaurant_performance
),
ranked AS (
    SELECT
        *,
        SUM(total_revenue) OVER () AS platform_revenue,
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS revenue_rank
    FROM restaurant_revenue
)
SELECT
    revenue_rank,
    restaurant_id,
    name,
    location,
    cuisine,
    total_revenue,
    ROUND(100 * total_revenue / NULLIF(platform_revenue, 0), 2) AS revenue_share_pct,
    ROUND(100 * cumulative_revenue / NULLIF(platform_revenue, 0), 2) AS cumulative_revenue_pct
FROM ranked
ORDER BY revenue_rank;

-- 2. Restaurant portfolio segmentation using volume and order value
WITH metrics AS (
    SELECT
        restaurant_id,
        name,
        location,
        cuisine,
        COALESCE(total_orders, 0) AS total_orders,
        COALESCE(total_revenue, 0) AS total_revenue,
        COALESCE(avg_order_value, 0) AS avg_order_value
    FROM restaurant_performance
),
benchmarks AS (
    SELECT
        *,
        AVG(total_orders) OVER () AS avg_orders_all,
        AVG(avg_order_value) OVER () AS avg_aov_all
    FROM metrics
)
SELECT
    restaurant_id,
    name,
    location,
    cuisine,
    total_orders,
    total_revenue,
    avg_order_value,
    CASE
        WHEN total_orders >= avg_orders_all AND avg_order_value >= avg_aov_all THEN 'High Volume / High Value'
        WHEN total_orders >= avg_orders_all AND avg_order_value < avg_aov_all THEN 'High Volume / Low Value'
        WHEN total_orders < avg_orders_all AND avg_order_value >= avg_aov_all THEN 'Low Volume / High Value'
        ELSE 'Low Volume / Low Value'
    END AS portfolio_segment
FROM benchmarks
ORDER BY total_revenue DESC;

-- 3. Location performance with revenue and restaurant concentration
SELECT
    location,
    COUNT(*) AS restaurant_count,
    SUM(COALESCE(total_orders, 0)) AS total_orders,
    SUM(COALESCE(total_revenue, 0)) AS total_revenue,
    ROUND(AVG(COALESCE(avg_order_value, 0)), 2) AS avg_order_value
FROM restaurant_performance
GROUP BY location
HAVING COUNT(*) >= 1
ORDER BY total_revenue DESC;

-- 4. Cuisine performance: supply, rating and revenue
SELECT
    cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating), 2) AS avg_rating,
    SUM(COALESCE(total_orders, 0)) AS total_orders,
    SUM(COALESCE(total_revenue, 0)) AS total_revenue,
    ROUND(AVG(COALESCE(avg_order_value, 0)), 2) AS avg_order_value
FROM restaurant_performance
WHERE cuisine IS NOT NULL
GROUP BY cuisine
ORDER BY total_revenue DESC;

-- 5. Rating vs order activity: descriptive comparison, not causal inference
SELECT
    CASE
        WHEN rating >= 4.5 THEN '4.5–5.0'
        WHEN rating >= 4.0 THEN '4.0–4.4'
        WHEN rating >= 3.5 THEN '3.5–3.9'
        WHEN rating >= 3.0 THEN '3.0–3.4'
        ELSE '<3.0'
    END AS rating_band,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(total_orders), 2) AS avg_orders,
    ROUND(AVG(avg_order_value), 2) AS avg_order_value,
    ROUND(SUM(COALESCE(total_revenue, 0)), 2) AS total_revenue
FROM restaurant_performance
WHERE rating IS NOT NULL
GROUP BY rating_band
ORDER BY rating_band DESC;

-- 6. Online ordering and table-booking adoption by location
SELECT
    location,
    COUNT(*) AS restaurant_count,
    SUM(CASE WHEN online_order = TRUE THEN 1 ELSE 0 END) AS online_order_restaurants,
    ROUND(100 * SUM(CASE WHEN online_order = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS online_order_adoption_pct,
    SUM(CASE WHEN table_booking = TRUE THEN 1 ELSE 0 END) AS table_booking_restaurants,
    ROUND(100 * SUM(CASE WHEN table_booking = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS table_booking_adoption_pct
FROM restaurants
GROUP BY location
ORDER BY restaurant_count DESC;
