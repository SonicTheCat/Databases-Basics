SELECT r.OpenDate, r.[Description], u.Email 
FROM Reports AS r
JOIN Categories AS C
	ON c.Id = r.CategoryId
JOIN Users AS u
	ON u.Id = r.UserId
WHERE 
	r.CloseDate IS NULL 
	AND LEN(r.Description) > 20
	AND r.Description LIKE '%STR%'
	AND c.DepartmentId IN 
		(SELECT d.Id 
		FROM Departments AS d
		WHERE d.[Name] IN 
		('Infrastructure', 'Emergency', 'Roads Maintenance'))
ORDER BY r.OpenDate, u.Email, r.Id