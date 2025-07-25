--Q: How many orders are still pending per customer's name?

--A: Let's ask SQL Server and find out...


--1) Reload data

TRUNCATE TABLE dbo.t_Pending_Orders_PerCustomer;

INSERT INTO dbo.t_Pending_Orders_PerCustomer
		SELECT v.[name]
			, v.Pending_Orders
		 FROM dbo.v_Pending_Orders_PerCustomer AS v;

--2) Review results

SELECT t.*
	FROM t_Pending_Orders_PerCustomer AS t;