/*
Sales Visualization Project
Dataset: Online Retail II
Tool: MySQL
*/

/* =========================
   1. Data Cleaning
========================= */

-- حذف العملاء اللي معندهمش CustomerID
DELETE FROM online_retali_raw
WHERE customerid IS NULL;

-- حذف المرتجعات (Quantity سالب)
DELETE FROM online_retali_raw
WHERE quantity < 0;

-- إضافة عمود TotalSales
ALTER TABLE online_retali_raw
ADD COLUMN totalsales DECIMAL(10,2);

-- حساب قيمة المبيعات
UPDATE online_retali_raw
SET totalsales = quantity * unitprice;

/* =========================
   2. Analysis (EDA)
========================= */

-- Top 5 Products by Revenue
SELECT description,
       SUM(totalsales) AS revenue
FROM online_retali_raw
GROUP BY description
ORDER BY revenue DESC
LIMIT 5;

-- Top 3 Countries by Revenue (excluding UK)
SELECT country,
       SUM(totalsales) AS revenue
FROM online_retali_raw
WHERE country <> 'United Kingdom'
GROUP BY country
ORDER BY revenue DESC
LIMIT 3;

-- Orders by Hour (using invoice_datetime)
SELECT HOUR(invoice_datetime) AS order_hour,
       COUNT(DISTINCT invoiceno) AS orders_count
FROM online_retali_raw
GROUP BY order_hour
ORDER BY order_hour;

