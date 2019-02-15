CREATE PROCEDURE usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS 
BEGIN 
	DECLARE @currentHotelID INT = 
	(
		SELECT DISTINCT h.Id
		FROM Trips AS t
		JOIN AccountsTrips AS at
		ON at.TripId = t.Id
		JOIN Accounts AS a
		ON a.Id = at.AccountId
		JOIN Rooms AS r
		ON r.Id = t.RoomId
		JOIN Hotels AS h
		ON h.Id = r.HotelId
		WHERE t.Id = @TripId
	)

	DECLARE @newHotelID INT =
	(
		SELECT DISTINCT r.HotelId 
		FROM Rooms AS r
		JOIN Hotels AS h
		ON h.Id  = r.Id
		WHERE r.Id = @TargetRoomId	
	)
	BEGIN TRANSACTION 
		
	IF(@currentHotelID <> @newHotelID)
	BEGIN 
		RAISERROR('Target room is in another hotel!', 16, 1); 
		ROLLBACK;
		RETURN; 
	END 

	DECLARE @bedsInRoom INT = (SELECT Beds FROM Rooms WHERE Id = @TargetRoomId); 
	DECLARE @countOfPeople INT = 
	(
		SELECT COUNT(*)
		FROM Trips AS t
		JOIN AccountsTrips AS at
		ON at.TripId = t.Id
		JOIN Accounts AS a
		ON a.Id = at.AccountId
		WHERE t.Id = 10
	)

	IF(@bedsInRoom < @countOfPeople)
	BEGIN 
		RAISERROR('Not enough beds in target room!', 16, 1); 
		ROLLBACK;
		RETURN; 
	END 

	UPDATE Trips 
	SET RoomId = @TargetRoomId
	WHERE Id = @TripId

	COMMIT;
END