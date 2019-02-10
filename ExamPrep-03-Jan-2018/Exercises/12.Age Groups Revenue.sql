WITH CTE_Clients(Id, [Year])
AS
(
	SELECT 
		c.Id,
		CASE
			WHEN YEAR(c.BirthDate) BETWEEN 1970 AND 1979 THEN '70''s'
			WHEN YEAR(c.BirthDate) BETWEEN 1980 AND 1989 THEN '80''s'
			WHEN YEAR(c.BirthDate) BETWEEN 1990 AND 1999 THEN '90''s'
			ELSE 'Others'
		END AS [Year]
	FROM Clients AS c
)

SELECT c.[Year] AS AgeGroup, SUM(o.Bill) AS Revenue, AVG(o.TotalMileage) AS AverageMileage
FROM Orders AS o
JOIN CTE_Clients AS c
ON c.Id = o.ClientId
GROUP BY c.[Year]
ORDER BY c.[Year]