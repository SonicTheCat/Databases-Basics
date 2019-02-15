SELECT 
	r.Id, 
	r.PRICE,
	h.Name, 
	c.NAME
FROM Rooms AS r
JOIN Hotels AS h 
ON h.Id = r.HotelId
JOIN Cities AS c
ON c.Id = h.CityId
WHERE r.Type = 'First Class'
ORDER BY r.PRICE DESC, r.Id