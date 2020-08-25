USE productsdb;
--GO
--CREATE TRIGGER Products_INSERT_UPDATE
--ON Products
--AFTER INSERT, UPDATE
--AS
--UPDATE Products
--SET Price = Price + Price * 0.38
--WHERE Id = (SELECT Id FROM inserted)

--insert into Products values ('xioami 3s', 'Xiaomi' ,666 , 7777);
--select * from Products;

--DISABLE TRIGGER Products_INSERT_UPDATE ON Products
--insert into Products values ('xioami 3s', 'Xiaomi' ,666 , 7777);
--ENABLE TRIGGER Products_INSERT_UPDATE ON Products
--select * from Products;

--DROP TRIGGER Products_INSERT_UPDATE



--INSERT TRIGGERS
--CREATE TABLE History 
--(
--    Id INT IDENTITY PRIMARY KEY,
--    ProductId INT NOT NULL,
--    Operation NVARCHAR(200) NOT NULL,
--    CreateAt DATETIME NOT NULL DEFAULT GETDATE(),
--);

--GO
--CREATE TRIGGER Products_INSERT
--ON Products
--AFTER INSERT
--AS
--INSERT INTO History (ProductId, Operation)
--SELECT Id, 'Добавлен товар ' + ProductName + '   фирма ' + Manufacturer
--FROM INSERTED

--INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
--VALUES('iPhone X', 'Apple', 2, 79900)
 
--SELECT * FROM History

--GO
--CREATE TRIGGER Products_DELETE
--ON Products
--AFTER DELETE
--AS
--INSERT INTO History (ProductId, Operation)
--SELECT Id, 'Удален товар ' + ProductName + '   фирма ' + Manufacturer
--FROM DELETED

--DELETE FROM Products
--WHERE Id=2
 
--SELECT * FROM History

--GO
--CREATE TRIGGER Products_UPDATE
--ON Products
--AFTER UPDATE
--AS
--INSERT INTO History (ProductId, Operation)
--SELECT Id, 'Обновлен товар ' + ProductName + '   фирма ' + Manufacturer
--FROM INSERTED

insert into Products values ('c350', 'Motorola', 777, 10050)
insert into Products values ('c3880', 'Motorola', 777, 10050)
update Products set Manufacturer='Moto'
where Manufacturer='Motorola';

SELECT * FROM History





-- TRigger INSTEAD OF

--CREATE DATABASE prods;
--GO
USE prods;
--CREATE TABLE Products
--(
--    Id INT IDENTITY PRIMARY KEY,
--    ProductName NVARCHAR(30) NOT NULL,
--    Manufacturer NVARCHAR(20) NOT NULL,
--    Price MONEY NOT NULL,
--    IsDeleted BIT NULL
--);

--GO
--CREATE TRIGGER products_delete
--ON Products
--INSTEAD OF DELETE
--AS
--UPDATE Products
--SET IsDeleted = 1
--WHERE ID =(SELECT Id FROM deleted)

--INSERT INTO Products(ProductName, Manufacturer, Price)
--VALUES ('iPhone X', 'Apple', 79000),
--('Pixel 2', 'Google', 60000);
 
--DELETE FROM Products 
--WHERE ProductName='Pixel 2';
 
SELECT * FROM Products;