SELECT 
	DATEPART(DAY, o.DateTime) AS [Date Part],
	CAST(AVG(i.Price * oi.Quantity) AS DECIMAL(15,2)) AS TotalPrice
FROM Orders AS o
JOIN OrderItems AS oi
	ON oi.OrderId = o.Id
JOIN Items AS i
	ON i.Id = oi.ItemId
GROUP BY DATEPART(DAY, o.DateTime)
ORDER BY [Date Part]