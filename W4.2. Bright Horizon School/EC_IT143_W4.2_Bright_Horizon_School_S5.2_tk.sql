DROP TABLE IF EXISTS dbo.t_Student_TotalNumber;
GO 

CREATE TABLE dbo.t_Student_TotalNumber
	(All_Students VARCHAR(25) NOT NULL,
	[Total Number] VARCHAR(25) NOT NULL
 DEFAULT 0,
CONSTRAINT PK_t_Student_TotalNumber PRIMARY KEY CLUSTERED (All_Students ASC)
);
GO