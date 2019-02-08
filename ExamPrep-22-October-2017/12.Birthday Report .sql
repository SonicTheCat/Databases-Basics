WITH CTE_ReportsBirthdates([Category Name], OpenMonth, OpenDay, UserMonth, UserDay)
AS
(
	SELECT 
	c.[Name], 
	DATEPART(MONTH, r.OpenDate), 
	DATEPART(DAY, r.OpenDate),
	DATEPART(MONTH, u.Birthdate),
	DATEPART(DAY, u.Birthdate) 
	FROM Users AS u
	JOIN Reports AS r
	ON r.UserId = u.Id
	JOIN Categories AS c
	ON c.Id = r.CategoryId
)

SELECT DISTINCT e.[Category Name] 
FROM CTE_ReportsBirthdates AS e
WHERE e.OpenDay = e.UserDay 
AND e.OpenMonth = e.UserMonth
ORDER BY e.[Category Name]