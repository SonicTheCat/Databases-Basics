CREATE TABLE TRANSACTIONS (
Id INT PRIMARY KEY IDENTITY, 
AccountId INT FOREIGN KEY REFERENCES Accounts(Id), 
OldBalance DECIMAL(15,2) NOT NULL, 
NewBalance DECIMAL(15,2) NOT NULL, 
Amount AS NewBalance - OldBalance, 
[DateTime] DATETIME2
)

CREATE TRIGGER tr_Transaction ON Accounts
AFTER UPDATE 
AS
	INSERT INTO TRANSACTIONS (AccountId,OldBalance,NewBalance,[DateTime])
	SELECT inserted.id, deleted.Balance, inserted.Balance, GETDATE() FROM inserted
	JOIN deleted ON inserted.Id = deleted.Id

SELECT * FROM TRANSACTIONS

SELECT * FROM v_ClientBalance

p_DEPOSIT 7, 10

p_DEPOSIT 1, 1

p_WithDraw 1, 1000000