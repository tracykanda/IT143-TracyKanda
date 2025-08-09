DROP TRIGGER IF EXISTS trg_customers_last_mod_user;
GO 

CREATE TRIGGER trg_customers_last_mod_user ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
/*****************************************************************************************************************
NAME:    dbo.trg_customers_last_mod_user
PURPOSE: Customers table - Last Modified User Trigger

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/09/2025   TKANDA       1. Built this script for EC IT143


RUNTIME: 


NOTES: 
Keep track of the user who last modified each row in the tabble t_w3_schools_customers

******************************************************************************************************************/
		
		UPDATE dbo.t_w3_schools_customers
				SET 
					last_modified_date = GETDATE(),
					last_modified_by = SYSTEM_USER
		 FROM dbo.t_w3_schools_customers c
		 INNER JOIN inserted i ON c.CustomerID = i.CustomerID;
;
