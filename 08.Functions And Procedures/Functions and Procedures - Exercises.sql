/* Task 1 */
--USE SoftUnI
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS 
BEGIN 
	SELECT e.FirstName, e.LastName 
	FROM Employees AS e
	WHERE e.Salary > 35000
END

EXECUTE dbo.usp_GetEmployeesSalaryAbove35000
GO

/* Task 2 */
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber(@number DECIMAL(18,4))
AS
BEGIN 
	SELECT e.FirstName, e.LastName 
	FROM Employees AS e
	WHERE e.Salary >= @number
END

/* Task 3 */
CREATE PROCEDURE usp_GetTownsStartingWith(@str NVARCHAR(10))
AS 
BEGIN 
	SELECT t.[Name]
	FROM Towns AS t
	WHERE t.[Name] LIKE @str + '%'
	-- OR WHERE LEFT(t.[Name], LEN(@str)) = @str
END

EXECUTE dbo.usp_GetTownsStartingWith 'p'

/* Task 4 */
CREATE PROCEDURE usp_GetEmployeesFromTown(@townName NVARCHAR(MAX))
AS
BEGIN 
	DECLARE @townID INT = (SELECT t.TownID
		FROM Towns AS t	
		WHERE t.[Name] = @townName) 
	
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	JOIN Addresses AS a
		ON a.AddressID = e.AddressID
	WHERE a.TownID = @townID
END
	
EXECUTE dbo.usp_GetEmployeesFromTown 'Sofia'

/* Task 4 */
CREATE PROCEDURE usp_GetEmployeesFromTown(@townName NVARCHAR(MAX))
AS
BEGIN 
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	JOIN Addresses AS a
		ON a.AddressID = e.AddressID
	JOIN Towns AS t
		ON t.TownID = a.TownID
	WHERE t.[Name] = @townName
END
GO

/* Task 5 */
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS 
BEGIN 
	DECLARE @Result NVARCHAR(10); 

	IF (@salary < 30000)
	BEGIN
		SET @Result = 'Low'; 
	END
	ELSE IF(@salary >= 30000 AND @salary <= 50000)
	BEGIN 
		SET @Result = 'Average'; 
	END
	ELSE
		SET @Result = 'High'; 

	RETURN @Result; 
END
GO

--testing
SELECT 
	e.FirstName, 
	e.LastName, 
	e.Salary,  
	dbo.ufn_GetSalaryLevel(e.Salary) AS SalaryLevel
FROM Employees AS e
GO

/* Task 6 */
CREATE PROCEDURE usp_EmployeesBySalaryLevel(@level NVARCHAR(10))
AS 
BEGIN 
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @level
END
GO

EXECUTE dbo.usp_EmployeesBySalaryLevel 'High'
GO

/* Task 7 */
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN 
	DECLARE @indexCounter INT = 1;
	DECLARE @doesContains BIT = 1; 

	WHILE(@indexCounter <= LEN(@word))
	BEGIN 
		DECLARE @currentChar NVARCHAR = SUBSTRING(@word, @indexCounter, 1); 
		DECLARE	@index INT = CHARINDEX(@currentChar, @setOfLetters);

		IF(@index = 0)
		BEGIN 
			SET @doesContains = 0;
			BREAK;
		END
		ELSE
			SET @indexCounter = @indexCounter + 1;
	END
	RETURN @doesContains;
END
GO

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')
GO

/* Task 8 */
--BACKUP DATABASE SoftUni
--TO DISK = 'D:\Downloads\testDB.bak'

CREATE PROCEDURE usp_DeleteEmployeesFromDepartment(@departmentId INT) 
AS 
BEGIN 
	ALTER TABLE EmployeesProjects NOCHECK CONSTRAINT ALL
	ALTER TABLE Departments NOCHECK CONSTRAINT ALL
	ALTER TABLE Employees NOCHECK CONSTRAINT ALL

	DELETE 
	FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE 
	FROM Departments 
	WHERE DepartmentID = @departmentId

	ALTER TABLE EmployeesProjects CHECK CONSTRAINT ALL 
	ALTER TABLE Departments CHECK CONSTRAINT ALL
	ALTER TABLE Employees CHECK CONSTRAINT ALL

	SELECT COUNT(*) 
	FROM Employees AS e
	WHERE e.DepartmentID = @departmentId
END

--Testing
EXECUTE dbo.usp_DeleteEmployeesFromDepartment 10
RESTORE DATABASE SoftUni
FROM DISK = 'D:\Downloads\testDB.bak' 
GO

/* Task 9 */
--USE BANK
CREATE PROCEDURE usp_GetHoldersFullName
AS 
BEGIN 
	SELECT ah.FirstName + ' ' + ah.LastName AS [Full Name]
	FROM AccountHolders AS ah 
END

EXECUTE dbo.usp_GetHoldersFullName
GO

/* Task 10 */
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@value DECIMAL(16,2))
AS 
BEGIN
	SELECT ac.FirstName, ac.LastName
	FROM AccountHolders AS ac
	JOIN Accounts AS a
	ON a.AccountHolderId = ac.Id
	GROUP BY a.AccountHolderId, ac.FirstName, ac.LastName
	HAVING SUM(a.Balance) > @value	
	ORDER BY ac.FirstName, ac.LastName
END

EXECUTE dbo.usp_GetHoldersWithBalanceHigherThan 10000
GO

/* Task 11 */
CREATE FUNCTION ufn_CalculateFutureValue(@sum DECIMAL(16, 2), @yearlyRate FLOAT, @numberYears INT)
RETURNS DECIMAL(16, 4)
AS 
BEGIN
	DECLARE @fv DECIMAL(16, 4); 
	SET @fv = @sum * (POWER(1 + @yearlyRate, @numberYears)); 
	RETURN @fv; 
END
GO

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO

/* Task 12 */
CREATE PROCEDURE usp_CalculateFutureValueForAccount(@accounID INT, @interestRate FLOAT, @years INT = 5)
AS 
BEGIN
	SELECT 
		a.Id,
		ah.FirstName,
		ah.LastName, 
		a.Balance, 
		dbo.ufn_CalculateFutureValue(a.Balance, @interestRate, @years) AS [Balance in 5 years]
	FROM Accounts AS a
	JOIN AccountHolders AS ah
	ON ah.Id = a.AccountHolderId
	WHERE a.Id = @accounID
END

EXECUTE usp_CalculateFutureValueForAccount 1, 0.1, 10
GO

/* Task 13 */
CREATE FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(MAX))
RETURNS TABLE
AS 
RETURN (SELECT SUM(fQuerry.Cash) AS SumCash
		FROM
			(
				SELECT 
				ug.Cash AS Cash,
				ROW_NUMBER() OVER (ORDER BY ug.Cash DESC) AS [Row Number]
				FROM UsersGames AS ug
				JOIN Games AS g
				ON g.Id = ug.GameId
				WHERE g.[Name] = @gameName
			) 
			AS fQuerry
		WHERE fQuerry.[Row Number] % 2 = 1)
GO

SELECT * FROM dbo.ufn_CashInUsersGames('Love in a mist')