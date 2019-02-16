SELECT DISTINCT q.Id, q.[Full Name]
FROM 
(
	SELECT 
	e.Id,
	e.FirstName + ' ' + e.LastName AS [Full Name],
	DATEDIFF(HOUR, s.CheckIn, s.CheckOut) AS HOURSPERDAY
	FROM Employees AS e
	JOIN Shifts AS s
	ON s.EmployeeId = e.Id
) AS q
WHERE q.HOURSPERDAY < 4
ORDER BY q.Id