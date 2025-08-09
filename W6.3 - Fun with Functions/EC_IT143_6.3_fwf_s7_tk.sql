--Q: How to extract first name from Contact Name?

--A: There is a problem:
--CustomerName = Maria Anders, the first name should be Maria
--Google search "How to extract the first name/last name from a full name column using functions in SQL server within SSMS"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

USE EC_IT143_DA;
WITH s1 --Use a common table expression and compare first_name to first_name2
	AS (SELECT t.ContactName,
		LEFT(t.contactName, CHARINDEX(' ',t.contactName + ' ') - 1) AS first_name,
		dbo.udf_parse_first_name(t.contactName) AS first_name2
	   FROM dbo.t_w3_schools_customers AS t)
	SELECT s1.*
	  FROM s1
	WHERE s1.first_name <> s1.first_name2; --Expected result is 0 rows
