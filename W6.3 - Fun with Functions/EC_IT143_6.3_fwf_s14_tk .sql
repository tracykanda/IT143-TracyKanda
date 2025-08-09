--Q: How to extract last name from Contact Name?

--A: There is a problem:
--ContactName = Maria Anders, the last name should be Anders
--Google search "How to extract the first name/last name from a full name column using functions in SQL server within SSMS"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

USE EC_IT143_DA;

SELECT t.ContactName,
	SUBSTRING(t.contactName, CHARINDEX(' ',t.contactName) +1, LEN(t.contactName) - CHARINDEX(' ',t.contactName)) AS last_name,
	dbo.udf_parse_last_name(t.contactName) AS last_name2
	FROM dbo.t_w3_schools_customers AS t
ORDER BY 1;