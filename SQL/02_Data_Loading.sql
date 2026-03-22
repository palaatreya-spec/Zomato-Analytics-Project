-- Data Loading for Zomato Analytics Project
-- Assuming CSV files are in the same directory or specify path

-- Load Restaurants Data
LOAD DATA INFILE 'restaurants.csv'
INTO TABLE restaurants
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name, location, cuisine, rating, cost_for_two, online_order, table_booking);

-- Load Customers Data
LOAD DATA INFILE 'customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name, email, phone);

-- Load Orders Data
LOAD DATA INFILE 'orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, restaurant_id, order_date, total_amount);

-- Load Order Items Data
LOAD DATA INFILE 'order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, item_name, price, quantity);

-- Load Reviews Data
LOAD DATA INFILE 'reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, restaurant_id, rating, review_text, review_date);
