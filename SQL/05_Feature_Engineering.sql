-- Feature Engineering for Zomato Analytics Project

-- Add total_orders column to restaurants
ALTER TABLE restaurants ADD COLUMN total_orders INT DEFAULT 0;

UPDATE restaurants r
SET total_orders = (
    SELECT COUNT(*) FROM orders o WHERE o.restaurant_id = r.restaurant_id
);

-- Add total_spent column to customers
ALTER TABLE customers ADD COLUMN total_spent DECIMAL(10,2) DEFAULT 0.00;

UPDATE customers c
SET total_spent = (
    SELECT COALESCE(SUM(o.total_amount), 0) FROM orders o WHERE o.customer_id = c.customer_id
);

-- Add average_rating column to restaurants
ALTER TABLE restaurants ADD COLUMN average_rating DECIMAL(3,2);

UPDATE restaurants r
SET average_rating = (
    SELECT AVG(rv.rating) FROM reviews rv WHERE rv.restaurant_id = r.restaurant_id
);

-- Add order_count column to customers
ALTER TABLE customers ADD COLUMN order_count INT DEFAULT 0;

UPDATE customers c
SET order_count = (
    SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id
);

-- Create a derived table for popular cuisines
CREATE TABLE popular_cuisines AS
SELECT cuisine, COUNT(*) AS restaurant_count, AVG(rating) AS avg_rating
FROM restaurants
WHERE cuisine IS NOT NULL
GROUP BY cuisine
ORDER BY restaurant_count DESC;

-- Add revenue per order to orders
ALTER TABLE orders ADD COLUMN revenue_per_item DECIMAL(10,2);

UPDATE orders o
SET revenue_per_item = o.total_amount / (
    SELECT SUM(quantity) FROM order_items oi WHERE oi.order_id = o.order_id
);
