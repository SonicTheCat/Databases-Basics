SELECT 
	t.Id, 
	h.Name, 
	r.Type,
	CASE
		WHEN t.CancelDate IS NOT NULL THEN 0 
		ELSE SUM(h.BaseRate + r.PRICE)
	END AS REVENUE
FROM Trips AS t
JOIN AccountsTrips AS act
ON act.TripId = t.Id
JOIN Rooms AS r
ON r.Id = t.RoomId
JOIN Hotels AS h
ON h.Id = r.HotelId
GROUP BY t.Id, h.Name, r.Type, t.CancelDate
ORDER BY r.Type, t.Id