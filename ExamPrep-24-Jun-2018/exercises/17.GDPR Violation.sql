SELECT
	t.Id, 
	a.FirstName + ' ' + ISNULL(a.MiddleName + ' ', '') + a.LastName AS [Full Name],
	c.NAME AS [From],
	cc.NAME AS [To],
	CASE 
		WHEN t.CancelDate IS NOT NULL THEN 'Canceled'
		ELSE CONCAT(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate), ' days')
	END AS [Duration]
FROM Accounts AS a
JOIN AccountsTrips AS act
	ON act.AccountId = a.Id
JOIN Trips AS t
	ON t.Id = act.TripId
JOIN Cities AS c
	ON c.Id = a.CityId
JOIN Rooms AS r
	ON r.Id = t.RoomId
JOIN Hotels AS h
	ON h.Id = r.HotelId
JOIN Cities AS cc
	ON cc.Id = h.CityId
ORDER BY [Full Name], t.Id