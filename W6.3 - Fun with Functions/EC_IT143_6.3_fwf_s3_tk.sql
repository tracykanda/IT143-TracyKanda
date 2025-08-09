--Q: How to extract first name from Contact Name?

--A: There is a problem:
--CustomerName = Maria Anders, the first name should be Maria
USE EC_IT143_DA;

SELECT t.ContactName
	FROM dbo.t_w3_schools_customers AS t
ORDER BY 1;