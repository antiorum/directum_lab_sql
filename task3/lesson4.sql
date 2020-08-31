--1
create table Documents (
dcamt float null,
dsamt float null,
ddate datetime not null,
onum int not null)

--2
alter table dbo.Documents add dnum integer not null