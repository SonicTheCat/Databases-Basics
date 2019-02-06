/* Task 14 */
--USE BANK
CREATE TABLE Logs
(	
	LogId INT IDENTITY, 
	AccountID INT NOT NULL, 
	OldSum DECIMAL(16,2) NOT NULL, 
	NewSum DECIMAL(16,2) NOT NULL, 

	CONSTRAINT PK_Logs
	PRIMARY KEY (LogId), 

	CONSTRAINT FK_Logs_Accounts
	FOREIGN KEY (AccountID)
	REFERENCES Accounts(Id)
)
GO

CREATE TRIGGER tr_ChangeBalance ON Accounts AFTER UPDATE
AS 
BEGIN 
	INSERT INTO Logs
	SELECT inserted.Id, deleted.Balance, inserted.Balance
	FROM inserted
	JOIN deleted
	ON inserted.Id = deleted.Id
END	

UPDATE Accounts 
SET Balance += 555
WHERE Id = 2

/* Task 15 */
CREATE TABLE NotificationEmails
(
	ID INT IDENTITY PRIMARY KEY, 
	Recipient INT FOREIGN KEY REFERENCES Accounts(ID), 
	Subject NVARCHAR(MAX) NOT NULL, 
	Body NVARCHAR(MAX) NOT NULL
)
GO

CREATE TRIGGER tr_SendEmail ON Logs AFTER INSERT
AS 
BEGIN 
	INSERT INTO NotificationEmails
	SELECT 
		inserted.AccountID,
		CONCAT('Balance change for account: ',inserted.AccountID ),
		CONCAT('On ', GETDATE(), ' your balance was changed from ', inserted.OldSum, ' to ', inserted.NewSum)
	FROM inserted
END
GO

SELECT * FROM Logs
SELECT * FROM NotificationEmails

UPDATE Accounts 
SET Balance += 500000
WHERE Id = 1
GO

/* Task 16 */
CREATE PROCEDURE usp_DepositMoney(@accountID INT, @moneyAmount DECIMAL (16,4))
AS
BEGIN
	BEGIN TRANSACTION 

	UPDATE Accounts
	SET Balance += @moneyAmount
	WHERE Id = @accountID
	
	IF @moneyAmount < 0
	BEGIN
		ROLLBACK; 
		RETURN;  
	END
		COMMIT
END

EXECUTE dbo.usp_DepositMoney 1, 100000
SELECT * FROM Accounts
GO

/* Task 17 */
CREATE PROCEDURE usp_WithdrawMoney (@AccountId INT, @MoneyAmount DECIMAL (16,4))
AS 
BEGIN 
	BEGIN TRANSACTION
		IF(@MoneyAmount > 0)
		BEGIN 
			UPDATE Accounts
			SET Balance -= @MoneyAmount
			WHERE ID = @AccountId
		
			IF(@@ROWCOUNT <> 1)
			BEGIN 
				RAISERROR('INVALID ACCOUNT!',16, 2)
				ROLLBACK; 
				RETURN; 
			END 
		END
	COMMIT
END

EXECUTE dBO.usp_WithdrawMoney 1, 100000
GO

/* Task 18 */
CREATE OR ALTER PROCEDURE usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DECIMAL (16,4))
AS
BEGIN 
	BEGIN TRANSACTION 
	IF(@Amount > 0)
	BEGIN 
		EXECUTE usp_WithdrawMoney @SenderId, @Amount
		EXECUTE usp_DepositMoney @ReceiverId, @Amount
	END
	COMMIT
END 

SELECT * FROM Accounts
EXECUTE dbo.usp_TransferMoney 1, 2, 1000
GO

/* Task 19 */
--BACKUP DATABASE Diablo
--TO DISK = 'D:\Downloads\diablo.bak'
CREATE TRIGGER tr_BuyItem ON UserGameItems AFTER INSERT
AS
BEGIN
	DECLARE @userLevel INT; 
	DECLARE @itemLevel INT;  

	SET @userLevel = (SELECT ug.[Level] 
	FROM inserted
	JOIN UsersGames AS ug
	ON ug.Id = inserted.UserGameId)

	SET @itemLevel = (SELECT i.MinLevel
	FROM inserted
	JOIN Items AS i
	ON i.Id = inserted.ItemId)

	IF(@userLevel < @itemLevel)
	BEGIN 
		RAISERROR('User can not buy this item!', 16, 1);
		ROLLBACK;
		RETURN;  
	END
END 

INSERT INTO UserGameItems
VALUES 
(4, 1)

UPDATE UsersGames
SET Cash += 50000
FROM UsersGames AS ug
JOIN Users AS u
ON u.Id = ug.UserId
JOIN Games AS g
ON g.Id = ug.GameId
WHERE g.Name = 'Bali' 
AND u.Username IN ('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
GO

CREATE PROCEDURE udp_BuyItems(@username NVARCHAR(MAX))
AS 
BEGIN 
	DECLARE @counter INT = 251;
	DECLARE @userId INT = (SELECT u.Id FROM Users AS u WHERE u.Username = @username);
	
	WHILE(@counter <= 539)
	BEGIN 
		DECLARE @itemValue DECIMAL(16,2) = (SELECT i.Price FROM Items AS i WHERE i.Id = @counter);
		DECLARE @UserCash DECIMAL(16,2) = (SELECT u.Cash FROM UsersGames AS u WHERE u.UserId = @userId);

		IF(@itemValue <= @UserCash)
		BEGIN 
			INSERT INTO UserGameItems 
			VALUES 
			(@counter, @userId)

			UPDATE UsersGames
			SET Cash -= @itemValue
			WHERE UserId = @userId
		END

		SET @counter += 1; 
		IF(@counter = 300)
		BEGIN
			SET @counter = 501; 
		END
	END
END

EXECUTE udp_BuyItems 'baleremuda'
EXECUTE udp_BuyItems 'loosenoise'
EXECUTE udp_BuyItems 'inguinalself'
EXECUTE udp_BuyItems 'buildingdeltoid'
EXECUTE udp_BuyItems 'monoxidecos'
GO

/* Task 20 */
DECLARE @gameId INT = (SELECT Id FROM Games AS g WHERE g.[Name] = 'Safflower'); 
DECLARE @userId INT = (SELECT u.Id FROM Users AS u WHERE u.Username = 'Stamat');	
DECLARE @userGameId INT = (SELECT ug.Id FROM UsersGames AS ug WHERE ug.GameId = @gameId AND ug.UserId = @userId);
DECLARE @userCash DECIMAL(15, 2) = (SELECT ug.Cash FROM UsersGames AS ug WHERE ug.Id = @userGameId);  
DECLARE @itemsPricesSummed DECIMAL(15, 2) = (SELECT SUM(i.Price) FROM Items AS i WHERE i.MinLevel BETWEEN 11 AND 12); 

IF(@userCash >= @itemsPricesSummed)
BEGIN
	BEGIN TRANSACTION
		INSERT UserGameItems
		SELECT i.Id, @UserGameId
		FROM Items AS i
		WHERE i.MinLevel BETWEEN 11 AND 12

		UPDATE UsersGames 
		SET Cash -= @itemsPricesSummed
		WHERE Id = @UserGameId 
	COMMIT
END

SET @itemsPricesSummed = (SELECT SUM(i.Price) FROM Items AS i WHERE i.MinLevel BETWEEN 19 AND 21); 
SET @UserCash = (SELECT ug.Cash FROM UsersGames AS ug WHERE ug.Id = @UserGameId);  

IF(@UserCash >= @itemsPricesSummed)
BEGIN 	
	BEGIN TRANSACTION
		INSERT UserGameItems
		SELECT i.Id, @UserGameId
		FROM Items AS i
		WHERE i.MinLevel BETWEEN 19 AND 21

		UPDATE UsersGames 
		SET Cash -= @itemsPricesSummed
		WHERE Id = @UserGameId 
	COMMIT TRANSACTION 
END

SELECT i.[Name] 
FROM UsersGames AS ug
JOIN Users AS u
ON u.Id = ug.UserId
JOIN Games AS g
ON g.Id = ug.GameId
JOIN UserGameItems AS ugi
ON ugi.UserGameId = ug.Id
JOIN Items AS i
ON i.Id = ugi.ItemId
WHERE (u.Username = 'Stamat' 
AND g.[Name] = 'Safflower')
ORDER BY i.[Name]

GO

/* Task 21 */
--USE SoftUnI
CREATE PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT)
AS
BEGIN 
	DECLARE @maxProjectsAllowed INT = 3; 
	DECLARE @currentProjects INT;

	SET @currentProjects = 
	(SELECT COUNT(*) 
	FROM Employees AS e
	JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
	WHERE ep.EmployeeID = @emloyeeId)

BEGIN TRANSACTION 	
	IF(@currentProjects >= @maxProjectsAllowed)
	BEGIN 
		RAISERROR('The employee has too many projects!', 16, 1);
		ROLLBACK;
		RETURN;
	END

	INSERT INTO EmployeesProjects
	VALUES
	(@emloyeeId, @projectID)

COMMIT	
END 

/* Task 22 */
CREATE TABLE Deleted_Employees
(
	EmployeeId INT NOT NULL IDENTITY, 
	FirstName NVARCHAR(64) NOT NULL, 
	LastName NVARCHAR(64) NOT NULL, 
	MiddleName NVARCHAR(64), 
	JobTitle NVARCHAR(64) NOT NULL, 
	DepartmentID INT NOT NULL, 
	Salary DECIMAL(15, 2) NOT NULL

	CONSTRAINT PK_Deleted_Emp
	PRIMARY KEY (EmployeeId), 

	CONSTRAINT FK_DeletedEmp_Departments
	FOREIGN KEY (DepartmentID)
	REFERENCES Departments(DepartmentID)
)
GO

CREATE TRIGGER tr_DeletedEmp 
ON Employees 
AFTER DELETE 
AS
	INSERT INTO Deleted_Employees
	SELECT 	
		d.FirstName, 
		d.LastName, 
		d.MiddleName, 
		d.JobTitle, 
		d.DepartmentID, 
		d.Salary
	FROM deleted as d
