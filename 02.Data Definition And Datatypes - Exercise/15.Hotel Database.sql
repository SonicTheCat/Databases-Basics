CREATE TABLE Employees(
    Id INT IDENTITY, 
    FirstName NVARCHAR(50) NOT NULL, 
    LastName NVARCHAR(50) NOT NULL, 
    Title NVARCHAR(50) NOT NULL, 
    NOTES NVARCHAR(MAX),
    CONSTRAINT PK_Employees PRIMARY KEY (Id)
)

INSERT INTO Employees VALUES
('Blago', 'Djiizasa', 'title', NULL),
('Valeri', 'Bozhinkata', 'title', NULL),
('Chernata', 'Zlatka', 'TITLE', NULL)

--SELECT * FROM Employees

CREATE TABLE Customers(
    AccountNumber INT NOT NULL, 
    FirstName NVARCHAR(50) NOT NULL, 
    LastName NVARCHAR(50) NOT NULL, 
    PhoneNumber VARCHAR(20) NOT NULL, 
    EmergencyName  NVARCHAR(50) NOT NULL, 
    EmergencyNumber VARCHAR(20) NOT NULL, 
    NOTES NVARCHAR(MAX),
    CONSTRAINT PK_Customers PRIMARY KEY (AccountNumber)
)

INSERT INTO Customers
 VALUES
(1123123, 'Volen', 'Siderov', '0898949232', 'GERGI','2131313131',NULL),
(2121313, 'VaLERI', 'siMEONOV', '0898949232', 'GERGI','2131313131',NULL),
(19991291, 'KRASIMIR', 'karakachanov', '0898949232', 'GERGI','2131313131',NULL)

--SELECT *  FROM Customers

CREATE TABLE RoomStatus(
    RoomStatus NVARCHAR(10) UNIQUE NOT NULL, 
    NOTES NVARCHAR(MAX),
    CONSTRAINT PK_Status PRIMARY KEY (RoomStatus)
)

--SELECT * FROM RoomStatus

INSERT INTO RoomStatus (RoomStatus)
VALUES
	('Booked'),
    ('Occupied'),
    ('Available')

CREATE TABLE RoomTypes(
    RoomType NVARCHAR(50) UNIQUE NOT NULL, 
    NOTES NVARCHAR(MAX), 
    CONSTRAINT PK_Type PRIMARY KEY (RoomType)
)

INSERT INTO RoomTypes (RoomType)
VALUES
	('Single'),
    ('Double'),
    ('Suite')

--SELECT * FROM RoomTypes

CREATE TABLE BedTypes(
    BedType NVARCHAR(50) UNIQUE NOT NULL, 
    NOTES NVARCHAR(MAX), 
    CONSTRAINT PK_BedType PRIMARY KEY (BedType)
)

INSERT INTO BedTypes (BedType)
VALUES
	('SINGLE'),
    ('DOUble'),
    ('KingSIZE')

--SELECT * FROM BedTypes

CREATE TABLE Rooms(
    RoomNumber INT IDENTITY NOT NULL, 
    RoomType NVARCHAR(50) NOT NULL, 
    BedType NVARCHAR(50) NOT NULL, 
    Rate MONEY NOT NULL, 
    RoomStatus NVARCHAR(10) NOT NULL, 
    NOTES NVARCHAR(MAX),
    CONSTRAINT PR_Rooms PRIMARY KEY (RoomNumber), 
    CONSTRAINT FK_RoomType FOREIGN KEY (RoomType) REFERENCES RoomTypes (RoomType), 
    CONSTRAINT FK_BedType FOREIGN KEY (BedType) REFERENCES BedTypes (BedType), 
    CONSTRAINT FK_Status FOREIGN KEY (RoomStatus) REFERENCES RoomStatus (RoomStatus)  
)


INSERT INTO Rooms(RoomType, BedType, Rate, RoomStatus)
VALUES
('SINGLE', 'KINGSIZE', 100, 'Booked'),
('Double', 'SINGLE', 200, 'Booked'),
('SINGLE', 'SINGLE', 50, 'Booked')

--SELECT * FROM Rooms

CREATE TABLE Payments(
    Id INT IDENTITY, 
    EmployeeId INT NOT NULL, 
    PaymentDate DATETIME NOT NULL, 
    AccountNumber INT NOT NULL, 
    FirstDateOccupied DATE NOT NULL, 
    LastDateOccupied DATE NOT NULL, 
    TotalDays AS DATEDIFF(DAY, FirstDateOccupied, LastDateOccupied),
    AmountCharged DECIMAL(6,2) NOT NULL, 
    TaxRate DECIMAL(6,2) NOT NULL, 
    TaxAmount DECIMAL(6,2) NOT NULL, 
    PaymentTotal AS AmountCharged + TaxRate + TaxAmount, 
    NOTES NVARCHAR(MAX),
    CONSTRAINT PK_Payments PRIMARY KEY (Id), 
    CONSTRAINT FK_Employee FOREIGN KEY (EmployeeId) REFERENCES Employees (Id), 
    CONSTRAINT FK_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES Customers (AccountNumber),
    CONSTRAINT CHK_EndDate CHECK (LastDateOccupied >= FirstDateOccupied)
)

INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, AmountCharged, TaxRate, TaxAmount)
VALUES
(1, GETDATE(),1123123, CONVERT([datetime], '10-10-2010', 103), CONVERT([datetime], '12-12-2010'), 303, 20,10),
(2, GETDATE(),1123123, CONVERT([datetime], '10-10-2010', 103), CONVERT([datetime], '12-12-2010'), 303, 20,10),
(3, GETDATE(),1123123, CONVERT([datetime], '10-10-2010', 103), CONVERT([datetime], '12-12-2010'), 303, 20,10)

--SELECT * FROM Payments

CREATE TABLE Occupancies(
    Id INT IDENTITY, 
    EmployeeId INT NOT NULL, 
    DateOccupied DATE NOT NULL, 
    AccountNumber INT NOT NULL, 
    RoomNumber INT NOT NULL, 
    RateApplied DECIMAL(6,2) NOT NULL,
    PhoneCharge DECIMAL(6,2) NOT NULL, 
    NOTES NVARCHAR(MAX),
    CONSTRAINT PK_Occupancies PRIMARY KEY (Id), 
    CONSTRAINT FK_Employees FOREIGN KEY (EmployeeId) REFERENCES Employees (Id), 
    CONSTRAINT FK_Customers FOREIGN KEY (AccountNumber) REFERENCES Customers (AccountNumber), 
    CONSTRAINT FK_RoomNumber FOREIGN KEY (RoomNumber) REFERENCES Rooms (RoomNumber),
    CONSTRAINT CHK_PhoneCharge CHECK (PhoneCharge >= 0) 
)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge)
VALUES
	(1, CONVERT([datetime], '2014-02-10', 103), 1123123, 1, 70, 0),
	(2, CONVERT([datetime], '2014-02-10', 103), 1123123, 2, 70, 0),
	(3, CONVERT([datetime], '2014-02-10', 103), 1123123, 3, 70, 0)

--SELECT * FROM Occupancies 