/*create database usersdb;*/
go
use usersdb;

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL 
  DROP TABLE dbo.Orders; 

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL 
  DROP TABLE dbo.Customers;

CREATE TABLE Customers
(
    Id INT,
    Age INT,
    FirstName NVARCHAR(20),
    LastName NVARCHAR(20),
    Email VARCHAR(30),
    Phone VARCHAR(20)
);

exec sp_rename 'Customers', 'People';
exec sp_rename 'People', 'Customers';

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL 
  DROP TABLE dbo.Customers;

CREATE TABLE Customers
(
    Id INT IDENTITY,
    Age INT CONSTRAINT DF_Customer_Age DEFAULT 18, 
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    Email VARCHAR(30),
    Phone VARCHAR(20),
    CONSTRAINT PK_Customer_Id PRIMARY KEY (Id), 
    CONSTRAINT CK_Customer_Age CHECK(Age >0 AND Age < 100),
    CONSTRAINT UQ_Customer_Email UNIQUE (Email),
    CONSTRAINT UQ_Customer_Phone UNIQUE (Phone)
)

CREATE TABLE Orders
(
    Id INT PRIMARY KEY IDENTITY,
    CustomerId INT,
    CreatedAt Date,
    CONSTRAINT FK_Orders_To_Customers FOREIGN KEY (CustomerId)  REFERENCES Customers (Id)
)

ALTER TABLE Customers
ADD Address NVARCHAR(50) null;

ALTER TABLE Customers
DROP COLUMN Address;

ALTER TABLE Customers
ALTER COLUMN FirstName NVARCHAR(200);

ALTER TABLE Orders
DROP FK_Orders_To_Customers;