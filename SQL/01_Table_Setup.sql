-- Zomato Restaurant Analytics — MySQL table setup
-- Fresher-level database setup for the cleaned restaurant dataset.

CREATE DATABASE IF NOT EXISTS zomato_analytics;
USE zomato_analytics;

DROP TABLE IF EXISTS zomato_restaurants_clean;

CREATE TABLE zomato_restaurants_clean (
    sno INT,
    zomato_url VARCHAR(500) NOT NULL,
    name VARCHAR(255),
    city VARCHAR(100),
    area VARCHAR(150),
    rating VARCHAR(20),
    rating_count INT,
    telephone VARCHAR(255),
    cusine VARCHAR(500),
    cost_for_two VARCHAR(50),
    address TEXT,
    coordinates VARCHAR(100),
    timings TEXT,
    online_order TINYINT,
    table_reservation TINYINT,
    delivery_only TINYINT,
    famous_food TEXT,
    rating_clean DECIMAL(3,2),
    cost_for_two_clean DECIMAL(10,2),
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    cuisine VARCHAR(500),
    has_rating TINYINT,
    has_cost TINYINT,
    coordinate_valid TINYINT,
    PRIMARY KEY (zomato_url)
);

-- Import the cleaned CSV created by Python.
-- Update the local file path for your MySQL setup.
-- The column order below matches the Python output CSV.
-- Example:
-- LOAD DATA LOCAL INFILE 'C:/path/to/Zomato-Analytics-Project-main/Data/processed/zomato_restaurants_clean.csv'
-- INTO TABLE zomato_restaurants_clean
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Basic post-load check
SELECT
    COUNT(*) AS restaurant_rows,
    COUNT(DISTINCT zomato_url) AS unique_restaurants
FROM zomato_restaurants_clean;
