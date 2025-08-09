
--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT. How about tracking when a record was last modified using an after update trigger?

--Q2: How to know when the record was last modified?
--A2: How about first recording the current time and save it in an additional column
-- https://stackoverflow.com/questions/56239984/sql-server-views-keep-track-of-last-altered-time-and-the-user-that-altered-i
-- https://www.mssqltips.com/tutorial/sql-server-trigger-after-update/
