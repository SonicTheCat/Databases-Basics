SELECT TOP 1 q.OrderId, SUM(q.Prices) [Total Price]
FROM
(
	SELECT 
	o.Id AS OrderId,
	i.Id AS ItemId, 
	SUM(i.Price) * SUM(oi.Quantity) AS [Prices]
	FROM Orders AS o
	JOIN OrderItems AS oi
	ON oi.OrderId = o.Id
	JOIN Items AS i
	ON i.Id = oi.ItemId
	GROUP BY o.Id, i.Id
) AS q
GROUP BY q.OrderId
ORDER BY [Total Price] DESC