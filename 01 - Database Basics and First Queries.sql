-- ============================================================
--  CLASS 01 — Querying, Sorting & Filtering
--  Database : BikeStores
-- ============================================================


-- ============================================================
--  1. CREATE DATABASE
--  Creates a new database named BikeStores.
-- ============================================================

CREATE DATABASE BikeStores;


-- ============================================================
--  2. SELECT — Basic Queries
--  Retrieves data from a table.
--  Use * to select all columns, or list specific column names.
-- ============================================================

-- Fetch every column from the customers table
SELECT * FROM sales.customers;

-- Fetch every column from the products table
SELECT * FROM production.products;

-- Fetch only specific columns (product_id and product_name)
SELECT product_id, product_name
FROM production.products;

-- Fetch all orders
SELECT * FROM sales.orders;


-- ============================================================
--  3. WHERE — Filtering Rows
--  Returns only the rows that match the given condition.
--  SQL executes FROM → WHERE → SELECT (Order of Execution).
-- ============================================================

-- Get the customer whose ID is 94
SELECT *
FROM sales.customers
WHERE customer_id = 94;

-- Get only the name of that specific customer
SELECT first_name, last_name
FROM sales.customers
WHERE customer_id = 94;

-- Filter customers by city
SELECT *
FROM sales.customers
WHERE city = 'New York';

-- Filter customers by state abbreviation
SELECT *
FROM sales.customers
WHERE state = 'NY';


-- ============================================================
--  4. ORDER BY — Sorting Results
--  Sorts the result set by one or more columns.
--  Default direction is ASC (ascending).
--
--  Syntax:
--    SELECT  select_list
--    FROM    table_name
--    ORDER BY column_name | expression [ASC | DESC]
-- ============================================================

-- Sort customers by first name A → Z (default ASC)
SELECT first_name, last_name
FROM sales.customers
ORDER BY first_name;

-- Sort customers by first name Z → A (DESC)
SELECT first_name, last_name
FROM sales.customers
ORDER BY first_name DESC;

-- Sort products by price lowest → highest
SELECT *
FROM production.products
ORDER BY list_price ASC;

-- Sort products by price highest → lowest
SELECT *
FROM production.products
ORDER BY list_price DESC;

-- Sort by multiple columns: model year ASC, then price DESC within each year
SELECT *
FROM production.products
ORDER BY model_year ASC, list_price DESC;


-- ---- Sorting with multiple columns ----

-- Sort customers by city then by first name (both ASC)
SELECT city, first_name, last_name
FROM sales.customers
ORDER BY city, first_name;

-- Sort customers by city ASC, then first name DESC
SELECT city, first_name, last_name
FROM sales.customers
ORDER BY city ASC, first_name DESC;

-- Sort all orders by order date newest first
SELECT *
FROM sales.orders
ORDER BY order_date DESC;

-- Filter by state then sort by city — WHERE runs before ORDER BY
SELECT city, first_name, last_name
FROM sales.customers
WHERE state = 'NY'
ORDER BY city;


-- ============================================================
--  5. TOP N / TOP PERCENT — Limiting Rows (SQL Server)
--  TOP N  → returns the first N rows after sorting.
--  TOP N PERCENT → returns N% of the total row count (rounds up).
--  Note: PostgreSQL uses LIMIT instead of TOP.
-- ============================================================

-- Top 10 most expensive products (all columns)
SELECT TOP 10 *
FROM production.products
ORDER BY list_price DESC;

-- Top 10 most expensive products (selected columns only)
SELECT TOP 10 product_id, product_name, list_price
FROM production.products
ORDER BY list_price DESC;

-- Top 10 cheapest products
SELECT TOP 10 product_id, product_name, list_price
FROM production.products
ORDER BY list_price ASC;

-- Top 1% of products by price
-- Total rows = 321 → 1% = 3.21 → rounds up to 4 rows returned
SELECT TOP 1 PERCENT *
FROM production.products
ORDER BY list_price DESC;


-- ============================================================
--  6. OFFSET & FETCH — Pagination
--  OFFSET  : skip the first N rows.
--  FETCH NEXT : take the next N rows after the offset.
--  Useful for page-by-page data navigation.
-- ============================================================

-- Skip the first 10 rows, return the rest (sorted by price DESC)
SELECT *
FROM production.products
ORDER BY list_price DESC
OFFSET 10 ROWS;

-- Skip 2 rows, then fetch the next 5 rows (rows 3–7)
SELECT *
FROM production.products
ORDER BY list_price DESC
OFFSET 2 ROWS
FETCH NEXT 5 ROWS ONLY;

-- Skip 0 rows, fetch the first 10 rows (same as TOP 10)
SELECT *
FROM production.products
ORDER BY list_price DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

-- Sort customers by street address
SELECT *
FROM sales.customers
ORDER BY street;

-- Return only customers who have a phone number on record
SELECT *
FROM sales.customers
WHERE phone IS NOT NULL;


-- ============================================================
--  7. DISTINCT — Unique Values
--  Removes duplicate rows from the result.
--  When used on multiple columns, the combination must be unique.
--
--  Syntax:
--    SELECT DISTINCT column_name
--    FROM   table_name
-- ============================================================

-- All cities (with duplicates)
SELECT city
FROM sales.customers
ORDER BY city;

-- Unique cities only — returns 195 unique city values
SELECT DISTINCT city
FROM sales.customers
ORDER BY city;

-- Unique model years in the products table
SELECT DISTINCT model_year
FROM production.products;

-- Unique city + state combinations
SELECT DISTINCT city, state
FROM sales.customers;

-- All city + state rows (with duplicates, for comparison)
SELECT city, state
FROM sales.customers
ORDER BY city;

-- Unique state + city combinations (column order swapped)
SELECT DISTINCT state, city
FROM sales.customers;

-- Unique states only
SELECT DISTINCT state
FROM sales.customers;

-- Unique phone numbers, sorted
SELECT DISTINCT phone
FROM sales.customers
ORDER BY phone;


-- ============================================================
--  8. Logical Operators — AND / OR
--  AND : both conditions must be TRUE → result is TRUE
--        if either condition is FALSE → result is FALSE
--  OR  : at least one condition must be TRUE → result is TRUE
-- ============================================================

-- AND: products in category 1 AND priced above $400
SELECT *
FROM production.products
WHERE category_id = 1
  AND list_price > 400
ORDER BY list_price DESC;

-- OR: products in category 1 OR priced above $400
SELECT *
FROM production.products
WHERE category_id = 1
   OR list_price > 400
ORDER BY list_price DESC;

-- AND: products priced above $300 AND from model year 2018
SELECT *
FROM production.products
WHERE list_price > 300
  AND model_year = 2018;

-- View all products sorted by category (reference query)
SELECT *
FROM production.products
ORDER BY category_id;

-- Class exercise: products priced above $1000 AND from brand 1 OR brand 2
-- Parentheses ensure OR is evaluated before AND
SELECT *
FROM production.products
WHERE list_price > 1000
  AND (brand_id = 1 OR brand_id = 2);
