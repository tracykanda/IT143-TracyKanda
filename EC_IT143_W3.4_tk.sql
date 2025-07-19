/*****************************************************************************************************************
NAME:    EC_IT143_W3.4_tk
PURPOSE: Solve 8 questions of 4 different levels of complexity.

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     05/23/2022   JJAUSSI       1. Built this script for EC IT440


RUNTIME: 
630ms

NOTES: 
I am building this script in order to show how we can answer business-related questions of different level of 
complexity using AdventureWorks 2022: 
https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak
SSMS, and SQL.
 
******************************************************************************************************************/

-- Q1: Marginal Complexity: Which products have a list price greater than $1,000? from Ibrahim Conteh
-- A1: 
     --Restating the question: Which products have a list price greater than $1,000? list their names and IDs;
	 --SQL solution: The following query retrieves the names and IDs of products whose list price exceeds $1,000:
SELECT  [ProductID],
		[Name],
		[ListPrice]
 FROM 
	[Production].[Product]
WHERE [ListPrice] > 1000 ;

--******************************************************************************************************************/

-- Q2: Marginal Complexity: How many employees were hired in 2014? from Kalemba Faith Esther
-- A2: 
     --Restating the question: What is the total number of employees hired from 01 January 2014 to 31 December 2014
	 --SQL solution: The following query returns the number of employees hired in 2014 :
SELECT COUNT(*) AS EmployeeHiredIn2014
 FROM [HumanResources].[Employee]
WHERE [HireDate] >= '2014-01-01' AND  [HireDate] <= '2014-12-31';

--******************************************************************************************************************/

-- Q3: Moderate Complexity: I’d like to know which sales reasons are being used the most. 
      --Can you give me a report showing the top 5 sales reasons based on how often each one appears in our order 
      --records? I want to see the sales reason name along with the total count for each. From Scott Baranda
-- A3: 
     --Restating the question: What are the top 5 most frequently used sales reasons in our order records?
	                         --I’d like to see each sales reason’s name along with the number of times it was used.
	 --SQL solution: The following query returns the top 5 most used SalesReasons and their usage counts:
SELECT TOP 5 
    sr.Name AS SalesReason,
    COUNT(*) AS ReasonCount
FROM Sales.SalesOrderHeaderSalesReason srsr
JOIN Sales.SalesReason sr ON srsr.SalesReasonID = sr.SalesReasonID
GROUP BY sr.Name
ORDER BY ReasonCount DESC;

--******************************************************************************************************************/

-- Q4: Moderate Complexity: To optimize our product portfolio and focus marketing efforts, I want to identify 
       --underperforming categories. Which product categories recorded no sales transactions during the year 2022? 
       --From Me
-- A4: 
     --Restating the question: I want to find out which product categories had no sales at all during the year 2022
	 --SQL solution: The following query returns product categories with no sales in 2022:

--Select product category names, alias the table as pc, and the output column as CategoryName.
SELECT pc.Name AS CategoryName
FROM Production.ProductCategory pc
--Filter categories to only include those without any matching sales record
--Join Product, SalesOrderDetail, and SalesOrderHeader tables to retrieve product sales,categories, and dates.
WHERE NOT EXISTS (
    SELECT 1
    FROM Production.Product p
    JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
   --Filter the products per category
    WHERE p.ProductSubcategoryID IN (
        SELECT psc.ProductSubcategoryID
        FROM Production.ProductSubcategory psc
        WHERE psc.ProductCategoryID = pc.ProductCategoryID
    )
    --Only include sales that happened in 2022
    AND soh.OrderDate >= '2022-01-01' AND soh.OrderDate < '2023-01-01'
);
--******************************************************************************************************************/

-- Q5: Increased Complexity: The boss has asked to see a report that we need help with. How do we get a report 
       --that takes the “ProductID”, “StartDate”, “StandardCost” from the Production.ProductCostHistory table 
       --and then adds in the products “Name” from the Production.Product table? We need the following sort order:
       --“productid” ascending, “startdate” descending. From Travis Ryan Graham
-- A5: 
     --Restating the question: How can we create a report showing ProductID, StartDate, and StandardCost from 
     --ProductCostHistory, plus the product Name from Product, sorted by ProductID (ASC) and StartDate (DESC)?
	 --SQL solution: This query retrieves ProductID, StartDate, StandardCost, and product Name from a join of two 
     --tables, sorted by ProductID (ascending) and StartDate (descending):
SELECT 
    pch.ProductID,
    pch.StartDate,
    pch.StandardCost,
    p.Name AS ProductName
FROM Production.ProductCostHistory pch
JOIN Production.Product p ON pch.ProductID = p.ProductID
ORDER BY 
    pch.ProductID ASC,
    pch.StartDate DESC;
--******************************************************************************************************************/

-- Q6: Increased Complexity: A manager is analyzing product return trends in 2013. Can you create a report showing 
       --which products were returned the most, along with the number of returns, reason for return, and average 
       --list price? The manager needs this to decide on quality improvements. From Alex Ohuru
-- A6: 
     --Restating the question: Create a report that shows which products were returned the most in 2013, plus the 
     --reason for each return, how many times each product was returned, and the average list price? 
     --Rework: Since return reasons aren't available, I've revised the question to ensure it's feasible and
     --produces meaningful results. Reworked question: "Create a report showing which products were returned the 
     --most in 2013, including the number of returns and the average list price?  
	 --SQL solution: This query returns each product’s name, number of returns, and average list price for every
     --product returned 2013, all sorted by the most returned:
SELECT 
    p.Name AS ProductName,
    COUNT(*) AS ReturnCount,
    AVG(p.ListPrice) AS AvgListPrice
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE soh.Status = 5
  AND soh.OrderDate >= '2013-01-01' AND soh.OrderDate < '2014-01-01'
GROUP BY p.Name
ORDER BY ReturnCount DESC;

--******************************************************************************************************************/

-- Q7: Metadata: Can you create a list of tables in AdventureWorks that contain a column with one of these names: 
       --BusinessEntityID or AddressID? From Me
-- A7: 
     --Restating the question: List all the tables in the AdventureWorks database that have a column named either 
     --BusinessEntityID or AddressID? 
	 --SQL solution: This query lists all tables that have a column named either BusinessEntityID or AddressID:
SELECT 
    t.name AS TableName,
    c.name AS ColumnName
FROM sys.tables t
JOIN sys.columns c ON t.object_id = c.object_id
WHERE c.name IN ('BusinessEntityID', 'AddressID')
ORDER BY c.name, t.name;

--******************************************************************************************************************/

-- Q8: Metadata:What are the names and data types of all columns in the Production.Product table?From ANdrew Peacock
-- A8: 
     --Restating the question: List all the column names of the table Production.Product along with their data types 
	 --SQL solution: This query retrieves the names and data types of all columns in the Production.Product table:
SELECT 
    COLUMN_NAME, 
    DATA_TYPE 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
    TABLE_NAME = 'Product' 
    AND TABLE_SCHEMA = 'Production';

--****************************************************THE END**************************************************************/
SELECT GETDATE() AS my_date;