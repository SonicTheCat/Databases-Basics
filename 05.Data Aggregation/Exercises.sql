/* Task 1 */
SELECT COUNT(Id) AS [Count]
FROM WizzardDeposits

/* Task 2 */
SELECT MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits

/* Task 3 */
SELECT DepositGroup, MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits
GROUP BY DepositGroup

/* Task 4 */
SELECT TOP(2) DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

/* Task 4 */
SELECT TOP 1 WITH TIES DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

/* Task 5 */
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY DepositGroup

/* Task 6 */
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

/* Task 6 */
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum] 
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
HAVING MagicWandCreator = 'Ollivander family'

/* Task 7 */
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

/* Task 8 */
SELECT DepositGroup,
MagicWandCreator, 
MIN(DepositCharge) AS [MinDepositCharge]
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

/* Task 9 */
SELECT *, 
COUNT(*) AS WizardCount FROM 
(
SELECT 
  CASE
   WHEN Age <= 10 THEN '[0-10]'
   WHEN Age between 11 and 20 THEN '[11-20]'
   WHEN Age between 21 and 30 THEN '[21-30]'
   WHEN Age between 31 and 40 THEN '[31-40]'
   WHEN Age between 41 and 50 THEN '[41-50]'
   WHEN Age between 51 and 60 THEN '[51-60]'
   ELSE '[61+]'
 END AS AgeGroup 
 FROM WizzardDeposits
) AS t
GROUP BY AgeGroup
ORDER BY AgeGroup

/* Task 10 */
SELECT LEFT(FirstName, 1) AS [FirstLetter]
FROM WizzardDeposits
GROUP BY LEFT(FirstName, 1), DepositGroup
HAVING DepositGroup = 'Troll Chest'

/* Task 10 */
SELECT DISTINCT LEFT(FirstName, 1) AS [FirstLetter]
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
ORDER BY FirstLetter

/* Task 11 */
SELECT DepositGroup,
IsDepositExpired, 
AVG(DepositInterest) AS [AverageInterest]
FROM WizzardDeposits
WHERE DepositStartDate > '01/01/1985'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC

/* Task 12 */
SELECT SUM(Diffrence) AS [SumDifference] FROM
(SELECT DepositAmount - LEAD(DepositAmount, 1) OVER(ORDER BY Id) AS Diffrence
-- OR DepositAmount - LAG(DepositAmount, 1) OVER(ORDER BY Id DESC) AS Diffrence
FROM WizzardDeposits) AS e

/* Task 13 */
SELECT DepartmentID, SUM(Salary)
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

/* Task 14 */
SELECT DepartmentID,
MIN(Salary) AS MinimumSalary
FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000 
GROUP BY DepartmentID
HAVING DepartmentID IN (2, 5, 7)

/* Task 15 */
SELECT * 
INTO FilteredTable
FROM Employees
WHERE Salary > 30000 

DELETE FROM FilteredTable
WHERE ManagerID = 42 

UPDATE FilteredTable
SET Salary += 5000 
WHERE DepartmentID = 1

SELECT DepartmentID, 
AVG(Salary)
FROM FilteredTable
GROUP BY DepartmentID

/* Task 16 */
SELECT DepartmentID, 
MAX(Salary) AS [MaxSalary]
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

/* Task 17 */
SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL 

/* Task 18 */
SELECT DepartmentID, Salary AS [ThirdHighestSalary]
FROM
(SELECT 
DepartmentID, Salary, 
DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY SALARY DESC) AS [DenseRank]
FROM Employees
GROUP BY DepartmentID, Salary) AS e
WHERE DenseRank = 3

/* Task 18 */
SELECT DepartmentID, Salary AS [ThirdHighestSalary]
FROM
(SELECT DISTINCT 
DepartmentID, Salary, 
DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY SALARY DESC) AS [DenseRank]
FROM Employees) AS e
WHERE DenseRank = 3

/* Task 19 */
SELECT TOP(10) FirstName, LastName, DepartmentID 
FROM
(SELECT *, AVG(Salary) OVER(PARTITION BY DepartmentId) AS [AvgSalaryInDepartment]
FROM Employees) AS e
WHERE Salary > AvgSalaryInDepartment

/* Task 19 */
SELECT TOP 10 FirstName, LastName, e.DepartmentID
FROM Employees AS e
INNER JOIN 
(SELECT DepartmentID, AVG(Salary) AS AverageSalary
FROM Employees 
GROUP BY DepartmentID) AS avgTable
ON e.DepartmentID = avgTable.DepartmentID
WHERE SALARY > AverageSalary
ORDER BY e.DepartmentID


