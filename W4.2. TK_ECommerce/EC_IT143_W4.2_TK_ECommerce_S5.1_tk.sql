--Q: How many orders are still pending per customer's name?

--A: Let's ask SQL Server and find out...

SELECT v.[name]
	, v.Pending_Orders
	INTO dbo.t_Pending_Orders_PerCustomer
FROM dbo.v_Pending_Orders_PerCustomer AS v; 