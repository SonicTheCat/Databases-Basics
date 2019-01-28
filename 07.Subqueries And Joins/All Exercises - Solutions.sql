/* Task 1 */
  SELECT TOP(5) 
  	     e.EmployeeID, 
  	     e.JobTitle,
  	     a.AddressID,
  	     a.AddressText
    FROM Employees AS e
   INNER JOIN Addresses AS a
      ON a.AddressID = e.AddressID
ORDER BY a.AddressID

/* Task 2 */
    SELECT TOP(50) 
    	   e.FirstName, 
    	   e.LastName, 
    	   t.[Name], 
    	   a.AddressText 
      FROM Employees AS e
     INNER JOIN Addresses AS a
        ON a.AddressID = e.AddressID
     INNER JOIN Towns AS t
    	ON t.TownID = a.TownID
  ORDER BY e.FirstName, e.LastName

/* Task 3 */
SELECT
	e.EmployeeID, 
	e.FirstName, 
	e.LastName,
	d.[Name]
FROM 
	Employees AS e
	INNER JOIN 
	   Departments AS d
	   ON d.DepartmentID = e.DepartmentID
	   AND d.[Name] = 'Sales'
ORDER BY
	e.EmployeeID 

/* Task 4 */
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.[Name]
FROM Employees AS e
INNER JOIN Departments AS d
ON D.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

/* Task 5 */
SELECT TOP(3) e.EmployeeID, e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID 
WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID 

/* Task 5 */
SELECT DISTINCT TOP (3) e.EmployeeID, e.FirstName FROM Employees AS e
RIGHT JOIN EmployeesProjects AS ep
ON e.EmployeeID NOT IN (SELECT DISTINCT EmployeeID 
						FROM EmployeesProjects)
ORDER BY e.EmployeeID

/* Task 6 */
SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] AS [DeptName]
FROM Employees AS e
INNER JOIN Departments AS d
ON (d.DepartmentID = e.DepartmentID
	AND e.HireDate > '01-01-1999'
	AND d.[Name] IN ('Sales', 'Finance'))
ORDER BY e.HireDate

/* Task 6 */
SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] AS [DeptNaME]
FROM Employees AS e
INNER JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE e.HireDate > '01-01-1999'
AND d.[Name] = 'Sales' OR  d.[Name] = 'Finance'
ORDER BY e.HireDate

/* Task 7 */
SELECT TOP(5) 
  e.EmployeeID, e.FirstName, p.[Name]
FROM Employees AS e
	INNER JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
	INNER JOIN Projects AS p
	ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '08-13-2002' AND p.EndDate IS NULL
ORDER BY e.EmployeeID

/* Task 8 */
SELECT e.EmployeeID, e.FirstName,
	CASE
		WHEN  DATEPART(YEAR, p.StartDate) >= 2005 THEN NULL
		ELSE p.[Name]
	END AS ProjectName 
FROM Employees AS e
INNER JOIN EmployeesProjects AS ep
	ON e.EmployeeID = ep.EmployeeID AND e.EmployeeID = 24
INNER JOIN Projects AS p
	ON p.ProjectID = ep.ProjectID

/* Task 9 */
SELECT 
	e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName AS ManagerName
FROM Employees AS e
INNER JOIN Employees AS m
	ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IN (3,7)
ORDER BY e.EmployeeID

/* Task 10 */
SELECT TOP (50)
	e.EmployeeID, 
	CONCAT(e.FirstName, ' ', e.LastName) AS [EmployeeName],
	CONCAT(m.FirstName, ' ', m.LastName) AS [EmployeeName],
	d.[Name] AS [DepartmentName] 
FROM Employees AS e
INNER JOIN Employees AS m
	ON m.EmployeeID = e.ManagerID
INNER JOIN Departments AS d
	ON d.DepartmentID = e.DepartmentID
ORDER BY EmployeeID

/* Task 11 */
SELECT TOP(1) AVG(Salary)
FROM Employees
GROUP BY DepartmentID
ORDER BY AVG(Salary) ASC

/* Task 11 */
SELECT MIN(AvgSalaries.Salary) 
FROM 
	(SELECT AVG(Salary) AS Salary
	FROM Employees
	GROUP BY DepartmentID) AS AvgSalaries

/* Task 11 */
WITH CTE_AvgSalaries(AverageSalary) AS
(
	SELECT AVG(Salary) as Salary
	FROM Employees
	GROUP BY DepartmentID 
)

SELECT MIN(AverageSalary) AS MinAverageSalary
FROM CTE_AvgSalaries

/* Task 12 */
--USE GEOGRAPHY

SELECT 
	mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation 
FROM Peaks AS p
INNER JOIN Mountains AS m
	ON (m.Id = p.MountainId 
	AND p.Elevation > 2835)
INNER JOIN MountainsCountries AS mc
	ON (mc.MountainId = m.Id 
	AND mc.CountryCode = 'BG')
ORDER BY p.Elevation DESC

/* Task 13 */
SELECT CountryCode, COUNT(*) AS MountainRanges
FROM MountainsCountries
WHERE CountryCode IN ('BG', 'RU', 'US')
GROUP BY CountryCode
--GO

/* Task 13 */
WITH CTE_MoutainsCount(CountryCode ,MountainRanges) AS (
	SELECT CountryCode, COUNT(*) 
	FROM MountainsCountries
	GROUP BY CountryCode
	HAVING CountryCode IN ('BG', 'RU', 'US')
)

SELECT * FROM CTE_MoutainsCount

/* Task 13 */
SELECT c.CountryCode, COUNT(*)
FROM Countries AS c
INNER JOIN MountainsCountries AS mc
ON mc.CountryCode = c.CountryCode
WHERE c.CountryName IN ('BULGARIA', 'Russia', 'United States')
GROUP BY c.CountryCode

/* Task 14 */
SELECT TOP(5) 
	c.CountryName, r.RiverName 
FROM Rivers AS r
INNER JOIN CountriesRivers AS cr
	ON cr.RiverId= r.Id
RIGHT OUTER JOIN Countries AS c
	ON c.CountryCode = cr.CountryCode
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName

/* Task 14 */
SELECT TOP(5)
	c.CountryName, r.RiverName
FROM Countries AS c
LEFT OUTER JOIN CountriesRivers AS cr
	ON cr.CountryCode = c.CountryCode 
LEFT OUTER JOIN Rivers AS r
	ON r.Id = cr.RiverId
WHERE c.ContinentCode= 'AF'
ORDER BY c.CountryName

/* Task 15 */
SELECT 
	secondQuerry.ContinentCode, 
	secondQuerry.CurrencyCode, 
	secondQuerry.UsageCounter AS [CurrencyUsage]
FROM 
	(SELECT *, 
		DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY firstQuerry.UsageCounter DESC) AS DenseRank
	FROM
		(SELECT	
			ContinentCode, CurrencyCode, COUNT(*) AS UsageCounter
		FROM Countries
		GROUP BY ContinentCode, CurrencyCode) AS firstQuerry) AS secondQuerry
WHERE secondQuerry.DenseRank = 1 
AND secondQuerry.UsageCounter <> 1
ORDER BY secondQuerry.ContinentCode, secondQuerry.CurrencyCode


/* Task 15 */
WITH CTE_CountedCurrencies(ContinentCode, CurrencyCode, UsageCounter) AS 
(
		SELECT	
		ContinentCode, CurrencyCode, COUNT(*) AS A
		FROM Countries
		GROUP BY ContinentCode, CurrencyCode
		HAVING COUNT(*) > 1
)

SELECT c.ContinentCode, c.CurrencyCode, c.UsageCounter AS [CurrencyUsage]
FROM
	(SELECT ContinentCode, MAX(UsageCounter) AS maxC
	FROM CTE_CountedCurrencies
	GROUP BY ContinentCode) AS biggestCurrencies
INNER JOIN CTE_CountedCurrencies AS c
	ON (c.ContinentCode = biggestCurrencies.ContinentCode AND c.UsageCounter = biggestCurrencies.maxC)
ORDER BY c.ContinentCode

/* Task 16 */
SELECT COUNT(*) AS CountryCode
FROM Countries AS c
LEFT OUTER JOIN MountainsCountries AS mc
ON mc.CountryCode = c.CountryCode
WHERE mc.CountryCode IS NULL

/* Task 16 */
WITH CTE_AllCountries AS 
(
	SELECT COUNT(*) AS [counterAll] 
	FROM Countries
),

CTE_CountriesWithMountains AS 
(
	SELECT COUNT(DISTINCT CountryCode) AS [counterWith] 
	FROM MountainsCountries
)

SELECT al.counterAll - cm.counterWith 
FROM CTE_AllCountries AS al
JOIN CTE_CountriesWithMountains AS cm 
ON al.counterAll IS NOT NULL

/* Task 17 */
WITH CTE_AllTablesJoined(CountryName, HighestPeakElevation, LongestRiverLength, dRank) AS 
(
	SELECT 
		c.CountryName,  
		p.Elevation AS [HighestPeakElevation],
		r.[Length] AS [LongestRiverLength],
		DENSE_RANK() OVER 
		(PARTITION BY c.CountryName ORDER BY p.Elevation DESC, r.[Length] DESC) AS [dRank]
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	LEFT JOIN Peaks AS p
		ON p.MountainId = mc.MountainId
	LEFT JOIN CountriesRivers AS cr
		ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers AS r
		ON r.Id = cr.RiverId
)

SELECT TOP(5) 
	CountryName, HighestPeakElevation, LongestRiverLength
FROM CTE_AllTablesJoined
WHERE dRank = 1
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, CountryName

/* Task 18 */
WITH CTE_AllCountriesInfo(CountryName, [Highest Peak Name], [Highest Peak Elevation], Mountain, [dRank]) AS 
(
	SELECT 
		c.CountryName,
		ISNULL(p.PeakName, '(no highest peak)'),
		ISNULL(p.Elevation, 0), 
		ISNULL(m.MountainRange, '(no mountain)'),
		DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC)
	FROM Countries AS c
	LEFT OUTER JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	LEFT OUTER JOIN Peaks AS p
		ON p.MountainId = mc.MountainId
	LEFT OUTER JOIN Mountains AS m
		ON m.Id = mc.MountainId
)

SELECT TOP(5)
   CountryName, [Highest Peak Name], [Highest Peak Elevation], Mountain
FROM CTE_AllCountriesInfo
WHERE dRank = 1
ORDER BY CountryName, [Highest Peak Name]