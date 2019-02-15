SELECT
	q.Id,
	q.Email,
	q.CountryCode,
	q.Trips
FROM
(
		SELECT
		a.Id,
		a.Email,
		c.CountryCode,
		COUNT(t.ID) AS [Trips],
		ROW_NUMBER() OVER(PARTITION BY c.CountryCode ORDER BY COUNT(t.id) DESC) AS ROWNUMBER
	FROM Accounts AS a
	JOIN AccountsTrips AS act
		ON act.AccountId = a.Id
	JOIN Trips AS t
		ON t.Id = act.TripId
	JOIN Rooms AS r
		ON r.Id = t.RoomId
	JOIN Hotels AS h
		ON h.Id = r.HotelId
	JOIN Cities AS C
		ON c.Id = h.CityId
	GROUP BY a.Id, a.Email, c.CountryCode
) AS q
WHERE q.ROWNUMBER = 1
ORDER BY q.Trips DESC, q.Id

