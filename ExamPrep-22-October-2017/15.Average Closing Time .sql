SELECT 
	d.[Name],  
	CASE 
		WHEN AVG(d.DIFF) IS NULL THEN 'no info'
		ELSE CAST(AVG(d.DIFF) AS VARCHAR) 
	END AS [Average Duration]
FROM
(
	SELECT d.Id, d.Name, DATEDIFF(DAY, r.OpenDate, r.CloseDate) AS DIFF
	FROM Reports AS r
	JOIN Categories AS c
	ON c.Id = r.CategoryId
	JOIN Departments AS d
	ON d.Id = c.DepartmentId
) AS d
GROUP BY d.Id, d.[Name]
ORDER BY d.[Name]
