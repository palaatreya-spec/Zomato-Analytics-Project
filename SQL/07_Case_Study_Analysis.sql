-- Case Study Analysis for Zomato Analytics Project

-- Case Study 1: Top Performing Restaurants by Revenue
SELECT
    name,
    location,
    cuisine,
    total_orders,
    total_revenue,
    average_rating
FROM restaurant_performance
ORDER BY total_revenue DESC
LIMIT 10;

-- Case Study 2: Customer Segmentation by Spending
SELECT
    CASE
        WHEN total_spent > 1000 THEN 'High Value'
        WHEN total_spent > 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    AVG(total_spent) AS avg_spending,
    AVG(order_count) AS avg_orders
FROM customer_insights
GROUP BY customer_segment;

-- Case Study 3: Popular Cuisines Analysis
SELECT
    cuisine,
    restaurant_count,
    avg_rating,
    (SELECT SUM(total_revenue) FROM restaurant_performance rp WHERE rp.cuisine = pc.cuisine) AS total_cuisine_revenue
FROM popular_cuisines pc
ORDER BY total_cuisine_revenue DESC;

-- Case Study 4: Order Trends by Month
SELECT
    year,
    month,
    order_count,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
    ((total_revenue - LAG(total_revenue) OVER (ORDER BY year, month)) / LAG(total_revenue) OVER (ORDER BY year, month)) * 100 AS growth_percentage
FROM monthly_sales
ORDER BY year, month;

-- Case Study 5: Review Analysis - Most Reviewed Restaurants
SELECT
    restaurant_name,
    review_count,
    avg_review_rating,
    min_rating,
    max_rating
FROM review_summary
ORDER BY review_count DESC
LIMIT 10;

-- Case Study 6: Customer Retention Analysis
SELECT
    CASE
        WHEN days_since_last_order <= 30 THEN 'Active'
        WHEN days_since_last_order <= 90 THEN 'Recent'
        ELSE 'Inactive'
    END AS retention_status,
    COUNT(*) AS customer_count,
    AVG(total_spent) AS avg_lifetime_value
FROM customer_insights
WHERE days_since_last_order IS NOT NULL
GROUP BY retention_status;
