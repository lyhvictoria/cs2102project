/*General Functions*/
INSERT INTO Customers(customerId, first_name, last_name) VALUES ($1, $2, $3); --add customers
INSERT INTO Employees (employeeId, employmentType) VALUES ($1, $2); --add Employees
INSERT INTO FDSManagers (managerId) VALUES ($1); --add FDSManagers
INSERT INTO DeliveryRiders (riderId) VALUES ($1); --add Delivery Riders
INSERT INTO PartTimers (riderId) VALUES ($1); --add part timers
INSERT INTO FullTimers (riderId) VALUES ($1); --add full timers
DELETE FROM Customers where customerId = $1; --delete users

INSERT INTO Orders (orderId, CustomerId, riderId, restaurantId, dateOfOrder, timeOfOrder, deliveryLocationArea, totalCost, departureTimeToRestaurant, arrivialTimeAtRestaurant, departureTimeToDestination, arrivalTimeAtDestination) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);

/*Restaurant staff Functions*/
SELECT itemName
FROM Menus
WHERE --see all menu items
--filter by cuisine
--set menus utems daily limit
--update menu item information
--select promo

/*Customer Functions*/
--select restaurant from list
--see all menu items
--add menu items to order
--filter by cuisine
--select price range
--select payment method
--enter card number (if payment by card)
--select recent order
--select promo
--See review posting
SELECT DISTINCT Res.name as Restaurant, O.dateOfOrder as OrderDate, Rev.review as Review, Rev.rating as Rating
FROM Restaurant Res JOIN Orders O USING (restaurantId) JOIN Reviews Rev USING (orderId)
ORDER BY Res.name
;
-- See past orders
SELECT as OrderDate, as Restaurant, as ItemName, as Quantity
FROM Orders O JOIN 
;
-- See resturant info
SELECT DISTINCT R.restaurantId, name, area, minSpendingAmt
FROM Restaurants INNER JOIN RestaurantStaff RS on R.restaurantId =  RS.restaurantId
WHERE RS.restaurantId = $1 LIMIT 1
;
-- See all menu items
SELECT DISTINCT itemId, itemName, price, category, isAvailable, dailyLimit
FROM Menus
WHERE restaurantId = $1
;
-- Filter by cuisine
SELECT DISTINCT itemId, itemName, price, category, isAvailable, dailyLimit
FROM Menus
WHERE restaurantId = $1 AND category = $2
;
-- Set menus items daily limit
UPDATE Menus
SET dailyLimit = $1
WHERE itemId = $2
;
-- Update menu item price
UPDATE Menus
SET price = $1
WHERE itemId = $2
;

-- Add menu item
INSERT INTO Menu (itemId, restuarnatId, itemName, price, category, dailyLimit) VALUES ($1, $2, $3, $4, $5, $6);

-- Select promo

/*Customer Functions*/
-- Get all restaurants
SELECT DISTINCT restuarnatId, name,  area, minSpendingAmt
FROM Restaurants
;
-- Get all resturants from area
SELECT DISTINCT restuarnatId, name,  area, minSpendingAmt
FROM Restaurants
where area = $1
;
-- Get info for specific resturant
SELECT DISTINCT restuarnatId, name,  area, minSpendingAmt
FROM Restaurants
WHERE restaurantId = $1
;
-- See all menu items for selected resturant
SELECT DISTINCT itemId, itemName, price, category, isAvailable, dailyLimit
FROM Menus
WHERE restaurantId = $1
;
-- Filter by cuisine
SELECT DISTINCT itemId, itemName, price, category, isAvailable, dailyLimit
FROM Menus
WHERE restaurantId = $1 AND category = $2
;
-- Add menu items to order

-- Make/ Add review
INSERT INTO Reviews (reviewId, orderId, review, rating) VALUES ($1, $2, $3, $4);

-- select price range
-- select payment method
-- enter card number (if payment by card)
-- select recent order
-- select promo
--view review posting
--view past orders


/*Fds Manager Functions*/
--select promo
--select total number of orders delivered per rider per month
--Select total number of hours worked rider/month
--Select total salary earned rider/month
--View total new customers/month
--View total number of orders/month
--View total cost of all orders/month
--View total number of orders/month/customer
--View total cost of all orders/month/customer
--View total number of orders/hour/location

--View orders delivered for riders/month
--View hours worked by rider/month
--View total salary earned by rider/month
--View average delivery time for rider/month
--View total number of ratings for all orders received for rider/month
--View average rating for rider/month


/*Fds Rider Functions*/
--Record time rider departs for restaurant
--Record time rider arrives at the restaurant
--Record time rider leaves the restaurant
--Record the time the rider deliver the order
--View total orders for week by rider
--View total orders for month by rider
--View hours worked by rider/month
--View past salaries
--Select total number of orders delivered rider/month
--Select total number of orders delivered rider/week
--Select total number of hours worked rider/month
