SELECT TOP 10
	c.Id, 
	c.NAME,
	SUM(h.BaseRate) + SUM(r.PRICE) AS [Total Revenue],
	COUNT(t.Id) AS [Trips]
FROM Trips AS t
JOIN Rooms AS r
ON r.Id = t.RoomId
JOIN Hotels AS h
ON h.Id = r.HotelId
JOIN Cities AS c
ON c.Id = h.CityId
WHERE YEAR(t.BookDate) = 2016
GROUP BY c.Id,c.NAME
ORDER BY [Total Revenue] DESC, [Trips] DESC