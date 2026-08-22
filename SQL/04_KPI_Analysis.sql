-- Zomato Restaurant Analytics — KPI analysis
-- Simple KPIs that can be used in the Power BI dashboard.

USE zomato_analytics;

-- 1. Overall KPIs
SELECT
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    COUNT(DISTINCT city) AS city_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(CASE WHEN cost_for_two_clean > 0 THEN cost_for_two_clean END), 2) AS avg_cost_for_two,
    ROUND(100 * AVG(online_order), 2) AS online_order_pct,
    ROUND(100 * AVG(table_reservation), 2) AS table_reservation_pct,
    SUM(rating_count) AS total_rating_count
FROM zomato_restaurants_clean;

-- 2. City KPIs
SELECT
    city,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(CASE WHEN cost_for_two_clean > 0 THEN cost_for_two_clean END), 2) AS avg_cost_for_two,
    SUM(rating_count) AS total_rating_count
FROM zomato_restaurants_clean
GROUP BY city
ORDER BY restaurant_count DESC;

-- 3. Cuisine KPIs
SELECT
    cuisine,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(CASE WHEN cost_for_two_clean > 0 THEN cost_for_two_clean END), 2) AS avg_cost_for_two
FROM zomato_restaurants_clean
WHERE cuisine IS NOT NULL
GROUP BY cuisine
ORDER BY restaurant_count DESC;
