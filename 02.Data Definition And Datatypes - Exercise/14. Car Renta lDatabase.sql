CREATE TABLE Categories(
    Id INT IDENTITY, 
    CategoryName NVARCHAR(50) NOT NULL, 
    DailyRate INT NOT NULL, 
    WeeklyRate INT NOT NULL, 
    MonthlyRate INT NOT NULL, 
    WeekendRate INT NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY (Id)
)

INSERT INTO Categories VALUES
('DISEL', 100, 600, 2500, 180),
('PETROL', 110, 660, 3000, 200),
('ELECTRIC', 200, 1000, 3500, 390)

--SELECT * FROM Categories

CREATE TABLE Cars(
    Id INT IDENTITY, 
    PlateNumber NVARCHAR(20) NOT NULL UNIQUE, 
    Manufacturer NVARCHAR(50) NOT NULL, 
    Model NVARCHAR(50) NOT NULL, 
    CarYear INT NOT NULL, 
    CategoryId INT NOT NULL, 
    Doors INT, 
    Picture VARBINARY(MAX), 
    Condition NVARCHAR(MAX), 
    Available BIT ,
    CONSTRAINT PK_Car PRIMARY KEY (Id), 
    CONSTRAINT FK_Category FOREIGN KEY (CategoryId) REFERENCES Categories(Id),
    CONSTRAINT CHK_PictureSize CHECK (DATALENGTH(Picture) <= 900 * 1024),
    CONSTRAINT CHK_DoorsCount CHECK (Doors > 0 AND Doors <= 5)
)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
('СА 4441 АС', 'BMW', 'X4', 2006, 2, 5, NULL, 'Kat chisto nova', 1),
('A 1457 BA', 'Ford', 'Focus', 2010, 1, 3, NULL, 'BARAKA', 1),
('СA 1111111 АС', 'TESLA', 'CHUK', 2030, 3, 2, NULL, 'TOVA E BADESHTETO', 0)

--SELECT * FROM Cars

CREATE TABLE Employees(
    Id INT IDENTITY, 
    FirstName NVARCHAR(50) NOT NULL, 
    LastName NVARCHAR(50) NOT NULL, 
    Title VARCHAR(4), 
    Notes NVARCHAR(MAX),
    CONSTRAINT PK_Employee PRIMARY KEY (Id)
)

INSERT INTO Employees VALUES
('Haralampi', 'Haralampiev', NULL, NULL),
('Ivan', 'Karakolev', NULL, NULL),
('Dimitar', 'Peshov', NULL, NULL)

--SELECT * FROM Employees

CREATE TABLE Customers(
    Id INT IDENTITY, 
    DriverLicenceNumber INT NOT NULL, 
    FullName NVARCHAR(50) NOT NULL, 
    [Address] NVARCHAR(200) NOT NULL,
    City NVARCHAR(50) NOT NULL, 
    ZIPCode NVARCHAR(10), 
    Notes NVARCHAR(MAX), 
    CONSTRAINT PK_Custromer PRIMARY KEY (Id)
)

INSERT INTO Customers VALUES
(111111007, 'James Bondov', 'Fakulteta', 'Sofia', 1000, NULL), 
(101020302, 'Gosho Peshov', 'Mladost 1', 'Varna', 3010, NULL), 
(101291921, 'Ivan Ivanov', 'Zaharna Fabrika', 'Sofia', 1001, NULL)

--SELECT * FROM Customers

CREATE TABLE RentalOrders(
    Id INT IDENTITY, 
    EmployeeId INT NOT NULL, 
    CustomerId INT NOT NULL, 
    CarId INT NOT NULL, 
    TankLevel INT NOT NULL, 
    KilometrageStart FLOAT NOT NULL,
    KilometrageEnd FLOAT NOT NULL, 
    TotalKilometrage AS KilometrageEnd - KilometrageStart, 
    StartDate DATE NOT NULL, 
    EndDate DATE NOT NULL, 
    TotalDays AS DATEDIFF(DAY, StartDate, EndDate),
    RateApplied MONEY NOT NULL,
    TaxRate MONEY NOT NULL, 
    OrderStatus NVARCHAR(50) NOT NULL,
    Notes NVARCHAR(MAX),
    CONSTRAINT PK_Order PRIMARY KEY (Id), 
    CONSTRAINT FK_Employee FOREIGN KEY (EmployeeId) REFERENCES Employees(Id), 
    CONSTRAINT FK_Customer FOREIGN KEY (CustomerId) REFERENCES Customers(Id), 
    CONSTRAINT FK_Car FOREIGN KEY (CarId) REFERENCES Cars(Id),
    CONSTRAINT CHK_TankLevel CHECK (TankLevel >= 0), 
    CONSTRAINT CHK_EndDate CHECK (EndDate >= StartDate)
)

INSERT INTO RentalOrders VALUES
(2, 3, 1, 60, 2500, 10000, CONVERT(datetime, '18-10-2010', 103), CONVERT(datetime, '18-10-2020', 103), 100, 0.50, 'Rented', NULL),
(1, 2, 2, 100, 1000, 100000, CONVERT(datetime, '08-10-2015', 103), CONVERT(datetime, '18-11-2015', 103), 50, 2, 'BOOKED', NULL),
(3, 1, 3, 20, 0, 100, CONVERT(datetime, '10-06-2030', 103), CONVERT(datetime, '11-06-2030', 103), 100, 0.50, 'Rented', NULL)


--SELECT * FROM RentalOrders

