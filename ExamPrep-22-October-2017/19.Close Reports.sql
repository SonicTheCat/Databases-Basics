CREATE TRIGGER tr_ChangeStatus 
ON Reports 
AFTER UPDATE
AS 
BEGIN 
	UPDATE Reports 
	SET StatusId = 
	(
		SELECT s.Id
		FROM [Status] AS s
		WHERE s.Label = 'completed'
	)
	FROM Reports AS r
	JOIN inserted AS i
	ON i.Id = r.Id
	WHERE i.CloseDate IS NOT NULL
END

UPDATE Reports
SET CloseDate = GETDATE()
WHERE EmployeeId = 5;