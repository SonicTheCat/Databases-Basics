WITH CTE_PROJ(Id, [Name], OpenProj, ClosedProj)
AS
(
	SELECT e.Id, CONCAT(e.FirstName,' ', e.LastName), r.OpenDate, r.CloseDate
	FROM Employees AS e
	RIGHT JOIN Reports AS r
	ON r.EmployeeId = e.Id
	WHERE ((DATEPART(YEAR, r.OpenDate) = 2016 AND r.CloseDate IS NULL) AND e.Id IS NOT NULL
	OR (DATEPART(YEAR, r.CloseDate)  = 2016 )) 
	AND e.Id IS NOT NULL
)

SELECT 
	e.Name, 
	CONCAT(SUM(e.ClosedProjects), '/', SUM(e.OpenProjects)) AS [Closed Open Reports]
FROM 
(SELECT 
	p.Id,
	p.Name, 
	CASE 
		WHEN DATEPART(YEAR, p.OpenProj) = 2016 THEN 1
		ELSE 0
	END  AS OpenProjects,
	CASE 
		WHEN p.ClosedProj IS NULL THEN 0
		ELSE 1
    END AS ClosedProjects
FROM CTE_PROJ AS p) AS e
GROUP BY e.Id,e.Name
ORDER BY e.Name, e.Id