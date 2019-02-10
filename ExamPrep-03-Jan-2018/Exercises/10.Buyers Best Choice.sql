SELECT  m.Manufacturer, m.Model, COUNT(o.Id) AS TimesOrdered
FROM Vehicles AS v
JOIN Models AS m
ON m.Id = V.ModelId
LEFT JOIN Orders AS o
ON o.VehicleId = v.Id
GROUP BY m.Id, m.Manufacturer, m.Model
ORDER BY  COUNT(o.Id) DESC, m.Manufacturer DESC, m.Model