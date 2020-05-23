-- Author: Harsh Arora

USE master;
GO

--Master encryption key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'xxxxxxxxxxxxxxxxxx';
GO

--Certificat to latter encrypt database master key
CREATE CERTIFICATE TDE WITH SUBJECT = 'My TDE Certificate';
GO

SELECT * FROM sys.certificates
WHERE name = 'TDE'
GO

--Demo database
CREATE DATABASE [Your Database Name] 
GO

USE [Your Database Name] 
GO

--Database encrytpion key defended by TDE certificate
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDE;
GO

--Activate TDE
ALTER DATABASE [Your Database Name] 
SET ENCRYPTION ON;
GO

--Try detaching database and attach it on another server or instance, it will fail

--Deactivate TDE
ALTER DATABASE [Your Database Name] 
SET ENCRYPTION OFF;
GO

--Cleaning
DROP CERTIFICATE TDE
GO

DROP DATABASE ENCRYPTION KEY 
GO

USE master
GO

DROP CERTIFICATE TDE
GO

DROP MASTER KEY
GO
DROP DATABASE [Your Database Name] 
GO