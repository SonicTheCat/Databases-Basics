USE Movies

CREATE TABLE Directors(
    Id INT IDENTITY, 
    DirectorName NVARCHAR(50) NOT NULL, 
    Notes NVARCHAR(MAX), 
    CONSTRAINT PK_Director PRIMARY KEY (Id) 
)

INSERT INTO Directors VALUES
('Q. Tarantino', NULL),
('Christopher Nolan', NULL),
('Mel Gibbson', NULL),
('Lana Wachowski', NULL),
('David Fincher', NULL)

SELECT * FROM Directors

CREATE TABLE Genres(
    Id INT IDENTITY, 
    GenreName NVARCHAR(50) NOT NULL, 
    Notes NVARCHAR(MAX),
    CONSTRAINT PK_Genre PRIMARY KEY (Id)
)

INSERT INTO Genres VALUES
('Drama', NULL),
('Comedy', NULL),
('Crime', NULL),
('Horror', NULL),
('Action', NULL)

--SELECT * FROM Genres

CREATE TABLE Categories(
    Id INT IDENTITY, 
    CategoryName NVARCHAR(50) NOT NULL, 
    Notes NVARCHAR(MAX),
    CONSTRAINT PK_Category PRIMARY KEY (Id)
)

INSERT INTO Categories VALUES
('A', NULL),
('B', NULL),
('C', NULL),
('D', NULL),
('F', NULL)

SELECT * FROM Categories

CREATE TABLE Movies(
    Id INT IDENTITY, 
    Title NVARCHAR(150) NOT NULL, 
    DirectorId INT NOT NULL, 
    CopyrightYear INT NOT NULL, 
    [Length] INT NOT NULL,  
    GenreId INT NOT NULL, 
    CategoryId INT NOT NULL, 
    Rating NUMERIC(2, 1), 
    Notes NVARCHAR(MAX), 
    CONSTRAINT PK_Movie PRIMARY KEY (Id), 
    CONSTRAINT FK_Director FOREIGN KEY (DirectorId) REFERENCES Directors (Id), 
    CONSTRAINT FK_Genre FOREIGN KEY (GenreId) REFERENCES Genres (Id), 
    CONSTRAINT FK_Category FOREIGN KEY (CategoryId) REFERENCES Categories (Id), 
    CONSTRAINT CHK_Movie_Length CHECK ([Length] > 0),
    CONSTRAINT CHK_Rating_Value CHECK (Rating <= 10)
)

--SELECT * FROM Movies

INSERT INTO Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
VALUES
('Pulp Fiction', 1, 1994, 120, 3, 1, 9.1, 'Very good movie!'),
('Seven', 5, 1994, 120, 4, 1, 7.2, 'Scary movie'),
('Inception', 2, 2010, 134, 1, 3, 9.9, NULL),
('Matrix', 4, 1994, 100, 5, 1, 7.0, NULL),
('Fight Club', 5, 1994, 120, 1, 1, 8.9, 'Nice one')
