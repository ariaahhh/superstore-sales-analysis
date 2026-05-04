# Superstore Sales Analysis 📊

## Project Overview
Analysed 9,994 retail orders from a US Superstore spanning 4 years (2014–2017) 
using SQL and PostgreSQL to uncover revenue trends, customer behaviour, 
product performance and profitability insights.

## Tools Used
- PostgreSQL
- SQL (CTEs, Window Functions, Subqueries, CASE WHEN, Date Functions)

## Dataset
- 9,994 orders
- 4 years of data (2014–2017)
- 3 categories, 17 sub-categories
- 4 US regions

## Key Business Questions Answered
1. What is the total revenue, profit and quantity sold?
2. Which category and region generates the most revenue?
3. Who are the top 10 customers by spending?
4. Which products are most and least profitable?
5. What are the monthly and yearly revenue trends?
6. Which customer segment drives the most revenue?
7. What percentage of orders are loss making?
8. Which sub-category has the highest profit margin?
9. Who are the top 3 customers in each region?
10. Which month has the highest sales?

## Key Findings
- 💰 Total revenue: $2.29M | Total profit: $286K
- 📦 Technology is the most profitable category
- 🚨 Furniture has high revenue but very low profit — a red flag
- 🏆 Canon imageCLASS Copier is the star product ($25K profit)
- ❌ 3D Printers are the biggest loss makers — negative profit
- 👤 793 unique customers | Sean Miller is the #1 customer
- 📅 November is peak sales month (Black Friday effect)
- 🌍 West region leads in both revenue and profit
- ⚠️ 19% of orders are loss making
- 📈 Copiers have the highest profit margin among all sub-categories

## SQL Concepts Used
- SELECT, WHERE, ORDER BY, LIMIT, DISTINCT
- Aggregate functions — SUM, COUNT, AVG, MIN, MAX
- GROUP BY and HAVING
- INNER JOIN, LEFT JOIN
- Subqueries
- CTEs (Common Table Expressions)
- CASE WHEN
- Window Functions — RANK, PARTITION BY
- Date Functions — EXTRACT

## Project Structure
- `superstore_analysis.sql` — all analysis queries with comments
- `findings_summary.md` — detailed findings written as an analyst report
