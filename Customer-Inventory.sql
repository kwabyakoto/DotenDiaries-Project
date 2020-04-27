--TABLE CREATION STATEMENTS
CREATE TABLE TblCustomer
(CustomerID		CHAR(5)	NOT NULL,
 LastName		VARCHAR(30)	NOT NULL,
 FirstName		VARCHAR(20),
 Address		VARCHAR(30)	NOT NULL,
 City			VARCHAR(20)	NOT NULL,
 State			CHAR(2)	NOT NULL,
 Zip			VARCHAR(12)	NOT NULL,
 Country		VARCHAR(15),
 FirstBuyDate		DATETIME,
 Email			VARCHAR(60),
 Phone			CHAR(15) NOT NULL,
 CustomerType		CHAR(1)	CHECK(CustomerType IN('P','S')),
 CustomerAffID	CHAR(5) REFERENCES TblCustomer(CustomerID),
 PRIMARY KEY(CustomerID)
);

CREATE TABLE TblShipAddress
(AddressID		INT NOT NULL,
 ShipName		VARCHAR(30),
 ShipAddress		VARCHAR(30),
 ShipPostalCode	VARCHAR(12),
 ShipCountry		VARCHAR(30),
 ShipPhone		CHAR(15),
 PRIMARY KEY(AddressID)
);

CREATE TABLE TblOrder
(OrderID		CHAR(6) NOT NULL,
 OrderDate		DATETIME NOT NULL,
 DiscountCode	CHAR(2) CHECK(DiscountCode IN('02','03','04','06','08','10','A1','B3')),
 CreditCode		CHAR(3) NOT NULL,
 CustomerID		CHAR(5) REFERENCES TblCustomer(CustomerID) NOT NULL,
 AddressID		INT REFERENCES TblShipAddress(AddressID),
 PRIMARY KEY(OrderID)
);

CREATE TABLE TblItemType
(TypeID			INT NOT NULL,
 CategoryDescription 	VARCHAR(50),
 PRIMARY KEY(TypeID)
);

CREATE TABLE TblItem
(ItemID		CHAR(6) NOT NULL,
 Description		VARCHAR(300),
 ListPrice		MONEY NOT NULL CHECK(ListPrice > 5.00),
 TypeID		INT REFERENCES TblItemType(TypeID) NOT NULL,
 PRIMARY KEY(ItemID)
);

CREATE TABLE TblOrderLine
(OrderID		CHAR(6) REFERENCES TblOrder(OrderID) NOT NULL,
 ItemID		CHAR(6) REFERENCES TblItem(ItemID) NOT NULL,
 Quantity		INT NOT NULL CHECK(Quantity > 0),
 Price			MONEY NOT NULL CHECK(Price > 0.00),
 AddressID		INT REFERENCES TblShipAddress(AddressID),
 PRIMARY KEY(OrderID, ItemID)
);

CREATE TABLE TblItemLocation
(ItemID		CHAR(6) REFERENCES TblItem(ItemID) NOT NULL,
 LocationID		CHAR(2) NOT NULL,
 QtyOnHand		INT,
 PRIMARY KEY(ItemID, LocationID)
);

CREATE TABLE TblShipLine
(DateShipped		DATETIME NOT NULL,
 OrderID		CHAR(6) NOT NULL,
 ItemID		CHAR(6) NOT NULL,
 LocationID		CHAR(2) NOT NULL,
 QtyShipped		INT NOT NULL,
 MethodShipped	VARCHAR(30) NOT NULL,
 FOREIGN KEY(OrderID, ItemID) REFERENCES TblOrderLine(OrderID, ItemID),
 FOREIGN KEY(ItemID, LocationID) REFERENCES TblItemLocation(ItemID, LocationID),
 PRIMARY KEY(DateShipped, OrderID, ItemID, LocationID)
);

CREATE TABLE TblItemCostHistory
(ItemID		CHAR(6) REFERENCES TblItem(ItemID) NOT NULL,
 LastCostDate		DATETIME NOT NULL,
 LastCost		MONEY NOT NULL,
 PRIMARY KEY(ItemID, LastCostDate)
);

CREATE TABLE TblReview
(ReviewID		INT IDENTITY(1,1) NOT NULL,
 ReviewDate		DATETIME,
 Rating		INT CHECK(Rating IN(1,2,3,4,5)),
 ReviewText		VARCHAR(500),
 OrderID		CHAR(6) NOT NULL,
 ItemID		CHAR(6) NOT NULL,
 FOREIGN KEY(OrderID, ItemID) REFERENCES TblOrderLine(OrderID, ItemID),
 PRIMARY KEY(ReviewID)
);
