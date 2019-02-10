WITH CTE_Genders(ID, TownName, Gender, GenderCount, TotalCount )
AS
(
	SELECT
		t.Id,
		t.Name, 
		c.Gender,
		COUNT(c.Gender) OVER(PARTITION BY t.Id, c.Gender),
		COUNT(c.Gender) OVER(PARTITION BY t.Id)
	FROM Towns AS t
	JOIN Orders AS o
	ON o.TownId = t.Id
	JOIN Clients AS c
	ON c.Id = o.ClientId
),

CTE_Percentages
AS
(
	SELECT DISTINCT
	c.ID,
	c.TownName, 
	CASE
		WHEN c.Gender = 'M' THEN CONVERT(INT, c.GenderCount * 100.0 / c.TotalCount, 0)
	END AS MalePercent,
	CASE
		WHEN c.Gender = 'F' THEN CONVERT(INT, c.GenderCount * 100.0 / c.TotalCount, 0)
	END AS FemalePercent
    FROM CTE_Genders AS c

)

SELECT 
	p.TownName, 
	SUM(p.MalePercent) AS MalePercent, 
	SUM(p.FemalePercent) AS FemalePercent
FROM CTE_Percentages AS p 
GROUP BY p.TownName, p.ID
ORDER BY p.TownName, p.ID