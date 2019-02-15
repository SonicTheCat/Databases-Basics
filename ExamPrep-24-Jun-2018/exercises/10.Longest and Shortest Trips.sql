SELECT  
	q.Id,
	q.FULLNAME,
	MAX(Q.Longest) AS Longest,
	MIN(Q.Shortest) AS Shortest
FROM 
(
		SELECT 
		a.Id, 
		a.FirstName + ' ' + a.LastName AS FULLNAME,
		MAX(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS [Longest],
		MIN(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS [Shortest]
	FROM Trips AS t
	JOIN AccountsTrips AS act
	ON act.TripId = t.Id
	JOIN Accounts AS a
	ON a.Id = act.AccountId
	WHERE a.MiddleName IS NULL AND t.CancelDate IS NULL
	GROUP BY a.Id, a.FirstName + ' ' + A.LastName
) AS q 
GROUP BY q.Id, q.FULLNAME
ORDER BY Longest DESC, Q.Id
