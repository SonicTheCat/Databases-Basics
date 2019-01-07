CREATE VIEW v_ClientBalance AS
SELECT (FirstName + ' ' + LastName) AS [Name], 
(AccountTypes.Name) AS [Account Type], Balance
From Clients
JOIN Accounts ON Clients.Id = Accounts.ClientId
JOIN AccountTypes ON AccountTypes.Id = Accounts.AccountTypeId

SELECT * FROM v_ClientBalance