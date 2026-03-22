-- Create Database and Tables for Zomato Analytics Project

CREATE DATABASE IF NOT EXISTS zomato_analytics;
USE zomato_analytics;

-- Table for Restaurants
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    cuisine VARCHAR(255),
    rating DECIMAL(2,1),
    cost_for_two INT,
    online_order BOOLEAN DEFAULT FALSE,
    table_booking BOOLEAN DEFAULT FALSE
);

-- Table for Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20)
);

-- Table for Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    restaurant_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Table for Order Items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_name VARCHAR(255),
    price DECIMAL(10,2),
    quantity INT DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Table for Reviews
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    restaurant_id INT,
    rating DECIMAL(2,1),
    review_text TEXT,
    review_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);
