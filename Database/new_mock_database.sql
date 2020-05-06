-- Create 5 Customers
insert into Users (name, username, password, type) values ('Truda Scroggie', 'tscroggie0', '3FLwB4TSVcy', 'Customer');
insert into Users (name, username, password, type) values ('Bealle Peete', 'bpeete1', 'LJykiUgw', 'Customer');
insert into Users (name, username, password, type) values ('Starlin Nutbeam', 'snutbeam2', 'rqh0w8Q', 'Customer');
insert into Users (name, username, password, type) values ('Barret von Grollmann', 'bvon3', 'Plf0ZX', 'Customer');
insert into Users (name, username, password, type) values ('Tricia Tregust', 'ttregust4', 'vGlowu', 'Customer');

insert into Customers (customerId, rewardPoints, startDate) values (1, 23, '2020-04-07 01:43:42');
insert into Customers (customerId, rewardPoints, startDate) values (2, 76, '2020-01-12 15:39:31');
insert into Customers (customerId, rewardPoints, startDate) values (3, 29, '2020-01-04 19:18:07');
insert into Customers (customerId, rewardPoints, startDate) values (4, 78, '2020-03-29 23:35:31');
insert into Customers (customerId, rewardPoints, startDate) values (5, 42, '2020-04-09 14:03:40');

-- Create 5 Credit Cards for each customer
insert into CreditCards (customerId, cardNumber) values (1, '5027-8511-0125-0172');
insert into CreditCards (customerId, cardNumber) values (2, '3060-0247-7129-9758');
insert into CreditCards (customerId, cardNumber) values (3, '5818-8235-6693-8956');
insert into CreditCards (customerId, cardNumber) values (4, '4777-1992-3468-6461');
insert into CreditCards (customerId, cardNumber) values (5, '1131-2567-7065-4352');

-- Create 5 FDSManagers
insert into Users (name, username, password, type) values ('Edgardo Coverley', 'ecoverley0', 'AUVGkLIjrJ2', 'FDSManager');
insert into Users (name, username, password, type) values ('Toddie Silverthorn', 'tsilverthorn1', 'ommBjE', 'FDSManager');
insert into Users (name, username, password, type) values ('Brigitta Hawney', 'bhawney2', '4EIdchpzix2', 'FDSManager');
insert into Users (name, username, password, type) values ('Paxon Dunkerton', 'pdunkerton3', 'VGrLrJdCNXQ', 'FDSManager');
insert into Users (name, username, password, type) values ('Kurt Girsch', 'kgirsch4', 'xsCOI0gzn9', 'FDSManager');

insert into FdsManagers (managerId) values (6);
insert into FdsManagers (managerId) values (7);
insert into FdsManagers (managerId) values (8);
insert into FdsManagers (managerId) values (9);
insert into FdsManagers (managerId) values (10);

-- Create the Areas
insert into Areas (area) values ('North');
insert into Areas (area) values ('South');
insert into Areas (area) values ('East');
insert into Areas (area) values ('West');
insert into Areas (area) values ('Central');

-- Create 7 Restaurants
insert into Restaurants (restaurantId, area, name, minSpendingAmt) values (1, 'North', 'Burgils', 10);
insert into Restaurants (restaurantId, area, name, minSpendingAmt) values (2, 'North', 'Spago', 10);
insert into Restaurants (restaurantId, area, name, minSpendingAmt) values (3, 'South', 'Maxican Grills', 10);
insert into Restaurants (restaurantId, area, name, minSpendingAmt) values (4, 'East', 'The Gourmet Kitchen', 10);
insert into Restaurants (restaurantId, area, name, minSpendingAmt) values (5, 'West', 'Pink Sugar', 10);
insert into Restaurants (restaurantId, area, name, minSpendingAmt) values (6, 'Central', 'Lord Of Fries', 10);

-- Create 7 Resturant Staff
insert into Users (name, username, password, type) values ('Maryanne Kolczynski', 'mkolczynski0', 'iX5A9o', 'RestaurantStaff');
insert into Users (name, username, password, type) values ('Royce Brandoni', 'rbrandoni1', 'APRuqs3SQk', 'RestaurantStaff');
insert into Users (name, username, password, type) values ('Cody Baudoux', 'cbaudoux2', 'HU1I6m', 'RestaurantStaff');
insert into Users (name, username, password, type) values ('Dulcia Halpin', 'dhalpin3', 'RIK1Qj', 'RestaurantStaff');
insert into Users (name, username, password, type) values ('Dwight Tubble', 'dtubble4', '9030kS', 'RestaurantStaff');
insert into Users (name, username, password, type) values ('Sibley Trevance', 'strevance0', 'WwRVitrj', 'RestaurantStaff');
insert into Users (name, username, password, type) values ('Clerc Johanchon', 'cjohanchon1', 'sJariyxD68Th', 'RestaurantStaff');

insert into RestaurantStaff (restStaffId, restaurantId) values (11, 1);
insert into RestaurantStaff (restStaffId, restaurantId) values (12, 2);
insert into RestaurantStaff (restStaffId, restaurantId) values (13, 3);
insert into RestaurantStaff (restStaffId, restaurantId) values (14, 4);
insert into RestaurantStaff (restStaffId, restaurantId) values (15, 5);
insert into RestaurantStaff (restStaffId, restaurantId) values (16, 6);

-- Create Restaurant Menus
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (1, 'Pad Thai', 3.3, 'Thai', true, 157);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (1, 'Tom Yum Soup', 19.0, 'Thai', true, 60);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (1, 'Green Papaya Salad', 3.9, 'Thai', true, 289);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (1, 'Basil Pork Rice', 3.9, 'Thai', true, 122);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (2, 'Cream Of Chicken Soup', 9.0, 'Western', true, 164);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (2, 'Beef Burger', 13.7, 'Western', true, 296);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (2, 'Fish And Chips', 13.6, 'Western', true, 167);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (2, 'Chicken Cutlet Set', 15.8, 'Western', true, 100);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (2, 'Mac And Cheese', 6.8, 'Western', true, 167);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (3, 'Beef Burger', 8.0, 'Western', true, 203);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (3, 'Cream Of Chicken Soup', 9.4, 'Western', true, 160);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (3, 'Fish And Chips', 15.6, 'Western', true, 85);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (3, 'Pork Chops', 19.2, 'Western', true, 114);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (4, 'Kung Pow Chicken', 16.4, 'Chinese', true, 291);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (4, 'Salted Fish Fried Rice', 7.9, 'Chinese', true, 129);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (4, 'Yangchow Fried Rice', 3.4, 'Chinese', true, 70);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (4, 'Sichuan Pork', 15.8, 'Chinese', true, 71);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (4, 'Spring Rolls', 7.7, 'Chinese', true, 250);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (4, 'Ma Po Tofu', 4.2, 'Chinese', true, 280);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (5, 'Tamagoyaki', 15.1, 'Japanese', true, 136);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (5, 'Miso Ramen', 16.2, 'Japanese', true, 167);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (5, 'Cold Cha Soba', 11.7, 'Japanese', true, 127);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (6, 'Mac And Cheese', 18.0, 'Italian', true, 134);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (6, 'Primavare Stuffed Chicken', 12.9, 'Italian', true, 197);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (6, 'Mushroom Risotto', 17.7, 'Italian', true, 285);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (6, 'Ricotta Spaghetti', 3.5, 'Italian', true, 117);
insert into Menus (restaurantId, itemName, price, category, isAvailable, amtLeft) values (6, 'Cheese Pizza', 6.3, 'Italian', true, 89);

-- Create 10 Delivery Riders
insert into Users (name, username, password, type) values ('Sianna Burchmore', 'sburchmore0', '9rpgahE14TyC', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Brinn Meir', 'bmeir1', 'QouwkFfvtTD', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Neila Le Fleming', 'nle2', '0OKF9mfqzK', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Derril Winders', 'dwinders3', 'XBg7p7LOYw', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Mort Freddi', 'mfreddi4', 'YLAIZAG4Pvj', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Tonia Worpole', 'tworpole5', 'z0u3kVb', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Eustacia Dewhirst', 'edewhirst6', '1pY7IoCHv', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Florie Doll', 'fdoll7', '30xrig4bHI', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Arin Frankum', 'afrankum8', 'XxWMHYn9', 'DeliveryRider');
insert into Users (name, username, password, type) values ('Ansel Deval', 'adeval9', 'eide5982m', 'DeliveryRider');

insert into DeliveryRiders (riderId, type, deliveryFee) values (18, 'PartTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (19, 'PartTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (20, 'PartTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (21, 'PartTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (22, 'PartTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (23, 'FullTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (24, 'FullTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (25, 'FullTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (26, 'FullTime', 5);
insert into DeliveryRiders (riderId, type, deliveryFee) values (27, 'FullTime', 5);

-- Create 5 Part Timers
insert into PartTime (riderId) values (18);
insert into PartTime (riderId) values (19);
insert into PartTime (riderId) values (20);
insert into PartTime (riderId) values (21);
insert into PartTime (riderId) values (22);

-- Create 5 Full Timers
insert into FullTime (riderId) values (23);
insert into FullTime (riderId) values (24);
insert into FullTime (riderId) values (25);
insert into FullTime (riderId) values (26);
insert into FullTime (riderId) values (27);

-- Create Shift Options
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (1, '10AM to 2PM', '3PM to 7PM');
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (2, '11AM to 3PM', '4PM to 8PM');
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (3, '12PM to 4PM', '5PM to 9PM');
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (4, '1PM to 5PM', '6PM to 10PM');
