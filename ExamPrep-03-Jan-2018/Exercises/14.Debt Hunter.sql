WITH CTE_ClientsPerTown(ID, Names, Email, Bill, Town, [RANK])
AS
(
	SELECT
		c.Id,
		c.FirstName + ' ' + c.LastName, 
		c.Email, 
		o.Bill, 
		t.[Name],
		DENSE_RANK() OVER (PARTITION BY t.[Name] ORDER BY o.Bill DESC) 
	FROM CLIENTS AS c
	JOIN Orders AS o
	ON o.ClientId = c.Id
	JOIN Towns AS t
	ON t.Id = o.TownId
	WHERE c.CardValidity < o.CollectionDate AND o.Bill IS NOT NULL
)

SELECT c.Names, c.Email, c.Bill, c.Town 
FROM CTE_ClientsPerTown AS c
WHERE c.[RANK] <= 2
ORDER BY c.Town, c.Bill ASC, c.ID