CREATE PROC p_AddAccount @ClientId INT, @AccountTypeId INT AS
INSERT INTO Accounts(ClientId, AccountTypeId)
VALUES (@ClientId, @AccountTypeId)

p_AddAccount 4, 1

SELECT * FROM Accounts

SELECT * FROM v_ClientBalance

GO
SELECT dbo.f_CalculateTotalBalance(4) AS Balance

CREATE PROC p_DEPOSIT @AccountId INT, @Amount DECIMAL(15,2) AS
UPDATE Accounts
SET Balance += @Amount
WHERE Id = @AccountId

p_DEPOSIT 1, 1000000

GO

CREATE PROC p_WithDraw @AccountId INT, @Amount Decimal (15,2) AS 
BEGIN
DECLARE @OldBalance DECIMAL (15,2)
SELECT @OldBalance = Balance FROM Accounts WHERE Id = @AccountId
IF (@OldBalance - @Amount >= 0)
BEGIN
	UPDATE Accounts
	SET Balance -= @Amount
	WHERE Id = @AccountId
END
ELSE
BEGIN
	RAISERROR('Insufucient fund', 10, 1)
END   
END

p_WithDraw 1,176