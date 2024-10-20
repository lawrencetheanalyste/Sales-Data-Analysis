---VIEW DATASET
SELECT *
FROM Sales_Data_No_dups

---CHECKING FOR NULL VALUES 
SELECT *
FROM Sales_Data_No_dups
WHERE Order_ID IS NOT NULL 
      AND Product IS NOT NULL
	  AND Quantity_Ordered IS NOT NULL
	  AND Price_Each IS NOT NULL
	  AND Order_Date IS NOT NULL
	  AND Purchase_Address IS NOT NULL
	  AND Sales IS NOT NULL
	  AND City IS NOT NULL

---TOTAL QUANTITY ORDERED
SELECT SUM(Quantity_Ordered) total_quantity_ordered
FROM Sales_Data_No_dups

---TOTAL ORDERS
SELECT COUNT(DISTINCT(Order_ID)) total_orders
FROM Sales_Data_No_dups

---TOTAL REVENUE
SELECT SUM(Sales) revenue
FROM Sales_Data_No_dups

---TOTAL QUANTITY ORDERED BY YEAR
SELECT DATENAME(YEAR, Order_Date) year_ordered,
       SUM(Quantity_Ordered) total_ordered
FROM Sales_Data_No_dups
GROUP BY DATENAME(YEAR, Order_Date)

---TOTAL ORDERS BY YEAR
SELECT DATENAME(YEAR, Order_Date) year_ordered,
       COUNT(DISTINCT(Order_ID))
FROM Sales_Data_No_dups
GROUP BY DATENAME(YEAR, Order_Date)

---TOTAL REVENUE BY YEAR
SELECT DATENAME(YEAR, Order_Date) year_ordered,
       SUM(Sales) revenue
FROM Sales_Data_No_dups
GROUP BY DATENAME(YEAR, Order_Date) 

---QUANTITY ORDERED BY PRODUCT
SELECT Product,
       SUM(Quantity_Ordered) total_ordered
FROM Sales_Data_No_dups
GROUP BY Product
ORDER BY total_ordered DESC

---TOP 10 PRODUCTS BY QUANTITY ORDERED
SELECT TOP(10) 
       Product, 
       SUM(Quantity_Ordered) total_ordered
FROM Sales_Data_No_dups
GROUP BY Product
ORDER BY total_ordered DESC

---BOTTOM 10 PRODUCTS BY QUANTITY ORDERED
SELECT TOP(10) 
       Product, 
       SUM(Quantity_Ordered) total_ordered
FROM Sales_Data_No_dups
GROUP BY Product
ORDER BY total_ordered ASC

---FREQUENTLY ORDERED PRODUCTS
SELECT Product,
       COUNT(DISTINCT(Order_ID)) times_ordered
FROM Sales_Data_No_dups
GROUP BY Product
ORDER BY times_ordered DESC

---AVG. QUANTITY ORDERED BY PRODUCT
SELECT Product,
       AVG(Quantity_Ordered) avg_order
FROM Sales_Data_No_dups
GROUP BY Product
ORDER BY avg_order DESC

---REVENUE BY CITY
SELECT City,
	   ROUND(SUM(Sales),2) revenue
FROM Sales_Data_No_dups
GROUP BY City
ORDER BY revenue DESC

---REVENUE BY PRODUCT
SELECT Product,
       ROUND(SUM(Sales),2) total_sales
FROM Sales_Data_No_dups
GROUP BY Product
ORDER BY Product

---MAX AND MIN SALES BY CITY
SELECT City,
       MAX(Sales) max_sales,
	   MIN(Sales) min_sales
FROM Sales_Data_No_dups
GROUP BY City

---TOTAL REVENUE, QUANTITY ORDER AND TOTAL ORDERS PER MONTH
SELECT MONTH(Order_Date) month_no,
       DATENAME(MONTH, Order_Date) sales_month,
       ROUND(SUM(Sales), 2) total_revenue,
	   SUM(Quantity_Ordered) total_quantity_ordered,
	   COUNT(DISTINCT(Order_ID)) total_orders
FROM Sales_Data_No_dups
GROUP BY MONTH(Order_Date), DATENAME(MONTH, Order_Date)
ORDER BY MONTH(Order_Date) ASC

---TOTAL SALES AND AVERAGE QUANTITY ORDERED BY PRODUCT AND CITY
SELECT City,
       Product,
	   ROUND(SUM(Sales), 2) total_sales,
	   ROUND(AVG(Quantity_Ordered), 2) avg_ordered
FROM Sales_Data_No_dups
GROUP BY Product, City

---MONTHLY SALES GROWTH
SELECT MONTH(Order_Date) month_no,
       DATENAME(MONTH, Order_Date) month_name,
       SUM(Sales) total_sales,
	   LAG(SUM(Sales)) OVER (ORDER BY MONTH(Order_Date)) previous_month_sales,
	   ROUND((SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY MONTH(Order_Date))) / LAG(SUM(Sales)) OVER (ORDER BY MONTH(Order_Date)) * 100, 2) montly_sales_growth
FROM Sales_Data_No_dups
GROUP BY MONTH(Order_Date), DATENAME(MONTH, Order_Date)
ORDER BY MONTH(Order_Date) ASC

---AVERAGE ORDER VALUE AND TOTAL REVENUE BY YEAR
SELECT DATENAME(YEAR, Order_Date) year_,
       ROUND(SUM(Sales),2) total_revenue,
	   ROUND(SUM(Sales)/ (COUNT(DISTINCT(Order_ID))),2) avg_order_value
FROM Sales_Data_No_dups
GROUP BY DATENAME(YEAR, Order_Date)





	  

