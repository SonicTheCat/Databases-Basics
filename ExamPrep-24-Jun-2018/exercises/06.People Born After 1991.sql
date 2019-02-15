SELECT 
	CONCAT(a.FirstName, ' ', a.MiddleName + ' ', a.LastName) AS  [Full Name], 
	YEAR(a.BirthDate) AS [BirthDate] 
FROM Accounts AS a
WHERE YEAR(a.BirthDate) > 1991
ORDER BY BirthDate DESC, FirstName