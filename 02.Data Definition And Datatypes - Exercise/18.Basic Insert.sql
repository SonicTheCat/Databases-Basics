INSERT INTO Addresses VALUES
('ул. Тинтява 17', 1),
('жк. Възраждане', 3),
('жк. Славейков', 4),
('ул. Кораб Планина', 1)

SELECT * FROM Addresses

INSERT INTO Towns VALUES
('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas')

SELECT * FROM Towns

INSERT INTO Departments VALUES
('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance')

SELECT * FROM Departments

INSERT INTO Employees VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, CONVERT([datetime], '01-02-2013',103), 3500, 1),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, CONVERT([datetime], '02-03-2014',103), 4000, 4),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, CONVERT([datetime], '28-08-2016',103), 525.25, 1), 
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, CONVERT([datetime], '09-12-2007',103), 3000, 2), 
('Peter', 'Pan', 'Pan', 'Intern', 3, CONVERT([datetime], '28-08-2016',103), 599.88, 3) 

SELECT * FROM Employees