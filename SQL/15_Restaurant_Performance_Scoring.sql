-- Zomato Restaurant Analytics — transparent performance scoring
-- Descriptive prioritization only; NOT profitability, revenue or causal scoring.

USE zomato_analytics;

WITH base AS (
    SELECT
        zomato_url,
        name,
        city,
        area,
        rating_clean,
        rating_count,
        online_order,
        table_reservation,
        PERCENT_RANK() OVER (ORDER BY rating_clean) AS quality_pct,
        PERCENT_RANK() OVER (ORDER BY LOG(1 + COALESCE(rating_count, 0))) AS engagement_pct
    FROM zomato_restaurants_clean
    WHERE rating_clean IS NOT NULL
),
scored AS (
    SELECT
        *,
        (
            quality_pct * 0.50
            + engagement_pct * 0.35
            + ((online_order * 0.70 + table_reservation * 0.30) * 0.15)
        ) * 100 AS performance_score
    FROM base
)
SELECT
    *,
    CASE
        WHEN performance_score >= 75 THEN 'Top Performer'
        WHEN performance_score >= 50 THEN 'Strong'
        WHEN performance_score >= 25 THEN 'Established'
        ELSE 'Developing'
    END AS performance_segment
FROM scored
ORDER BY performance_score DESC;

-- City-level performance summary
WITH scored AS (
    SELECT
        city,
        rating_clean,
        rating_count,
        online_order,
        table_reservation,
        PERCENT_RANK() OVER (ORDER BY rating_clean) AS quality_pct,
        PERCENT_RANK() OVER (ORDER BY LOG(1 + COALESCE(rating_count, 0))) AS engagement_pct
    FROM zomato_restaurants_clean
    WHERE rating_clean IS NOT NULL
),
city_score AS (
    SELECT
        city,
        COUNT(*) AS rated_restaurants,
        AVG(rating_clean) AS avg_rating,
        AVG(rating_count) AS avg_rating_count,
        AVG(online_order) * 100 AS online_order_pct,
        AVG(table_reservation) * 100 AS reservation_pct,
        AVG((quality_pct * 0.50 + engagement_pct * 0.35
            + ((online_order * 0.70 + table_reservation * 0.30) * 0.15)) * 100) AS avg_performance_score
    FROM scored
    GROUP BY city
)
SELECT *
FROM city_score
WHERE rated_restaurants >= 100
ORDER BY avg_performance_score DESC;
