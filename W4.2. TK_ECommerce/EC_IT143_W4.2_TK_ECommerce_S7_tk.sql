DROP PROCEDURE IF EXISTS dbo.usp_Pending_Orders_PerCustomer;
GO

CREATE PROCEDURE dbo.usp_Pending_Orders_PerCustomer
AS

/*************************************************************************************************************
NAME: dbo.usp_Pending_Orders_PerCustomer
PURPOSE: Pending orders per Customer's name - Load user stored procedure  

MODIFICATION LOG:
Ver		Date			Author		Description
----	-------			--------	----------------------------------------------------------------------------
1.0		07/24/2025		TKanda		1. Built this script for EC IT143; Bright Horizon School DB


RUNTIME:
1s

NOTES:
This script exists to help me run step 7 of 8 in the Answer Focused Approach for T-SQL Data Manipulation

*************************************************************************************************************/

	BEGIN
	--1) Reload data
		TRUNCATE TABLE dbo.t_Pending_Orders_PerCustomer;

		INSERT INTO dbo.t_Pending_Orders_PerCustomer
			SELECT v.[name]
					,v.Pending_Orders
					FROM t_Pending_Orders_PerCustomer AS v;

	--2) Review results

		SELECT t.*
		 FROM t_Pending_Orders_PerCustomer AS t;
	END;
GO

