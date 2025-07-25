DROP VIEW IF EXISTS dbo.v_Pending_Orders_PerCustomer;
GO

CREATE VIEW dbo.v_Pending_Orders_PerCustomer
AS

/********************************************************************************************************************
NAME: dbo.v_Pending_Orders_PerCustomer
PURPOSE: Create Pending orders report per customer's name - Load view 

MODIFICATION LOG:
Ver		Date			Author		Description
----	-------			--------	----------------------------------------------------------------------------
1.0		07/24/2025		TKanda		1. Built this script for EC IT143


RUNTIME:
1s

NOTES:
This script exists to help me learn step 4 of 8 in the Answer Focused Approach for T-SQL Data Manipulation

**********************************************************************************************************************/
--Q: How many orders are still pending per customer's name?
--A: This script shows how many pending orders each customer has, along with their name within the TK_ECommerce database

SELECT 
    c.[name],
    COUNT([order_id]) AS pending_orders
 FROM [TK_ECommerce].dbo.orders AS o
 JOIN [TK_ECommerce].dbo.customers AS c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Pendente'
GROUP BY c.[name]
;