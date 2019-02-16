SELECT 
	i.Name AS Item, 
	c.Name AS Category,
	SUM(oi.Quantity) AS [Count],
	i.Price * SUM(oi.Quantity) AS [TotalPrice]
FROM Items AS i
LEFT JOIN OrderItems AS oi
ON oi.ItemId = i.Id
LEFT JOIN Orders AS o
ON o.Id = oi.OrderId
JOIN Categories AS c
ON c.Id = i.CategoryId
GROUP BY i.Id, i.Name, c.Id, c.Name, i.Price
ORDER BY TotalPrice DESC, [Count] DESC

SELECT * FROM Items AS i
LEFT JOIN OrderItems AS oi
ON oi.ItemId = i.Id
WHERE i.Name = 'Pillow'
