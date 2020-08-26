use directumlabdb;

insert into Customers values
('Nagibator', 'Super', '9000', 'Moscow'),
('�������', '�����', '����������', 'London'),
('������', '����', '������', 'Moscow'),
('�����', '��������', '������������', 'Moscow'),
('Sam', 'Breadford', 'John', 'London')

insert into Sellers values
('����', '������', '��������', 'Moscow', 12),
('John', 'Smit', 'Samuel', 'London', 14),
('test', 'test', 'test', 'Ufa', 666);

insert into Orders values
('�����', 56, DEFAULT, 1, 1),
('��� � �����', 34524687, DEFAULT, 3, 1),
('Tea with lemon', 1.22, DEFAULT, 2, 2),
('Guinness', 4.5, DEFAULT, 5, 2),
('������', 42, DEFAULT, 3, 1),
('������ ����', 420000, DEFAULT, 4, 1),
('������� ������', 444259897, DEFAULT, 4, 1)

delete from Orders where id in (1, 2)

update Orders set Description = 'just thing' where id in (3, 4)

insert into Orders values                     -- will not affected
('Another thing', 42, DEFAULT, 1, 2),
('Hell thing', 666, DEFAULT, 1, 1)



