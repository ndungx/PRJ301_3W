create database FlowerManagement
create table dbo.[Role] (
	roleID varchar(2),
	name varchar(10),
	CONSTRAINT PK_Role PRIMARY KEY (roleID));

insert into dbo.[Role](roleID, [name]) values 
('AD', 'admin'),('G', 'guest'),('M', 'modifier');

create table dbo.[User] (
	userID varchar(250),
	[password] varchar (250),
	fullname varchar (250),
	roleID varchar(2)
	foreign key(roleID) references dbo.[Role](roleID),
	phone int, 
	email varchar(250),
	[address] varchar(250)
	CONSTRAINT PK_User PRIMARY KEY (userID)
);

insert into dbo.[User] (userID, [password], fullname, roleID, phone, email, [address])
values 
('servlet', 1234, 'Servlet Tomcat Server', 'G', '7687648464','Servlet@Tomcat.com', 'Local host'),
('kevin', 1234, 'Kevin De Bruyne', 'G', '5612357564', 'kevin@mancity.com', 'Belgium'),
('ndungx', 1234, 'Nguyen Dung', 'G','3455645657', 'ndungx@gmail.com', 'Viet Nam'),
('james', 1234, 'Nguyen Tuan Khai','7324636252', 'AD', 'tuankhai513@gmail.com','Viet Nam'),
('roberto', 1234, 'Roberto Firmino','7486543234', 'G', 'Firmino@liverpool.com', 'Brazil');


create table dbo.Category (
	categoryID int primary key identity,
	categoryName varchar (250),
);

create table dbo.Product (
	productID int primary key identity,
	productName varchar (250),
	price float,
	quantity int,
    categoryID int foreign key references dbo.Category(categoryID),
	[image] varchar(250)
);


create table dbo.[Order] (
	userID varchar(250) foreign key references dbo.[User](userID),
	[Date] datetime,	
	orderID int primary key identity,
	total float
);

create table dbo.OrderDetail (
	orderID int,
	productID int,
	quantity int,
	foreign key (orderID) references dbo.[Order](orderID),
	foreign key (productID) references dbo.Product(productID),
	primary key(orderID, productID)
);


DBCC CHECKIDENT ('[Category]', RESEED, 0); --hàm này để reset identity khi đã delete row (empty table)
delete from dbo.Category where categoryName like 'hoa%'

insert into dbo.Category(categoryName)
values('birthday'),('inaugurals grand openings'), ('condolence'),('bouquets'),('floral baskets'),('romance');

--hoa sinh nhật
insert into dbo.Product(productName,price,quantity,categoryID,[Image])
values
('Crystal Pearl', 499000, 100, 1, 'https://assets.flowerstore.vn/uploads/products/photos/WYcmQ89Dq9vnmPU077rA9GYNb1FCJn11ePEa8hbO.jpeg'),
('Dreamlike', 889000, 100, 1, 'https://assets.flowerstore.vn/uploads/products/photos/9k0IC6apvvIuE6GceG47WQvfGYQRW5gSwbeNx2U9.jpeg'),
('Dream Of You', 429000, 100, 1, 'https://assets.flowerstore.vn/uploads/products/photos/YZyZZMldiiUx3WuzuBe1p2EHcbCBOl7WJ6CLfp3n.jpeg'),
('Roseanne', 569000, 100, 1, 'https://assets.flowerstore.vn/uploads/products/photos/f2zzQZROOMM8RjHzlgJtR6Gw4aafn4w1yA4y68jU.jpeg'),
('First Date', 349000, 100, 1, 'https://assets.flowerstore.vn/uploads/products/photos/TQZqXHJONWQEEr5NFHHPXfBPaalAyNOCPv2sGHbL.jpeg');

--hoa khai trương
insert into dbo.Product(productName,price,quantity,categoryID,[Image])
values
('Amazing', 1029000, 100, 2, 'https://assets.flowerstore.vn/uploads/products/photos/bcaH8AGyehIV48Pu4O4xLA5qIKs73RSfs7xN5XDF.jpeg'),
('Captivating', 1249000, 100, 2, 'https://assets.flowerstore.vn/uploads/products/photos/tZHIPASBEjBabznRSNm5x8ENhrhiBctFpsJXD3qx.jpeg'),
('Magnificient', 429000, 100, 2, 'https://assets.flowerstore.vn/uploads/products/photos/8XXG9JTLyS9W9RDuupKYmsTy2DGKyi8QaWB7qK6A.jpeg'),
('Marvellous', 929000, 100, 2, 'https://assets.flowerstore.vn/uploads/products/photos/d6somdCnUZi4cErzFjEhYTuXOfP35tREsvrSBWS9.jpeg'),
('Spectacular', 349000, 100, 2, 'https://assets.flowerstore.vn/uploads/products/photos/GFXNXWuxLRfSUR4g9FmV29bPm0NWzkQeb6wWG4vQ.jpeg');

--hoa chia buồn
insert into dbo.Product(productName,price,quantity,categoryID,[Image])
values
('Sympathy', 1659000, 100, 3, 'https://assets.flowerstore.vn/uploads/products/photos/YF1tXIDa5vukf1uYd2Y9RWFDa3Q8yjiIffpzN6fX.jpeg'),
('Gentle Sentiment', 1049000, 100, 3, 'https://assets.flowerstore.vn/uploads/products/photos/spjiGtLNcwxbgvkrrXvrlG7Pakw8Jcp1CRpm6xnu.jpeg'),
('Relief', 1969000, 100, 3, 'https://assets.flowerstore.vn/uploads/products/photos/aF24GQYssWDfqW5JHWOQU2h7U3uJQSgVSl0dPO0F.jpeg'),
('Goodbye Salute', 1239000, 100, 3, 'https://assets.flowerstore.vn/uploads/products/photos/W9wLjqcvQD6xWXnlAjDNhW4GK7a2Kq9L55vXoinM.jpeg'),
('Farewell', 929000, 100, 3, 'https://assets.flowerstore.vn/uploads/products/photos/E0CaNFZZvSM55lOniSjtWVtNRITKDnZW51xEbsys.jpeg');

--hoa bó
insert into dbo.Product(productName,price,quantity,categoryID,[Image])
values
('Aphrodite', 459000, 100, 4, 'https://assets.flowerstore.vn/uploads/products/photos/Ak8b81V1qsQHJtPmio3sp0f8NKLWNXX8ObmhuFTD.jpeg'),
('Summertime', 479000, 100, 4, 'https://assets.flowerstore.vn/uploads/products/photos/7Xu70pINIiNxGw19NgdsVOlEwz545Co0qgIGlA8e.jpeg'),
('Timeless Elegance', 379000, 100, 4, 'https://assets.flowerstore.vn/uploads/products/photos/ni2oh1Qfn5OZAinnKMP8uJhMa8PXNp7Jc6djA9kp.jpeg'),
('Love Me Tender', 399000, 100, 4, 'https://assets.flowerstore.vn/uploads/products/photos/nmZErCkzVjZbJqB2Vf8xcVVDteZNCBHeUopUthhS.jpeg'),
('Simple Charm', 259000, 100, 4, 'https://assets.flowerstore.vn/uploads/products/photos/vnjBHlzEZnzQFmsHo6oS5oRLme13XRlts9XNdPAY.jpeg');

--hoa giỏ
insert into dbo.Product(productName,price,quantity,categoryID,[Image])
values
('Dreamlike', 889000, 100, 5, 'https://assets.flowerstore.vn/uploads/products/photos/9k0IC6apvvIuE6GceG47WQvfGYQRW5gSwbeNx2U9.jpeg'),
('Enchanting Romance', 649000, 100, 5, 'https://assets.flowerstore.vn/uploads/products/photos/XdvooDcQoYN7Myk0Tmqcu5hZeHXmHIIkbt6Xu4Vk.jpeg'),
('Wonderland', 1279000, 100, 5, 'https://assets.flowerstore.vn/uploads/products/photos/quSKhY3uOLmQP5Ka8FmNRX59hMiuACq8FjZKpgvs.jpeg'),
('Intimate Amber', 869000, 100, 5, 'https://assets.flowerstore.vn/uploads/products/photos/gy2cglnO11Jk2ERcr00X1rIedt8rtLJry23p0Umj.jpeg'),
('Midsummer', 599000, 100, 5, 'https://assets.flowerstore.vn/uploads/products/photos/EyDVxM1hs0d1NhMM7B1r0j5iYdI5hEdoPYd64S0t.jpeg');

--hoa tình yêu
insert into dbo.Product(productName,price,quantity,categoryID,[Image])
values
('Sweet Desire', 369000, 100, 6, 'https://assets.flowerstore.vn/uploads/products/photos/E0SNn6aUdTgEaG1bpjDw0HhrJssn66v6GS4GH5RB.jpeg'),
('Burning Love', 1049000, 100, 6, 'https://assets.flowerstore.vn/uploads/products/photos/CBaS2qpVqeR73SApJ2WAO6uxLBnamgHp2TaFQg9b.jpeg'),
('My Princess', 369000, 100, 6, 'https://assets.flowerstore.vn/uploads/products/photos/5QT1PAG4FEWpAV0Iu2leBVxFw1lqq36qVzYyvQhG.jpeg'),
('My Juliet', 329000, 100, 6, 'https://assets.flowerstore.vn/uploads/products/photos/G5AXLedfDA9QfXhelb4U7WASGJNGAjqcbJMY4c0U.jpeg'),
('Intense Love', 69000, 100, 6, 'https://assets.flowerstore.vn/uploads/products/photos/QvW53IgUu7IaP7Vk5PMRGfapEPlNHEr7VAFPC88T.jpeg');

select * from dbo.Product
select * from dbo.[Order]
select * from dbo.[OrderDetail]

insert into dbo.[Order]([userID], [date], total, [address])
values('james',CURRENT_TIMESTAMP,1000000,'123/5 đường kha vạn cân');

delete from [Order] where userID = 'james'
DBCC CHECKIDENT ('[Order]', RESEED, 0);

delete from [OrderDetail] where productID = 3;

delete from [OrderDetail] where orderID = 8;

select * from [User] where userID = 'james'

select max(orderID) as orderID 
from dbo.[Order]
where userID = 'james'

update dbo.Product
set quantity = 100
where productID = 1

select quantity
from Product
where [productID] = 1

select max(orderID) as orderID 
from dbo.[Order] 
where userID = 'james'

select [date] as [date]
from dbo.[Order] 
where orderID = 6

select [productName] as [productName]
from dbo.[Product] 
where productID = 1

select * from dbo.[Product]

delete from dbo.[User]
where userID like 'dungnse%'