DROP TRIGGER IF EXISTS trg_customers_last_mod_date;
GO 

CREATE TRIGGER trg_customers_last_mod_date ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
/*****************************************************************************************************************
NAME:    dbo.trg_customers_last_mod_date
PURPOSE: Customers table - Last Modified Date Trigger

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/09/2025   TKANDA       1. Built this script for EC IT143


RUNTIME: 


NOTES: 
Keep track of the last modified date for each row in the tabble t_w3_schools_customers

******************************************************************************************************************/
		
		UPDATE dbo.t_w3_schools_customers
				SET 
					last_modified_date = GETDATE()
		WHERE CustomerID IN
		(
			SELECT DISTINCT
				CustomerID
			 FROM inserted
		);
