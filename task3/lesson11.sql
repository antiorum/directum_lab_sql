declare tbl_space cursor 
	for
	select 
	  schemas.name + '.' + objects.name 
	from 
	  sys.objects objects
	  inner join sys.schemas schemas on objects.schema_id = schemas.schema_id
	where type = 'U' order by 1

open tbl_space
declare @tbl_name varchar(max)
fetch next from tbl_space into @tbl_name
while (@@fetch_status = 0)
begin
	exec sp_spaceused @tbl_name
	fetch next from tbl_space into @tbl_name
end
close tbl_space
deallocate tbl_space

-------------------------
-- Все что ниже - один большой скрипт. Перебрасывает таблицы из "dbo" в "guest" и обратно, по ходу показывает изменения в схемах

select * from sys.objects where schema_id = 1
select * from sys.objects where schema_id = 2

declare @schemaTo nvarchar(max)
declare @schemaFrom nvarchar(max)
set @schemaTo = (select name from sys.schemas where schema_id = 2)
set @schemaFrom = (select name from sys.schemas where schema_id = 1)

declare @sql nvarchar(200);


declare FromDboToGuest cursor
	for
	select
		name
	from sys.objects where schema_id = 1 and type_desc = 'USER_TABLE'
open FromDboToGuest
declare @table_name varchar(max)
fetch next from FromDboToGuest into @table_name
while (@@fetch_status = 0)
begin
	set @sql = 'alter schema '+ @schemaTo +' transfer '+ @schemaFrom + '.' + @table_name
	exec sp_executesql @sql
	fetch next from FromDboToGuest into @table_name
end
close FromDboToGuest
deallocate FromDboToGuest

select * from sys.objects where schema_id = 1
select * from sys.objects where schema_id = 2

set @schemaTo = (select name from sys.schemas where schema_id = 1)
set @schemaFrom = (select name from sys.schemas where schema_id = 2)

declare FromGuestToDbo cursor
	for
	select
		name
	from sys.objects where schema_id = 2 and type_desc = 'USER_TABLE'
open FromGuestToDbo
declare @table_name2 varchar(max)
fetch next from FromGuestToDbo into @table_name2
while (@@fetch_status = 0)
begin
	set @sql = 'alter schema '+ @schemaTo +' transfer '+ @schemaFrom + '.' + @table_name2
	exec sp_executesql @sql
	fetch next from FromGuestToDbo into @table_name2
end
close FromGuestToDbo
deallocate FromGuestToDbo

select * from sys.objects where schema_id = 1
select * from sys.objects where schema_id = 2