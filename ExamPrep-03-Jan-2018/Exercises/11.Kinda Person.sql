SELECT a.Names, a.Class 
FROM 
	(
		SELECT
			c.Id,
			c.FirstName + ' ' + c.LastName AS [Names],
			m.Class,
			DENSE_RANK() OVER (PARTITION BY c.FirstName + ' ' + c.LastName ORDER BY COUNT(*) DESC) AS [Rank]
		FROM Clients AS c
		JOIN Orders AS o
		ON o.ClientId = c.Id
		JOIN Vehicles AS v
		ON v.Id = o.VehicleId
		JOIN Models AS m
		ON m.Id = v.ModelId
		GROUP BY c.Id, c.FirstName, c.LastName, m.Class
	) AS a
WHERE a.Rank = 1
ORDER BY a.Names, a.Class, a.Id
