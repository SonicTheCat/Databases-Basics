WITH CTE_OpenedRepots(EmployeeId, Count) AS
(
	SELECT e.Id, COUNT(r.Id) FROM Employees AS e
	JOIN Reports AS r ON e.Id = r.EmployeeId
	WHERE DATEPART(YEAR, r.OpenDate) = 2016
	GROUP BY e.Id
),

CTE_ClosededRepots(EmployeeId, Count) AS
(
	SELECT e.Id, COUNT(r.Id) FROM Employees AS e
	JOIN Reports AS r ON e.Id = r.EmployeeId
	WHERE DATEPART(YEAR, r.CloseDate) = 2016
	GROUP BY e.Id
)

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Name, CONCAT(ISNULL(c.Count, 0), '/', ISNULL(o.Count, 0)) AS [Closed Open Reports] 
FROM  CTE_ClosededRepots AS c 
FULL JOIN CTE_OpenedRepots AS o ON c.EmployeeId = o.EmployeeId
JOIN Employees AS e ON c.EmployeeId = e.Id OR o.EmployeeId = e.Id
ORDER BY Name, e.Id