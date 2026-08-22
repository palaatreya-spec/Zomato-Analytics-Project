-- Zomato Restaurant Analytics — MySQL table setup
-- Fresher-level database setup for the cleaned restaurant dataset.

CREATE DATABASE IF NOT EXISTS zomato_analytics;
USE zomato_analytics;

DROP TABLE IF EXISTS zomato_restaurants_clean;

CREATE TABLE zomato_restaurants_clean (
    source_row_id INT,
    sno INT,
    zomato_url VARCHAR(500) NOT NULL,
    name VARCHAR(255),
    city VARCHAR(100),
    area VARCHAR(150),
    rating_raw VARCHAR(20),
    rating_clean DECIMAL(3,2),
    rating_count INT,
    telephone VARCHAR(255),
    cuisine VARCHAR(500),
    cost_for_two_raw VARCHAR(50),
    cost_for_two_clean DECIMAL(10,2),
    address TEXT,
    coordinates VARCHAR(100),
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    timings TEXT,
    online_order BOOLEAN,
    table_reservation BOOLEAN,
    delivery_only BOOLEAN,
    famous_food TEXT,
    coordinate_valid BOOLEAN,
    has_rating BOOLEAN,
    has_cost BOOLEAN,
    PRIMARY KEY (zomato_url)
);

-- Import the cleaned CSV created by Python.
-- Update the file path for your local MySQL setup.
-- Example:
-- LOAD DATA LOCAL INFILE '../Data/processed/zomato_restaurants_clean.csv'
-- INTO TABLE zomato_restaurants_clean
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Basic post-load check
SELECT
    COUNT(*) AS restaurant_rows,
    COUNT(DISTINCT zomato_url) AS unique_restaurants
FROM zomato_restaurants_clean;
