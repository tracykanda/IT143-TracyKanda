DROP PROCEDURE IF EXISTS dbo.usp_Student_TotalNumber;
GO

CREATE PROCEDURE dbo.usp_Student_TotalNumber
AS

/*************************************************************************************************************
NAME: dbo.usp_Student_TotalNumber
PURPOSE: Student Total Number - Load user stored procedure  

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
		TRUNCATE TABLE dbo.t_Student_TotalNumber;

		INSERT INTO dbo.t_Student_TotalNumber
			SELECT v.my_report
					,v.[Total Number]
					FROM dbo.v_Student_TotalNumber AS v;

	--2) Review results

		SELECT t.*
		 FROM t_Student_TotalNumber AS t;
	END;
GO



