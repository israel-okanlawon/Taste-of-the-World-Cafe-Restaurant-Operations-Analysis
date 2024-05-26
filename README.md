# Taste of the World Café Restaurant Operations Analysis
**Tools:** **`Excel`** , **`MySQL`** , **`Power BI`**

## Table of Content
- [Project Overview](#project-overview)
- [About Data](#about-data)
- [The Objectives](#the-objectives)
- [Methodology Used](#methodology-used)

## Project Overview
This project aims to explore the Taste of the World Café restaurant menu and order data to understand what’s on the menu get an idea of the data that has been collected and use both data to understand how the customers are reacting to the new menu, top performing menu, sales trend of different menu items and customer behaviour. The major aim of this project is to gain insight into the sales data of Taste of the World Café to understand which menu items are doing well / not well and what the top customers seem to like best. The dataset was obtained from maven analytics playground [here](https://mavenanalytics.io/data-playground?pageSize=10&search=Restaurant%20Orders)
![top_cafe_restaurant_dashboard](https://github.com/israel-okanlawon/Taste-of-the-World-Cafe-Restaurant-Operations-Analysis/assets/37417155/f3310904-06d5-4fba-8e9a-1e99cb367419)

## About Data

The datasets were obtained from the [here](https://mavenanalytics.io/data-playground?pageSize=10&search=Restaurant%20Orders). There are datasets on the menu items table and order details table of the Taste of the World Café restaurant. The menu_items table contains 4 columns and 32 rows while the order_details table contains 5 columns and 12,234 rows:

### menu_items table
| Column                  | Description                                     | Data Type         |
| :---------------------- | :--------------------------------------         | :-------------    |
| menu_item_id            | Unique ID of a menu item                        | SMALLINT          |
| item_name               | Name of a menu item                             | VARCHAR(45)       |
| category                | Category or type of cuisine of the menu item    | VARCHAR(45)       |
| price                   | Price of the menu item (US Dollars $)           | DECIMAL(5, 2)     |

### order_details table
| Column                  | Description                                         | Data Type      |
| :---------------------- | :--------------------------------------             | :------------- |
| order_details_id        | Unique ID of an item in an order                    | SMALLINT       |
| order_id                | ID of an order                                      | SMALLINT       |
| order_date              | Date an order was put in (MM/DD/YY)                 | DATE           |
| order_time              | Time an order was put in (HH:MM:SS AM/PM)           | TIME           |
| item_id                 | Matches the menu_item_id in the menu_items table    | SMALLINT       |

## The Objectives:
### Objective 1: Exploring menu_item table to get an idea of what’s on the menu.

1.	View the menu_items table and write a query to find the number of items on the menu.
2.	What are the least and most expensive items on the menu?
3.	How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
4.	How many dishes are in each category? What is the average dish price within each category?

### Objective 2: Exploring the orders_details table to get an idea of the data that’s been collected.

1.	View the order_details table. What is the date range of the table?
2.	How many orders were made within this date range? How many items were ordered within this date range?
3.	Which orders had the most number of items?
4.	How many orders had more than 12 items?

### Objective 3: Analyze customer's behaviour to understand how they are reacting to the new menu.

1.	Combine the menu_items and order_details table into a single table.
2.	What were the least and most ordered items? What categories were they in?
3.	What were the top 5 orders that spent the most money?
4.	View the details of the highest spending order. What insights can you gather from the results?


## Methodology Used:

1.	**Data Wrangling**

> 1.	Data Collection: The CSV of the dataset was obtained from here.
> 2.    Use **Excel** to format the order_date column.
![order_details_screenshot](https://github.com/israel-okanlawon/Taste-of-the-World-Cafe-Restaurant-Operations-Analysis/assets/37417155/54dbf673-2236-497a-ba7a-7bfb70eb4738)
> 3.	Build Database: **MySQL RDBMS** was used to create a database and table and data from the CSV file was inserted into the table.
> 4.	There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out leaving us with 12,097 for the order_details table.

2.	**Feature Engineering:** This will help use generate some new columns from existing ones.

> 1.	Add a new column named `time_of_day` to give an insight into Morning, Afternoon and Evening sales. This will help answer the question of which part of the day most sales are made.
> 2.	Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question of which day of the week the restaurant is busiest.
> 3.	Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

3. **Exploratory Data Analysis (EDA):** EDA is done to understand its characteristics, patterns, and relationships and to answer the listed questions.

4.	**Interpretation and Visualization:** The analysis results and insights are effectively communicated through the report Dashboard using **Power BI.**


