-- Business Insights for Zomato Analytics Project

-- Insight 1: Top Revenue Generating Restaurants
-- The following query shows the top 5 restaurants by total revenue
SELECT name, total_revenue, total_orders
FROM restaurant_performance
ORDER BY total_revenue DESC
LIMIT 5;
-- Insight: Focus marketing efforts on these high-performing restaurants to maximize revenue.

-- Insight 2: Customer Segmentation
-- High-value customers contribute significantly to revenue
SELECT
    SUM(CASE WHEN total_spent > 1000 THEN total_spent ELSE 0 END) / SUM(total_spent) * 100 AS high_value_percentage
FROM customer_insights;
-- Insight: Implement loyalty programs targeting high-value customers to increase retention.

-- Insight 3: Popular Cuisines
-- Identify trending cuisines
SELECT cuisine, restaurant_count, avg_rating
FROM popular_cuisines
ORDER BY restaurant_count DESC
LIMIT 5;
-- Insight: Expand restaurant partnerships in popular cuisines to meet customer demand.

-- Insight 4: Seasonal Trends
-- Revenue peaks during certain months
SELECT year, month, total_revenue
FROM monthly_sales
ORDER BY total_revenue DESC
LIMIT 3;
-- Insight: Prepare for peak seasons with increased delivery capacity and promotions.

-- Insight 5: Customer Retention
-- Many customers become inactive after 90 days
SELECT
    SUM(CASE WHEN days_since_last_order > 90 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS inactive_percentage
FROM customer_insights
WHERE days_since_last_order IS NOT NULL;
-- Insight: Send re-engagement campaigns to inactive customers to boost repeat orders.

-- Insight 6: Review Impact
-- Higher rated restaurants have more orders
SELECT
    CASE
        WHEN average_rating >= 4.5 THEN 'Excellent'
        WHEN average_rating >= 4.0 THEN 'Good'
        WHEN average_rating >= 3.5 THEN 'Average'
        ELSE 'Poor'
    END AS rating_category,
    AVG(total_orders) AS avg_orders
FROM restaurant_performance
GROUP BY rating_category
ORDER BY avg_orders DESC;
-- Insight: Encourage restaurants to maintain high ratings through quality improvements.

-- Insight 7: Order Value Trends
-- Average order value is increasing
SELECT
    year,
    month,
    avg_order_value,
    LAG(avg_order_value) OVER (ORDER BY year, month) AS prev_avg
FROM monthly_sales
ORDER BY year, month;
-- Insight: Customers are willing to spend more; introduce premium menu items.

-- Overall Business Recommendations:
-- 1. Invest in top-performing restaurants and cuisines
-- 2. Develop targeted retention strategies for different customer segments
-- 3. Optimize operations for peak seasons
-- 4. Leverage customer reviews to improve service quality
-- 5. Explore upselling opportunities to increase average order value
