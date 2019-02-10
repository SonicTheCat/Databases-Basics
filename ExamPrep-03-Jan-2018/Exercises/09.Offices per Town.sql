SELECT t.Name, COUNT(o.Id) 
FROM Towns AS t
JOIN Offices AS o
ON o.TownId = t.Id
GROUP BY t.Id, t.Name
ORDER BY COUNT(o.Id) DESC, t.Name