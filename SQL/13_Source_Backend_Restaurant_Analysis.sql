-- Zomato Restaurant Analytics — Source-backed analysis
-- These queries use fields available in the uploaded restaurant source after
-- the Python cleaning pipeline creates the cleaned table.
-- Rename table/columns as needed when importing the processed CSV into MySQL.

USE zomato_analytics;

-- 1. Restaurant supply by city
SELECT
    city_clean AS city,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(cost_for_two_clean), 2) AS avg_cost_for_two,
    ROUND(100 * AVG(online_order), 2) AS online_order_adoption_pct,
    ROUND(100 * AVG(table_reservation), 2) AS table_reservation_adoption_pct
FROM zomato_restaurants_clean
GROUP BY city_clean
ORDER BY restaurant_count DESC;

-- 2. City performance among cities with meaningful restaurant coverage
SELECT
    city_clean AS city,
    COUNT(DISTINCT zomato_url) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(cost_for_two_clean), 2) AS avg_cost_for_two,
    SUM(rating_count) AS total_rating_count
FROM zomato_restaurants_clean
GROUP BY city_clean
HAVING COUNT(DISTINCT zomato_url) >= 100
ORDER BY total_rating_count DESC;

-- 3. Pricing bands by city
SELECT
    city_clean AS city,
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
GROUP BY city_clean, price_band
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

-- 5. Digital adoption by city
SELECT
    city_clean AS city,
    COUNT(*) AS restaurant_count,
    SUM(online_order) AS online_order_count,
    ROUND(100 * AVG(online_order), 2) AS online_order_adoption_pct,
    SUM(table_reservation) AS reservation_count,
    ROUND(100 * AVG(table_reservation), 2) AS reservation_adoption_pct,
    SUM(delivery_only) AS delivery_only_count,
    ROUND(100 * AVG(delivery_only), 2) AS delivery_only_pct
FROM zomato_restaurants_clean
GROUP BY city_clean
HAVING COUNT(*) >= 100
ORDER BY restaurant_count DESC;

-- 6. Cuisine performance (top cuisines by restaurant supply)
SELECT
    cusine_clean AS cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(cost_for_two_clean), 2) AS avg_cost_for_two,
    ROUND(AVG(rating_count), 1) AS avg_rating_count
FROM zomato_restaurants_clean
WHERE cusine_clean IS NOT NULL
GROUP BY cusine_clean
HAVING COUNT(*) >= 100
ORDER BY restaurant_count DESC;

-- 7. Restaurant prioritization: high rating + high engagement signal
WITH scored AS (
    SELECT
        zomato_url,
        name_clean AS restaurant_name,
        city_clean AS city,
        rating_clean,
        rating_count,
        cost_for_two_clean,
        NTILE(4) OVER (ORDER BY rating_count DESC) AS engagement_quartile,
        NTILE(4) OVER (ORDER BY rating_clean DESC) AS rating_quartile
    FROM zomato_restaurants_clean
    WHERE rating_clean IS NOT NULL
)
SELECT *
FROM scored
WHERE engagement_quartile = 1
  AND rating_quartile = 1
ORDER BY rating_count DESC, rating_clean DESC
LIMIT 100;

-- 8. Revenue concentration is intentionally NOT calculated here.
-- The source does not contain order-level revenue. Cost-for-two is a listed
-- pricing proxy and must not be presented as revenue.
