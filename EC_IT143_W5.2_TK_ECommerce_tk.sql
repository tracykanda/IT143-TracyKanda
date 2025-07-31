
-- Enable time statistics
SET STATISTICS TIME ON;

/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_TK_ECommerce_tk.sql
PURPOSE: This script is answering 4 questions related to the TK_ECommerce analysis

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     07/31/2025   TKANDA       1. Built this script for EC IT143


RUNTIME: 
 1s 363ms

NOTES: 
This script has been developed in response to Assignment 5.2 for EC IT143. It focuses on generating responses for
the TK_ECommerce analysis. Through this task, I aim to apply the knowledge and skills acquired over the 
past four weeks, while also preparing for the Final Project: "My Community’s Analysis – Present Findings." 
Additional context and explanations for each question are provided within the script comments.
 
******************************************************************************************************************/

--Enforcing the use of TK_ECommerce Database
USE TK_ECommerce;
/* Q1: As part of the marketing team, we want to analyze which product categories generate the most revenue. 
   Provide a report that includes each category name, total quantity sold, total revenue, and the number of distinct
   customers who purchased from that category. From Frederick Boafo Ampofo
   A1: 
   Restating: Provide a report showing each product category’s name, total quantity sold, total revenue, and number 
   of unique customers, to help identify top-sold categories.
   SQL solution: The script below creates a view that aggregates sales data by product category. It calculates the 
   total quantity sold, rounded-up total revenue, and unique customers count. This is then saved in a procedure. 
*/
-- Drop the procedure, the view, the table if they exist
DROP PROCEDURE IF EXISTS usp_Revenue_By_Category;
GO
DROP VIEW IF EXISTS v_Revenue_By_Category;
GO
DROP TABLE IF EXISTS t_Revenue_By_Category;
GO
-- Create a view that summarizes product category performance
-- This includes total quantity sold, total revenue, and number of distinct customers per category
CREATE VIEW v_Revenue_By_Category AS
SELECT
    pr.category AS Product_Category,
    SUM(oi.quantity) AS Total_Quantity_Sold,
    CEILING(SUM(oi.total_price)) AS Total_Revenue,
    COUNT(DISTINCT o.customer_id) AS Customers_Count
 FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN payments pa ON o.order_id = pa.order_id
--Handling potential errors due to null values recorded in the table
WHERE pr.category IS NOT NULL AND oi.quantity IS NOT NULL AND oi.total_price IS NOT NULL
GROUP BY pr.category;
GO
CREATE TABLE t_Revenue_By_Category (
    Prodcut_Category NVARCHAR(50) NOT NULL,
    Total_Quantity_Sold FLOAT NOT NULL,
    Total_Revenue FLOAT NOT NULL,
    Customers_Count INT NOT NULL
);
GO
--Creating a Procedure
CREATE PROCEDURE usp_Revenue_By_Category
AS
    BEGIN
--Reloading data into the table
        TRUNCATE TABLE t_Revenue_By_Category;
        INSERT INTO t_Revenue_By_Category
            SELECT 
                Product_Category,
                Total_Quantity_Sold,
                Total_Revenue,
                Customers_Count
            FROM v_Revenue_By_Category
;
--Reviewing the results that have been stored in the table
        SELECT t.*
         FROM t_Revenue_By_Category AS t
        ORDER BY Total_Revenue DESC;
    END;
GO
--Executing the stored procedure
EXEC usp_Revenue_By_Category;

/**************************************************************************************************************************************************/

/* Q2: Can you determine which product category generated the highest total revenue using the Products, Order_items, and Orders tables? 
       From roni rolando ñahui bolivar
   A2: 
   Restating: Which product category has the highest total revenue? 
   SQL solution: The script below lists teachers in order of the number of students they’ve graded, along with their personal details
   I have used a view and stored the results into a new table. 
   not necessary for this particular question
*/
-- Determining the product category with the highest total revenue
--joining order_items with products and aggregating by category
SELECT TOP 1
    p.category AS Product_Category,
    CEILING(SUM(oi.total_price)) AS Total_Revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE p.category IS NOT NULL AND oi.total_price IS NOT NULL
GROUP BY p.category
ORDER BY total_revenue DESC
;

/**************************************************************************************************************************************************/
/* Q3: Customer support is reviewing potentially failed transactions. Show a list of all orders that have not received any payments. Include the 
       order ID, customer name, order date, and order status. This helps in flagging incomplete or abandoned orders. From Me
   A3: 
   Restating: List all orders that haven’t received any payments. Include the order ID, customer name, order date, and order status
   SQL solution: The script below retrieves all orders that have no associated payment records, meaning that they exist in the orders table but do 
   not have a record (or have a null paid amount) in the payments table
*/

SELECT 
    o.order_id,
    c.[name] AS Customer_Name, 
    o.order_date,
    o.order_status
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
LEFT JOIN customers c ON o.customer_id = c.customer_id

WHERE p.order_id IS NULL
ORDER BY order_id ASC;

/**************************************************************************************************************************************************/
/* Q4: The marketing team is identifying top customers for a loyalty program. Which customers have placed the most orders, and what is their total 
       spending across all transactions?. From Me
   A4: 
   Restating: Who are the top customers by number of orders and what is their total spending? 
   SQL solution: The script lists students who have never scored below 70 in any subject. It returns their full name, email, and total number of 
   exams taken. Results are sorted by exam count (descending) and then alphabetically by name. The output is saved as a view, then in a table, and 
   accessed via a stored procedure.
*/
-- Dropping the table/the view/the procedure if it exists
DROP PROCEDURE IF EXISTS usp_Top_Customers_ByOrders_Count;
GO
DROP VIEW IF EXISTS v_Top_Customers_ByOrders_Count;
GO
DROP TABLE IF EXISTS t_Top_Customers_ByOrders_Count;
GO

CREATE VIEW v_Top_Customers_ByOrders_Count
AS
SELECT
    o.customer_id,
    c.[name] AS Customer_Name,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    CEILING(SUM(p.amount_paid)) AS Total_Spending
FROM orders o
JOIN payments p ON o.order_id = p.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL AND p.amount_paid IS NOT NULL
GROUP BY o.customer_id, c.[name]
;
GO
 -- Creating a new table to store the results from the view
CREATE TABLE t_Top_Customers_ByOrders_Count (
    Customer_id FLOAT NOT NULL,
    Customer_Name VARCHAR(50),
    Total_Orders INT NOT NULL,
    Total_Spending FLOAT NOT NULL
);
GO
--Creating a Procedure
CREATE PROCEDURE usp_Top_Customers_ByOrders_Count
AS
    BEGIN
--Reloading data
        TRUNCATE TABLE t_Top_Customers_ByOrders_Count;
        INSERT INTO t_Top_Customers_ByOrders_Count
            SELECT Customer_id, 
                   Customer_Name, 
                   Total_Orders,
                   Total_Spending
              FROM v_Top_Customers_ByOrders_Count
;
--Reviewing the results that have been stored in the table
        SELECT t.*
         FROM t_Top_Customers_ByOrders_Count AS t
        ORDER BY Total_Orders DESC, Total_Spending DESC
    END;
GO
--Executing the stored procedure
EXEC usp_Top_Customers_ByOrders_Count;   

-- Disable time statistics
SET STATISTICS TIME OFF;
