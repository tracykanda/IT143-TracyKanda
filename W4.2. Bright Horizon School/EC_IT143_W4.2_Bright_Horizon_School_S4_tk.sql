DROP VIEW IF EXISTS dbo.v_Student_TotalNumber;
GO

CREATE VIEW dbo.v_Student_TotalNumber
AS

/*************************************************************************************************************
NAME: dbo.v_Student_TotalNumber
PURPOSE: Create the total number of students report - Load view 

MODIFICATION LOG:
Ver		Date			Author		Description
----	-------			--------	----------------------------------------------------------------------------
1.0		07/24/2025		TKanda		1. Built this script for EC IT143


RUNTIME:
1s

NOTES:
This script exists to help me learn step 4 of 8 in the Answer Focused Approach for T-SQL Data Manipulation

*************************************************************************************************************/
--Q: What is the total number of students?
--A: This script performs a simple count of all students in the Students table within the BrightHorizon_School database 

SELECT 'Total Number of Students' AS my_report,
	COUNT([StudentID]) AS [Total Number]
 FROM BrightHorizon_School.dbo.Students;