
-- To see the data
SELECT * FROM pizza_sales

-- To find Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

-- To find Average Order Value
SELECT (SUM(total_price)/COUNT(DISTINCT order_id)) AS Average_Order_Value 
FROM pizza_sales

-- To find Total Pizza sold
SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales

-- To find Total orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
From pizza_sales

-- To find Average pizza per order
SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS Average_Pizza_Per_Order
FROM pizza_sales
-- Casting it to Decimal (10,2)
-- 10 decimal places but we want only 2 decimal points to be displayed
SELECT CAST(SUM(quantity) AS DECIMAL(10,2))/
       CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
AS Average_Pizza_Per_Order
FROM pizza_sales
-- Casting the final result
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
            CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Average_Pizza_Per_Order
FROM pizza_sales
--------------------------------------------------------------------------------------
-- CHARTS
-- 1. Daily trend of Orders
SELECT DATENAME(DW,order_date) AS Order_Day,
       COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY DATENAME(DW,order_date)

-- 2. Monthly Trend of Orders
SELECT DATENAME(MONTH,order_date) AS Order_Month,
       COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_Order DESC

-- Percentage Sale by Pizza Category
SELECT pizza_category,
       SUM(total_price) AS Total_Sales, 
	   SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_category

-- NOTE if we want to see at month level
SELECT pizza_category,
       SUM(total_price) AS Total_Sales, 
	   SUM(total_price)*100/
	   (SELECT SUM(total_price) FROM pizza_sales 
	    WHERE MONTH(order_date)=1) AS Percentage_of_Sales
FROM pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_category

-- Sale Percentage by Pizza Size
SELECT pizza_size,
       SUM(total_price) AS Total_Sales, 
	   SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_of_Sales DESC

-- NOTE To see at quarter level
SELECT pizza_size,
       SUM(total_price) AS Total_Sales, 
	   SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter,order_date)=1) 
	   AS Percentage_of_Sales
FROM pizza_sales
WHERE DATEPART(quarter,order_date)=1
GROUP BY pizza_size
ORDER BY Percentage_of_Sales DESC

-- TOP 5 Pizza by revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Bottom 5 Pizza by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- TOP 5 Best seller pizza by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- Bottom 5 pizza by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

-- TOP 5 pizza by Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- BOTTOM 5 pizza by Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
