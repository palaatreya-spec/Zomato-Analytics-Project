-- Zomato Restaurant Analytics — source-backed KPI layer
-- Single source of truth for dashboard-level KPI calculations.

USE zomato_analytics;

DROP VIEW IF EXISTS vw_zomato_kpis;
CREATE VIEW vw_zomato_kpis AS
SELECT
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    COUNT(DISTINCT city) AS city_count,
    COUNT(DISTINCT area) AS area_count,
    COUNT(DISTINCT CASE WHEN rating_clean IS NOT NULL THEN zomato_url END) AS rated_restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(MEDIAN(cost_for_two_clean), 2) AS median_cost_for_two,
    ROUND(100 * AVG(online_order), 2) AS online_order_adoption_pct,
    ROUND(100 * AVG(table_reservation), 2) AS reservation_adoption_pct,
    ROUND(100 * AVG(delivery_only), 2) AS delivery_only_pct,
    SUM(rating_count) AS total_rating_count
FROM zomato_restaurants_clean;

DROP VIEW IF EXISTS vw_city_kpis;
CREATE VIEW vw_city_kpis AS
SELECT
    city,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    COUNT(DISTINCT CASE WHEN rating_clean IS NOT NULL THEN zomato_url END) AS rated_restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(MEDIAN(cost_for_two_clean), 2) AS median_cost_for_two,
    SUM(rating_count) AS total_rating_count,
    ROUND(AVG(online_order) * 100, 2) AS online_order_adoption_pct,
    ROUND(AVG(table_reservation) * 100, 2) AS reservation_adoption_pct,
    ROUND(AVG(delivery_only) * 100, 2) AS delivery_only_pct
FROM zomato_restaurants_clean
GROUP BY city;

DROP VIEW IF EXISTS vw_cuisine_kpis;
CREATE VIEW vw_cuisine_kpis AS
SELECT
    cuisine,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(MEDIAN(cost_for_two_clean), 2) AS median_cost_for_two,
    SUM(rating_count) AS total_rating_count,
    ROUND(AVG(online_order) * 100, 2) AS online_order_adoption_pct,
    ROUND(AVG(table_reservation) * 100, 2) AS reservation_adoption_pct
FROM zomato_restaurants_clean
WHERE cuisine IS NOT NULL
GROUP BY cuisine;

-- QA: inspect the KPI layer before connecting Power BI.
SELECT * FROM vw_zomato_kpis;
SELECT * FROM vw_city_kpis ORDER BY restaurant_count DESC LIMIT 20;
SELECT * FROM vw_cuisine_kpis ORDER BY restaurant_count DESC LIMIT 20;
