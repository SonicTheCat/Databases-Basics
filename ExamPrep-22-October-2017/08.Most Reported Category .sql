SELECT c.Name, COUNT(*) 
FROM Reports AS r
JOIN Categories AS c
ON c.Id = r.CategoryId
GROUP BY c.Id, c.Name
ORDER BY COUNT(*) DESC, c.Name
