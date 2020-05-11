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

-- Create 5 Last 5 Destinations for each customers
insert into Last_5_Dests (customerId, latest, second_latest, third_latest, fourth_latest, fifth_latest) values (1, 'S100001', 'S100496', 'S100528', 'S101953', 'S102016');
insert into Last_5_Dests (customerId, latest, second_latest, third_latest, fourth_latest, fifth_latest) values (2, 'S100003', 'S100561', 'S102080', NULL, NULL);
insert into Last_5_Dests (customerId, latest, second_latest, third_latest, fourth_latest, fifth_latest) values (3, 'S100006', 'S100595', 'S102145', NULL, NULL);
insert into Last_5_Dests (customerId, latest, second_latest, third_latest, fourth_latest, fifth_latest) values (4, 'S100010', 'S100630', 'S102211', NULL, NULL);
insert into Last_5_Dests (customerId, latest, second_latest, third_latest, fourth_latest, fifth_latest) values (5, 'S100015', 'S100666', 'S102278', NULL, NULL);

-- Create 5 FDSManagers
insert into Users (name, username, password, type) values ('Edgardo Coverley', 'ecoverley0', 'AUVGkLIjrJ2', 'FDSManager');
insert into Users (name, username, password, type) values ('Toddie Silverthorn', 'tsilverthorn1', 'ommBjE', 'FDSManager');
insert into Users (name, username, password, type) values ('Brigitta Hawney', 'bhawney2', '4EIdchpzix2', 'FDSManager');
insert into Users (name, username, password, type) values ('Paxon Dunkerton', 'pdunkerton3', 'VGrLrJdCNXQ', 'FDSManager');
insert into Users (name, username, password, type) values ('Kurt Girsch', 'kgirsch4', 'xsCOI0gzn9', 'FDSManager');

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

-- Create 10 Promotions
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('FDSpromo', '2020-04-01', '2020-04-10', 20, 0, 10);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('FDSpromo', '2020-05-01', '2020-05-20', 25, 0, 20);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('FDSpromo', '2020-05-21', '2020-05-31', 10, 0, 10);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('FDSpromo', '2020-06-01', '2020-08-01', 5, 0, 0);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('FDSpromo', '2020-08-02', '2020-08-31', 15, 0, 50);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('Restpromo', '2020-08-09', '2020-08-09', 30, 0, 25);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('Restpromo', '2020-09-01', '2020-09-15', 35, 0, 30);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('Restpromo', '2020-09-16', '2020-10-05', 3, 0, 25);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('Restpromo', '2020-10-25', '2020-10-25', 12, 0, 0);
insert into Promotions (type, startDate, endDate, discountPerc, discountAmt, minimumAmtSpent) values ('Restpromo', '2020-11-01', '2020-11-08', 2, 0, 0);

-- Create 5 Restaurant Promotions
insert into RestaurantPromotions (promotionId, restaurantId) values (6, 1);
insert into RestaurantPromotions (promotionId, restaurantId) values (7, 2);
insert into RestaurantPromotions (promotionId, restaurantId) values (8, 3);
insert into RestaurantPromotions (promotionId, restaurantId) values (9, 4);
insert into RestaurantPromotions (promotionId, restaurantId) values (10, 5);

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

-- Create Shift Options
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (1, '10AM to 2PM', '3PM to 7PM');
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (2, '11AM to 3PM', '4PM to 8PM');
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (3, '12PM to 4PM', '5PM to 9PM');
insert into ShiftOptions (shiftId, shiftDetail1, shiftDetail2) values (4, '1PM to 5PM', '6PM to 10PM');

-- Create WorkingDays
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-06', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-06', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-07', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-07', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-08', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-08', '15:00', '19:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-13', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-13', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-14', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-14', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-15', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-15', '15:00', '19:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-20', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-20', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-21', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-21', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-22', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-22', '15:00', '19:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-27', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-27', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-28', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-28', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-29', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-04-29', '15:00', '19:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-04', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-04', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-05', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-05', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-06', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-06', '15:00', '19:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-11', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-11', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-12', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-12', '15:00', '19:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-13', '10:00', '14:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(18, '2020-05-13', '15:00', '19:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-09', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-09', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-10', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-10', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-11', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-11', '15:00', '19:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-16', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-16', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-17', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-17', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-18', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-18', '15:00', '19:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-23', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-23', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-24', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-24', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-25', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-25', '15:00', '19:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-30', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-04-30', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-01', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-01', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-02', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-02', '15:00', '19:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-07', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-07', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-08', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-08', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-09', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-09', '15:00', '19:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-14', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-14', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-15', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-15', '15:00', '19:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-16', '10:00', '14:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (19, '2020-05-16', '15:00', '19:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-06', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-06', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-07', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-07', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-08', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-08', '16:00', '20:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-13', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-13', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-14', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-14', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-15', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-15', '16:00', '20:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-20', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-20', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-21', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-21', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-22', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-22', '16:00', '20:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-27', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-27', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-28', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-28', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-29', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-04-29', '16:00', '20:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-04', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-04', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-05', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-05', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-06', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-06', '16:00', '20:00', 0);

INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-11', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-11', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-12', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-12', '16:00', '20:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-13', '11:00', '15:00', 0);
INSERT INTO WorkingDays(riderId, workDate, intervalStart, intervalEnd, numCompleted) VALUES(20, '2020-05-13', '16:00', '20:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-09', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-09', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-10', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-10', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-11', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-11', '16:00', '20:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-16', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-16', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-17', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-17', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-18', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-18', '16:00', '20:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-23', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-23', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-24', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-24', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-25', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-25', '16:00', '20:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-30', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-04-30', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-01', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-01', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-02', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-02', '16:00', '20:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-07', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-07', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-08', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-08', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-09', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-09', '16:00', '20:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-14', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-14', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-15', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-15', '16:00', '20:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-16', '11:00', '15:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (21, '2020-05-16', '16:00', '20:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-09', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-09', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-10', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-10', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-11', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-11', '18:00', '22:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-16', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-16', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-17', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-17', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-18', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-18', '18:00', '22:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-23', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-23', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-24', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-24', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-25', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-25', '18:00', '22:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-30', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-04-30', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-01', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-01', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-02', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-02', '18:00', '22:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-07', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-07', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-08', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-08', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-09', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-09', '18:00', '22:00', 0);

INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-14', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-14', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-15', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-15', '18:00', '22:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-16', '13:00', '17:00', 0);
INSERT INTO WorkingDays (riderId, workDate, intervalStart, intervalEnd, numCompleted) values (22, '2020-05-16', '18:00', '22:00', 0);


-- Create 5 Full Timers
insert into FullTime (riderId) values (23);
insert into FullTime (riderId) values (24);
insert into FullTime (riderId) values (25);
insert into FullTime (riderId) values (26);
insert into FullTime (riderId) values (27);

-- Create WorkingWeeks
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-01', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-02', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-03', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-04', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-05', 3, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-08', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-09', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-10', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-11', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-12', 3, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-15', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-16', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-17', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-18', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-19', 3, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-22', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-23', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-24', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-25', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-04-26', 3, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-05', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-06', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-07', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-08', 3, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-09', 3, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-12', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-13', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-14', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-15', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-16', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-19', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-20', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-21', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-22', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-23', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-26', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-27', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-28', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-29', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(23, '2020-05-30', 1, 0);


INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-01', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-02', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-03', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-04', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-05', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-08', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-09', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-10', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-11', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-12', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-15', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-16', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-17', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-18', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-19', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-22', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-23', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-24', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-25', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-04-26', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-05', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-06', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-07', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-08', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-09', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-12', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-13', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-14', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-15', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-16', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-19', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-20', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-21', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-22', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-23', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-26', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-27', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-28', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-29', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(24, '2020-05-30', 1, 0);


INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-03', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-04', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-05', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-06', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-07', 2, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-10', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-11', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-12', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-13', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-14', 2, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-17', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-18', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-19', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-20', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-21', 2, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-24', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-25', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-26', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-27', 2, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(25, '2020-04-28', 2, 0);


INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-02', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-03', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-04', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-05', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-06', 4, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-09', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-10', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-11', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-12', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-13', 4, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-16', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-17', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-18', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-19', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-20', 4, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-23', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-24', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-25', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-26', 4, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(26, '2020-04-27', 4, 0);


INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-04', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-05', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-06', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-07', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-08', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-11', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-12', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-13', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-14', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-15', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-18', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-19', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-20', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-21', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-22', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-25', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-26', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-27', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-28', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-04-29', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-05', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-06', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-07', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-08', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-09', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-12', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-13', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-14', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-15', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-16', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-19', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-20', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-21', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-22', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-23', 1, 0);

INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-26', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-27', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-28', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-29', 1, 0);
INSERT INTO WorkingWeeks(riderId, workDate, shiftID, numCompleted) VALUES(27, '2020-05-30', 1, 0);

-- Create 5 Orders
insert into CustomerLocations (custLocation, area) values ('S100123', 'North');
insert into CustomerLocations (custLocation, area) values ('S100124', 'North');
insert into CustomerLocations (custLocation, area) values ('S100159', 'South');
insert into CustomerLocations (custLocation, area) values ('S100170', 'West');
insert into CustomerLocations (custLocation, area) values ('S100190', 'North');
insert into Orders (customerID, orderDate, deliveryLocation, totalCost, orderTime, departureTimeToRestaurant, arrivalTimeAtRestaurant, departureTimeToDestination, arrivalTimeAtDestination, paymentMode) values (1, '2020-05-06', 'S100123', 0, '11:59:20', '12:00:00', '12:05:00', '12:10:00', '12:15:00', 'Card');
insert into OrderDetails (orderId, restaurantId, itemName, quantity, orderCost) values (1, 5, 'Miso Ramen', 3, 48.6);
insert into Delivers (orderId, riderId, rating) values (1, 20, 3);
insert into Orders (customerID, orderDate, deliveryLocation, totalCost, orderTime, departureTimeToRestaurant, arrivalTimeAtRestaurant, departureTimeToDestination, arrivalTimeAtDestination, paymentMode) values (2, '2020-05-06', 'S100124', 0, '11:59:15', '12:00:00', '12:06:00', '12:16:00', '12:20:00', 'Card');
insert into OrderDetails (orderId, restaurantId, itemName, quantity, orderCost) values (2, 4, 'Kung Pow Chicken', 3, 49.2);
insert into Delivers (orderId, riderId, rating) values (2, 20, 0);
insert into Orders (customerID, orderDate, deliveryLocation, totalCost, orderTime, departureTimeToRestaurant, arrivalTimeAtRestaurant, departureTimeToDestination, arrivalTimeAtDestination, paymentMode) values (3, '2020-05-07', 'S100159', 0, '12:30:00', '13:00:00', '13:05:00', '13:10:00', '13:15:00', 'Card');
insert into OrderDetails (orderId, restaurantId, itemName, quantity, orderCost) values (3, 2, 'Beef Burger', 3, 41.1);
insert into Delivers (orderId, riderId, rating) values (3, 21, 1);
insert into Orders (customerID, orderDate, deliveryLocation, totalCost, orderTime, departureTimeToRestaurant, arrivalTimeAtRestaurant, departureTimeToDestination, arrivalTimeAtDestination, paymentMode) values (4, '2020-05-07', 'S100170', 0, '15:10:00', '16:00:00', '16:05:00', '16:10:00', '16:15:00', 'Card');
insert into OrderDetails (orderId, restaurantId, itemName, quantity, orderCost) values (4, 3, 'Pork Chops', 3, 57.6);
insert into Delivers (orderId, riderId, rating) values (4, 22, 2);
insert into Orders (customerID, orderDate, deliveryLocation, totalCost, orderTime, departureTimeToRestaurant, arrivalTimeAtRestaurant, departureTimeToDestination, arrivalTimeAtDestination, paymentMode) values (5, '2020-05-07', 'S100190', 0, '18:00:00', '18:02:00', '18:05:00', '18:10:00', '18:15:00', 'Card');
insert into OrderDetails (orderId, restaurantId, itemName, quantity, orderCost) values (5, 6, 'Mushroom Risotto', 3, 53.1);
insert into Delivers (orderId, riderId, rating) values (5, 22, 5);

-- Create 5 Reviews
insert into Reviews (orderId, review, rating) values (1, 'Fast and good', 4);
insert into Reviews (orderId, review, rating) values (2, 'Good pricing', 5);
insert into Reviews (orderId, review, rating) values (3, 'Food was delicious', 5);
insert into Reviews (orderId, review, rating) values (4, 'Good pricing', 4);
insert into Reviews (orderId, review, rating) values (5, 'Fast delivery time', 4);
