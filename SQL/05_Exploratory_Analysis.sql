USE zomato_analytics;

/* =========================================================
   ZOMATO RESTAURANT ANALYTICS
   05 - Exploratory SQL Analysis
   ========================================================= */

/* ============================================================
-- 1. Overall dataset overview
   ============================================================ */

SELECT
    COUNT(*) AS total_restaurants,
    COUNT(DISTINCT city) AS total_cities,
    COUNT(DISTINCT area) AS total_areas,
    COUNT(DISTINCT cuisine) AS total_cuisines
FROM zomato_restaurants_clean;

/* ============================================================
-- 2. Restaurant distribution by city
   ============================================================ */

SELECT
    city,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_restaurants_clean),
        2
    ) AS percentage_of_total
FROM zomato_restaurants_clean
GROUP BY city
ORDER BY restaurant_count DESC;

/* ============================================================
-- 3. City-level restaurant performance
   ============================================================ */

SELECT
    city,
    COUNT(*) AS restaurant_count,
    COUNT(rating_clean) AS rated_restaurants,
    ROUND(
        COUNT(rating_clean) * 100.0 / COUNT(*),
        2
    ) AS rating_coverage_pct,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(rating_count), 0) AS avg_rating_count,
    SUM(has_rating = 1) AS restaurants_with_rating
FROM zomato_restaurants_clean
GROUP BY city
HAVING COUNT(*) >= 100
ORDER BY avg_rating DESC;

/* ============================================================
   4. Rating Distribution
   ============================================================ */

SELECT
    rating_clean,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(rating_clean)
         FROM zomato_restaurants_clean),
        2
    ) AS percentage_of_rated_restaurants
FROM zomato_restaurants_clean
WHERE rating_clean IS NOT NULL
GROUP BY rating_clean
ORDER BY rating_clean;

/* ============================================================
   5. Rating Band Distribution
   ============================================================ */

SELECT
    CASE
        WHEN rating_clean < 2.5 THEN 'Below 2.5'
        WHEN rating_clean < 3.0 THEN '2.5 - 2.9'
        WHEN rating_clean < 3.5 THEN '3.0 - 3.4'
        WHEN rating_clean < 4.0 THEN '3.5 - 3.9'
        WHEN rating_clean >= 4.0 THEN '4.0+'
    END AS rating_band,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(rating_clean)
         FROM zomato_restaurants_clean),
        2
    ) AS percentage_of_rated_restaurants
FROM zomato_restaurants_clean
WHERE rating_clean IS NOT NULL
GROUP BY
    CASE
        WHEN rating_clean < 2.5 THEN 'Below 2.5'
        WHEN rating_clean < 3.0 THEN '2.5 - 2.9'
        WHEN rating_clean < 3.5 THEN '3.0 - 3.4'
        WHEN rating_clean < 4.0 THEN '3.5 - 3.9'
        WHEN rating_clean >= 4.0 THEN '4.0+'
    END
ORDER BY MIN(rating_clean);

/* ============================================================
   6. Rating vs Customer Engagement
   ============================================================ */

SELECT
    CASE
        WHEN rating_clean < 2.5 THEN 'Below 2.5'
        WHEN rating_clean < 3.0 THEN '2.5 - 2.9'
        WHEN rating_clean < 3.5 THEN '3.0 - 3.4'
        WHEN rating_clean < 4.0 THEN '3.5 - 3.9'
        ELSE '4.0+'
    END AS rating_band,
    COUNT(*) AS restaurant_count,
    COUNT(
        CASE
            WHEN rating_count > 0 THEN 1
        END
    ) AS restaurants_with_reviews,
    ROUND(AVG(rating_count), 0) AS avg_rating_count,
    ROUND(
        AVG(
            CASE
                WHEN rating_count > 0 THEN rating_count
            END
        ), 0
    ) AS avg_positive_rating_count
FROM zomato_restaurants_clean
WHERE rating_clean IS NOT NULL
GROUP BY
    CASE
        WHEN rating_clean < 2.5 THEN 'Below 2.5'
        WHEN rating_clean < 3.0 THEN '2.5 - 2.9'
        WHEN rating_clean < 3.5 THEN '3.0 - 3.4'
        WHEN rating_clean < 4.0 THEN '3.5 - 3.9'
        ELSE '4.0+'
    END
ORDER BY MIN(rating_clean);

/* ============================================================
   7. Most Reviewed Restaurants
   ============================================================ */

SELECT
    name,
    city,
    area,
    rating_clean,
    rating_count,
    cost_for_two_clean,
    online_order,
    table_reservation
FROM zomato_restaurants_clean
WHERE rating_clean IS NOT NULL
  AND rating_count > 0
ORDER BY rating_count DESC
LIMIT 20;

/* ============================================================
   8. Most Common Cuisine Listings
   ============================================================ */

SELECT
    cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM zomato_restaurants_clean
         WHERE cuisine IS NOT NULL
           AND TRIM(cuisine) <> ''),
        2
    ) AS percentage_of_restaurants
FROM zomato_restaurants_clean
WHERE cuisine IS NOT NULL
  AND TRIM(cuisine) <> ''
GROUP BY cuisine
ORDER BY restaurant_count DESC
LIMIT 25;

/* ============================================================
   9. Cuisine Performance
   ============================================================ */

SELECT
    cuisine,
    COUNT(*) AS restaurant_count,
    COUNT(rating_clean) AS rated_restaurants,
    ROUND(
        COUNT(rating_clean) * 100.0 / COUNT(*),
        2
    ) AS rating_coverage_pct,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(AVG(
        CASE
            WHEN rating_count > 0 THEN rating_count
        END
    ), 0) AS avg_rating_count
FROM zomato_restaurants_clean
WHERE cuisine IS NOT NULL
  AND TRIM(cuisine) <> ''
  AND cuisine <> '0'
GROUP BY cuisine
HAVING COUNT(*) >= 500
ORDER BY avg_rating DESC;

/* ============================================================
   10. Most Popular Cuisine Listings
   ============================================================ */

SELECT
    cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM zomato_restaurants_clean
         WHERE cuisine IS NOT NULL
           AND TRIM(cuisine) <> ''
           AND cuisine <> '0'),
        2
    ) AS percentage_of_restaurants
FROM zomato_restaurants_clean
WHERE cuisine IS NOT NULL
  AND TRIM(cuisine) <> ''
  AND cuisine <> '0'
GROUP BY cuisine
HAVING COUNT(*) >= 500
ORDER BY restaurant_count DESC
LIMIT 20;

/* ============================================================
   11. Online Ordering Analysis
   ============================================================ */

SELECT
    CASE
        WHEN online_order = 1 THEN 'Online Order Available'
        ELSE 'Online Order Not Available'
    END AS online_order_status,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_restaurants_clean),
        2
    ) AS percentage_of_restaurants
FROM zomato_restaurants_clean
GROUP BY online_order
ORDER BY restaurant_count DESC;

/* ============================================================
   12. Online Ordering by City
   ============================================================ */

SELECT
    city,
    COUNT(*) AS restaurant_count,
    SUM(online_order = 1) AS online_order_restaurants,
    ROUND(
        SUM(online_order = 1) * 100.0 / COUNT(*),
        2
    ) AS online_order_pct
FROM zomato_restaurants_clean
GROUP BY city
HAVING COUNT(*) >= 500
ORDER BY online_order_pct DESC;

/* ============================================================
   13. Online Ordering vs Restaurant Characteristics
   ============================================================ */

SELECT
    CASE
        WHEN online_order = 1 THEN 'Online Order Available'
        ELSE 'Online Order Not Available'
    END AS online_order_status,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating_clean), 2) AS avg_rating,
    ROUND(
        AVG(
            CASE
                WHEN rating_count > 0 THEN rating_count
            END
        ),
        0
    ) AS avg_rating_count,
    ROUND(AVG(cost_for_two_clean), 0) AS avg_cost_for_two,
    ROUND(
        SUM(table_reservation = 1) * 100.0 / COUNT(*),
        2
    ) AS table_reservation_pct
FROM zomato_restaurants_clean
GROUP BY online_order
ORDER BY online_order DESC;

/* ============================================================
   14. Online Ordering vs Financial Performance
   ============================================================ */

SELECT
    CASE
        WHEN online_order = 1 THEN 'Online Order Available'
        ELSE 'Online Order Not Available'
    END AS online_order_status,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(estimated_revenue), 0) AS avg_estimated_revenue,
    ROUND(AVG(contribution_margin), 2) AS avg_contribution_margin
FROM zomato_unit_economics
GROUP BY online_order
ORDER BY online_order DESC;

/* ============================================================
   15. Revenue Contribution by Online Ordering
   ============================================================ */

SELECT
    CASE
        WHEN online_order = 1 THEN 'Online Order Available'
        ELSE 'Online Order Not Available'
    END AS online_order_status,
    COUNT(*) AS restaurant_count,
    ROUND(SUM(estimated_revenue), 0) AS total_estimated_revenue,
    ROUND(SUM(contribution_margin), 2) AS total_contribution_margin,
    ROUND(
        SUM(estimated_revenue) * 100.0 /
        SUM(SUM(estimated_revenue)) OVER (),
        2
    ) AS revenue_contribution_pct,
    ROUND(
        SUM(contribution_margin) * 100.0 /
        SUM(SUM(contribution_margin)) OVER (),
        2
    ) AS contribution_margin_pct
FROM zomato_unit_economics
GROUP BY online_order
ORDER BY total_estimated_revenue DESC;

/* ============================================================
   16. City-Level Financial Performance
   ============================================================ */

SELECT
    city,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(estimated_revenue), 0) AS avg_estimated_revenue,
    ROUND(AVG(contribution_margin), 2) AS avg_contribution_margin,
    ROUND(SUM(estimated_revenue), 0) AS total_estimated_revenue,
    ROUND(SUM(contribution_margin), 2) AS total_contribution_margin
FROM zomato_unit_economics
GROUP BY city
HAVING COUNT(*) >= 500
ORDER BY avg_estimated_revenue DESC;

/* ============================================================
   17. City Ranking by Restaurant Revenue
   ============================================================ */

SELECT
    city,
    restaurant_count,
    avg_estimated_revenue,
    RANK() OVER (
        ORDER BY avg_estimated_revenue DESC
    ) AS revenue_rank
FROM (
    SELECT
        city,
        COUNT(*) AS restaurant_count,
        ROUND(AVG(estimated_revenue), 0) AS avg_estimated_revenue
    FROM zomato_unit_economics
    GROUP BY city
    HAVING COUNT(*) >= 500
) AS city_revenue
ORDER BY revenue_rank;

/* ============================================================
   18. Table Reservation vs Restaurant Characteristics
   ============================================================ */

SELECT
    CASE
        WHEN table_reservation = 'True'
            THEN 'Table Reservation Available'
        ELSE 'Table Reservation Not Available'
    END AS table_reservation_status,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(
        AVG(
            CASE
                WHEN rating_count > 0
                THEN rating_count
            END
        ),
        0
    ) AS avg_rating_count,
    ROUND(AVG(estimated_revenue), 0) AS avg_estimated_revenue,
    ROUND(AVG(contribution_margin), 2) AS avg_contribution_margin
FROM zomato_unit_economics
GROUP BY table_reservation
ORDER BY table_reservation DESC;

/* ============================================================
   19. Restaurant Cost vs Estimated Financial Performance
   ============================================================ */

SELECT
    CASE
        WHEN COST_FOR_TWO < 300 THEN 'Under 300'
        WHEN COST_FOR_TWO BETWEEN 300 AND 599 THEN '300 - 599'
        WHEN COST_FOR_TWO BETWEEN 600 AND 999 THEN '600 - 999'
        WHEN COST_FOR_TWO BETWEEN 1000 AND 1499 THEN '1000 - 1499'
        ELSE '1500+'
    END AS cost_band,

    COUNT(*) AS restaurant_count,

    ROUND(AVG(ESTIMATED_REVENUE), 0) AS avg_estimated_revenue,

    ROUND(AVG(CONTRIBUTION_MARGIN), 0) AS avg_contribution_margin,

    ROUND(AVG(RATING), 2) AS avg_rating

FROM zomato_unit_economics

WHERE COST_FOR_TWO IS NOT NULL
  AND COST_FOR_TWO > 0

GROUP BY
    CASE
        WHEN COST_FOR_TWO < 300 THEN 'Under 300'
        WHEN COST_FOR_TWO BETWEEN 300 AND 599 THEN '300 - 599'
        WHEN COST_FOR_TWO BETWEEN 600 AND 999 THEN '600 - 999'
        WHEN COST_FOR_TWO BETWEEN 1000 AND 1499 THEN '1000 - 1499'
        ELSE '1500+'
    END

ORDER BY
    MIN(COST_FOR_TWO);
