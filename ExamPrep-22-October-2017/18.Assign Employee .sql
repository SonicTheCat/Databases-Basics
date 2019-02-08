CREATE PROCEDURE usp_AssignEmployeeToReport(@employeeId INT, @reportId INT)
AS 
BEGIN 
	DECLARE @employeeDepartmentID INT = 
	(
		SELECT e.DepartmentId 
		FROM Employees AS e 
		WHERE e.Id = @employeeId
	); 

	DECLARE @reportDepartmentID INT =
	(
		SELECT c.DepartmentId 
		FROM Reports AS r
		JOIN Categories AS c
		ON c.Id = r.CategoryId
		WHERE r.Id = @reportId	 
	);

	BEGIN TRANSACTION 

	IF(@employeeDepartmentID <> @reportDepartmentID)
	BEGIN 
		ROLLBACK; 
		RAISERROR('Employee doesn''t belong to the appropriate department!', 16, 1); 
		RETURN; 
	END

	UPDATE Reports
	SET EmployeeId = @employeeId
	WHERE Id = @reportId
	COMMIT
END

EXEC usp_AssignEmployeeToReport 17, 2;
SELECT EmployeeId FROM Reports WHERE id = 2

