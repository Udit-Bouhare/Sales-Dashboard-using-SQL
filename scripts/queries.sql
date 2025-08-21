-- =====================================================
--  Create & Use Database
-- =====================================================
CREATE DATABASE Coffee_Shop_Sales_db;
USE Coffee_Shop_Sales_db;

-- =====================================================
--  Ensure Order_date is a DATE type
-- =====================================================
ALTER TABLE Coffee_Shop_Table
    MODIFY COLUMN Order_date DATE;

DESCRIBE Coffee_Shop_Table;

-- =====================================================
--  Basic Sales Aggregations
-- =====================================================

-- Total Sales in May
SELECT 
    SUM(Total_Price) AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5;


-- =====================================================
--  Month-over-Month (MoM) Sales Growth
-- =====================================================
WITH monthly_sales AS (
    SELECT 
        MONTH(Order_date) AS month,
        ROUND(SUM(Total_Price)) AS total_sales
    FROM Coffee_Shop_Table
    WHERE MONTH(Order_date) IN (4, 5) -- April & May
    GROUP BY MONTH(Order_date)
)
SELECT 
    month,
    total_sales,
    ((total_sales - LAG(total_sales, 1) OVER (ORDER BY month))
     / LAG(total_sales, 1) OVER (ORDER BY month)) * 100 AS mom_increase_percentage
FROM monthly_sales
ORDER BY month;


-- =====================================================
--  Total Orders in May
-- =====================================================
SELECT 
    COUNT(Order_id) AS Total_Orders
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5;


-- MoM Orders Growth
WITH Monthly_orders AS (
    SELECT
        MONTH(Order_date) AS Month,
        COUNT(Order_id) AS Total_orders
    FROM Coffee_Shop_Table
    WHERE MONTH(Order_date) IN (4, 5)
    GROUP BY MONTH(Order_date)
)
SELECT
    Month,
    Total_orders,
    (Total_orders - LAG(Total_orders, 1) OVER (ORDER BY Month))
        / LAG(Total_orders, 1) OVER (ORDER BY Month) * 100 AS mom_increase_percentage
FROM Monthly_orders;


-- =====================================================
--  Total Quantity Sold
-- =====================================================
SELECT 
    SUM(Quantity) AS total_quantity
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 6;


-- MoM Quantity Growth
WITH Monthly_sold AS (
    SELECT 
        MONTH(Order_date) AS Month,
        ROUND(SUM(Quantity)) AS Total_quantity
    FROM Coffee_Shop_Table
    WHERE MONTH(Order_date) IN (4, 5)
    GROUP BY MONTH(Order_date)
)
SELECT
    Month,
    Total_quantity,
    (Total_quantity - LAG(Total_quantity, 1) OVER (ORDER BY Month))
        / LAG(Total_quantity, 1) OVER (ORDER BY Month) * 100 AS mom_increase_percentage
FROM Monthly_sold;


-- =====================================================
--  KPIs on a Specific Date
-- =====================================================
SELECT
    CONCAT(ROUND(SUM(Total_Price) / 1000, 1), 'k') AS Total_sales,
    CONCAT(ROUND(COUNT(Order_id) / 1000, 1), 'k') AS Total_Orders,
    CONCAT(ROUND(SUM(Quantity) / 1000, 1), 'k') AS Total_quantity_sold
FROM Coffee_Shop_Table
WHERE Order_date = '2023-05-18';


-- =====================================================
--  Weekdays vs Weekends Sales
-- =====================================================
SELECT
    CASE 
        WHEN DAYOFWEEK(Order_date) IN (1, 7) THEN 'Weekends'
        ELSE 'Weekdays' 
    END AS day_type,
    CONCAT(ROUND(SUM(Total_Price) / 1000, 1), 'k') AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5
GROUP BY day_type;


-- =====================================================
--  Sales by Store Location
-- =====================================================
SELECT
    Store_location,
    CONCAT(ROUND(SUM(Total_Price) / 1000, 2), 'k') AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5
GROUP BY Store_location
ORDER BY SUM(Total_Price) DESC;


-- =====================================================
--  Sales by Product Category
-- =====================================================
SELECT
    product_category,
    SUM(Total_Price) AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5
GROUP BY product_category
ORDER BY SUM(Total_Price) DESC;


-- =====================================================
--  Average Daily Sales in May
-- =====================================================
SELECT
    CONCAT(ROUND(AVG(Total_sales) / 1000, 1), 'K') AS Avg_sales
FROM (
    SELECT 
        SUM(Total_Price) AS Total_sales
    FROM Coffee_Shop_Table
    WHERE MONTH(Order_date) = 5
    GROUP BY Order_date
) AS Inner_query;


-- =====================================================
--  Daily Sales Trend in May
-- =====================================================
SELECT
    DAY(Order_date) AS day_of_month,
    SUM(Total_price) AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5
GROUP BY Order_date
ORDER BY Order_date;


-- =====================================================
--  Daily Sales vs Average Sales
-- =====================================================
SELECT 
    day_of_month,
    CASE 
        WHEN avg_sales > Total_sales THEN 'Below Average'
        WHEN avg_sales < Total_sales THEN 'Above Average'
        ELSE 'Average'
    END AS sales_status,
    Total_sales
FROM (
    SELECT 
        DAY(Order_date) AS day_of_month,
        SUM(Total_Price) AS Total_sales,
        AVG(SUM(Total_Price)) OVER () AS avg_sales
    FROM Coffee_Shop_Table
    WHERE MONTH(Order_date) = 5
    GROUP BY Order_date
) AS sales_data
ORDER BY day_of_month;


-- =====================================================
--  Top 10 Products by Sales
-- =====================================================
SELECT  
    product_type,
    SUM(Total_Price) AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5
GROUP BY product_type
ORDER BY Total_sales DESC
LIMIT 10;


-- Top 10 Coffee Products
SELECT  
    product_type,
    SUM(Total_Price) AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5 
  AND product_category = 'Coffee'
GROUP BY product_type
ORDER BY Total_sales DESC
LIMIT 10;


-- =====================================================
--  Sales by Day of Week
-- =====================================================
SELECT
    CASE 
        WHEN DAYOFWEEK(Order_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(Order_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(Order_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(Order_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(Order_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(Order_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_week,
    ROUND(SUM(Total_Price)) AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5
GROUP BY Day_of_week
ORDER BY FIELD(Day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');


-- =====================================================
--  Hourly Sales in May
-- =====================================================
SELECT
    HOUR(Time) AS Hour_of_day,
    ROUND(SUM(Total_Price)) AS Total_sales
FROM Coffee_Shop_Table
WHERE MONTH(Order_date) = 5
GROUP BY Hour_of_day
ORDER BY Hour_of_day;


-- =====================================================
--  Monday at 8 AM Sales (Granular Example)
-- =====================================================
SELECT
    ROUND(SUM(Total_Price)) AS Total_sales,
    SUM(Quantity) AS Total_Quantity,
    COUNT(Order_id) AS Total_Orders
FROM Coffee_Shop_Table
WHERE DAYOFWEEK(Order_date) = 2  -- Monday
  AND MONTH(Order_date) = 5
  AND HOUR(Time) = 8;


















