CREATE FUNCTION udf_GetPromotedProducts(@CurrentDate DATETIME, @StartDate DATETIME, @EndDate DATETIME, @Discount DECIMAL, @FirstItemId INT, @SecondItemId INT, @ThirdItemId INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @products TABLE (Id INT, [Name] NVARCHAR(MAX), Price DECIMAL(15,2)); 

	INSERT INTO @products
	SELECT i.Id, i.Name, i.Price 
	FROM Items AS i
	WHERE i.ID IN(@FirstItemId, @SecondItemId, @ThirdItemId)

	DECLARE @rows INT = (SELECT COUNT(*) FROM @products)

	IF (@rows < 3)
		RETURN 'One of the items does not exists!';
	IF (@CurrentDate < @StartDate OR @CurrentDate > @EndDate)
		RETURN 'The current date is not within the promotion dates!';

	UPDATE @products
	SET Price -= Price * (@Discount / 100.0); 
	
	DECLARE @FirstItemName NVARCHAR(MAX) = (SELECT i.[Name] FROM @products AS i WHERE i.Id = @FirstItemId);
	DECLARE @SecondItemName NVARCHAR(MAX) = (SELECT i.[Name] FROM @products AS i WHERE i.Id = @SecondItemId);
	DECLARE @ThirdItemName NVARCHAR(MAX) = (SELECT i.[Name] FROM @products AS i WHERE i.Id = @ThirdItemId);

	DECLARE @FirstItemPRICE NVARCHAR(MAX) = (SELECT i.Price FROM @products AS i WHERE i.Id = @FirstItemId);
	DECLARE @SecondItemPRICE NVARCHAR(MAX) = (SELECT i.Price FROM @products AS i WHERE i.Id = @SecondItemId);
	DECLARE @ThirdItemPRICE NVARCHAR(MAX) = (SELECT i.Price FROM @products AS i WHERE i.Id = @ThirdItemId);

	RETURN CONCAT(@FirstItemName, ' price: ', @FirstItemPRICE, ' <-> ', @SecondItemName, ' price: ', @SecondItemPRICE,' <-> ', @ThirdItemName, ' price: ',@ThirdItemPRICE)
END