-- Databricks notebook source
--instead of always have to copy and paste the path for the dataset. I am setting the coffee shop data sales for this workbook
USE brightcoffeshop.coffee_sales

-- COMMAND ----------

--=====================================================================================================================
--------------------------------------------------2. -Data Upload
--=====================================================================================================================

--Display the uploaded dataset to verify that the CSV was sucessfully imported into Databricks. It will assist me by providing me with an initial understanding of the data structure before performing validation.
SELECT *
FROM sales;

-- ====================================================================================================================
---------------------------------------------------3. Data Profiling
-- ====================================================================================================================
--- The objective of the data profiling section is to understand the structure of the data, quality and completeness of the raw dataset before performing any transctios. 

-- The functions that will be demonstrated in this section:
-- COUNT()
-- DISTINCT
-- COUNT(DISTINCT)
-- MIN()
-- MAX()
-- AVG()
-- DESCRIBE
-- Expected Outcome:
-- Confirm that the dataset is suitable for cleaning and
-- transformation.

-- ==========================================================
-- Query 3.1 - Total Number of Records
-- ==========================================================
--
-- Purpose:
-- Determine the total number of records loaded into the coffee shop sales table.
--
-- Functions Used:
-- COUNT(*)
--
-- Description:
-- COUNT(*) counts every row in the dataset.
--
-- Business Value:
-- Confirms that the CSV file was uploaded successfully and establishes the size of the dataset before analysis.

SELECT COUNT(*) AS Total_Records
FROM sales; 

-- The dataset contains 149,116 transaction records. This confirms that the CSV file was successfully uploaded into Databricks and provides a sufficiently large dataset for meaningful sales analysis.

-- ==========================================================
-- Query 3.2 – Display Table Structure
-- ==========================================================
--
-- Purpose:
-- Display all columns and their associated data types.
--
-- Function Used:
-- DESCRIBE
--
-- Description:
-- The DESCRIBE command displays the schema of the table, including column names, data types and metadata.
--
-- Business Value:
-- Understanding the table structure helps identify, whether any columns require data type conversion, before cleaning and transformation.

DESCRIBE sales;

-- Results Interpretation of the query: The table contains 11 columns, Most numeric identifier and quantity fields were loaded as bigint, transaction_date was correctly loaded as a date. The transaction_time was loaded as a timestamp, th e unit_price was loaded as a string and will need to be cleaned and converted to a decimal data type before revenue calculations.

-- ==========================================================
-- Query 3.3 – Count the Number of Product Categories
-- ==========================================================
--
-- Purpose: Determine the total number of unique product categories that are available in the coffee shop sales dataset.
--
-- Functions Used:
-- COUNT(DISTINCT)
--
-- Description:
-- COUNT(DISTINCT) counts only unique (non-duplicate)
-- values within the specified column.
--
-- Business Value: Understanding the number of product categories helps the business understand the diversity of products sold and supports category-level sales analysis later in the project.

SELECT
    COUNT(DISTINCT product_category) AS Total_Product_Categories
FROM sales;

-- Results Interpretation: The dataset contains 9 unique product categories. This indicates that the coffee shop offers a diverse range of products across multiple categories.

-- ==========================================================
-- Query 3.4 – Display Product Categories
-- ==========================================================
--
-- Purpose: Display all unique product categories that are available in the coffee shop sales dataset.
--
-- Functions Used:
-- DISTINCT
-- ORDER BY
--
-- Description: DISTINCT removes duplicate values and returns only unique product categories.
--
-- ORDER BY sorts the categories alphabetically, making the results easier to read.
--
-- Business Value: Understanding the available product categories helps identify the scope of products that will be analysed during the revenue and sales performance analysis.

SELECT DISTINCT
       product_category
FROM sales
ORDER BY product_category ASC;

-- Results Interpretation: The coffee shop sells products across nine distinct product categories, including beverages, food items and retail products. The dataset includes categories such as Coffee, Tea, Bakery, Coffee Beans and Drinking Chocolate, indicating a diverse product offering. Understanding the available product categories will assist in analysing revenue contribution and sales performance for each category during the CEO analysis.

-- ==========================================================
-- Query 3.5 – Count the Number of Product Types
-- ==========================================================
--
-- Purpose: Determine the total number of unique product types available in the coffee shop sales dataset.
--
-- Functions Used:
-- COUNT(DISTINCT)
--
-- Description:
-- COUNT(DISTINCT) counts only unique values within
-- the specified column, excluding duplicates.
--
-- Business Value: Product types provide a more detailed breakdown of the product categories and will be used to identify the best-performing product groups during the sales analysis.

SELECT
    COUNT(DISTINCT product_type) AS Total_Product_Types
FROM sales;

-- Results Interpretation: The dataset contains 29 unique product types.This indicates that the coffee shop offers a wide variety of products within its nine product categories. Product type analysis will provide more detailed nsights into customer purchasing behaviour and will support the identification of high-performing and low-performing product groups during the CEO analysis.

-- ==========================================================
-- Query 3.6 – Display Product Types
-- ==========================================================
--
-- Purpose:
-- Display all unique product types available in the coffee shop sales dataset.
--
-- Functions Used:
-- DISTINCT
-- ORDER BY
--
-- Description: DISTINCT returns only unique product types by removing duplicate values.
--
-- ORDER BY sorts the product types alphabetically
-- for easier interpretation.
--
-- Business Value: Product types provide a detailed view of the coffee shop's product portfolio and support more granular revenue and sales performance analysis.

SELECT DISTINCT
       product_type
FROM sales
ORDER BY product_type ASC;

-- Results Interpretation: The dataset contains 29 unique product types that span multiple beverage, food and retail product offerings. The product portfolio includes coffee beverages, tea beverages, bakery items, chocolate products,  coffee beans and branded merchandise. This diverse product mix provides an opportunity to analyse customer purchasing behaviour at a much more detailed level than product categories alone. Product type analysis will later be used to identify the highest and lowest revenue generating products.

-- ==========================================================
-- Query 3.7 – Count the Number of Store Locations
-- ==========================================================
--
-- Purpose:
-- Determine the total number of unique store locations represented in the coffee shop sales dataset.
--
-- Functions Used:
-- COUNT(DISTINCT)
--
-- Description:
-- COUNT(DISTINCT) counts only unique store locations,
-- excluding duplicate entries.
--
-- Business Value: Understanding the number of store locations allows the business to compare sales performance between different stores during the CEO analysis.

SELECT
    COUNT(DISTINCT store_location) AS Total_Store_Locations
FROM sales;

-- Results Interpretation: The dataset contains sales transactions from three unique store locations. Having multiple store locations enables comparative sales analysis to identify which branches generate the highest revenue, sell the most products and perform best overall. Store performance analysis will later assist management in identifying best practices and opportunities for operational improvement.

-- ==========================================================
-- Query 3.8 – Display Store Locations
-- ==========================================================
--
-- Purpose: Display all unique store locations represented in the coffee shop sales dataset.
--
-- Functions Used:
-- DISTINCT
-- ORDER BY
--
-- Description:
-- DISTINCT returns each store location only once.
-- ORDER BY sorts the store locations alphabetically
-- to improve readability.
--
-- Business Value: Identifying the available store locations provides context for comparing branch performance during the sales analysis.

SELECT DISTINCT
       store_location
FROM sales
ORDER BY store_location ASC;

-- Results Interpretation: The coffee shop operates from three unique store
-- locations:

-- • Astoria
-- • Hell's Kitchen
-- • Lower Manhattan
--
-- These locations provide the opportunity to compare branch performance based on revenue, sales volume, product popularity and customer purchasing behaviour. Store-level analysis will help identify the strongest and weakest performing branches during the CEO analysis.

-- ==========================================================
-- Query 3.9 – Determine the Date Range
-- ==========================================================
--
-- Purpose: Identify the earliest and latest transaction dates contained within the coffee shop sales dataset.
--
-- Functions Used:
-- MIN()
-- MAX()
--
-- Description:
-- MIN() returns the earliest transaction date.
-- MAX() returns the latest transaction date.
--
-- Business Value: Understanding the reporting period provides context for all subsequent sales analysis and ensures that management knows the time frame covered by the data.

SELECT
    MIN(transaction_date) AS Earliest_Transaction_Date,
    MAX(transaction_date) AS Latest_Transaction_Date
FROM sales;

-- Results Interpretation: The dataset covers a six-month reporting period, from 01 January 2023 to 30 June 2023. This reporting period provides sufficient historical data to analyse sales trends, customer purchasing behaviour and store performance. All revenue, product and store analysis performed during this project will be based on this six-month period.

-- ==========================================================
-- Query 3.10 – Transaction Quantity Statistics
-- ==========================================================
--
-- Purpose: Analyse the distribution of transaction quantities by identifying the minimum, maximum and average number of items purchased per transaction.
--
-- Functions Used:
-- MIN()
-- MAX()
-- AVG()
-- ROUND()
--
-- Description:
-- MIN() returns the smallest transaction quantity.
-- MAX() returns the largest transaction quantity.
-- AVG() calculates the average transaction quantity.
-- ROUND() formats the average to two decimal places.
--
-- Business Value: Understanding purchasing quantities helps identify customer buying behaviour and supports inventory planning and demand forecasting.

SELECT
    MIN(transaction_qty) AS Minimum_Quantity,
    MAX(transaction_qty) AS Maximum_Quantity,
    ROUND(AVG(transaction_qty),2) AS Average_Quantity
FROM sales;

-- Results Interpretation: Customers purchase an average of 1.44 items per transaction, indicating that most transactions consist of one or two products. The minimum quantity purchased is one item, while the maximum quantity purchased in a single transaction is eight items. These results suggest that customer purchases are generally small, presenting an opportunity for the business to increase basket size through promotions and product bundling.

-- ==========================================================
-- Query 3.11 - Transactions by Category
-- ==========================================================
--
-- Purpose: Count transactions for each product category.
--
-- Functions Used:
-- COUNT()
-- GROUP BY
--
-- Business Value: Identifies which categories appear most often.


SELECT
product_category,
COUNT(*) AS Total_Transactions
FROM sales
GROUP BY product_category
ORDER BY Total_Transactions DESC;

-- Results Interpretation: Coffee is the most frequently purchased product category. The high number of Coffee transactions indicates that beverages represent the core business offering. This analysis measures transaction frequency rather than revenue. Categories with fewer transactions may still generate higher revenue depending on their selling price.

-- ==========================================================
--                    4. DATA VALIDATION
-- ==========================================================
--
-- Objective: Validate the quality, completeness and consistency of the coffee shop sales dataset before performing data cleaning, transformation and business analysis. The validation process ensures that the dataset is accurate, reliable and suitable for generating meaningful business insights.
--
-- Functions demonstrated in this section:
--
-- CASE
-- SUM()
-- COUNT()
-- COUNT(DISTINCT)
-- WHERE
-- TRIM()
-- LIKE
--
-- Expected Outcome: 
--
-- Identify missing values, duplicate records,
-- invalid values and formatting issues that require
-- correction during the data cleaning phase.
-- ==========================================================

-- ==========================================================
-- Query 4.1 – Missing Values Check
-- ==========================================================
--
-- Purpose: Identify missing (NULL) values in the key columns of the coffee shop sales dataset.
--
-- Functions Used:
-- CASE
-- SUM()
--
-- Description: CASE evaluates whether a column contains NULL values. SUM() totals the number of missing values for each selected column.
--
-- Business Value: Missing values may lead to inaccurate calculations and unreliable business insights if not identified before data transformation.

SELECT

SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_ID,

SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_Date,

SUM(CASE WHEN transaction_time IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_Time,

SUM(CASE WHEN transaction_qty IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_Quantity,

SUM(CASE WHEN store_location IS NULL THEN 1 ELSE 0 END) AS Missing_Store_Location,

SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Category,

SUM(CASE WHEN product_type IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Type,

SUM(CASE WHEN product_detail IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Detail,

SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS Missing_Unit_Price

FROM sales;

-- Results Interpretation: No missing (NULL) values were identified across any of the key columns in the coffee shop sales dataset. This indicates that the dataset is complete and contains all the required information for data cleaning, transformation and business analysis. Since there are no missing values, no imputation or removal of records is required during the cleaning phase. The dataset is suitable to proceed to the next validation check.

-- ==========================================================
-- Query 4.2 – Duplicate Transaction ID Validation
-- ==========================================================
--
-- Purpose: Determine whether any duplicate transaction IDs exist in the coffee shop sales dataset.
--
-- Functions Used:
-- COUNT()
-- COUNT(DISTINCT)
--
-- Description:
-- COUNT(*) returns the total number of records.
-- COUNT(DISTINCT) returns the number of unique
-- transaction IDs.
--
-- Business Value: Duplicate transaction IDs may indicate duplicate records, which could result in inflated sales, revenue and transaction counts if not identified.

SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT transaction_id) AS Unique_Transaction_IDs,
    COUNT(*) - COUNT(DISTINCT transaction_id) AS Duplicate_Transaction_IDs
FROM sales;

-- Results Interpretation: The total number of records matches the total number of unique transaction IDs. This confirms that there are no duplicate transaction records within the dataset. The absence of duplicate transaction IDs improves the reliability of revenue calculations, transaction counts and customer purchasing analysis. No duplicate records require removal during the data cleaning phase.

-- ==========================================================
-- Query 4.3 – Validate Transaction Quantities
-- ==========================================================
--
-- Purpose: Identify any transactions with invalid quantities.
--
-- Functions Used:
-- COUNT()
-- WHERE
--
-- Description:
-- COUNT() counts the number of records that satisfy
-- the specified condition.
--
-- WHERE filters the dataset to include only records
-- where the transaction quantity is less than or
-- equal to zero.
--
-- Business Value: Transaction quantities should always be greater than zero. Invalid quantities may indicate data entry errors or system issues that require correction.

SELECT
    COUNT(*) AS Invalid_Transaction_Quantities
FROM sales
WHERE transaction_qty <= 0;

-- Results Interpretation: There are no invalid transaction quantities were identified. All recorded transactions contain quantities greater than zero, indicating that every transaction represents a valid customer purchase. This confirms that the transaction quantity field is suitable for sales calculations and inventory analysis. No corrective action is required during the data cleaning phase.

-- ==========================================================
-- Query 4.4 – Validate Unit Prices
-- ==========================================================
--
-- Purpose: Identify any products with invalid unit prices (less than or equal to zero).
--
-- Functions Used:
-- CAST()
-- REPLACE()
-- COUNT()
-- WHERE
--
-- Description:
-- REPLACE() converts commas to decimal points where
-- necessary.
--
-- CAST() converts the unit_price from STRING to DECIMAL.
--
-- COUNT() counts the number of invalid prices.
--
-- WHERE filters prices that are less than or equal to zero.
--
-- Business Value: Products should always have a positive selling price. Invalid prices could result in incorrect revenue calculations and misleading business insights.

SELECT
    COUNT(*) AS Invalid_Unit_Prices
FROM sales
WHERE CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2)) <= 0;

-- Results Interpretation: There are no invalid unit prices were identified within the dataset. All products have positive selling prices, confirming that the pricing information is suitable for revenue calculations and financial analysis. Since no invalid prices were detected, no corrective action is required during the data cleaning phase.

-- ==========================================================
-- Query 4.5 – Validate Product Categories
-- ==========================================================
--
-- Purpose: Identify blank or empty product category values.
--
-- Functions Used:
-- TRIM()
-- COUNT()
-- WHERE
--
-- Description:
-- TRIM() removes leading and trailing spaces.
-- COUNT() counts the number of blank values.
--
-- Business Value: Every transaction should belong to a product category. Blank categories would impact category-level reporting.

SELECT
    COUNT(*) AS Blank_Product_Categories
FROM sales
WHERE TRIM(product_category) = '';

-- Results Interpretation: There are no blank product category values were identified in the dataset. Every transaction has been assigned to a valid product category, ensuring complete category-level reporting and accurate sales analysis. No data cleaning is required for the product category field.

-- ==========================================================
-- Query 4.6 – Validate Product Types
-- ==========================================================
--
-- Purpose: Identify blank or empty product type values.
--
-- Functions Used:
-- TRIM()
-- COUNT()
-- WHERE
--
-- Description:
-- TRIM() removes leading and trailing spaces.
-- COUNT() counts blank product type values.
--
-- Business Value: Every transaction should be assigned to a product type. Blank values would reduce the accuracy of detailed product performance analysis.


SELECT
    COUNT(*) AS Blank_Product_Types
FROM sales
WHERE TRIM(product_type) = '';

-- Results Interpretation: There are no blank product type values were identified in the dataset. Every transaction has been assigned to a valid product types, ensuring complete category-level reporting and accurate sales analysis. No data cleaning is required for the product category field.

-- ==========================================================
-- Query 4.7 – Validate Store Locations
-- ==========================================================
--
-- Purpose: Identify blank or empty store location values.
--
-- Functions Used:
-- TRIM()
-- COUNT()
-- WHERE
--
-- Description:
-- TRIM() removes leading and trailing spaces.
-- COUNT() counts blank store location values.
--
-- Business Value: Every transaction should be linked to a valid store location. Blank values would impact branch-level sales analysis and reporting.

SELECT
    COUNT(*) AS Blank_Store_Locations
FROM sales
WHERE TRIM(store_location) = '';

-- Results Interpretation: There are no blank store locations values that were identified in the dataset. Every transaction has been assigned to a valid location, ensuring complete category-level reporting and accurate sales analysis. No data cleaning is required for the product category field.

-- ===============================================================
--                   5.  Data Transformation
-- ===============================================================
--
-- The objective of the Data Transformation section is to prepare the validated dataset for business analysis by converting, enriching and creating new data elements that support meaningful reporting and decision-making. Data transformation ensures that the dataset is stored in the correct format, improves data quality, and creates additional business metrics that will be used throughout the CEO analysis and dashboard.
--
-- The Functions that will be demonstrated in this section:
--
-- • CAST()
-- • REPLACE()
-- • CASE WHEN
-- • HOUR()
-- • MINUTE()
-- • CONCAT()
-- • ROUND()
-- • YEAR()
-- • MONTH()
-- • DAY()
-- • QUARTER()
-- • DAYOFWEEK()
-- • DATE_FORMAT()
--
-- New Business Columns Created:
--
-- • unit_price_decimal
-- • total_amount
-- • transaction_time_bucket
-- • sales_period
-- • transaction_year
-- • transaction_month
-- • transaction_day
-- • transaction_quarter
-- • day_of_week
--
-- Expected Outcome:
--
-- • Convert text values into the correct numeric format.
-- • Create calculated fields for revenue analysis.
-- • Group transactions into meaningful time intervals.
-- • Create business-friendly date fields for trend analysis.
-- • Prepare the dataset for CEO-ready reporting and
--   dashboard visualisations.
--
-- ===============================================================

-- ==========================================================
-- Query 5.1 – Convert Unit Price to Decimal
-- ==========================================================
--
-- Purpose: Convert unit_price from a text/string field into a decimal number so that revenue calculations can be performed.
--
-- Functions Used:
-- REPLACE()
-- CAST()
--
-- Description:
-- REPLACE() changes commas to decimal points.
-- CAST() converts the cleaned value into a DECIMAL data type.
--
-- Business Value: Revenue analysis requires product prices to be stored as numeric values. This transformation prepares unit_price for calculations such as total_amount and total revenue. The data set is being limited to 20 so that it's easier to perform spot checks. 


SELECT
    unit_price,
    CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2)) AS unit_price_decimal
FROM sales
LIMIT 20;

-- Results Interpretation: The unit_price field was successfully converted from a string data type into a decimal data type. Values containing commas were correctly converted into decimal numbers, allowing mathematical calculations to be performed. The transformed unit_price field is now ready for the calculation of total_amount and revenue analysis.

-- ==========================================================
-- Query 5.2 – Create the Total Amount Column
-- ==========================================================
--
-- Purpose:Calculate the total sales amount for each transaction by multiplying the quantity purchased by the unit price.
--
-- Functions Used:
-- REPLACE()
-- CAST()
-- Arithmetic Operator (*)
--
-- Description:
-- REPLACE() converts commas to decimal points.
-- CAST() converts the cleaned value into a DECIMAL.
-- The multiplication operator (*) calculates the total
-- sales amount for each transaction.
--
-- Business Value: The total_amount column represents the revenue generated from each transaction and will be used throughout the CEO analysis to calculate total revenue, store performance, product performance and sales trends.


SELECT

transaction_id,

transaction_qty,

unit_price,

CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))
AS unit_price_decimal,

transaction_qty *
CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))
AS total_amount

FROM sales

LIMIT 20;

-- Results Interpretation: The total_amount column was successfully calculated by multiplying the transaction quantity by the converted unit price.The calculated values represent the revenue generated by each individual transaction. This new business metric will be used throughout the CEO analysis to calculate:
--
-- • Total Revenue
-- • Revenue by Store
-- • Revenue by Product Category
-- • Revenue by Product Type
-- • Monthly Revenue Trends

-- ==========================================================
-- Query 5.3 – Create Transaction Time Buckets
-- ==========================================================
--
-- Purpose: Group transactions into 3-hour intervals to analyse customer purchasing behaviour throughout the day.
--
-- Functions Used:
-- CASE WHEN
-- HOUR()
--
-- Description:
-- HOUR() extracts the hour from the transaction timestamp.
--
-- CASE WHEN assigns each transaction to a predefined
-- 3-hour reporting interval.
--
-- Business Value: Grouping transactions into time buckets allows the business to identify peak trading periods, customer purchasing behaviour and periods of low activity. This information assists management with staffing, inventory planning and promotional campaigns.

SELECT

transaction_id,

transaction_time,

CASE

WHEN HOUR(transaction_time) BETWEEN 0 AND 2 THEN '00:00 - 02:59'

WHEN HOUR(transaction_time) BETWEEN 3 AND 5 THEN '03:00 - 05:59'

WHEN HOUR(transaction_time) BETWEEN 6 AND 8 THEN '06:00 - 08:59'

WHEN HOUR(transaction_time) BETWEEN 9 AND 11 THEN '09:00 - 11:59'

WHEN HOUR(transaction_time) BETWEEN 12 AND 14 THEN '12:00 - 14:59'

WHEN HOUR(transaction_time) BETWEEN 15 AND 17 THEN '15:00 - 17:59'

WHEN HOUR(transaction_time) BETWEEN 18 AND 20 THEN '18:00 - 20:59'

ELSE '21:00 - 23:59'

END AS transaction_time_bucket

FROM sales

LIMIT 20;

-- Results Interpretation: The transaction_time values were successfully grouped into predefined 3-hour reporting intervals. The sample records fall within the 06:00–08:59 time bucket, confirming that the CASE statement correctly categorises transactions based on the hour of the day. This transformed field will support future analysis of customer purchasing behaviour and identification of peak trading periods.

-- ==========================================================
-- Query 5.4 – Create Sales Period
-- ==========================================================
--
-- Purpose: Categorise each transaction into a business-friendly sales period (Morning, Afternoon or Evening) based on the transaction time.
--
-- Functions Used:
-- CASE
-- HOUR()
--
-- Description:
-- HOUR() extracts the hour from the transaction timestamp.
-- CASE assigns each transaction to a sales period based
-- on the hour of the day.
--
-- Business Value: Creating sales periods makes it easier to analyse customer purchasing behaviour throughout the day and identify the busiest trading periods for staffing and operational planning.

SELECT
    transaction_id,
    transaction_time,

    CASE
        WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(transaction_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS sales_period

FROM sales
LIMIT 20;

-- Results Interpretation: The transaction_time values were successfully classified into business-friendly sales periods. The sample records were all categorised as Morning, confirming that the CASE statement correctly grouped transactions occurring between 06:00 and 11:59. This transformation simplifies future reporting by making it easier to analyse sales performance by time of day, compare customer purchasing behaviour across different periods, and identify peak trading hours.

-- ==========================================================
-- Query 5.5 – Extract Day of Week
-- ==========================================================
--
-- Purpose: Extract the day of the week from each transaction date.
--
-- Functions Used:
-- DATE_FORMAT()
--
-- Description:
-- DATE_FORMAT() converts the transaction date into the
-- corresponding weekday name.
--
-- Business Value: Identifying the day of the week allows the business to analyse sales trends, compare weekday and weekend performance, and support staffing and promotional planning.


SELECT
    transaction_id,
    transaction_date,
    DATE_FORMAT(transaction_date, 'EEEE') AS day_of_week
FROM sales
LIMIT 20;

-- Results Interpretation: The transaction_date field was successfully transformed into the corresponding weekday name. The sample records all occurred on 01 January 2023, which was correctly identified as Sunday. This transformation prepares the dataset for analysing sales trends by day of the week, identifying peak trading days, and supporting staffing and promotional decisions

-- ==========================================================
-- Query 5.6 – Extract Month Name
-- ==========================================================
--
-- Purpose: Extract the month name from each transaction date.
--
-- Functions Used:
-- DATE_FORMAT()
--
-- Description:
-- DATE_FORMAT() converts the transaction date into its
-- corresponding month name.
--
-- Business Value: Extracting the month name enables the business to analyse monthly sales trends, identify seasonal purchasing patterns, and compare revenue performance across different months.

SELECT
    transaction_id,
    transaction_date,
    DATE_FORMAT(transaction_date, 'MMMM') AS month_name
FROM sales
LIMIT 20;

-- Results Interpretation: The transaction_date field was successfully transformed into the corresponding month name. The sample records all occurred during January, confirming that the DATE_FORMAT() function correctly extracted the month from the transaction date. This transformation prepares the dataset for monthly sales trend analysis, seasonal performance comparisons, and management reporting.

-- ==========================================================
-- SECTION 6 – EXPLORATORY DATA ANALYSIS (EDA)
-- ==========================================================
--
-- Purpose: Explore the prepared coffee shop sales dataset to identify business trends, customer purchasing behaviour and sales performance across products, stores and time periods. The queries in this section focus on generating business insights rather than cleaning or transforming the data.
--
-- Key Areas Analysed:
-- • Revenue Performance
-- • Product Performance
-- • Store Performance
-- • Customer Purchasing Behaviour
-- • Time-based Sales Trends
-- ==========================================================

-- ==========================================================
-- Query 6.1 – Calculate Total Revenue
-- ==========================================================
--
-- Purpose: Calculate the total revenue generated from all coffee shop transactions.
--
-- Functions Used:
-- SUM()
-- CAST()
-- REPLACE()
--
-- Description:
-- REPLACE() converts commas into decimal points.
-- CAST() converts unit_price into a numeric value.
-- SUM() adds together the revenue generated by each
-- transaction.
--
-- Business Value: Total revenue is one of the most important business performance indicators. It provides management with an overall view of sales performance across the reporting period.
-- ==========================================================

SELECT

ROUND(
SUM(
transaction_qty *
CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))
),2) AS Total_Revenue

FROM sales;

-- Results Interpretation: The coffee shop generated a total revenue of 698,812.33 during the reporting period. This metric provides management with an overall view of business performance and serves as a baseline for further analysis of revenue by product category, store location, sales period and time. The calculated revenue will also be used to compare the contribution of different products and stores in the subsequent analysis.

-- ==========================================================
-- Query 6.2 – Revenue by Product Category
-- ==========================================================
--
-- Purpose: Calculate the total revenue generated by each product category.
--
-- Functions Used:
-- SUM()
-- CAST()
-- REPLACE()
-- ROUND()
-- GROUP BY
-- ORDER BY
--
-- Description: Revenue is calculated by multiplying transaction quantity by the converted unit price. The results are grouped by product category and sorted from highest to lowest revenue. Business Value: Understanding revenue by product category helps management identify the most profitable product groups, optimise product offerings, and make informed inventory and marketing decisions.

SELECT

product_category,

ROUND(
SUM(
transaction_qty *
CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))
),2) AS Total_Revenue

FROM sales

GROUP BY product_category

ORDER BY Total_Revenue DESC;

-- Results Interpretation: Coffee generated the highest revenue (269,952.45), followed by Tea (196,405.95). Together, these two categories account for the majority of the coffee shop's revenue. Bakery and Drinking Chocolate also contribute significantly, while Coffee Beans, Branded items, Loose Tea and Flavours generate comparatively lower revenue. These insights help management identify the most profitable product categories and support decisions regarding inventory planning, marketing campaigns, pricing strategies and future product investments.

-- ==========================================================
-- Query 6.3 – Revenue by Store Location
-- ==========================================================
--
-- Purpose: Calculate the total revenue generated by each store location.
--
-- Functions Used:
-- SUM()
-- CAST()
-- REPLACE()
-- ROUND()
-- GROUP BY
--
-- Description:
-- REPLACE() converts commas in unit_price to decimal points.
-- CAST() converts unit_price into a numeric data type.
-- SUM() calculates the total revenue for each store.
-- ROUND() formats the revenue to two decimal places.
-- GROUP BY groups the results by store location.
--
-- Business Value: Analysing revenue by store location enables management to compare branch performance and identify which stores contribute the most to overall sales. These insights can support operational planning, staffing decisions, inventory allocation and future business expansion. Lower-performing branches can also be identified for further investigation and improvement initiatives.

SELECT

    store_location,

    ROUND(
        SUM(
            transaction_qty *
            CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))
        ),2
    ) AS Total_Revenue

FROM sales

GROUP BY store_location

ORDER BY Total_Revenue DESC;

-- Results Interpretation: The analysis shows that Hell's Kitchen generated the highest total revenue (236,511.17), followed closely by Astoria (232,243.91) and Lower Manhattan (230,057.25). Although Hell's Kitchen is the top-performing branch, the revenue difference between the three store locations is relatively small, indicating that sales performance is well balanced across all branches. These results suggest that each store is making a strong contribution to overall business revenue. Management can use this information to monitor branch performance, identify best practices from the highest-performing location and investigate opportunities to further improve sales at the other stores while maintaining consistent operational performance across all locations.

-- ==========================================================
-- Query 6.4 – Revenue by Month
-- ==========================================================
--
-- Purpose: Calculate the total revenue generated in each month during the reporting period.
--
-- Functions Used:
-- SUM()
-- ROUND()
-- CAST()
-- REPLACE()
-- DATE_FORMAT()
-- GROUP BY
--
-- Description:
-- DATE_FORMAT() extracts the month name from the transaction date.
-- REPLACE() converts commas in unit_price to decimal points.
-- CAST() converts the cleaned unit_price into a DECIMAL data type.
-- SUM() calculates the total revenue for each month.
-- ROUND() formats the revenue to two decimal places.
-- GROUP BY groups the results by month.
--
-- Business Value: Analysing revenue by month enables the business to identify seasonal sales trends and monitor revenue performance over time. This information supports budgeting, forecasting, inventory planning, staffing decisions and promotional campaigns. Understanding monthly revenue patterns also allows management to prepare for peak and low trading periods.

SELECT

    DATE_FORMAT(transaction_date,'MMMM') AS Month,

    ROUND(
        SUM(
            transaction_qty *
            CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))
        ),2
    ) AS Total_Revenue

FROM sales

GROUP BY DATE_FORMAT(transaction_date,'MMMM')

ORDER BY MIN(transaction_date);

-- Results Interpretation: The monthly revenue analysis shows a steady increase in sales over the six-month reporting period. Revenue started at 81,677.74 in January, declined slightly to 76,145.19 in February, and then increased consistently from March through June. June recorded the highest monthly revenue at 166,485.88, more than double the revenue generated in February. This upward trend suggests that the coffee shop experienced sustained business growth throughout the reporting period. The increase in monthly revenue may be attributed to growing customer demand, successful promotional activities, seasonal purchasing behaviour or improvements in operational performance. Management can use these insights to forecast future sales, plan inventory requirements and develop marketing strategies that maintain this positive growth trajectory.

-- ==========================================================
-- Query 6.5 – Revenue by Sales Period
-- ==========================================================
--
-- Purpose: Calculate the total revenue generated during each sales period (Morning, Afternoon and Evening).
--
-- Functions Used:
-- CASE
-- HOUR()
-- SUM()
-- ROUND()
-- CAST()
-- REPLACE()
-- GROUP BY
--
-- Description:
-- HOUR() extracts the hour from the transaction time.
-- CASE classifies transactions into Morning,
-- Afternoon or Evening.
-- REPLACE() converts commas to decimal points.
-- CAST() converts unit_price into a DECIMAL data type.
-- SUM() calculates the total revenue for each sales period.
-- ROUND() formats the revenue to two decimal places.
-- GROUP BY groups the results by sales period.
--
-- Business Value: Analysing revenue by sales period helps the business understand when customers spend the most money throughout the day. These insights support workforce planning, promotional scheduling, inventory preparation and operational efficiency by ensuring resources are allocated during peak trading periods.


SELECT

CASE

    WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(transaction_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'

END AS sales_period,

ROUND(

SUM(

transaction_qty *
CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))

),2) AS Total_Revenue

FROM sales

GROUP BY

CASE

    WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(transaction_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'

END

ORDER BY Total_Revenue DESC;

-- Results Interpretation: The analysis indicates that the Morning sales period generated the highest revenue (388,288.67), accounting for the largest share of total sales. The Afternoon period generated the second-highest revenue (244,855.14), while the Evening period recorded the lowest revenue (65,668.52). These findings suggest that customer purchasing activity is concentrated during the morning hours, making it the busiest and most profitable trading period. Management can use these insights to allocate additional staff, ensure sufficient inventory is available during peak morning hours and schedule promotional campaigns to increase customer traffic during the lower-performing afternoon and evening periods. Optimising operations based on customer purchasing behaviour can improve both sales performance and customer service.

-- ==========================================================
-- Query 6.6 – Average Transaction Value
-- ==========================================================
--
-- Purpose: Calculate the average value of a customer transaction.
--
-- Functions Used:
-- SUM()
-- COUNT()
-- ROUND()
-- CAST()
-- REPLACE()
--
-- Description:
-- SUM() calculates the total revenue generated.
-- COUNT() counts the total number of transactions.
-- REPLACE() converts commas to decimal points.
-- CAST() converts unit_price into a DECIMAL data type.
-- ROUND() formats the average transaction value to two decimal places.
--
-- Business Value: Average transaction value is an important performance indicator that measures how much customers spend per transaction. Monitoring this metric helps management evaluate customer purchasing behaviour, assess the effectiveness of promotions and pricing strategies, and identify opportunities to increase customer spending through upselling and cross-selling initiatives.

SELECT

ROUND(

SUM(
transaction_qty *
CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))
)
/COUNT(transaction_id)

,2) AS Average_Transaction_Value

FROM sales;

-- Results Interpretation: The analysis shows that the average transaction value is 4.69. This indicates that, on average, each customer transaction generated 4.69 in revenue during the reporting period. This metric provides valuable insight into customer spending behaviour and serves as a benchmark for measuring future business performance. Management can use the average transaction value to evaluate the effectiveness of pricing strategies, promotional campaigns and upselling initiatives. Increasing this value over time would indicate that customers are purchasing higher-value products or buying more items per transaction, ultimately contributing to increased revenue and business growth.

-- ==========================================================
-- Query 6.7 – Average Revenue per Store
-- ==========================================================
--
-- Purpose: Calculate the average revenue generated by each store location.
--
-- Functions Used:
-- AVG()
-- ROUND()
-- SUM()
-- CAST()
-- REPLACE()
-- GROUP BY
--
-- Description: Revenue is first calculated for each transaction before AVG() determines the average revenue generated at each store location. ROUND() formats the results to two decimal places.
--
-- Business Value: Comparing the average revenue generated across store locations enables management to evaluate branch  performance and identify whether revenue generation is balanced across the business. These insights support operational planning, resource allocation and continuous performance improvement.


SELECT

store_location,

ROUND(

AVG(

transaction_qty *
CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))

),2) AS Average_Revenue_Per_Transaction

FROM sales

GROUP BY store_location

ORDER BY Average_Revenue_Per_Transaction DESC;

-- Results Interpretation: The analysis shows that Lower Manhattan recorded the highest average revenue per transaction (4.81), followed by Hell's Kitchen (4.66) and Astoria (4.59). Although Lower Manhattan generated the lowest total revenue overall, customers at this location spent slightly more on average per transaction than customers at the other stores. These findings suggest that while Hell's Kitchen generated the highest overall revenue due to a larger number of transactions, Lower Manhattan achieved the highest average transaction value, indicating stronger customer spending per  purchase. Management can use these insights to compare customer purchasing behaviour across locations, identify successful sales strategies and implement best practices across all stores to increase average customer spending and  overall revenue.
-- ==========================================================
