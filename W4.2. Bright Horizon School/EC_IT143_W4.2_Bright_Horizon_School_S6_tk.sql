--Q: What is the total number of students?

--A: Let's ask SQL Server and find out...


--1) Reload data

TRUNCATE TABLE t_Student_TotalNumber;

INSERT INTO t_Student_TotalNumber
		SELECT v.my_report
			, v.[Total Number]
		 FROM dbo.v_Student_TotalNumber AS v;

--2) Review results

SELECT t.*
	FROM t_Student_TotalNumber AS t;
