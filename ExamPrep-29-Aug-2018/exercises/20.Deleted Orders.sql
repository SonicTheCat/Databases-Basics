CREATE TRIGGER t_DeleteOrders
ON OrderItems 
AFTER DELETE
AS
BEGIN
	INSERT INTO DeletedOrders
	SELECT d.OrderId, d.ItemId, d.Quantity
	FROM deleted AS d
END