Create extension IF NOT EXISTS "pgcrypto";

DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS Customers CASCADE;
DROP TABLE IF EXISTS CreditCards CASCADE;
DROP TABLE IF EXISTS Areas CASCADE;
DROP TABLE IF EXISTS CustomerLocations CASCADE;
DROP TABLE IF EXISTS Restaurants CASCADE;
DROP TABLE IF EXISTS Menus CASCADE;
DROP TABLE IF EXISTS Promotions CASCADE;
DROP TABLE IF EXISTS RestaurantPromotions CASCADE;
DROP TABLE IF EXISTS RestaurantStaff CASCADE;
DROP TABLE IF EXISTS DeliveryRiders CASCADE;
DROP TABLE IF EXISTS FullTime CASCADE;
DROP TABLE IF EXISTS PartTime CASCADE;
DROP TABLE IF EXISTS WorkingDays CASCADE;
DROP TABLE IF EXISTS ShiftOptions CASCADE;
DROP TABLE IF EXISTS WorkingWeeks CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS OrderDetails CASCADE;
DROP TABLE IF EXISTS Delivers CASCADE;
DROP TABLE IF EXISTS Reviews CASCADE;
DROP TABLE IF EXISTS Last_5_Dests CASCADE;

CREATE TABLE Users (
	uid INTEGER GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	username VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	type VARCHAR(100) NOT NULL CHECK(
		type IN (
			'Customer',
			'FDSManager',
			'RestaurantStaff',
			'DeliveryRider'
		)
	),
	PRIMARY key (uid)
);

CREATE TABLE Customers (
	customerId INTEGER,
	rewardPoints INTEGER DEFAULT 0 NOT NULL,
	startDate DATE DEFAULT CURRENT_DATE NOT NULL,
	PRIMARY key (customerId),
	FOREIGN key (customerId) REFERENCES Users (uid) ON DELETE CASCADE
);

CREATE TABLE CreditCards (
	customerId INTEGER,
	cardNumber VARCHAR(200) NOT NULL,
	PRIMARY key (customerId, cardNumber),
	FOREIGN key (customerId) REFERENCES Customers (customerId) ON DELETE CASCADE
);

CREATE TABLE Areas (
	area VARCHAR(200) NOT NULL CHECK (
		area IN (
			'North',
			'East',
			'South',
			'West',
			'Central'
		)
	),
	PRIMARY key (area)
);

CREATE TABLE CustomerLocations (
	custLocation VARCHAR(50),
	area VARCHAR(50),
	PRIMARY key(custLocation),
	FOREIGN key(area) REFERENCES Areas (area)
);

CREATE TABLE Restaurants (
	restaurantId INTEGER,
	area VARCHAR(200),
	name VARCHAR(200),
	minSpendingAmt INTEGER DEFAULT 0 NOT NULL,
	PRIMARY key (restaurantId),
	FOREIGN key (area) REFERENCES Areas (area)
);

CREATE TABLE Menus (
	restaurantId INTEGER,
	itemName VARCHAR(100) NOT NULL,
	price NUMERIC NOT NULL CHECK (price > 0),
	category VARCHAR(100) NOT NULL,
	isAvailable BOOLEAN NOT NULL,
	amtLeft INTEGER NOT NULL CHECK (amtLeft >= 0) DEFAULT 100,
	PRIMARY key (restaurantId, itemName),
	FOREIGN key (restaurantId) REFERENCES Restaurants (restaurantId) ON DELETE CASCADE
);

CREATE TABLE Promotions (
	promotionId INTEGER GENERATED ALWAYS AS IDENTITY,
	type VARCHAR(100) NOT NULL CHECK (type IN ('FDSpromo', 'Restpromo')),
	startDate DATE NOT NULL,
	endDate DATE NOT NULL,
	discountPerc INTEGER CHECK (
		(discountPerc >= 0)
		AND (discountPerc <= 100)
	),
	discountAmt INTEGER CHECK (discountAmt >= 0),
	minimumAmtSpent INTEGER CHECK (minimumAmtSpent >= 0) DEFAULT 0,
	PRIMARY key (promotionId),
	CHECK (startDate <= endDate)
);

CREATE TABLE RestaurantPromotions (
	promotionId INTEGER,
	restaurantId INTEGER,
	PRIMARY key (promotionId),
	FOREIGN key (promotionId) REFERENCES Promotions ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN key (restaurantId) REFERENCES Restaurants ON DELETE CASCADE
);

CREATE TABLE RestaurantStaff (
	restStaffId INTEGER,
	restaurantId INTEGER,
	PRIMARY key (restStaffId),
	FOREIGN key (restStaffId) REFERENCES Users (uid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN key (restaurantId) REFERENCES Restaurants ON DELETE CASCADE
);

CREATE TABLE DeliveryRiders (
	riderId INTEGER,
	type VARCHAR(100) NOT NULL CHECK (type IN ('FullTime', 'PartTime')),
	deliveryFee INTEGER NOT NULL DEFAULT 5,
	PRIMARY key (riderId),
	FOREIGN key (riderId) REFERENCES Users (uid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PartTime (
	riderId INTEGER PRIMARY KEY,
	weeklyBasePay NUMERIC NOT NULL DEFAULT 100,
	FOREIGN KEY (riderId) REFERENCES DeliveryRiders(riderId) ON DELETE CASCADE
);

CREATE TABLE FullTime (
	riderId INTEGER PRIMARY KEY,
	monthlyBasePay INTEGER NOT NULL DEFAULT 1800,
	FOREIGN KEY (riderId) REFERENCES DeliveryRiders(riderId) ON DELETE CASCADE
);

CREATE TABLE WorkingDays ( 	-- Part Timer
	riderId INTEGER,
	workDate DATE NOT NULL,
	intervalStart TIME NOT NULL,
	intervalEnd TIME NOT NULL,
	numCompleted INTEGER DEFAULT 0,
	PRIMARY KEY (
		riderId,
		workDate,
		intervalStart,
		intervalEnd
	),
	FOREIGN KEY (riderId) REFERENCES PartTime(riderId) ON DELETE CASCADE,
	CHECK (intervalEnd > intervalStart),
	CHECK (intervalStart>='10:00:00' and intervalEnd<='22:00:00'),
	CHECK (CAST(CONCAT(CAST(EXTRACT(HOUR from intervalStart) AS VARCHAR),':00:00') AS TIME)=intervalStart),
	CHECK (CAST(CONCAT(CAST(EXTRACT(HOUR from intervalEnd) AS VARCHAR),':00:00') AS TIME)=intervalEnd),
	CHECK ((EXTRACT(HOUR FROM intervalEnd) - EXTRACT(HOUR FROM intervalStart))< 5)
);

CREATE TABLE ShiftOptions (
	shiftId INTEGER CHECK (shiftId IN (1, 2, 3, 4)),
	shiftDetail1 VARCHAR(30) NOT NULL,
	shiftDetail2 VARCHAR(30) NOT NULL,
	PRIMARY KEY (shiftID)
);

CREATE TABLE WorkingWeeks ( -- Full Timer
	riderId INTEGER,
	workDate DATE NOT NULL,
	shiftID INTEGER NOT NULL,
	numCompleted INTEGER DEFAULT 0,
	PRIMARY KEY (riderId, workDate),
	FOREIGN KEY (riderId) REFERENCES FullTime ON DELETE CASCADE,
	FOREIGN KEY (shiftId) REFERENCES ShiftOptions(shiftId)
);

CREATE TABLE Orders (
	orderId INTEGER GENERATED ALWAYS AS IDENTITY,
	customerId INTEGER,
	orderDate DATE DEFAULT CURRENT_DATE NOT NULL,
	deliveryLocation VARCHAR(50),
	totalCost NUMERIC DEFAULT 0 Check (totalCost >= 0),
	promotionId INTEGER DEFAULT NULL,
	orderTime TIME,
	departureTimeToRestaurant TIME,
	arrivalTimeAtRestaurant TIME,
	departureTimeToDestination TIME,
	arrivalTimeAtDestination TIME,
	paymentMode VARCHAR(50) CHECK (paymentMode IN ('Card', 'Cash')),
	PRIMARY key (orderId),
	FOREIGN key (customerId) REFERENCES Customers (customerId) ON DELETE CASCADE,
	FOREIGN key (deliveryLocation) REFERENCES CustomerLocations (custLocation),
	FOREIGN key (promotionId) REFERENCES Promotions (promotionId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE OrderDetails (
	orderId INTEGER,
	restaurantId INTEGER,
	itemName VARCHAR(100) NOT NULL,
	quantity INTEGER CHECK (quantity > 0),
	orderCost NUMERIC,
	PRIMARY key (orderId, itemName),
	FOREIGN key (restaurantId) REFERENCES Restaurants (restaurantId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN key (orderId) REFERENCES Orders (orderId) ON DELETE CASCADE deferrable initially deferred,
	FOREIGN key (restaurantId, itemName) REFERENCES Menus (restaurantId, itemName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Delivers (
	orderId INTEGER,
	riderId INTEGER,
	rating INTEGER DEFAULT NULL CHECK (
		rating >= 0
		AND rating <= 5
	),
	PRIMARY KEY (orderID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE,
	FOREIGN KEY (riderId) REFERENCES DeliveryRiders(riderId) ON DELETE CASCADE
);


CREATE TABLE Reviews (
	orderId INTEGER,
	review VARCHAR(200),
	rating INTEGER CHECK (
		rating >= 0
		AND rating <= 5
	),
	PRIMARY key (orderId),
	FOREIGN key (orderId) REFERENCES Orders (orderId) ON DELETE CASCADE
);

CREATE TABLE Last_5_Dests (
	customerId INTEGER,
	latest VARCHAR(100) NOT NULL,
	second_latest VARCHAR(100),
	third_latest VARCHAR(100),
	fourth_latest VARCHAR(100),
	fifth_latest VARCHAR(100),
	PRIMARY key (customerId),
	FOREIGN key (customerId) REFERENCES Customers (customerId) ON DELETE CASCADE
);

/* TRIGGERS */
-- Checks if order can go through
-- if does then updates amtleft in menus and the ordercosts of that item in orderdetails
create or replace function check_isAvailable() returns trigger as $$
DECLARE currAvailAmt INTEGER;
DECLARE qtyOrdered INTEGER;
DECLARE itemPrice NUMERIC;

begin
	qtyOrdered := NEW.quantity;

	SELECT amtLeft into currAvailAmt
	FROM Menus M
	WHERE M.itemName = NEW.itemName
	AND M.restaurantId = NEW.restaurantId;
	SELECT price into itemPrice
	FROM Menus M
	WHERE M.itemName = NEW.itemName
	AND M.restaurantId = NEW.restaurantId;

	if NEW.quantity > currAvailAmt then
		RAISE NOTICE 'Exceed Daily Limit';
		RETURN NULL; -- reject order
	else -- update amtLeft
		UPDATE Menus M
		SET amtLeft = amtLeft - qtyOrdered
		WHERE M.itemName = NEW.itemName
		AND M.restaurantId = NEW.restaurantId;
		NEW.orderCost = qtyOrdered * itemPrice;
		RETURN NEW;

	end if;
end;
$$ language plpgsql;

create trigger trig_check_isAvailable
before insert or update
on OrderDetails
for each row
execute function check_isAvailable();

-- Auto sets item availability if amtLeft changes
create or replace function update_isAvailable() returns trigger as $$
begin
	if NEW.amtLeft = 0 then
		UPDATE Menus M
		SET isAvailable = false
		WHERE M.itemName = NEW.itemName
		AND M.restaurantId = NEW.restaurantId;
	end if;
	RETURN NEW;
end;
$$ language plpgsql;

create trigger trig_update_isAvailable
after insert or update
on Menus
for each row
execute function update_isAvailable();

-- Auto add rewards points
create or replace function insert_default_points() returns trigger as $$
begin
	UPDATE Customers
	SET rewardPoints = rewardPoints + Trunc(NEW.orderCost)
	WHERE EXISTS (
		SELECT 1
		FROM Orders O
		WHERE O.orderId = NEW.orderId
		AND O.customerId = Customers.customerId);
	RETURN NULL;
end;
$$ language plpgsql;

create trigger trig_insert_default_points
after insert
on OrderDetails
for each row
execute function insert_default_points();

--Calculate total costs of order for every item added
Create or replace function add_total_costs() returns trigger as $$
Declare price_to_add Numeric;

begin
	price_to_add := NEW.orderCost;

	Update Orders
	Set totalCost = totalCost + price_to_add
	Where Orders.orderId = NEW.orderId;

	RETURN NEW;
end;
$$ language plpgsql;

Create trigger calculate_total_costs_trigger
After update or insert
on OrderDetails
For each row
Execute function add_total_costs();

-- Update newly completed
Create or replace function add_to_orders_completed() returns trigger as $$
DECLARE type_of_rider varchar(100);
DECLARE time_of_order TIME;
DECLARE date_of_order DATE;

Begin
	SELECT orderTime into time_of_order
	FROM Orders
	WHERE orderId = NEW.orderId;

	SELECT orderDate into date_of_order
	FROM Orders
	WHERE orderId = NEW.orderId;

	SELECT type into type_of_rider
	FROM DeliveryRiders dr
	WHERE dr.riderId = NEW.riderId;

	if type_of_rider = 'FullTime' then
		UPDATE WorkingWeeks
		SET numCompleted = numCompleted + 1
		WHERE riderId = NEW.riderId
		AND workDate = date_of_order
		AND time_of_order >= intervalStart
		AND time_of_order <= intervalEnd;
	else
		UPDATE WorkingDays
		SET numCompleted = numCompleted + 1
		WHERE riderId = NEW.riderId
		AND workDate = date_of_order
		AND time_of_order >= intervalStart
		AND time_of_order <= intervalEnd;
	end if;
	RETURN NEW;

End;
$$ language plpgsql;

Create trigger increase_completed_orders
After update of riderID or insert
on Delivers
For each row
Execute function add_to_orders_completed();

-- Update when orders are cancelled
Create or replace function minus_to_orders_completed() returns trigger as $$
DECLARE type_of_rider varchar(100);
DECLARE time_of_order TIME;
DECLARE date_of_order DATE;
DECLARE riderId_of_order INTEGER;

Begin

			RAISE NOTICE 'Hello';
	SELECT orderTime into time_of_order
	FROM Orders
	WHERE orderId = OLD.orderId;

	SELECT orderDate into date_of_order
	FROM Orders
	WHERE orderId = OLD.orderId;

	SELECT type into type_of_rider
	FROM DeliveryRiders dr join Delivers d on (dr.riderId = d.riderId)
	WHERE d.orderId = OLD.orderId;

	SELECT dr.riderID into riderId_of_order
	FROM DeliveryRiders dr join Delivers d on (dr.riderId = d.riderId)
	WHERE d.orderId = OLD.orderId;

	if type_of_rider = 'FullTime' then
		UPDATE WorkingWeeks
		SET numCompleted = numCompleted - 1
		WHERE riderId = riderId_of_order
		AND workDate = date_of_order
		AND time_of_order >= intervalStart
		AND time_of_order <= intervalEnd;
	else
		UPDATE WorkingDays
		SET numCompleted = numCompleted - 1
		WHERE riderId = riderId_of_order
		AND workDate = date_of_order
		AND time_of_order >= intervalStart
		AND time_of_order <= intervalEnd;
	end if;
	RETURN OLD;

End;
$$ language plpgsql;

Create trigger decrease_completed_orders
Before Delete
on Orders
For each row
Execute function minus_to_orders_completed();

-- Update when orders are cancelled
Create or replace function update_minus_to_orders_completed() returns trigger as $$
DECLARE type_of_rider varchar(100);
DECLARE time_of_order TIME;
DECLARE date_of_order DATE;

Begin
	SELECT orderTime into time_of_order
	FROM Orders
	WHERE orderId = OLD.orderId;

	SELECT orderDate into date_of_order
	FROM Orders
	WHERE orderId = OLD.orderId;

	SELECT type into type_of_rider
	FROM DeliveryRiders dr
	WHERE dr.riderId = OLD.riderId;

	if type_of_rider = 'FullTime' then
		UPDATE WorkingWeeks
		SET numCompleted = numCompleted - 1
		WHERE riderId = OLD.riderId
		AND workDate = date_of_order
		AND workDate = date_of_order
		AND time_of_order >= intervalStart
		AND time_of_order <= intervalEnd;
	else
		UPDATE WorkingDays
		SET numCompleted = numCompleted - 1
		WHERE riderId = OLD.riderId
		AND workDate = date_of_order
		AND time_of_order >= intervalStart
		AND time_of_order <= intervalEnd;
	end if;
	RETURN NEW;

End;
$$ language plpgsql;

Create trigger update_decrease_completed_orders
After update
on Delivers
For each row
Execute function update_minus_to_orders_completed();

-- Check if all items come from 1 restaurant
Create or replace function check_all_one_restaurant() returns trigger as $$
DECLARE restaurantIdid_of_order INTEGER;
DECLARE num_ods INTEGER;

Begin
	SELECT count(*) into num_ods
	FROM OrderDetails
	WHERE orderId = NEW.orderId;

	if num_ods > 0 then
		SELECT restaurantId into restaurantIdid_of_order
		FROM OrderDetails od
		WHERE orderId = NEW.orderId;
	end if;

	if num_ods = 0 then
		RETURN NEW;
	elsif restaurantIdid_of_order = NEW.restaurantId then
		RETURN NEW;
	else
		RAISE NOTICE 'All items in Order only from 1 Restaurant';
		RETURN NULL;
	end if;

End;
$$ language plpgsql;

Create trigger order_from_one_trigger
Before update of restaurantId or insert on OrderDetails
For each row
Execute function check_all_one_restaurant();

-- Check if the rider is availabile to deliver that orders
'TOOOOOOOOOO BEEEEEEEEEEEE DONEEEEEEEEEEEEE'
Create trigger available_rider_trigger
Before update of riderId or insert on Delivers
For each row
Execute function check_availability_of_rider();
