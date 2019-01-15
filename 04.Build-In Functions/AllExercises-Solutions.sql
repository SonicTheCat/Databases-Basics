USE SoftUnI

/* Task 1 */
SELECT FirstName, LastName 
FROM EMPLOYEES
WHERE SUBSTRING(FirstName, 1, 2) = 'SA'
--Or  LEFT(FirstName, 2) = 'SA'

/* Task 2 */
SELECT FirstName, LastName 
FROM EMPLOYEES
WHERE CHARINDEX('ei', LastName , 1) != 0

/* Task 2 */
SELECT FirstName, LastName 
FROM EMPLOYEES
WHERE LastName LIKE '%ei%'

/* Task 3 */
SELECT  FirstName
FROM Employees
WHERE DepartmentID IN (3,10) AND DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005

/* Task 4 */
SELECT FirstName, LastName 
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

/* Task 4 */
SELECT FirstName, LastName 
FROM Employees
WHERE CHARINDEX('engineer', JobTitle , 1) = 0

/* Task 5 */
SELECT [Name]
FROM TOWNS
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name]

/* Task 6 */
SELECT TownID, [Name]
FROM Towns
WHERE [Name] LIKE '[mkbe]%'
ORDER BY [Name]

/* Task 6 */
SELECT TownID, [Name]
FROM Towns
WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name]

/* Task 7 */
SELECT TownID, [Name]
FROM Towns
WHERE [Name] LIKE '[^rbd]%'
ORDER BY [Name]

GO

/* Task 8 */
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) > 2000

GO
--SELECT * FROM V_EmployeesHiredAfter2000

/* Task 9 */
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

/* Task 10 */
USE Geography

SELECT CountryName, IsoCode
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

/* Task 11 */
SELECT PeakName, RiverName, 
LOWER(PeakName + SUBSTRING(RiverName, 2, LEN(RiverName) - 1)) AS [Mix]
FROM Peaks
JOIN Rivers ON RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix

/* Task 12 */
USE Diablo

SELECT TOP(50) [Name], FORMAT(Start, 'yyyy-MM-dd') AS [Start]
FROM Games
WHERE DATEPART(YEAR, [Start]) IN (2011,2012)
ORDER BY [Start], [Name]

/* Task 13 */
SELECT Username, RIGHT(Email, LEN(Email) - CHARINDEX('@', Email, 1)) AS [Email Provider]
FROM Users
ORDER BY [Email Provider], Username

/* Task 14 */
SELECT Username, IpAddress AS [IP Address] 
FROM USERS
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

/* Task 15 */
SELECT [Name] AS [Game],
CASE
	WHEN DATEPART(HOUR, Start) < 12 
		THEN 'Morning'
	WHEN DATEPART(HOUR, Start) < 18 
		THEN 'Afternoon'
	ELSE 'Evening'
END AS [Part Of The Day],
CASE
	WHEN Duration <= 3 
		THEN 'Extra Short'
	WHEN Duration <= 6 
		THEN 'Short'
	WHEN Duration > 6 
		THEN 'Long'
	WHEN Duration IS NULL 
		THEN 'Extra Long'
END AS Duration
FROM Games
ORDER BY [Name], Duration, [Part Of The Day]

/* Task 15 */
SELECT [Name] AS [Game],
IIF(DATEPART(HOUR, Start) < 12, 'Morning',
	IIF(DATEPART(HOUR, Start) < 18, 'Afternoon', 'Evening'))
	AS [Part Of The Day], 
IIF(Duration <= 3, 'Extra Short', 
	IIF(Duration <= 6, 'Short',
		IIF(Duration > 6, 'Long', 'Extra Long')))
		AS [Duration]
FROM Games
ORDER BY [Name], Duration, [Part Of The Day]

/* Task 16 */
USE Orders

SELECT ProductName, OrderDate,
DATEADD(DAY, 3, OrderDate) AS [Pay Due], 
DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders

/* Task 17 */
CREATE TABLE People(
	Id INT IDENTITY, 
	[Name] NVARCHAR(50) NOT NULL, 
	Birthdate DATETIME NOT NULL,
	CONSTRAINT PK_PeopleId PRIMARY KEY (Id)
)

INSERT INTO People([Name], Birthdate) VALUES
('Stevan Segal', CONVERT(datetime, '10-09-1999', 103)),
('Rene Artua', CONVERT(datetime, '11-02-1944', 103)),
('Van Dam', CONVERT(datetime, '20-11-1944', 103)),
('Barak Obama', CONVERT(datetime, '01-01-2000', 103)),
('100 kila', CONVERT(datetime, '09-09-1999', 103)),
('Milko Kalaidjiev', CONVERT(datetime, '04-07-1920', 103))

SELECT [Name], 
DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age In Years],
DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age In Months],
DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age In Days],
DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age In Minutes]
FROM People
ORDER BY [Age In Years], [Age In Months], [Age In Days]