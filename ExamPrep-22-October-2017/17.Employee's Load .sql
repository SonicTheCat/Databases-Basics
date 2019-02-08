CREATE FUNCTION udf_GetReportsCount(@employeeId INT, @statusId INT)
RETURNS INT 
AS
BEGIN 
	DECLARE @reportsCount INT =
	(
		SELECT COUNT(r.StatusId) 
		FROM Reports AS r
		WHERE r.EmployeeId = @employeeId
		AND r.StatusId = @statusId
		GROUP BY r.EmployeeId
	)
	
	RETURN COALESCE(@reportsCount, 0);
END


SELECT dbo.udf_GetReportsCount(18,5)