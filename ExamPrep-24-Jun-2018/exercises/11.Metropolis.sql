SELECT TOP 5 
	c.Id, 
	c.NAME, 
	c.CountryCode,
	COUNT(*) AS AccountsCount
FROM Accounts AS a
JOIN Cities AS c
ON c.Id = a.CityId
GROUP BY c.Id, c.NAME, c.CountryCode
ORDER BY COUNT(*) DESC