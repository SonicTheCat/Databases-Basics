CREATE FUNCTION  udf_CheckForVehicle(@townName NVARCHAR(MAX), @seatsNumber INT)
RETURNS NVARCHAR(MAX)
AS 
BEGIN 
	DECLARE @result NVARCHAR(MAX) = 
	(SELECT TOP (1)
		ofi.Name + ' - ' + m.Model
	FROM Towns AS t
	JOIN Offices AS ofi
	ON ofi.TownId = t.Id
	JOIN Vehicles AS v
	ON v.OfficeId = ofi.Id
	JOIN Models AS m
	ON m.Id = v.ModelId
	WHERE m.Seats = @seatsNumber AND t.Name = @townName
	ORDER BY Ofi.Name)

	RETURN ISNULL(@result, 'NO SUCH VEHICLE FOUND'); 
END

GO

SELECT dbo.udf_CheckForVehicle ('La Escondida', 9) 