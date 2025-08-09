--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT. How about tracking when a record was last modified using an after update trigger?

--Q2: How to know when the record was last modified?
--A2: How about first recording the current time and saving it in an additional column

--Q3: Did it work?
--A3: Let's find out...

--Remove rows if already exist
DELETE FROM dbo.t_w3_schools_customers
 WHERE CustomerID IN(92, 93, 94);

 --Load test rows
 INSERT INTO dbo.t_w3_schools_customers (CustomerID, CustomerName, ContactName, [Address], City, Country)
 VALUES 
	(92, 'David Thomas', 'Michael Anders', 'Mehrheimerstr. 369', 'Vancouver', 'Canada'),
	(93, 'Jude Batista', 'felicia Martins', 'Grenzacherweg 237', 'Geneva','EUR15')
	;

--See if the trigger works
SELECT t.*
 FROM dbo.t_w3_schools_customers AS t
 ORDER BY CustomerID DESC;

 --Try it again 
 UPDATE dbo.t_w3_schools_customers SET CustomerID = 94
  WHERE CustomerID = 93;

--See if the trigger works
SELECT t.*
 FROM dbo.t_w3_schools_customers AS t
 ORDER BY CustomerID DESC;
