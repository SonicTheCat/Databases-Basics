SELECT 
	act.TripId, 
	SUM(act.Luggage) AS Luggage,
	CASE 
		WHEN SUM(act.Luggage) > 5 THEN CONCAT('$',SUM(act.Luggage) * 5)
		ELSE '$0'	 
	END AS Fee
FROM AccountsTrips AS act
JOIN Accounts AS a
	ON a.Id = act.AccountId
WHERE act.Luggage > 0 
GROUP BY act.TripId
ORDER BY Luggage DESC