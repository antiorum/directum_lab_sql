USE productsdb;

select avg(price) as Average_Price FROM Products

SELECT AVG(Price) FROM Products
WHERE Manufacturer='Apple Inc.'

SELECT COUNT(*) FROM Products

SELECT COUNT(Manufacturer) FROM Products

SELECT MIN(Price) as Min_Price FROM Products

SELECT MAX(Price) as Max_Price FROM Products

SELECT SUM(ProductCount * Price) FROM Products

SELECT AVG(DISTINCT ProductCount) AS Average_Price FROM Products

SELECT COUNT(*) AS ProdCount,
       SUM(ProductCount) AS TotalCount,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice,
       AVG(Price) AS AvgPrice
FROM Products

SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM Products
GROUP BY Manufacturer

SELECT Manufacturer, ProductCount, COUNT(*) AS ModelsCount
FROM Products
GROUP BY Manufacturer, ProductCount

SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM Products
WHERE Price > 30000
GROUP BY Manufacturer
ORDER BY ModelsCount DESC

SELECT Manufacturer, COUNT(*) AS ModelsCount, sum(ProductCount) as Units
FROM Products
WHERE Price * ProductCount > 80000
GROUP BY Manufacturer
HAVING COUNT(*) > 1
order by Units desc

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY ROLLUP(Manufacturer)

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY Manufacturer, ProductCount WITH ROLLUP

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY Manufacturer, ProductCount WITH CUBE

SELECT Manufacturer, COUNT(*) AS Models, 
        ProductCount, SUM(ProductCount) AS Units
FROM Products
GROUP BY GROUPING SETS(ROLLUP(Manufacturer), ProductCount)

SELECT Manufacturer, COUNT(*) AS Models, 
        ProductCount, SUM(ProductCount) AS Units
FROM Products
GROUP BY GROUPING SETS((Manufacturer, ProductCount), ProductCount)

SELECT ProductName, Manufacturer, ProductCount,
        COUNT(*) OVER (PARTITION BY Manufacturer) AS Models,
        SUM(ProductCount) OVER (PARTITION BY Manufacturer) AS Units
FROM Products