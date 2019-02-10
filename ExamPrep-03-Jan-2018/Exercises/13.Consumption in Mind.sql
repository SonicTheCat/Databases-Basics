WITH CTE_TOP7(Manufacturer, AverageConsumption, [Rank])
AS
(
	SELECT TOP(7)
		 m.Manufacturer, 
		 AVG(m.Consumption), 
		 DENSE_RANK() OVER (ORDER BY COUNT(*) DESC)
	FROM Orders AS o
	JOIN Vehicles AS v
		ON v.Id = o.VehicleId
	JOIN Models AS m
		ON m.Id = v.ModelId
	GROUP BY m.Manufacturer, m.Model
)

SELECT x.Manufacturer, x.AverageConsumption
FROM CTE_TOP7 AS x
WHERE x.AverageConsumption BETWEEN 5 AND 15 AND x.[Rank] <= 7
ORDER BY x.Manufacturer, x.AverageConsumption
