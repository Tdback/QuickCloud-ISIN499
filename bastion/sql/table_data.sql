use quick_cloud_db

CREATE TABLE Donor (
DonorID  iNT AUTO_INCREMENT PRIMARY KEY, 
FName varchar(30),
LName varchar(30),
City varchar(40),
State varchar(40));

Create Table Recepiant (
RecepiantID int AUTO_INCREMENT PRIMARY KEY,
FName varchar(30),
LName varchar(30),
City varchar(40),
State varchar(40));

Create Table Donations(
DonationID int AUTO_INCREMENT Primary Key,
DAmount float,
PayType varchar(50));

Create Table Categories(
CategoryID int NOT NULL AUTO_INCREMENT Primary Key,
CName varchar(50),
CDesc varchar(200));


Insert Into Donor (FName, LName, City, State)
Values
		('Alex','Peariso', 'Flint', 'Michigan'),
		('Jim','Smith', 'Chicago', 'Illinois'),
		('John','Hamm', 'Ney York', 'New York'),
		('Dwayne','Johnson', 'Los Angeles', 'California'),
		('Fred','Keen', 'Lansing', 'Michigan'),
		('Melody','Rose', 'Miami', 'Flordia'),
		('Steve','Shull', 'San Antonio', 'Texas'),
		('Jamie','Dredge', 'Denver', 'Colorado'),
		('Stacey','Johnson', 'Cleveland', 'Ohio'),
		('Dan','Frost', 'Kansas City', 'Missouri'),
		('Forest','Gump', 'Montgomery', 'Alabama'),
		('Jenny','Curran', 'Montgomery', 'Alabama'),
		('Todd','Smith', 'Detroit', 'Michigan'),
		('Jason','Curt', 'Montgomery', 'Alabama'),
		('John','Smith', 'Seattle', 'Washington'),
		('Jason','Curt', 'Cleaveland', 'Ohio'),
		('Brennan','Nelson', 'Flint', 'Michigan'),
		('Bill','Dill', 'Big Rapids', 'Michigan'),
		('Jeff','Bezos', 'New York City', 'New York'), 
		('Elon','Musk', 'Houston', 'Texas'), 
		('Bill','Gates', 'San Francisco', 'Califonria'), 
		('Gwyneth','Paltrow', 'Los Angeles', 'California'), 
		('George','Lopez', 'New York City', 'New York'), 
		('Steve','Harvey', 'New York City', 'New York'), 
		('Will','Smith', 'Slapout', 'Oklahoma');

Insert Into Donations(DAmount, PayType)
Values
		(2000, 'Check'),
		(5000, 'Cash'),
		(3000, 'Card'),
		(4000,  'Cash'),
		(1000, 'Cash'),
		(3000, 'Card'),
		(1200, 'Check'),
		(45100, 'Check'),
		(52000, 'Card'),
		(12000, 'Check'),
		(22000, 'Cash'),
		(3200, 'Cash'),
		(7200, 'Cash'),
		(85100, 'Card'),
		(12000, 'Card'),
		(62000, 'Check'),
		(29000, 'Cash'),
		(42200, 'Cash'),
		(9000, 'Check'),
		(3100, 'Cash'),
		(5400, 'Card'),
		(9700, 'Card'),
		(1100, 'Card');

Insert Into Categories( CName, CDesc)
Values
		('Textbooks and Supplies','Student books and needed supplies'),
		('Construction','Building projects, sidewalks, and communal spaces'),
		('Dining','Kitchen staff payroll as well as the purchasing of new equipment'),
		('Housing','Room and board as well as the purchase of new amenities'),
		('Sports','New sporting fields as well as new equipment'),
		('Technology','Improvements to technological infratructure'),
		('Staff','Bonuses given to staff and other members of faculty'),
		('Medical','Improved medical services');

