-- Analytical Views for Zomato Analytics Project

-- View for Restaurant Performance
CREATE VIEW restaurant_performance AS
SELECT
    r.restaurant_id,
    r.name,
    r.location,
    r.cuisine,
    r.rating,
    r.total_orders,
    r.average_rating,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS avg_order_value
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name, r.location, r.cuisine, r.rating, r.total_orders, r.average_rating;

-- View for Customer Insights
CREATE VIEW customer_insights AS
SELECT
    c.customer_id,
    c.name,
    c.email,
    c.order_count,
    c.total_spent,
    AVG(o.total_amount) AS avg_order_value,
    MAX(o.order_date) AS last_order_date,
    DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email, c.order_count, c.total_spent;

-- View for Order Details
CREATE VIEW order_details AS
SELECT
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    r.name AS restaurant_name,
    r.location,
    r.cuisine,
    o.total_amount,
    COUNT(oi.order_item_id) AS item_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, c.name, r.name, r.location, r.cuisine, o.total_amount;

-- View for Review Summary
CREATE VIEW review_summary AS
SELECT
    r.restaurant_id,
    res.name AS restaurant_name,
    COUNT(rv.review_id) AS review_count,
    AVG(rv.rating) AS avg_review_rating,
    MIN(rv.rating) AS min_rating,
    MAX(rv.rating) AS max_rating
FROM reviews rv
JOIN restaurants res ON rv.restaurant_id = res.restaurant_id
GROUP BY r.restaurant_id, res.name;

-- View for Monthly Sales
CREATE VIEW monthly_sales AS
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year DESC, month DESC;
