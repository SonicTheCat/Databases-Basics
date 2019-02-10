CREATE OR ALTER PROCEDURE usp_MoveVehicle(@vehicleId INT, @officeId INT)
AS 
BEGIN
	DECLARE @usedPlaces INT =  
	(
		SELECT TOP 1 
			 COUNT(*) OVER (PARTITION BY v.OFFICEID)
		FROM Vehicles AS v
		JOIN Offices AS o
			ON o.Id = v.OfficeId
		WHERE v.OfficeId = @officeId
	)

	DECLARE @parkingPlaces INT = 
	(
		SELECT ofi.ParkingPlaces 
		FROM Offices AS ofi
		WHERE ofi.Id = @officeId
	)

	BEGIN TRANSACTION 
	IF(@parkingPlaces <= @usedPlaces)
	BEGIN 
		ROLLBACK; 
		RAISERROR('Not enough room in this office!', 16, 2); 
		RETURN;
	END

	UPDATE Vehicles
	SET OfficeId = @officeId 
	WHERE Id = @vehicleId

	COMMIT
END	
