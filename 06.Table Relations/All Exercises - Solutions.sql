/* Task 1 */
CREATE TABLE Passports(
    PassportID INT IDENTITY, 
	PassportNumber NVARCHAR(32) NOT NULL UNIQUE, 

	CONSTRAINT PK_Passport PRIMARY KEY (PassportID)
)

CREATE TABLE Persons(
	PersonID INT IDENTITY, 
	FirstName NVARCHAR(64) NOT NULL, 
	Salary DECIMAL(15, 2) NOT NULL, 
	PassportID INT NOT NULL UNIQUE, 

	CONSTRAINT PK_Persons PRIMARY KEY (PersonId),
	CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)
)

--Testing...

INSERT INTO Passports
VALUES
('BG1239901AI'),
('UK293392USA'),
('BG99999AAAA'),
('RU504010200'),
('BRA20020211')

INSERT INTO Persons 
VALUES 
('BAT Gergi', 1200, 3), 
('Peri Peri', 2000, 2),
('Jorge Andrare', 200, 5),
('Milcho Kalaidjiev', 500, 1),
('Anna Karenina', 3300, 4)     

SELECT FirstName, Salary
FROM 
	(SELECT *, 
	AVG(Salary) OVER (PARTITION BY PassportID) AS [avgSalary] 
	FROM Persons) AS e
WHERE Salary > e.[avgSalary]


/* Task 2 */
CREATE TABLE Manufacturers(
	ManufacturerID INT IDENTITY, 
	[Name] NVARCHAR(32) NOT NULL, 
	EstablishedOn DATE NOT NULL, 

	CONSTRAINT PK_Manufacturers PRIMARY KEY (ManufacturerID)
)

CREATE TABLE Models(
	ModelID INT IDENTITY, 
	[Name] NVARCHAR(32) NOT NULL, 
	ManufacturerID INT NOT NULL, 

	CONSTRAINT PK_Models 
	PRIMARY KEY (ModelID), 

	CONSTRAINT FK_Models_Manufacturers 
	FOREIGN KEY (ManufacturerID) 
	REFERENCES Manufacturers(ManufacturerID)
)

--Testing...

INSERT INTO Manufacturers 
VALUES 
('Volga', CONVERT(datetime, '10-07-1954', 103)),
('BMW', CONVERT(datetime, '10-12-1923', 103)),
('Honda', CONVERT(datetime, '06-03-1950', 103)),
('Great Wall', CONVERT(datetime, '10-07-2010', 103))

INSERT INTO Models
VALUES 
('X3', 1), 
('X5', 1),
('CR-V', 3), 
('Civic', 3)


/* Task 3 */
CREATE TABLE Students(
	StudentID INT IDENTITY, 
	[Name] NVARCHAR(64) NOT NULL, 

	CONSTRAINT PK_Students 
	PRIMARY KEY (StudentID)
)

CREATE TABLE Exams(
	ExamID INT IDENTITY, 
	[Name] NVARCHAR(64) NOT NULL,

	CONSTRAINT PK_Exams 
	PRIMARY KEY (ExamID)
)

CREATE TABLE StudentsExams(
	StudentID INT NOT NULL, 
	ExamID INT NOT NULL,

	CONSTRAINT PK_Students_Exams
	PRIMARY KEY (StudentID, ExamID), 

	CONSTRAINT FK_Students 
	FOREIGN KEY (StudentID) 
	REFERENCES Students(StudentID),

	CONSTRAINT FK_Exams
	FOREIGN KEY (ExamID)
	REFERENCES Exams(ExamID)
)

--Testing...

INSERT INTO Students
VALUES 
('Velcho'),
('Milcho'),
('Gergi')

INSERT INTO Exams
VALUES
('T-SQL'),
('js'),
('Python'),
('Ruby'),
('c++')

INSERT INTO StudentsExams
VALUES
(1,1),
(2,5),
(3,5),
(1,4)

SELECT * FROM Students
SELECT * FROM Exams

SELECT * FROM
	(SELECT s.StudentID, s.Name AS [Student Name], e.Name AS [Exam Name]
	FROM StudentsExams AS st
	JOIN Students AS s
	ON s.StudentID = st.StudentID
	JOIN Exams AS e
	ON e.ExamID = st.ExamID) AS result
ORDER BY result.[Exam Name], StudentID

/* Task 4 */
CREATE TABLE Teachers(
	TeacherID INT IDENTITY(100, 1), 
	[Name] NVARCHAR(50) NOT NULL, 
	ManagerID INT,

	CONSTRAINT PK_Teachers 
	PRIMARY KEY (TeacherID),

	CONSTRAINT FK_Teachers_Mangers
	FOREIGN KEY (ManagerID)
	REFERENCES Teachers(TeacherID)
)

--Testing...

INSERT INTO Teachers
VALUES 
('John', NULL),
('Mon', NULL),
('Sofka', 101),
('Jessica', 102),
('Ted', 101)

/* Task 5 */
 CREATE TABLE Cities(
	CityID INT IDENTITY, 
	[Name] NVARCHAR(50) NOT NULL, 

	CONSTRAINT PK_Cities
	PRIMARY KEY (CityID)
 )

 CREATE TABLE Customers(
	CustomerID INT IDENTITY, 
	[Name] NVARCHAR(50) NOT NULL, 
	Birthday DATE NOT NULL, 
	CityID INT NOT NULL, 

	CONSTRAINT PK_Customers 
	PRIMARY KEY (CustomerID),

	CONSTRAINT FK_Customers_Cities
	FOREIGN KEY (CityID)
	REFERENCES Cities(CityID)
 )

 CREATE TABLE Orders(
	OrderID INT IDENTITY, 
	CustomerID INT NOT NULL,

	CONSTRAINT PK_Orders
	PRIMARY KEY (OrderID),

	CONSTRAINT FK_Orders_Customers
	FOREIGN KEY (CustomerID)
	REFERENCES Customers(CustomerID)
 )

 CREATE TABLE ItemTypes(
	ItemTypeID INT IDENTITY, 
	[Name] NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_ItemTypes
	PRIMARY KEY (ItemTypeID)
 )

 CREATE TABLE Items(
	ItemID INT IDENTITY, 
	[Name] NVARCHAR(50) NOT NULL, 
	ItemTypeID INT NOT NULL,

	CONSTRAINT PK_Items
	PRIMARY KEY (ItemID), 

	CONSTRAINT FK_Items_ItemTypes
	FOREIGN KEY (ItemTypeID)
	REFERENCES ItemTypes(ItemTypeID)
 )

 CREATE TABLE OrderItems(
	OrderID INT NOT NULL, 
	ItemID INT NOT NULL, 

	CONSTRAINT PK_OrderItems
	PRIMARY KEY(OrderID, ItemID),

	CONSTRAINT FK_Orders
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),

    CONSTRAINT FK_ITEMS
	FOREIGN KEY (ItemID)
	REFERENCES Items(ItemID)
 )

/* Task 6 */
--USE University
CREATE TABLE Majors(
	MajorID INT IDENTITY, 
	Name NVARCHAR(64) NOT NULL,

	CONSTRAINT PK_Majors
	PRIMARY KEY (MajorID)
)

CREATE TABLE Students(
	StudentID INT IDENTITY, 
	StudentNumber BIGINT NOT NULL, 
	StudentName NVARCHAR(64) NOT NULL, 
	MajorID INT NOT NULL, 

	CONSTRAINT PK_Students
	PRIMARY KEY (StudentID),

	CONSTRAINT FK_Students_Majors
	FOREIGN KEY (MajorID)
	REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
	PaymentID INT IDENTITY, 
	PaymentDate DATE NOT NULL, 
	PaymentAmount DECIMAL(15,2) NOT NULL,
	StudentID INT NOT NULL, 

	CONSTRAINT PK_Payments
	PRIMARY KEY (PaymentID),

	CONSTRAINT FK_Payments_Students
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID)
)

CREATE TABLE Subjects(
	SubjectID INT IDENTITY, 
	SubjectName NVARCHAR(64),

	CONSTRAINT PK_Subjects
	PRIMARY KEY (SubjectID)
)

CREATE TABLE Agenda(
	StudentID INT NOT NULL, 
	SubjectID INT NOT NULL,

	CONSTRAINT PK_Agenda
	PRIMARY KEY (StudentID, SubjectID),

	CONSTRAINT FK_Students
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID), 

	CONSTRAINT FK_Subject
	FOREIGN KEY (SubjectID)
	REFERENCES Subjects(SubjectID)
)

/* Task 9 */
--USE Geography

SELECT m.MountainRange, p.PeakName, p.Elevation 
FROM Peaks AS p
JOIN Mountains AS m
ON m.Id = p.MountainId
WHERE m.MountainRange = 'RILA'
ORDER BY p.Elevation DESC