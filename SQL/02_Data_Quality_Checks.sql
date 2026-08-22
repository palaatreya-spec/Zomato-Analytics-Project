-- Zomato Restaurant Analytics — basic data-quality checks
-- Fresher-level SQL for validating the cleaned restaurant dataset.

USE zomato_analytics;

-- 1. Row count and unique restaurants
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT zomato_url) AS unique_restaurants
FROM zomato_restaurants_clean;

-- 2. Missing values in important columns
SELECT
    SUM(name IS NULL OR TRIM(name) = '') AS missing_name,
    SUM(city IS NULL OR TRIM(city) = '') AS missing_city,
    SUM(cuisine IS NULL OR TRIM(cuisine) = '') AS missing_cuisine,
    SUM(rating_clean IS NULL) AS missing_rating,
    SUM(cost_for_two_clean IS NULL) AS missing_cost
FROM zomato_restaurants_clean;

-- 3. Rating values outside the expected 1–5 range
SELECT COUNT(*) AS invalid_rating_rows
FROM zomato_restaurants_clean
WHERE rating_clean IS NOT NULL
  AND (rating_clean < 1 OR rating_clean > 5);

-- 4. Non-positive cost values
SELECT COUNT(*) AS non_positive_cost_rows
FROM zomato_restaurants_clean
WHERE cost_for_two_clean IS NULL OR cost_for_two_clean <= 0;

-- 5. Duplicate restaurant URLs
SELECT
    zomato_url,
    COUNT(*) AS duplicate_count
FROM zomato_restaurants_clean
GROUP BY zomato_url
HAVING COUNT(*) > 1;
