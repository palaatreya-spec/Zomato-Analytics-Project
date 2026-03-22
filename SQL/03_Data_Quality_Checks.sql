-- Data Quality Checks for Zomato Analytics Project

-- Check for null values in key columns
SELECT 'Restaurants - Null Names' AS Check_Type, COUNT(*) AS Count
FROM restaurants WHERE name IS NULL
UNION ALL
SELECT 'Restaurants - Null Locations', COUNT(*)
FROM restaurants WHERE location IS NULL
UNION ALL
SELECT 'Customers - Null Names', COUNT(*)
FROM customers WHERE name IS NULL
UNION ALL
SELECT 'Orders - Null Customer ID', COUNT(*)
FROM orders WHERE customer_id IS NULL
UNION ALL
SELECT 'Orders - Null Restaurant ID', COUNT(*)
FROM orders WHERE restaurant_id IS NULL;

-- Check for duplicate records
SELECT 'Duplicate Restaurants' AS Check_Type, COUNT(*) AS Count
FROM (SELECT name, location, COUNT(*) FROM restaurants GROUP BY name, location HAVING COUNT(*) > 1) AS dup
UNION ALL
SELECT 'Duplicate Customers', COUNT(*)
FROM (SELECT email, COUNT(*) FROM customers WHERE email IS NOT NULL GROUP BY email HAVING COUNT(*) > 1) AS dup;

-- Check rating ranges (assuming 1-5)
SELECT 'Invalid Ratings', COUNT(*) AS Count
FROM restaurants WHERE rating < 1 OR rating > 5
UNION ALL
SELECT 'Invalid Review Ratings', COUNT(*)
FROM reviews WHERE rating < 1 OR rating > 5;

-- Check for negative amounts
SELECT 'Negative Order Amounts', COUNT(*) AS Count
FROM orders WHERE total_amount < 0;

-- Check data consistency (orders referencing existing customers/restaurants)
SELECT 'Orphaned Orders (No Customer)', COUNT(*) AS Count
FROM orders o LEFT JOIN customers c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL
UNION ALL
SELECT 'Orphaned Orders (No Restaurant)', COUNT(*)
FROM orders o LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id WHERE r.restaurant_id IS NULL;

-- Summary counts
SELECT 'Total Restaurants', COUNT(*) FROM restaurants
UNION ALL
SELECT 'Total Customers', COUNT(*) FROM customers
UNION ALL
SELECT 'Total Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'Total Order Items', COUNT(*) FROM order_items
UNION ALL
SELECT 'Total Reviews', COUNT(*) FROM reviews;
