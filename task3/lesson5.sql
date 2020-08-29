--2
alter table Customers
add constraint d_rating default 100 for rating

--3
insert Customers
(cnum, cname, city, snum)
values
(2012, 'Деточкин', 'Ижевск', 1001)
select * from Customers
where cnum=2012

--4
alter table Salespeople
add constraint ch_comm check (comm > 0)

update Salespeople
set comm = -0.13
where snum = 1001

alter table Orders
add constraint ch_amt check (amt > 0)

update Orders
set amt = -2

--5
alter table Salespeople 
add constraint pk_snum primary key clustered (snum)

alter table Orders
add constraint pk_onam primary key clustered (onum)

exec sp_helpconstraint Salespeople
exec sp_helpconstraint Orders

--6
alter table Salespeople
nocheck constraint ch_comm

update Salespeople
set comm = -0.13
where snum = 1001

alter table Salespeople
check constraint ch_comm

update Salespeople
set comm = 0.12
where snum = 1001

--************--

--1
alter table Documents 
add constraint u_dcamt unique (dcamt)

insert into Documents values
(null, null, GETDATE(), 1, 1),
(null, null, GETDATE(), 1, 1)

--2
alter table Customers
add constraint pk_cnum primary key clustered (cnum)

alter table Orders
add constraint fk_cnum foreign key (cnum) references Customers (cnum)

delete from Customers where cnum = 2001

--3
alter table Orders
drop constraint fk_cnum

alter table Orders
add constraint fk_cnum foreign key (cnum) references Customers (cnum) on delete cascade

delete from Customers where cnum = 2001

