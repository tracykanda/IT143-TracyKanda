--Q: How to extract first name from Contact Name?

--A: There is a problem:
--CustomerName = Maria Anders, the first name should be Maria
--Google search "How to extract the first name/last name from a full name column using functions in SQL server within SSMS"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

USE EC_IT143_DA;

SELECT t.ContactName,
	LEFT(t.contactName, CHARINDEX(' ',t.contactName + ' ') - 1) AS first_name
	FROM dbo.t_w3_schools_customers AS t
ORDER BY 1;