INSERT INTO Employees(FirstName, LastName, Gender, Birthdate, DepartmentId)
VALUES
('Marlo', 'O’Malley', 'M', CONVERT(datetime, '9/21/1958'), 1),
('Niki', 'Stanaghan', 'F', CONVERT(datetime, '11/26/1969'), 4),
('Ayrton', 'Senna', 'M', CONVERT(datetime, '03/21/1960'), 9),
('Ronnie', 'Peterson', 'M', CONVERT(datetime, '02/14/1944'), 9),
('Giovanna', 'Amati', 'F', CONVERT(datetime, '07/20/1959'), 5)


INSERT INTO Reports(CategoryId, StatusId, OpenDate, CloseDate, [Description], UserId, EmployeeId)
VALUES
(1, 1, CONVERT(datetime, '04/13/2017'), NULL, 'Stuck Road on Str.133', 6, 2),
(6, 3, CONVERT(datetime, '09/05/2015'),CONVERT(datetime, '12/06/2015'), 'Charity trail running', 3, 5),
(14, 2, CONVERT(datetime, '09/07/2015'), NULL, 'Falling bricks on Str.58', 5, 2),
(4, 3, CONVERT(datetime, '07/03/2017'),CONVERT(datetime, '07/06/2017') , 'Cut off streetlight on Str.11', 1, 1)
