--Q: What is the total number of students?

--A: Let's ask SQL Server and find out...

SELECT 'Total Number of Students' AS my_report,
	COUNT([StudentID]) AS [Total Number]
 FROM BrightHorizon_School.dbo.Students;


