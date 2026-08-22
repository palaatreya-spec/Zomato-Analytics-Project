-- Zomato Restaurant Analytics — Source-backed analysis
-- Beginner-to-intermediate Data Analyst SQL.
-- These queries use only fields available in the cleaned restaurant-level table.

USE zomato_analytics;

-- 1. Restaurant supply and average metrics by city
SELECT
    city,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(cost_for_two_clean), 2) AS avg_cost_for_two,
    ROUND(100 * AVG(online_order), 2) AS online_order_adoption_pct,
    ROUND(100 * AVG(table_reservation), 2) AS table_reservation_adoption_pct
FROM zomato_restaurants_clean
GROUP BY city
ORDER BY restaurant_count DESC;

-- 2. City comparison for cities with at least 100 restaurants
SELECT
    city,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(cost_for_two_clean), 2) AS avg_cost_for_two,
    SUM(rating_count) AS total_rating_count
FROM zomato_restaurants_clean
GROUP BY city
HAVING COUNT(DISTINCT zomato_url) >= 100
ORDER BY total_rating_count DESC;

-- 3. Pricing bands by city
SELECT
    city,
    CASE
        WHEN cost_for_two_clean <= 200 THEN 'Budget (<=200)'
        WHEN cost_for_two_clean <= 500 THEN 'Mid (201-500)'
        WHEN cost_for_two_clean <= 1000 THEN 'Premium (501-1000)'
        ELSE 'Luxury (>1000)'
    END AS price_band,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating
FROM zomato_restaurants_clean
WHERE cost_for_two_clean > 0
GROUP BY city, price_band
ORDER BY city, restaurant_count DESC;

-- 4. Rating-band analysis
SELECT
    CASE
        WHEN rating_clean < 3 THEN '<3.0'
        WHEN rating_clean < 3.5 THEN '3.0-3.4'
        WHEN rating_clean < 4 THEN '3.5-3.9'
        WHEN rating_clean < 4.5 THEN '4.0-4.4'
        ELSE '4.5+'
    END AS rating_band,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating_count), 1) AS avg_rating_count,
    ROUND(AVG(cost_for_two_clean), 2) AS avg_cost_for_two
FROM zomato_restaurants_clean
WHERE rating_clean IS NOT NULL
GROUP BY rating_band
ORDER BY rating_band;

-- 5. Online ordering and table reservation by city
SELECT
    city,
    COUNT(*) AS restaurant_count,
    SUM(online_order) AS online_order_count,
    ROUND(100 * AVG(online_order), 2) AS online_order_adoption_pct,
    SUM(table_reservation) AS reservation_count,
    ROUND(100 * AVG(table_reservation), 2) AS reservation_adoption_pct
FROM zomato_restaurants_clean
GROUP BY city
HAVING COUNT(*) >= 100
ORDER BY restaurant_count DESC;

-- 6. Cuisine analysis by restaurant supply
SELECT
    cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(cost_for_two_clean), 2) AS avg_cost_for_two,
    ROUND(AVG(rating_count), 1) AS avg_rating_count
FROM zomato_restaurants_clean
WHERE cuisine IS NOT NULL
GROUP BY cuisine
HAVING COUNT(*) >= 100
ORDER BY restaurant_count DESC;

-- Note: The source does not contain order-level revenue or customer data.
-- Cost-for-two is a pricing field and must not be presented as revenue.
