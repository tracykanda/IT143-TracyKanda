--Q: How to extract first name from Contact Name?
--Q: How to extract last name from Contact Name?

--A: There is a problem:
--ContactName = Maria Anders, the firts name should be Maria, and the last name should be Anders
--Google search "How to extract the first name/last name from a full name column using functions in SQL server within SSMS"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

USE EC_IT143_DA;

SELECT t.CustomerID
	 , t.CustomerName
	 , t.ContactName
	 , dbo.udf_parse_first_name(t.ContactName) AS Contact_Name_first_name
	 , dbo.udf_parse_last_name(t.ContactName) AS Contact_Name_last_name --Properly extracted after creating the fucntion
	 , t.Address
	 , t.Country
	FROM dbo.t_w3_schools_customers AS t
	ORDER BY 3;