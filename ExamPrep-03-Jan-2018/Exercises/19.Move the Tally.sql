CREATE TRIGGER tr_UpdateMileage 
ON Orders 
AFTER UPDATE 
AS
BEGIN 
	BEGIN TRANSACTION 

	DECLARE @vehicleID INT = (SELECT inserted.VehicleId FROM inserted);
	DECLARE @insertedMileage INT = (SELECT inserted.TotalMileage FROM inserted);
	DECLARE @deletedMileage INT = (SELECT deleted.TotalMileage FROM deleted);

	IF(@deletedMileage IS NOT NULL)
	BEGIN 
		ROLLBACK; 
		RETURN; 
	END

	UPDATE Vehicles
	SET Mileage += @insertedMileage
	WHERE Id = @vehicleID

	COMMIT
END