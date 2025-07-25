--Q: How many orders are still pending per customer's name?

--A: Let's ask SQL Server and find out...

EXEC dbo.usp_Pending_Orders_PerCustomer;