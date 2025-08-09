--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT. How about tracking when a record was last modified using an after update trigger?

--Q2: How to know when the record was last modified?
--A2: How about first recording the current time and saving it in an additional column
-- https://stackoverflow.com/questions/56239984/sql-server-views-keep-track-of-last-altered-time-and-the-user-that-altered-i
-- https://www.mssqltips.com/tutorial/sql-server-trigger-after-update/


USE EC_IT143_DA;

--Adding a column in the Customers table, named last_modified_date to track the date: as part of question 1
ALTER TABLE dbo.t_w3_schools_customers
ADD last_modified_date DATETIME DEFAULT GETDATE();

--Adding a column in the Customers table, named last_modified_by to track the user: as part of question 2
ALTER TABLE dbo.t_w3_schools_customers
ADD last_modified_by NVARCHAR (500) DEFAULT SUSER_NAME();