WITH CTE_WaitingStatus(CategoryName, NumberReports)
AS 
(
	SELECT 
	c.Name, 
	COUNT(r.StatusId) AS [Reports Number]	
	FROM Reports AS r
	JOIN Status AS s
	ON s.Id = r.StatusId
	JOIN Categories AS c
	ON c.Id = r.CategoryId
	WHERE s.Label = 'waiting'
	GROUP BY c.Id, c.Name 
), 

CTE_InProgress(CategoryName, NumberReports)
AS 
(
	SELECT 
	c.Name, 
	COUNT(r.StatusId) AS [Reports Number]	
	FROM Reports AS r
	JOIN Status AS s
	ON s.Id = r.StatusId
	JOIN Categories AS c
	ON c.Id = r.CategoryId
	WHERE s.Label = 'in progress' 
	GROUP BY c.Id, c.Name
),

CTE_All(CategoryName, TotalCOUNT)
AS
(
	SELECT 
	c.Name, 
	COUNT(r.StatusId) AS [Reports Number]	
	FROM Reports AS r
	JOIN Status AS s
	ON s.Id = r.StatusId
	JOIN Categories AS c
	ON c.Id = r.CategoryId
	WHERE s.Label = 'in progress' 
	OR  s.Label = 'waiting'
	GROUP BY c.Id, c.Name
)

SELECT 
	a.CategoryName,
	a.TotalCOUNT,
	CASE
		WHEN ISNULL(p.NumberReports, 0) > ISNULL(w.NumberReports, 0) THEN 'in progress'
		WHEN ISNULL(w.NumberReports, 0) > ISNULL(p.NumberReports, 0) THEN 'waiting'
		ELSE 'equal'
	END AS [Main Status]
FROM CTE_All AS a
LEFT JOIN CTE_InProgress AS p
ON p.CategoryName = a.CategoryName
LEFT JOIN CTE_WaitingStatus AS w
ON w.CategoryName = a.CategoryName
ORDER BY a.CategoryName, a.TotalCOUNT, [Main Status]
