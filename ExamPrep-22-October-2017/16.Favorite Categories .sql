WITH CTE_DepartmentsAndCategories([Department Name], [Category Name], [Count])
AS
(
	SELECT d.Name, c.Name, COUNT(*)
	FROM Categories AS c
	JOIN Departments AS d
	ON d.Id = c.DepartmentId
	JOIN Reports AS r
	ON r.CategoryId = c.Id
	GROUP BY d.Id, d.Name, c.Id, c.Name

),

CTE_TotalCountInDepartment([Department Name], Total)
AS
(
	SELECT d.Name, COUNT(*) 
	FROM Categories AS c
	JOIN Departments AS d
	ON d.Id = c.DepartmentId
	JOIN Reports AS r
	ON r.CategoryId = c.Id
	GROUP BY d.Name
)

SELECT 
	d.[Department Name], 
	d.[Category Name], 
	CONVERT(INT, ROUND(d.Count * 100.0 / td.Total, 0)) AS [Percentage]
FROM CTE_TotalCountInDepartment AS td
JOIN CTE_DepartmentsAndCategories AS d
ON d.[Department Name] = td.[Department Name]
ORDER BY d.[Department Name], d.[Category Name], [Percentage]