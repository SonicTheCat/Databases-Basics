SELECT DISTINCT u.Username
FROM Reports AS r
JOIN Users AS u
ON u.Id = r.UserId
JOIN Categories AS c
ON c.Id = r.CategoryId
WHERE (LEFT(u.Username, 1) LIKE '[0-9]%' 
OR RIGHT(u.Username, 1) LIKE '%[0-9]')
AND (LEFT(u.Username, 1) = CONVERT(NVARCHAR, c.ID)
OR RIGHT(u.Username, 1) = CONVERT(NVARCHAR, c.Id))
ORDER BY u.Username