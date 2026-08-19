-- ============================================================
--  ASSIGNMENT 01 — Querying, Sorting & Filtering
--  Database : BikeStores
--  Topics   : SELECT, WHERE, ORDER BY, TOP/OFFSET-FETCH,
--             DISTINCT, AND / OR
-- ============================================================


-- ============================================================
--  Question 1 — SELECT & WHERE
--  Retrieve the first name, last name, city, and phone number
--  of all customers who live in the state of 'CA' (California)
--  and have a phone number on record.
-- ============================================================

-- Write your query below:

select first_name, last_name, city, state, phone 
from sales.customers 
where state = 'CA' and phone IS NOT NULL


-- ============================================================
--  Question 2 — ORDER BY (Multiple Columns)
--  Fetch the product_id, product_name, model_year, and
--  list_price of all products.
--  Sort the results by model_year in descending order, and
--  within the same year sort by list_price in ascending order.
-- ============================================================

-- Write your query below:

select product_id, product_name, model_year, list_price 
from production.products 
ORDER by model_year DESC, list_price ASC


-- ============================================================
--  Question 3 — TOP N & TOP PERCENT
--  a) Return the top 5 most expensive products showing only
--     product_name and list_price.
--  b) Return the top 5% of cheapest products (all columns).
--     How many rows does the 5% result return? Add the row
--     count as a comment in your answer.
-- ============================================================

-- Part a:
select TOP 5 product_name, list_price 
from production.products 
ORDER by list_price DESC

-- Part b:
select TOP 5 PERCENT * from production.products 
ORDER by list_price ASC
--total rows = 17

SELECT COUNT(*) AS TotalProducts
FROM (
    SELECT TOP 5 PERCENT *
    FROM production.products
    ORDER BY list_price ASC
) AS p;



-- ============================================================
--  Question 4 — OFFSET & FETCH (Pagination)
--  The sales team wants to browse products page by page,
--  10 products per page, sorted by list_price descending.
--  Write queries to return:
--    a) Page 1  (rows  1 – 10)
--    b) Page 2  (rows 11 – 20)
--    c) Page 3  (rows 21 – 30)
-- ============================================================

-- Page 1:


-- Page 2:


-- Page 3:




-- ============================================================
--  Question 5 — DISTINCT
--  a) List all unique states in which BikeStores has customers.
--     Sort the result alphabetically.
--  b) List every unique combination of state and city,
--     sorted by state then city (both ascending).
--  c) How many unique model years exist in the products table?
--     (Retrieve the distinct values; count them manually or
--     use COUNT — your choice.)
-- ============================================================

-- Part a:
select Distinct state from SALES.CUSTOMERS 
order by state asc

-- Part b:
select Distinct state, city from SALES.CUSTOMERS 
order by state asc ,city asc

-- Part c:
select Distinct model_year AS model_year 
from production.products

select COUNT (Distinct model_year) AS model_year 
from production.products 
--total_values = 4
 


-- ============================================================
--  Question 6 — Logical Operators (AND / OR)
--  Write a single query that returns the product_id,
--  product_name, brand_id, category_id, and list_price for
--  products that meet ALL of the following conditions:
--    • list_price is between $500 and $1500 (inclusive)
--    • model_year is 2019 OR 2020
--  Sort the results by list_price ascending.
--  Hint: use parentheses to control the order of evaluation.
-- ============================================================

-- Write your query below:
select product_id,product_name, brand_id, category_id, list_price, model_year 
from production.products 
where (list_price > 500 or list_price < 1500) and (model_year = 2019 or model_year = 2020)
order by list_price asc