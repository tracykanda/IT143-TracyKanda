
-- Enable time statistics
SET STATISTICS TIME ON;

/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_BrightHorizonSchool_tk.sql
PURPOSE: This script is answering 4 questions related to the Bright Horizon School analysis

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     07/30/2025   TKANDA       1. Built this script for EC IT143


RUNTIME: 
216 ms

NOTES: 
This script has been developed in response to Assignment 5.2 for EC IT143. It focuses on generating responses for
the Bright Horizon School analysis. Through this task, I aim to apply the knowledge and skills acquired over the 
past four weeks, while also preparing for the Final Project: "My Community’s Analysis – Present Findings." 
Additional context and explanations for each question are provided within the script comments.
 
******************************************************************************************************************/
--Enforcing the use of BrightHorizon_School Database
USE BrightHorizon_School;
/* Q1: Based on the Marks table, which subject had the highest average mark, and how many teachers contributed to 
that subject’s scores? From roni rolando ñahui bolivar
   A1: 
   Restating: Which subject had the highest average obtained mark, and how many teachers gave marks for that subject?
   This is technically feasible, but it's important to note a data limitation: each teacher is assigned to only one subject.
   SQL solution: The script below will return the subject with the highest average mark and count the total number
   of teachers that have assigned scores for that subject. I determined that using a view or stored procedure was 
   not necessary for this particular question
*/
--Finding the subject with the highest averge mark obtained
--Subject_Averages is the calculated average of marks obtained in each subject
WITH Subject_Averages AS (
	SELECT SubjectID,
	   AVG(MarkObtained) AS Average_Mark
	  FROM Marks
	GROUP BY SubjectID
),
--Identifying the subject with the highest average mark and storing it in Top_Subject
Top_Subject AS (
	SELECT TOP 1 SubjectID
	 FROM Subject_Averages
	ORDER BY Average_Mark DESC
)
--Counting how many distinct teachers contributed to the Top_subject
SELECT m.SubjectID,
	   AVG(m.MarkObtained) AS Average_Mark,
	   COUNT(DISTINCT m.TeacherID) AS Teacher_Count
 FROM Marks m
 JOIN Top_Subject ts ON m.SubjectID = ts.SubjectID
 GROUP BY m.SubjectID
;
/**************************************************************************************************************************************************/

/* Q2: A curriculum planner is reviewing teacher assignments. Provide a list of all teachers along with the total 
number of students they have graded across all subjects. Return teacher name, email, and student count. From Me
   A2: 
   Restating: List each teacher with their name, email, and total students graded, all sorted from the teacher with
   the highest number of students
   This is technically feasible, but it's important to note a data limitation: each teacher has graded the total number of students
   SQL solution: The script below lists teachers in order of the number of students they’ve graded, along with their personal details
   I have used a view and stored the results into a new table. 
   not necessary for this particular question
*/
-- Drop the view if it already exists
DROP VIEW IF EXISTS v_GradedStudents_Per_Teacher;
GO

-- Drop the table if it already exists
DROP TABLE IF EXISTS t_GradedStudents_Per_Teacher;
GO

-- Creating the view to calculate total students graded per teacher
CREATE VIEW v_GradedStudents_Per_Teacher AS
SELECT 
    CONCAT(t.FirstName, ' ', t.LastName) AS FullName,
    t.Email,
    COUNT(DISTINCT m.StudentID) AS Total_StudentsGraded
FROM Marks m
JOIN Teachers t ON m.TeacherID = t.TeacherID
GROUP BY t.TeacherID, t.FirstName, t.LastName, t.Email;
GO

-- Creating a new table to store the results from the view
CREATE TABLE t_GradedStudents_Per_Teacher (
    FullName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Total_StudentsGraded INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_t_GradedStudents_Per_Teacher PRIMARY KEY CLUSTERED (FullName)
);
GO

-- clearing any existing data from the table
TRUNCATE TABLE t_GradedStudents_Per_Teacher;
-- Inserting data from the view into the new table
INSERT INTO t_GradedStudents_Per_Teacher (FullName, Email, Total_StudentsGraded)
SELECT FullName, Email, Total_StudentsGraded
FROM v_GradedStudents_Per_Teacher
ORDER BY Total_StudentsGraded;
--Displaying the results that have been stored in the table
SELECT t.*
FROM t_GradedStudents_Per_Teacher AS t
GO

/**************************************************************************************************************************************************/
/* Q3: A recent review requires identifying teachers whose students consistently score high. Find all teachers who have taught at least one subject
        where the average mark of their students is above 85. Return the teacher's full name, email, and the subjects they taught. From Me
   A3: 
   Restating: Identify teachers who have taught at least one subject where their students' average mark is above 85. Return their full name, email,
   and the subjects they taught
   SQL solution: The script ranks teachers by highest average student mark, showing their details and subjects taught. I used a view, saved the 
   results in a table, and created a stored procedure for easy execution.
*/
-- Dropping the table/the view/the procedure if it exists
DROP PROCEDURE IF EXISTS usp_TopTeacher_Per_MarkObtained;
GO
DROP VIEW IF EXISTS v_TopTeacher_Per_MarkObtained;
GO
DROP TABLE IF EXISTS t_TopTeacher_Per_MarkObtained;
GO

-- Finding teachers who have taught at least one subject where the average student mark is greater than 85
--Joining the 4 tables to fetch all the required information
-- Creating the view to calculate total students graded per teacher
CREATE VIEW v_TopTeacher_Per_MarkObtained AS
SELECT 
    t.FirstName, 
    t.LastName,
    t.Email, 
    su.SubjectName,
    AVG(m.MarkObtained) AS Average_Mark
FROM 
    Marks m
JOIN 
    Subjects su ON m.SubjectID = su.SubjectID
JOIN 
    Teachers t ON m.TeacherID = t.TeacherID
JOIN 
    Students st ON m.StudentID = st.StudentID
GROUP BY 
    m.TeacherID, t.FirstName, t.LastName, t.Email, su.SubjectName
HAVING 
    AVG(m.MarkObtained) > 85
-- Sorting the result by the highest average mark in descending order
;
GO

-- Creating a new table to store the results from the view
CREATE TABLE t_TopTeacher_Per_MarkObtained (
    Teacher_FirstName VARCHAR(50) NOT NULL,
    Teacher_LastName VARCHAR(50) NOT NULL,
    Teacher_Email VARCHAR(50) NOT NULL,
    SubjectName VARCHAR(50) NOT NULL,
    Average_Mark INT NOT NULL DEFAULT 0
);
GO
--Creating a Procedure
CREATE PROCEDURE usp_TopTeacher_Per_MarkObtained
AS
    BEGIN
--Reloading data
        TRUNCATE TABLE t_TopTeacher_Per_MarkObtained;
        INSERT INTO t_TopTeacher_Per_MarkObtained
            SELECT FirstName, 
                    LastName,
                    Email, 
                    SubjectName,
                    Average_Mark
             FROM v_TopTeacher_Per_MarkObtained
;
--Reviewing the results that have been stored in the table
        SELECT t.*
         FROM t_TopTeacher_Per_MarkObtained AS t
        ORDER BY Average_Mark DESC;
    END;
GO
--Executing the stored procedure
EXEC usp_TopTeacher_Per_MarkObtained;

/**************************************************************************************************************************************************/
/* Q4: The Awards committee needs to identify students who have never scored below 70 in any subject. Return their full name, email, and the total
   number of exams they've appeared in. This helps identify and reward consistently strong performers. From Me
   A4: 
   Restating: Identify students who have never scored below 70 in any subject. Return their full name, email, and the total number of exams 
   they've taken.
   SQL solution: The script lists students who have never scored below 70 in any subject. It returns their full name, email, and total number of 
   exams taken. Results are sorted by exam count (descending) and then alphabetically by name. The output is saved as a view and a table, and 
   accessed via a stored procedure.
*/
-- Dropping the table/the view/the procedure if it exists
DROP PROCEDURE IF EXISTS usp_Consistent_Students_Exam_Count;
GO
DROP VIEW IF EXISTS v_Consistent_Students_Exam_Count;
GO
DROP TABLE IF EXISTS t_Consistent_Students_Exam_Count;
GO

CREATE VIEW v_Consistent_Students_Exam_Count
AS
-- Identifying students who have all marks >= 70
WITH Consistent_Students AS (
    SELECT
        StudentID
    FROM
        Marks
    GROUP BY
        StudentID
    HAVING
        MIN(MarkObtained) >= 70
),

-- Counting total exams for these students
Exam_Counts AS (
    SELECT
        StudentID,
        COUNT(*) AS Exam_Count
    FROM
        Marks
    WHERE
        StudentID IN (SELECT StudentID FROM Consistent_Students)
    GROUP BY
        StudentID
)
-- Joining with Students table to fetch student full name and email
SELECT
    CONCAT(s.FirstName, ' ', s.LastName) AS FullName,
    s.Email,
    e.Exam_Count
FROM
    Students s
JOIN
    Exam_Counts e ON s.StudentID = e.StudentID
;
GO

 -- Creating a new table to store the results from the view
CREATE TABLE t_Consistent_Students_Exam_Count (
    Student_FullName VARCHAR(50) NOT NULL,
    Student_Email VARCHAR(50) NOT NULL,
    Exam_Count INT NOT NULL
);
GO
--Creating a Procedure
CREATE PROCEDURE usp_Consistent_Students_Exam_Count
AS
    BEGIN
--Reloading data
        TRUNCATE TABLE t_Consistent_Students_Exam_Count;
        INSERT INTO t_Consistent_Students_Exam_Count
            SELECT FullName, 
                   Email, 
                   Exam_Count
              FROM v_Consistent_Students_Exam_Count
;
--Reviewing the results that have been stored in the table (Optional)
        SELECT t.*
         FROM t_Consistent_Students_Exam_Count AS t
        ORDER BY Exam_Count DESC, Student_FullName;
    END;
GO
--Executing the stored procedure
EXEC usp_Consistent_Students_Exam_Count;   

SELECT GETDATE() AS my_date;

-- Disable time statistics
SET STATISTICS TIME OFF;
