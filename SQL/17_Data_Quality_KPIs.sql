-- Zomato Restaurant Analytics — source-backed data quality KPI layer
USE zomato_analytics;

DROP VIEW IF EXISTS vw_data_quality_kpis;
CREATE VIEW vw_data_quality_kpis AS
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT zomato_url) AS unique_urls,
    COUNT(*) - COUNT(DISTINCT zomato_url) AS duplicate_url_rows,
    SUM(rating_clean IS NULL) AS unrated_rows,
    SUM(cost_for_two_clean IS NULL OR cost_for_two_clean <= 0) AS unusable_cost_rows,
    SUM(coordinate_valid = FALSE OR coordinate_valid IS NULL) AS invalid_coordinate_rows,
    SUM(famous_food IS NULL OR TRIM(famous_food) = '') AS missing_famous_food_rows,
    ROUND(100 * AVG(has_rating), 2) AS rating_completeness_pct,
    ROUND(100 * AVG(has_cost), 2) AS usable_cost_pct,
    ROUND(100 * AVG(coordinate_valid), 2) AS valid_coordinate_pct
FROM zomato_restaurants_clean;

SELECT * FROM vw_data_quality_kpis;
