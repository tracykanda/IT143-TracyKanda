--Q: What is the total number of students?

--A: Let's ask SQL Server and find out...

SELECT v.my_report
	, v.[Total Number]
	INTO dbo.t_Student_TotalNumber
FROM dbo.v_Student_TotalNumber AS v; 