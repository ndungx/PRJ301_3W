create database FlowerManagement
create table dbo.tblRole (
	roleID varchar(2),
	name varchar(10),
	CONSTRAINT PK_tblRole PRIMARY KEY (roleID));

insert into dbo.tblRole(roleID, name) values 
('AD', 'admin'),('G', 'guest'),('M', 'modifier'),('C', 'customer');

create table dbo.tblUser (
	userID varchar(250),
	[password] varchar (250),
	fullname varchar (250),
	roleID varchar(2)
	foreign key(roleID) references  dbo.tblRole(roleID),
	phone int, 
	email varchar(250),
	[address] varchar(250)
	CONSTRAINT PK_tblUser PRIMARY KEY (userID)
);

insert into dbo.tblUser (userID, [password], fullname, roleID, email, [address])
values 
('kevin', 111111, 'Kevin De Bruyne', 'G', 'kevin@mancity.com', 'Belgium'),
('ndungx', 123456, 'Nguyen Dung', 'G', 'ndungx@gmail.com', 'Viet Nam'),
('james', 123456, 'Nguyen Tuan Khai', 'AD', 'tuankhai513@gmail.com','Viet Nam'),
('roberto', 123456, 'Roberto Firmino', 'G', 'Firmino@liverpool.com', 'Brazil'),
('servlet', 123456, 'Servlet Tomcat Server', 'G', 'Servlet@Tomcat.com', 'Local host');


create table dbo.tblCategory (
	categoryID int primary key identity,
	categoryName varchar (250),
);

create table dbo.tblProduct (
	productID int primary key identity,
	productName varchar (250),
	price float,
	quantity int,
    categoryID int foreign key references dbo.tblCategory(categoryID),
	Image varchar(250)
);


create table dbo.tblOrder (
	userID varchar(250) foreign key references dbo.tblUser(userID),
	[Date] datetime,	
	orderID int primary key identity,
	total float
);

create table dbo.tblOrderDetail (
	orderID int,
	productID int,
	quantity int,
	foreign key (orderID) references dbo.[tblOrder](orderID),
	foreign key (productID) references dbo.tblProduct(productID),
	primary key(orderID, productID)
);

SELECT productID, productName
FROM dbo.tblProduct

select * from dbo.[tblOrderDetail]