ALTER TABLE Users
ADD CONSTRAINT DF_Last_Login DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO Users(Username, Password, ProfilePicture, IsDeleted) VALUES
('Marinka', 'SECRETPASSWORD', NULL, 1)

SELECT * FROM Users