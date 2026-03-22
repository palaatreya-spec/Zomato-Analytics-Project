-- Advanced Business Queries for Zomato Analytics Project

-- Query 1: Rank Restaurants by Revenue within each Cuisine
SELECT
    cuisine,
    name,
    total_revenue,
    RANK() OVER (PARTITION BY cuisine ORDER BY total_revenue DESC) AS rank_within_cuisine
FROM restaurant_performance
WHERE cuisine IS NOT NULL
ORDER BY cuisine, rank_within_cuisine;

-- Query 2: Customer Lifetime Value Quartiles
SELECT
    customer_id,
    name,
    total_spent,
    NTILE(4) OVER (ORDER BY total_spent DESC) AS quartile
FROM customer_insights
ORDER BY quartile, total_spent DESC;

-- Query 3: Moving Average of Monthly Revenue
SELECT
    year,
    month,
    total_revenue,
    AVG(total_revenue) OVER (ORDER BY year, month ROWS 2 PRECEDING) AS moving_avg_3_months
FROM monthly_sales
ORDER BY year, month;

-- Query 4: Restaurants with Highest Rating Variance
SELECT
    r.name,
    COUNT(rv.rating) AS review_count,
    AVG(rv.rating) AS avg_rating,
    STDDEV(rv.rating) AS rating_stddev
FROM restaurants r
JOIN reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.name
HAVING review_count > 5
ORDER BY rating_stddev DESC
LIMIT 10;

-- Query 5: Cross-Sell Analysis - Customers who ordered from multiple cuisines
SELECT
    c.customer_id,
    c.name,
    COUNT(DISTINCT r.cuisine) AS unique_cuisines,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY c.customer_id, c.name
HAVING unique_cuisines > 1
ORDER BY unique_cuisines DESC, total_spent DESC;

-- Query 6: Seasonal Analysis - Orders by Day of Week
SELECT
    DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);

-- Query 7: Basket Analysis - Most Common Item Combinations
SELECT
    oi1.item_name AS item1,
    oi2.item_name AS item2,
    COUNT(*) AS frequency
FROM order_items oi1
JOIN order_items oi2 ON oi1.order_id = oi2.order_id AND oi1.order_item_id < oi2.order_item_id
GROUP BY oi1.item_name, oi2.item_name
ORDER BY frequency DESC
LIMIT 20;
