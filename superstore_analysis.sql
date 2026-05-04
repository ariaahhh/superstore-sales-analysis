-- ================================================
-- Superstore Sales Analysis
-- Tool: PostgreSQL
-- Dataset: 9,994 orders | 2014-2017
-- Author: ARYA I R 
-- ================================================


-- ================================================
-- SECTION 1: Basic Business Overview
-- ================================================

-- Q1: Total revenue, profit and quantity sold
SELECT 
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM superstore;
-- Result: $2.29M revenue | $286K profit | 37,873 units

-- Q2: Total revenue and profit per category
SELECT 
    category,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_revenue DESC;
-- Result: Technology leads revenue and profit

-- Q3: Top 10 most profitable products
SELECT 
    product_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;
-- Result: Canon imageCLASS Copier is the star product at $25K profit

-- Q4: Bottom 5 least profitable products
SELECT 
    product_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 5;
-- Result: 3D Printers are the biggest loss makers

-- Q5: Total revenue and profit per region
SELECT 
    region,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_revenue DESC;
-- Result: West region leads in both revenue and profit


-- ================================================
-- SECTION 2: Time Based Analysis
-- ================================================

-- Q6: Total revenue per year
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS total_revenue
FROM superstore
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;

-- Q7: Which month has the highest total sales?
SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(sales) AS total_revenue
FROM superstore
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY total_revenue DESC
LIMIT 1;
-- Result: November is peak sales month (Black Friday effect)

-- Q8: Total revenue per year per category
SELECT 
    category,
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS total_revenue
FROM superstore
GROUP BY EXTRACT(YEAR FROM order_date), category
ORDER BY year;


-- ================================================
-- SECTION 3: Customer Analysis
-- ================================================

-- Q9: Top 10 customers by total spending
SELECT 
    customer_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;
-- Result: Sean Miller is the #1 customer at $25K

-- Q10: Total number of unique customers
SELECT COUNT(DISTINCT customer_name) AS unique_customers
FROM superstore;
-- Result: 793 unique customers

-- Q11: Revenue and profit per segment
SELECT 
    segment,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_revenue DESC;
-- Result: Consumer segment dominates revenue and profit


-- ================================================
-- SECTION 4: Advanced Analysis
-- ================================================

-- Q12: Count orders by profitability category
WITH order_categories AS (
    SELECT 
        CASE 
            WHEN profit > 0 THEN 'Profitable'
            WHEN profit = 0 THEN 'Break Even'
            ELSE 'Loss'
        END AS profit_category
    FROM superstore
)
SELECT 
    profit_category,
    COUNT(*) AS total_orders
FROM order_categories
GROUP BY profit_category;
-- Result: 8058 profitable | 1871 loss | 65 break even

-- Q13: Orders above average sales value
SELECT COUNT(*) AS above_avg_orders
FROM superstore
WHERE sales > (SELECT AVG(sales) FROM superstore);
-- Result: 2,360 orders above average

-- Q14: Top 3 customers by revenue in each region
WITH customer_sales AS (
    SELECT 
        region,
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY region, customer_name
),
ranked_customers AS (
    SELECT 
        region,
        customer_name,
        total_sales,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) AS region_rank
    FROM customer_sales
)
SELECT 
    region,
    customer_name,
    total_sales,
    region_rank
FROM ranked_customers
WHERE region_rank <= 3
ORDER BY region, region_rank;

-- Q15: Profit margin per sub-category
SELECT 
    sub_category,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY sub_category
ORDER BY profit_margin DESC;
-- Result: Copiers have highest margin | Tables have negative margin
