CREATE TABLE Users(
        Id BIGINT IDENTITY, 
        Username VARCHAR(30) NOT NULL, 
        [Password] VARCHAR(26) NOT NULL, 
        ProfilePicture VARBINARY(MAX), 
        LastLoginTime SMALLDATETIME,
        IsDeleted BIT
        CONSTRAINT PK_User_Id PRIMARY KEY (Id),
        CONSTRAINT UQ_Username UNIQUE(Username),
        CONSTRAINT CK_ProfilePicture CHECK (DATALENGTH(ProfilePicture) <= 900 * 1024)
)

INSERT INTO Users VALUES
('goshoOtPochivka', 'parolata', NULL, NULL, 1),
('pesho', 'parolata', NULL, NULL, 0),
('ivan', 'parolata', NULL, NULL, 1),
('dragan', 'parolata', NULL, NULL, 44),
('rrr', 'parolata', NULL, NULL,-1)

Select * from Users