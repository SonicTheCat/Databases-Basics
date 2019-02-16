CREATE PROCEDURE usp_CancelOrder(@OrderId INT , @CancelDate DATETIME)
AS
BEGIN 
	DECLARE @ORDER INT = (SELECT COUNT(*) FROM Orders WHERE Id = @OrderId);
	DECLARE @OrderDate DATETIME = (SELECT o.DateTime FROM Orders AS o WHERE Id = @OrderId);

	BEGIN TRANSACTION 

	IF (@ORDER <> 1)
	BEGIN 
		RAISERROR('The order does not exist!',16, 1); 
		RETURN; 
		ROLLBACK; 
	END

	IF(DATEADD(DAY, 3, @OrderDate) < @CancelDate)
	BEGIN 
		RAISERROR('You cannot cancel the order!',16, 2); 
		RETURN; 
		ROLLBACK; 
	END

DELETE FROM OrderItems
WHERE OrderId = @OrderId

DELETE FROM Orders
WHERE Id = @OrderId

COMMIT
END