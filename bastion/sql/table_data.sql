Use quick_cloud_db

Create Table Donor (
DonorID  int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
FName nvarchar(30),
LName nvarchar(30),
City nvarchar(40),
State nvarchar(40));

Create Table Recepiant (
RecepiantID int IDENTITY(1,1) PRIMARY KEY,
FName nvarchar(30),
LName nvarchar(30),
City nvarchar(40),
State nvarchar(40));

Create Table Donations(
DonationID int NOT NULL IDENTITY(1,1) Primary Key,
DAmount float,
PayType varchar(50));

Create Table Categories(
CategoryID int NOT NULL IDENTITY(1,1) Primary Key,
CName varchar(50),
CDesc varchar(Max));

Create Table DonorDonations (
DonorID  int NOT NULL FOREIGN KEY REFERENCES Donor(DonorID), 
DonationID int NOT NULL FOREIGN KEY REFERENCES Donations(DonationID));



Create Table DonationCategories(
DonationID int NOT NULL Foreign KEY REFERENCES Donations(DonationID),
CategoryID  int NOT NULL Foreign KEY REFERENCES Categories(CategoryID));



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

Insert Into DonorDonations (DonorID, DonationID)
Values
		(1,6),
		(2,5),
		(4,9),
		(3,4),
		(6,12),
		(17,15),
		(14,13),
		(19,11),
		(20,10),
		(14,13),
		(21,13),
		(1,3),
		(5,14),
		(1,3),
		(7,2),
		(7,7);

Insert Into DonationCategories (DonationID, CategoryID)
Values
		(3,6),
		(10,3),
		(4,2),
		(1,5),
		(1,2),
		(2,6),
		(7,7),
		(9,8),
		(2,8);
