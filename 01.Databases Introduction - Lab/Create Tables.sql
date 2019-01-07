CREATE TABLE Clients(
Id INT PRIMARY KEY IDENTITY, 
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL
)

CREATE TABLE AccountTypes(
Id INT PRIMARY KEY IDENTITY, 
[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Accounts(
Id INT PRIMARY KEY IDENTITY,
ClientId INT FOREIGN KEY REFERENCES Clients(Id), 
AccountTypeId INT FOREIGN KEY REFERENCES AccountTypes(Id),
Balance DECIMAL(15,2) NOT NULL DEFAULT(0)
)

SELECT * FROM Clients

INSERT INTO Clients (FirstName, LastName) VALUES
('Gosho', 'Ivanov'),
('Pesho', 'Petrov'),
('Ivan', 'Iliev'),
('Merry', 'Ivanova')

INSERT INTO AccountTypes (Name) VALUES
('Checking'),
('Savings')

INSERT INTO Accounts (ClientId, AccountTypeId, Balance) VALUES
(1, 1, 175),
(2, 1, 275.56),
(3, 1, 138.01),
(4, 1, 40.30),
(4, 2, 375.50)

SELECT * FROM Clients

SELECT * FROM Accounts

SELECT * FROM AccountTypes