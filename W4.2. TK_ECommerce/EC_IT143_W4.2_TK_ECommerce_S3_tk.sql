--Q: How many orders are still pending per customer's name?

--A: Let's ask SQL Server and find out...

SELECT 
    c.[name],
    COUNT([order_id]) AS pending_orders
 FROM [TK_ECommerce].dbo.orders AS o
 JOIN [TK_ECommerce].dbo.customers AS c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Pendente'
GROUP BY c.[name]
ORDER BY pending_orders DESC;




