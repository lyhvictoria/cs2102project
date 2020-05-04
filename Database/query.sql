/*General Functions*/
INSERT INTO Customers(customerId, first_name, last_name) VALUES ($1, $2, $3); --add customers
INSERT INTO Employees (employeeId, employmentType) VALUES ($1, $2); --add Employees
INSERT INTO FDSManagers (managerId) VALUES ($1); --add FDSManagers
INSERT INTO DeliveryRiders (riderId) VALUES ($1); --add Delivery Riders
INSERT INTO PartTimers (riderId) VALUES ($1); --add part timers
INSERT INTO FullTimers (riderId) VALUES ($1); --add full timers
DELETE FROM Customers where customerId = $1; --delete users

INSERT INTO Orders (orderId, CustomerId, riderId, restaurantId, dateOfOrder, timeOfOrder, deliveryLocationArea, totalCost, departureTimeToRestaurant, arrivialTimeAtRestaurant, departureTimeToDestiantion, arrivalTimeAtDestiantion) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);

/*Restaurant staff Functions*/
-- See restaurant info
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
INSERT INTO Menu (itemId, restaurantId, itemName, price, category, dailyLimit) VALUES ($1, $2, $3, $4, $5, $6);
-- Select promo



/*Customer Functions*/
-- Get all restaurants
SELECT DISTINCT restaurantId, name,  area, minSpendingAmt
FROM Restaurants
;
-- Get all restaurants from area
SELECT DISTINCT restaurantId, name,  area, minSpendingAmt
FROM Restaurants
where area = $1
;
-- Get info for specific restaurant
SELECT DISTINCT restaurantId, name,  area, minSpendingAmt
FROM Restaurants
WHERE restaurantId = $1
;
-- See all menu items for selected restaurant
SELECT DISTINCT itemId, itemName, price, category, isAvailable, dailyLimit
FROM Menus
WHERE restaurantId = $1
;
-- Filter by cuisine
SELECT DISTINCT itemId, itemName, price, category, isAvailable, dailyLimit
FROM Menus
WHERE restaurantId = $1 AND category = $2
;
-- Make/ Add review
INSERT INTO Reviews (reviewId, orderId, review, rating) VALUES ($1, $2, $3, $4);
--See review posting
SELECT DISTINCT Res.name as Restaurant, O.dateOfOrder as OrderDate, Rev.review as Review, Rev.rating as Rating
FROM Restaurant Res JOIN Orders O ON (Res.restaurantId = O.restaurantId) JOIN Reviews Rev ON (O.orderId = Rev.orderId)
ORDER BY Res.name
;
-- See past orders
SELECT O.dateOfOrder as OrderDate, Res.name as Restaurant, M.itemName as ItemName, OD.quantity as Quantity
FROM Orders O JOIN Restaurants Res ON (O.restaurantId = Res.restaurantId)
JOIN OrderDetails OD ON (O.orderId = OD.orderId)
JOIN Menus M ON (M.restaurantId = Res.restaurantId) AND (M.itemId = OD.itemID)
WHERE O.customerId = $1
ORDER BY O.dateOfOrder
;
-- Add menu items to order
INSERT INTO OrderDetails (orderId, itemID, quantity, promotionId, orderCost, pointsObtained, pointsRedeemed) VALUES ($1, $2, $3, $4, $5, $6, $7);
-- select price range
SELECT R.name as RestaurantName, minSpendingAmt, itemName, price, isAvailable, minSpendingAmt
FROM Menus M JOIN Restaurants R ON (M.restaurantId = R.restaurantId)
WHERE price >= $1 AND price <=$2
-- select payment method
UPDATE Orders
SET paymentMode = $1
WHERE orderId = $2
;
-- enter card number (if payment by card)
INSERT INTO CreditCards (customerId, cardNumber) VALUES ($1, $2)
-- select recent order
SELECT O.orderId, R.name as RestaurantName, M.itemName, OD.quantity
FROM Orders O JOIN OrderDetails OD ON (O.orderId = OD.orderId)
JOIN Restaurants R ON (O.restaurantId = R.restaurantId) JOIN Menus M ON (OD.itemId = M.itemId)
WHERE O.customerId = $1
AND (O.dateOfOrder, O.timeOfOrder) >= ALL (
  SELECT dateOfOrder, timeOfOrder
  FROM Orders O1
  WHERE O1.orderId = O.orderId
  AND O1.customerId = $1
);
-- select promo
UPDATE OrderDetails
SET promotionId = $1
WHERE orderId = $2
;





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
