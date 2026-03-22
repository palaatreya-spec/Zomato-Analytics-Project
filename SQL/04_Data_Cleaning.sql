-- Data Cleaning for Zomato Analytics Project

-- Remove duplicate restaurants (keep the first one)
DELETE r1 FROM restaurants r1
INNER JOIN restaurants r2
WHERE r1.restaurant_id > r2.restaurant_id
AND r1.name = r2.name AND r1.location = r2.location;

-- Remove duplicate customers based on email
DELETE c1 FROM customers c1
INNER JOIN customers c2
WHERE c1.customer_id > c2.customer_id
AND c1.email = c2.email AND c1.email IS NOT NULL;

-- Fill null locations with 'Unknown'
UPDATE restaurants SET location = 'Unknown' WHERE location IS NULL;

-- Correct invalid ratings (set to NULL or default)
UPDATE restaurants SET rating = NULL WHERE rating < 1 OR rating > 5;
UPDATE reviews SET rating = NULL WHERE rating < 1 OR rating > 5;

-- Remove orders with negative amounts
DELETE FROM orders WHERE total_amount < 0;

-- Remove orphaned order items
DELETE oi FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Remove orphaned reviews
DELETE r FROM reviews r
LEFT JOIN customers c ON r.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

DELETE r FROM reviews r
LEFT JOIN restaurants res ON r.restaurant_id = res.restaurant_id
WHERE res.restaurant_id IS NULL;

-- Standardize cuisine names (example: lowercase)
UPDATE restaurants SET cuisine = LOWER(cuisine) WHERE cuisine IS NOT NULL;

-- Trim whitespace from names
UPDATE restaurants SET name = TRIM(name), location = TRIM(location), cuisine = TRIM(cuisine);
UPDATE customers SET name = TRIM(name), email = TRIM(email), phone = TRIM(phone);
UPDATE order_items SET item_name = TRIM(item_name);
