--1
create database STUDYTrace

--2
select DATABASEPROPERTYEX ('STUDYTrace', 'IsAutoCreateStatistics')
select DATABASEPROPERTYEX ('STUDYTrace', 'IsAutoUpdateStatistics')
alter database STUDYTrace set AUTO_CREATE_STATISTICS OFF
alter database STUDYTrace set AUTO_UPDATE_STATISTICS OFF
select DATABASEPROPERTYEX ('STUDYTrace', 'IsAutoCreateStatistics')
select DATABASEPROPERTYEX ('STUDYTrace', 'IsAutoUpdateStatistics')

--3
GO
ALTER DATABASE STUDYTrace
MODIFY FILE
    (NAME = STUDYTrace,
    SIZE = 20MB);

go
DBCC SHRINKFILE (STUDYTrace, 8);

--4
select * from sys.all_objects

--5
select * from INFORMATION_SCHEMA.VIEWS
select * from INFORMATION_SCHEMA.SCHEMATA -- и там вообще много всего

--6
execute sp_help
execute sp_helpdb
execute sp_helpindex N'sys.all_columns'