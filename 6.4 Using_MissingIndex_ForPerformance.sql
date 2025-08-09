USE AdventureWorks2022;

--Query#1 on a unindexed character field: the credit card type in the Credit card table
SELECT scc.*
 FROM Sales.CreditCard AS scc
WHERE scc.CardType = 'Vista' ;

--Following are the missing index details I received from the execution plan tab, the estimated subtree cost is 0.16209
/*
Missing Index Details from SQLQuery12.sql - PCUNOPS-CQ35P34\TK_IT143_DB.AdventureWorks2022 (sa (65))
The Query Processor estimates that implementing the following index could improve the query cost by 75.6849%.
USE [AdventureWorks2022]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [Sales].[CreditCard] ([CardType])
INCLUDE ([CardNumber],[ExpMonth],[ExpYear],[ModifiedDate])
GO
*/
--Now let's create the suggested index for query#1
CREATE NONCLUSTERED INDEX IX_CardType
ON [Sales].[CreditCard] ([CardType])
INCLUDE ([CardNumber],[ExpMonth],[ExpYear],[ModifiedDate])
GO

--Then let's execute the original query#1 after creating the index
SELECT scc.*
 FROM Sales.CreditCard AS scc
WHERE scc.CardType = 'Vista' ;
--The estimated subtree cost passed from 0.16209 to 0.0402075

/***************************************************************************************************************************************/

--Query#2 on a unindexed character field: the name in the Sales Store table
SELECT ss.*
 FROM Sales.Store AS ss
WHERE ss.Name = 'Bike Boutique' ;

--Following are the missing index details I received from the execution plan tab, the estimated subtree cost is 0.16209
/*
Missing Index Details from SQLQuery23.sql - PCUNOPS-CQ35P34\TK_IT143_DB.AdventureWorks2022 (sa (93))
The Query Processor estimates that implementing the following index could improve the query cost by 95.0732%.
USE [AdventureWorks2022]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [Sales].[Store] ([Name])
GO
*/
--Now let's create the suggested index for query#2
CREATE NONCLUSTERED INDEX IX_Sales_Store_Name
ON [Sales].[Store] ([Name])
GO

--Then let's execute the original query#2 after creating the index
SELECT ss.*
 FROM Sales.Store AS ss
WHERE ss.Name = 'Bike Boutique' ;
--The estimated subtree cost passed from 0.0781272 to 0.0065704