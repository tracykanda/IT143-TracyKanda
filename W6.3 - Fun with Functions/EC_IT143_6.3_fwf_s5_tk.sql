
CREATE FUNCTION [dbo].[udf_parse_first_name]
(@v_combined_name AS VARCHAR(500)
)
RETURNS VARCHAR(100)

/*****************************************************************************************************************
NAME:    dbo.udf_parse_first_name
PURPOSE: Parse First Name from combnined name

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/07/2025   TKANDA       1. Built this script for EC IT143


RUNTIME: 


NOTES: 
This script creates a function that parses the first name from a combined name.
 
******************************************************************************************************************/

--Q: How to extract first name from Contact Name?

--A: There is a problem:
--CustomerName = Maria Anders, the first name should be Maria
--Google search "How to extract the first name/last name from a full name column using functions in SQL server within SSMS"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

	BEGIN 
	
		DECLARE @v_first_name AS VARCHAR(100);

		SET @v_first_name = LEFT(@v_combined_name, CHARINDEX(' ',@v_combined_name + ' ') - 1);
	
		RETURN @v_first_name;

	END;
GO