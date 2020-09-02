CREATE TABLE customers
(
    Id SERIAL PRIMARY KEY,
    FirstName CHARACTER VARYING(30),
    LastName CHARACTER VARYING(30),
    Email CHARACTER VARYING(30),
    Age INTEGER
);

drop  table customers cascade;

CREATE TABLE Customers
(
    Id SERIAL,
    Age INTEGER,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Email VARCHAR(30),
    Phone VARCHAR(20),
    CONSTRAINT customer_Id PRIMARY KEY(Id),
    CONSTRAINT customers_age_check CHECK(Age >0 AND Age < 100),
    CONSTRAINT customers_email_key UNIQUE(Email),
    CONSTRAINT customers_phone_key UNIQUE(Phone)
);

drop table Orders;

CREATE TABLE Orders
(
    Id SERIAL PRIMARY KEY,
    CustomerId INTEGER,
    Quantity INTEGER,
    FOREIGN KEY (CustomerId) REFERENCES Customers (Id)
    --on delete set null, cascade, set default, restrict
);

ALTER TABLE Customers
ADD Address CHARACTER VARYING(30) NOT NULL DEFAULT 'Неизвестно';

ALTER TABLE Customers
DROP COLUMN Address;

ALTER TABLE Customers
ALTER COLUMN FirstName TYPE VARCHAR(50);

ALTER TABLE Customers
ALTER COLUMN FirstName
SET NOT NULL;

ALTER TABLE Customers
ALTER COLUMN FirstName
DROP NOT NULL;

ALTER TABLE Customers
ADD CHECK (Age > 0);

ALTER TABLE Customers
ADD CONSTRAINT phone_unique UNIQUE (Phone);

--ALTER TABLE Customers
--RENAME COLUMN Address TO City;

ALTER TABLE Customers
RENAME TO Users;

select * from Users


CREATE TABLE Products
(
    Id SERIAL PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INTEGER DEFAULT 0,
    Price NUMERIC
);


INSERT INTO Products VALUES (1, 'Galaxy S9', 'Samsung', 4, 63000)

select * from Products

delete from Products where id = 1
INSERT INTO Products
(ProductName, Manufacturer, Price, ProductCount)
VALUES('Desire 12', 'HTC', 8, 21000) RETURNING id;

select * from Products

truncate table Products

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES
('iPhone X', 'Apple', 3, 36000),
('iPhone 8', 'Apple', 2, 41000),
('Galaxy S9', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Desire 12', 'HTC', 5, 28000);

SELECT ProductCount AS Title,
Manufacturer,
Price * ProductCount  AS TotalSum
FROM Products;

SELECT * FROM Products
WHERE Manufacturer = 'Samsung' AND Price > 50000;

--and имеет больший приоритет чем or
SELECT * FROM Products
WHERE Manufacturer = 'Samsung' OR Price > 30000 AND ProductCount > 2;

SELECT * FROM Products
WHERE (Manufacturer = 'Samsung' OR Price > 30000) AND ProductCount > 2;

SELECT * FROM Products
WHERE ProductCount IS NULL;

UPDATE Products
SET Manufacturer = 'Samsung Inc.'
WHERE Manufacturer = 'Samsung';

SELECT * FROM Products

DELETE FROM Products
WHERE Manufacturer='HTC' AND Price < 15000;

SELECT * FROM Products

SELECT DISTINCT Manufacturer FROM Products;


SELECT * FROM Products
ORDER BY ProductCount;

SELECT ProductName, ProductCount * Price AS TotalSum
FROM Products
ORDER BY TotalSum;

SELECT ProductName, Price, ProductCount
FROM Products
ORDER BY ProductCount * Price;

SELECT ProductName, Manufacturer
FROM Products
ORDER BY Manufacturer DESC;

SELECT ProductName, Price, Manufacturer
FROM Products
ORDER BY Manufacturer ASC, ProductName DESC;

SELECT * FROM Products
ORDER BY ProductName
LIMIT 3 OFFSET 2;

SELECT * FROM Products
WHERE Manufacturer IN ('Samsung', 'HTC', 'Huawei');

SELECT * FROM Products
WHERE Manufacturer NOT IN ('Samsung', 'HTC', 'Huawei');

SELECT * FROM Products
WHERE Price BETWEEN 20000 AND 50000;

SELECT * FROM Products
WHERE ProductName LIKE 'iPhone%';


SELECT AVG(Price) AS Average_Price FROM Products;

SELECT COUNT(DISTINCT Manufacturer) FROM Products;

SELECT MIN(Price) FROM Products;

SELECT BOOL_OR(IsDiscounted) FROM Products;
SELECT BOOL_AND(IsDiscounted) FROM Products;

SELECT STRING_AGG(ProductName, ', ') FROM Products;

SELECT manufacturer, ProductCount, COUNT(*) AS ModelsCount
FROM Products
GROUP BY manufacturer, ProductCount;

SELECT manufacturer, COUNT(*) AS Models, ProductCount
FROM Products
GROUP BY GROUPING SETS(manufacturer, ProductCount);

SELECT manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY ROLLUP(manufacturer);

alter table Products
rename manufacturer to Company

SELECT Company, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY CUBE(Company, ProductCount);


CREATE TABLE Customers
(
    Id SERIAL PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
    Id SERIAL PRIMARY KEY,
    ProductId INTEGER NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
    CustomerId INTEGER NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
    CreatedAt DATE NOT NULL,
    ProductCount INTEGER DEFAULT 1,
    Price NUMERIC NOT NULL
);

INSERT INTO Customers(FirstName)
VALUES ('Tom'), ('Bob'),('Sam');

INSERT INTO Orders(ProductId, CustomerId, CreatedAt, ProductCount, Price)
VALUES
(
    (SELECT Id FROM Products WHERE ProductName='Galaxy S9'),
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-11',
    2,
    (SELECT Price FROM Products WHERE ProductName='Galaxy S9')
),
(
    (SELECT Id FROM Products WHERE ProductName='iPhone 8'),
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-13',
    1,
    (SELECT Price FROM Products WHERE ProductName='iPhone 8')
),
(
    (SELECT Id FROM Products WHERE ProductName='iPhone 8'),
    (SELECT Id FROM Customers WHERE FirstName='Bob'),
    '2017-07-11',
    1,
    (SELECT Price FROM Products WHERE ProductName='iPhone 8')
);

SELECT *
FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);

SELECT  CreatedAt,
        Price,
        (SELECT ProductName FROM Products
        WHERE Products.Id = Orders.ProductId) AS Product
FROM Orders;

SELECT ProductName,
       Company,
       Price,
        (SELECT AVG(Price) FROM Products AS SubProds
         WHERE SubProds.Company=Prods.Company)  AS AvgPrice
FROM Products AS Prods
WHERE Price >
    (SELECT AVG(Price) FROM Products AS SubProds
     WHERE SubProds.Company=Prods.Company)

create table posts(
    id serial primary key,
    title varchar(30),
    body text,
    tags varchar(10)[]
);

insert into posts(title, body, tags)
values('Post Title', 'Post Text', '{"sql", "postgres", "database", "plsql"}');


select tags from posts;
select tags[0:3] from posts;

update posts
set tags='{}'
where id=1;

update posts
set tags='{"sql", "postgres", "database"}'
where id=1;

update posts
set tags[2]='system'
where id=1;

select tags from posts;

create type request_state as enum ('created', 'approved', 'finshed');
create table requests(
    id serial primary key,
    title varchar(30),
    status request_state
);

insert into requests(title, status)
values ('Request 1', 'created');

update requests
set status='approved'
where id=1;

ALTER TYPE request_state ADD VALUE 'blocked';

DROP TYPE request_state;
