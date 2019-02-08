WITH CTE_TotalReportsByDepartment (DepartmentId, Count) AS
(
	SELECT d.Id, COUNT(r.Id) 
	FROM Departments AS d
	JOIN Categories AS c ON d.Id = c.DepartmentId
	JOIN Reports AS r ON c.Id = r.CategoryId
	GROUP BY d.Id
)

SELECT d.Name AS [Department Name], c.Name AS [Category Name], CAST(ROUND(CEILING(CAST(COUNT(r.Id) AS DECIMAL(7,2)) * 100)/tr.Count, 0) AS INT) AS Percentage FROM Departments AS d
JOIN CTE_TotalReportsByDepartment AS tr ON d.Id = tr.DepartmentId
JOIN Categories AS c ON d.Id = c.DepartmentId
JOIN Reports AS r ON c.Id = r.CategoryId
GROUP BY d.Name, c.Name, tr.Count