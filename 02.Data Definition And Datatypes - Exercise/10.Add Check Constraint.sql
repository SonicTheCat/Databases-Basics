ALTER TABLE Users
ADD CONSTRAINT CK_Password_Lenght CHECK (DATALENGTH([Password]) >= 5)
--  OR CHECK (LEN([Password]) >= 5)

SELECT * FROM Users 