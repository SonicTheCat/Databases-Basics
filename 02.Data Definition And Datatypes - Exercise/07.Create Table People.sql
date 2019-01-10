CREATE TABLE People(
    Id INT IDENTITY, 
    [Name] NVARCHAR(200) NOT NULL, 
    Picture VARBINARY(MAX), 
    Height DECIMAL(3, 2), 
    [Weight] DECIMAL(5, 2),
    Gender CHAR(1) NOT NULL, 
    BirthDate DATE NOT NULL, 
    Biography NVARCHAR(MAX),
    CONSTRAINT PK_PeopleId PRIMARY KEY (Id),
    CONSTRAINT CK_Picture_Size CHECK (DATALENGTH(Picture) > 1024 * 1024 * 2),
    CONSTRAINT CK_Person_Gender CHECK (Gender = 'm' OR Gender = 'f')
)

INSERT INTO People VALUES
('Maria', NULL, 2, 100, 'm', '2000/12/31', NULL),
('Penka', NULL, 2.10, 220, 'f', '1980/02/10', 'hello'),
('Stoyanka', NULL, 1.69, 55.03, 'f', '1993/03/17', 'ne mi znaish istoriqta !1!11!!!!'),
('jay-z', NULL, 1.90, 150.4, 'm', '1970/12/31', NULL), 
('beyonce', NULL, 1.77, 66, 'f', '1970/12/31', NULL)


SELECT * FROM People