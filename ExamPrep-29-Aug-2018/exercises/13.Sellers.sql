SELECT 
	q.[Full Name], SUM(q.[PRICE]) AS [total], SUM(q.Quantity) AS [ITEMS]
FROM
(
	SELECT 
		e.ID, 
		e.FirstName + ' ' + e.LastName AS [Full Name],
		i.Id AS [ItemID],
		i.Price * SUM(oi.Quantity) AS [PRICE],
		SUM(oi.Quantity) AS Quantity
	FROM Employees AS e
	JOIN Orders AS o
	ON o.EmployeeId = e.Id
	JOIN OrderItems AS oi
	ON oi.OrderId = o.Id
	JOIN Items AS i
	ON i.Id = oi.ItemId
	WHERE o.DateTime < '2018-06-15'
	GROUP BY e.ID, e.FirstName, e.LastName, i.Id, i.Price
) AS q
GROUP BY q.Id, q.[Full Name]
ORDER BY TOTAL DESC, Items