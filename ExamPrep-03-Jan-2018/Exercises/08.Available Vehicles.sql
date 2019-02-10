SELECT 
	m.Model, 
	m.Seats,
	v.Mileage
FROM Models AS m
JOIN Vehicles AS v
ON V.ModelId = m.Id
WHERE v.Id NOT IN (
	SELECT o.VehicleId 
	FROM Orders AS o
	WHERE o.ReturnDate IS NULL
)
ORDER BY v.Mileage, m.Seats, m.Id