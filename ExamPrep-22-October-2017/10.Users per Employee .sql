WITH CTE_UsersEmp(FirstName, LastName, UsersNumber)
AS
(
	SELECT e.FirstName, e.LastName, COUNT(r.UserId) 
	FROM Reports AS r
	RIGHT JOIN Employees AS e
	ON r.EmployeeId = e.Id
	GROUP BY e.Id, e.FirstName, e.LastName
)

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS [Name], e.UsersNumber AS [Users Number]
FROM CTE_UsersEmp AS e
ORDER BY UsersNumber DESC, [Name] 
