--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT. How about tracking when a record was last modified using an after update trigger?

--Q2: How to know when the record was last modified?
--A2: How about first recording the current time and saving it in an additional column

--Q3: Did it work?
--A3: Let's find out...

--Remove rows if already exist

EXEC sp_configure 'nested triggers', 0;
RECONFIGURE;

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

   --Try it again 
 UPDATE dbo.t_w3_schools_customers SET CustomerName = 'Tracy Kanda'
  WHERE CustomerName = 'Wolski';

--See if the trigger works
SELECT t.*
 FROM dbo.t_w3_schools_customers AS t
 ORDER BY CustomerID DESC;

--Q4: How to keep track of who last modified a record?
--A4: How about first recording the current user in a new column: last_modified_by?
--The new column is creating in EC_IT143_6.3_fwt_s3_tk.sql

--Now let's create the trigger in EC_IT143_6.3_fwt_s7_tk.sql 
--Q5: Did it work?
--A5: Let's execute this script to find out


