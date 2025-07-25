DROP TABLE IF EXISTS dbo.t_Pending_Orders_PerCustomer;
GO 

CREATE TABLE dbo.t_Pending_Orders_PerCustomer
	([name] VARCHAR(25) NOT NULL,
	Pending_Orders VARCHAR(25) NOT NULL
 DEFAULT 0,
CONSTRAINT PK_t_Pending_Orders_PerCustomer PRIMARY KEY CLUSTERED (Pending_Orders DESC)
);
GO