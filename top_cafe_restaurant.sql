-- Creating top_cafe_restaurant Database 
CREATE DATABASE IF NOT EXISTS top_cafe_restaurant;

-- -------------------------- Data Wrangling -----------------------------

USE top_cafe_restaurant;

-- Creating Table for the menu items
CREATE TABLE menu_items (
	menu_item_id SMALLINT NOT NULL,
    item_name VARCHAR(45) NOT NULL,
    category VARCHAR(45) NOT NULL,
    price DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (menu_item_id)
);

-- Creating Table for the order details
CREATE TABLE order_details(
	order_details_id SMALLINT NOT NULL,
    order_id SMALLINT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    item_id SMALLINT NOT NULL,
    PRIMARY KEY (order_details_id)
);

-- Insert data into menu_items table using import records from an external file
-- Insert data into order_details table using import records from an external file

-- --------------------------- Feature Engineering -------------------------------
-- -------------------------------------------------------------------------------
-- 1. Add a new column named time_of_day to give an insight into Morning, Afternoon and Evening sales
ALTER TABLE order_details ADD COLUMN time_of_day VARCHAR(20);

UPDATE order_details
SET time_of_day = (
CASE
		WHEN `order_time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `order_time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
);

-- 2. Add a new column named day_name that contains the extracted days of the week
ALTER TABLE order_details ADD COLUMN day_name VARCHAR(10);

UPDATE order_details
SET day_name = DAYNAME(order_date);

-- 3. Add a new column named month_name that contains the extracted months of the year
ALTER TABLE order_details ADD COLUMN month_name VARCHAR(10);

UPDATE order_details
SET month_name = MONTHNAME(order_date);


-- ---------------------- Exploratory Data Analysis (EDA) ------------------------
-- -------------------------------------------------------------------------------

-- --------------- Objective 1: Exploring Product (Menu Item) --------------------

-- 1. View the menu_items table and write a query to find the number of items on the menu.
SELECT
	COUNT(*)
FROM menu_items;

-- 2. What are the least and most expensive items on the menu?
SELECT item_name, price
FROM menu_items
GROUP BY item_name, price
ORDER BY price DESC;

-- 3. How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
SELECT 
	COUNT(*)
FROM menu_items
WHERE category = "Italian";

SELECT 
	*
FROM menu_items
WHERE category = "Italian"
ORDER BY price DESC;

-- 4. How many dishes are in each category? What is the average dish price within each category?
SELECT * FROM menu_items;

SELECT 
	category,
    COUNT(item_name) AS "total_menu_item"
FROM menu_items
GROUP BY category;

SELECT 
	category,
    AVG(price) AS "AVERAGE PRICE"
FROM menu_items
GROUP BY category;


-- --------------- Objective 2: Exploring the Sales (Orders) Table --------------------

-- 1. View the order_details table. What is the date range of the table?
SELECT
	MAX(order_date) AS "Recent Order Date",
    MIN(order_date) AS "Earliest Order Date"
FROM order_details;

-- 2. How many orders were made within this date range? How many items were ordered within this date range?
SELECT
	COUNT(DISTINCT order_id) as "Total Orders"
FROM order_details;

SELECT
	COUNT(DISTINCT item_id) AS "Total Number of Items"
FROM order_details;


-- 3. Which orders had the most number of items?
SELECT
	DISTINCT order_id,
    COUNT(item_id) AS num_item
FROM order_details
GROUP BY
	order_id
ORDER BY num_item DESC;

-- 4. How many orders had more than 12 items?
SELECT COUNT(*) AS order_with_over_12item
FROM(
SELECT
	DISTINCT order_id,
    COUNT(item_id) AS num_item
FROM order_details
GROUP BY
	order_id
HAVING num_item > 12
ORDER BY num_item DESC) AS order_with_over_12item;


-- --------------- Objective 3: Analyze Customer Behaviour --------------------

-- 1. Combine the menu_items and order_details table into a single table.
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT * 
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;



-- 2. What were the least and most ordered items? What categories were they in?

-- Most Ordered Items
SELECT item_id, item_name, category, COUNT(order_details_id) as num_purchase 
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_id, category
ORDER BY num_purchase DESC;


-- 3. What were the top 5 orders that spent the most money?
SELECT order_id , SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;


-- 4. View the details of the highest spend order. What insights can you gather from the results?
SELECT order_id, category, COUNT(item_id) as num_of_item,  SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330)
GROUP BY order_id, category;

-- Revenue
SELECT item_name, item_id , SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_id
ORDER BY price;
