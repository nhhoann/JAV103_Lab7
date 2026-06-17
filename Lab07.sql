CREATE DATABASE Lab07;
GO

USE Lab07;
GO

CREATE TABLE [User] (
    [id] NVARCHAR(50) PRIMARY KEY,    
    [password] NVARCHAR(255) NOT NULL,      
    [fullname] NVARCHAR(255) NOT NULL,     
    [admin] BIT NOT NULL DEFAULT 0,         
    [createdDate] DATETIME DEFAULT GETDATE() 
);
GO

INSERT INTO [User] ([id], [password], [fullname], [admin])
VALUES
    ('admin', '123456', 'Nguyễn Văn Admin', 1),
    ('user1', '123456', 'Trần Thị User 1', 0),
    ('user2', '123456', 'Lê Văn User 2', 0),
    ('quoc', '123456', 'Ngô Quốc Anh', 1),
    ('hoa', '123456', 'Trương Hoa Liên', 0);
GO

CREATE TABLE [AccessLog] (
    [id] INT PRIMARY KEY IDENTITY(1,1),
    [username] NVARCHAR(50),             
    [userRole] NVARCHAR(50),              
    [uri] NVARCHAR(500) NOT NULL,          
    [accessTime] DATETIME DEFAULT GETDATE(),
    [ipAddress] NVARCHAR(50)                
);
GO

CREATE TABLE [AdminAccessLog] (
    [id] INT PRIMARY KEY IDENTITY(1,1),
    [adminUsername] NVARCHAR(50) NOT NULL,
    [uri] NVARCHAR(500) NOT NULL,        
    [action] NVARCHAR(50) NOT NULL,         
    [accessTime] DATETIME DEFAULT GETDATE(), 
    [reason] NVARCHAR(255)                 
);
GO

CREATE PROCEDURE sp_GetUserById
    @userId NVARCHAR(50)
AS
BEGIN
    SELECT [id], [password], [fullname], [admin]
    FROM [User]
    WHERE [id] = @userId;
END
GO

CREATE PROCEDURE sp_LogAccess
    @username NVARCHAR(50),
    @userRole NVARCHAR(50),
    @uri NVARCHAR(500),
    @ipAddress NVARCHAR(50) = NULL
AS
BEGIN
    INSERT INTO [AccessLog] ([username], [userRole], [uri], [ipAddress])
    VALUES (@username, @userRole, @uri, @ipAddress);
END
GO

CREATE PROCEDURE sp_LogAdminAccess
    @adminUsername NVARCHAR(50),
    @uri NVARCHAR(500),
    @action NVARCHAR(50),
    @reason NVARCHAR(255) = NULL
AS
BEGIN
    INSERT INTO [AdminAccessLog] ([adminUsername], [uri], [action], [reason])
    VALUES (@adminUsername, @uri, @action, @reason);
END
GO

CREATE VIEW vw_AccessLogStats AS
SELECT 
    [username],
    [userRole],
    COUNT(*) AS [TotalAccess],
    MAX([accessTime]) AS [LastAccess]
FROM [AccessLog]
GROUP BY [username], [userRole];
GO

CREATE VIEW vw_AdminAccessStats AS
SELECT 
    [adminUsername],
    COUNT(*) AS [TotalActions],
    SUM(CASE WHEN [action] = 'SUCCESS' THEN 1 ELSE 0 END) AS [SuccessCount],
    SUM(CASE WHEN [action] = 'DENIED' THEN 1 ELSE 0 END) AS [DeniedCount]
FROM [AdminAccessLog]
GROUP BY [adminUsername];
GO

SELECT * FROM [User];
GO

SELECT * FROM [AccessLog];
GO
SELECT * FROM [AdminAccessLog];
GO

SELECT * FROM vw_AccessLogStats;
GO

SELECT * FROM vw_AdminAccessStats;
GO
