use directumlabdb;

GO
CREATE TRIGGER orders_check_customer_and_seller
ON Orders
INSTEAD OF INSERT
AS
	DECLARE @id int, @description NVARCHAR(4000), @summ MONEY, @orderDateTime DATETIME2, @customerId INT, @sellerId INT, @customerCity NVARCHAR(200), @sellerCity NVARCHAR(200);
	DECLARE @CURSOR CURSOR
	SET @CURSOR = CURSOR SCROLL 
	FOR 
	SELECT Id, Description, Summ, OrderDateTime, CustomerId, SellerId FROM INSERTED ORDER BY Id
	OPEN @CURSOR
	FETCH NEXT FROM @CURSOR INTO @id, @description, @summ, @orderDateTime, @customerId, @sellerId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @customerCity = (select City from Customers where Id = @customerId)
			SET @sellerCity = (select City from Sellers where Id = @sellerId)
				IF @customerCity = @sellerCity
					BEGIN 
						INSERT INTO Orders
						VALUES (@description, @summ , @orderDateTime, @customerId, @sellerId)
					END;	
				ELSE
					PRINT 'CUSTOMER AND CELLER MUST BE FROM SAME CITY'
			FETCH NEXT FROM @CURSOR INTO @id, @description, @summ, @orderDateTime, @customerId, @sellerId
		END
	CLOSE @CURSOR

GO
CREATE PROCEDURE AddOrderHistory
    @orderId int,
	@operation nvarchar(20),
	@orderDateTime datetime2,
	@customerId int,
	@sellerId int
AS
INSERT INTO OrdersHistory
VALUES(@orderId, @operation, DEFAULT, @orderDateTime, @customerId, @sellerId)

GO
CREATE TRIGGER orders_log_insert
ON Orders
AFTER INSERT 
AS
	DECLARE @orderId INT, @operation NVARCHAR(20), @orderDateTime DATETIME2, @customerId INT, @sellerId INT
	SET @operation = 'INSERT'
	DECLARE @CURSOR CURSOR
	SET @CURSOR = CURSOR SCROLL 
	FOR 
	SELECT Id, OrderDateTime, CustomerId, SellerId FROM INSERTED ORDER BY Id
	OPEN @CURSOR 
	FETCH NEXT FROM @CURSOR INTO @orderId, @orderDateTime, @customerId, @sellerId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC AddOrderHistory  @orderId, @operation, @orderDateTime, @customerId, @sellerId
			FETCH NEXT FROM @CURSOR INTO @orderId, @orderDateTime, @customerId, @sellerId
		END
	CLOSE @CURSOR

GO
CREATE TRIGGER orders_log_delete
ON Orders
AFTER DELETE
AS
	DECLARE @orderId INT, @operation NVARCHAR(20), @orderDateTime DATETIME2, @customerId INT, @sellerId INT
	SET @operation = 'DELETE'
	DECLARE @CURSOR CURSOR
	SET @CURSOR = CURSOR SCROLL 
	FOR 
	SELECT Id, OrderDateTime, CustomerId, SellerId FROM DELETED ORDER BY Id
	OPEN @CURSOR 
	FETCH NEXT FROM @CURSOR INTO @orderId, @orderDateTime, @customerId, @sellerId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC AddOrderHistory  @orderId, @operation, @orderDateTime, @customerId, @sellerId
			FETCH NEXT FROM @CURSOR INTO @orderId, @orderDateTime, @customerId, @sellerId
		END
	CLOSE @CURSOR

GO
CREATE TRIGGER orders_log_update
ON Orders
AFTER UPDATE 
AS
	DECLARE @orderId INT, @operation NVARCHAR(20), @orderDateTime DATETIME2, @customerId INT, @sellerId INT
	SET @operation = 'UPDATE'
	DECLARE @CURSOR CURSOR
	SET @CURSOR = CURSOR SCROLL 
	FOR 
	SELECT Id, OrderDateTime, CustomerId, SellerId FROM INSERTED ORDER BY Id
	OPEN @CURSOR 
	FETCH NEXT FROM @CURSOR INTO @orderId, @orderDateTime, @customerId, @sellerId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC AddOrderHistory  @orderId, @operation, @orderDateTime, @customerId, @sellerId
			FETCH NEXT FROM @CURSOR INTO @orderId, @orderDateTime, @customerId, @sellerId
		END
	CLOSE @CURSOR