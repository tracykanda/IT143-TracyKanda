
DROP FUNCTION IF EXISTS [dbo].[udf_parse_last_name];
GO

CREATE FUNCTION [dbo].[udf_parse_last_name]
(@v_combined_name AS VARCHAR(500)
)
RETURNS VARCHAR(100)

/*****************************************************************************************************************
NAME:    dbo.udf_parse_last_name
PURPOSE: Parse First Name from combnined name

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/07/2025   TKANDA       1. Built this script for EC IT143


RUNTIME: 


NOTES: 
This script creates a function that extracts the last name from a combined name 
******************************************************************************************************************/

--Q: How to extract last name from Contact Name?

--A: There is a problem:
--ContactName = Maria Anders, the last name should be Anders
--Google search "How to extract the first name/last name from a full name column using functions in SQL server within SSMS"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

	BEGIN 
	
		DECLARE @v_last_name AS VARCHAR(100);

		SET @v_last_name = SUBSTRING(@v_combined_name, CHARINDEX(' ',@v_combined_name) +1, LEN(@v_combined_name) - CHARINDEX(' ',@v_combined_name));
	
		RETURN @v_last_name;

	END;
GO