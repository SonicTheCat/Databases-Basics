SELECT c.Name, COUNT(*)
FROM Categories AS c
JOIN Employees AS e
ON e.DepartmentId = c.DepartmentId
GROUP BY c.Name
ORDER BY c.Name

