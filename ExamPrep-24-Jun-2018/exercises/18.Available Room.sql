CREATE FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATE, @People INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN 
	DECLARE @result NVARCHAR(MAX); 
	DECLARE @bookedRooms TABLE(Id INT); 

	INSERT INTO @bookedRooms
	SELECT DISTINCT r.Id
	FROM Rooms AS r
	LEFT JOIN Trips AS t
		ON t.RoomId = r.Id
	WHERE 
		r.HotelId = @HotelId 
		AND @DATE BETWEEN t.ArrivalDate AND t.ReturnDate 
		AND t.CancelDate IS NULL

	SET @result =
	(SELECT TOP (1)
		 CONCAT('Room ', querry.Id, ': ', querry.Type, ' (', querry.Beds, ' beds', ')', ' - ', '$', querry.[Prices])  
	FROM 
	(	
		SELECT 
			r.Id,
			r.[Type], 
			r.Beds, 
			(h.BaseRate + r.PRICE) * @People AS [Prices]
		FROM Hotels AS h
		JOIN Rooms AS r
			ON r.HotelId = h.Id
		JOIN Trips AS t
			ON t.RoomId = r.Id
		WHERE
			r.Id NOT IN (SELECT Id FROM @bookedRooms)
			AND h.Id = @HotelId 
			AND r.Beds >= @People
	) AS querry
	ORDER BY querry.[Prices] DESC)

	IF(@result IS NULL)
	BEGIN 
		RETURN 'No rooms available'; 
	END

	RETURN @result; 
END	
