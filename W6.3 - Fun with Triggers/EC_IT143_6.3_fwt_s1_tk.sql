--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT 

ALTER TABLE dbo.t_hello_world
ADD last_modified_date DATETIME DEFAULT GETDATE();


--Q2: How to keep track of when a record was last modified?