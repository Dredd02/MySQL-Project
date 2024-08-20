-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS WalmartData;

-- Switch to the WalmartData database
USE WalmartData;

-- Create the sales table if it does not exist
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,  
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cost_goods_sold DECIMAL(10, 2) NOT NULL,
    gross_margin_per FLOAT(11, 9),
    gross_income DECIMAL(12, 4) NOT NULL,
    rating FLOAT(2, 1)
);

-- Add VAT column to the sales table
ALTER TABLE sales
ADD VAT FLOAT(6, 4) NOT NULL;

-- Add derived columns for time_of_day, day_name, and month_name
-- Time of Day
ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = CASE
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END;

-- Day of Week
ALTER TABLE sales
ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Month Name
ALTER TABLE sales
ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);


-- --- ----------------------------------------------------------------------------------------------------------------------------------------------
-- Product Analysis

-- Number of unique product lines
SELECT COUNT(DISTINCT product_line) AS unique_product_lines
FROM sales;

-- Most common payment method
SELECT payment_method, COUNT(payment_method) AS count
FROM sales
GROUP BY payment_method
ORDER BY count DESC;

-- Most selling product line
SELECT product_line, COUNT(product_line) AS count
FROM sales
GROUP BY product_line
ORDER BY count DESC;

-- Total revenue by month
SELECT month_name AS month, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- Product line with the largest revenue
SELECT product_line, SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Branches with above-average product sales
SELECT branch, SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- Most common product line by gender
SELECT gender, product_line, COUNT(gender) AS total_count
FROM sales
GROUP BY gender, product_line
ORDER BY total_count DESC;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Sales Analysis

-- Number of sales made each time of day per weekday
SELECT time_of_day, COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Monday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Customer type bringing in the most revenue
SELECT customer_type, SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- City with the largest VAT
SELECT city, AVG(VAT) AS average_VAT
FROM sales
GROUP BY city
ORDER BY average_VAT DESC;

-- Gender distribution per branch
SELECT branch, gender, COUNT(*) AS gender_count
FROM sales
GROUP BY branch, gender
ORDER BY branch;
