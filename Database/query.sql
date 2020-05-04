/*General Function*/
INSERT INTO Customers(customerId, first_name, last_name) VALUES ($1, $2, $3); --add customers
INSERT INTO Employees (employeeId, employmentType) VALUES ($1, $2); --add Employees
INSERT INTO FDSManagers (managerId) VALUES ($1); --add FDSManagers
INSERT INTO DeliveryRiders (riderId) VALUES ($1); --add Delivery Riders
INSERT INTO PartTimers (riderId) VALUES ($1); --add part timers
INSERT INTO FullTimers (riderId) VALUES ($1); --add full timers
DELETE FROM Customers where customerId = $1; --delete users

INSERT INTO Orders (orderId, CustomerId, riderId, restaurantId, dateOfOrder, timeOfOrder, deliveryLocationArea, totalCost, departureTimeToRestaurant, arrivialTimeAtRestaurant, departureTimeToDestination, arrivalTimeAtDestination) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);
INSERT INTO Menu (itemId, restuarnatId, itemName, price, category, dailyLimit) VALUES ($1, $2, $3, $4, $5, $6);
INSERT INTO Reviews (reviewId, orderId, review, rating) VALUES ($1, $2, $3, $4);

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
--View average delivery time for rider/month
--View total number of ratings for all orders received for rider/month
--View average rating for rider/month

/*Fds Rider Functions*/
--Record time rider departs for restaurant
--Record time rider arrives at the restaurant
--Record time rider leaves the restaurant
--Record the time the rider deliver the order
--View past work schedule
--View past salaries
--Select total number of orders delivered rider/month
--Select total number of orders delivered rider/week
--Select total number of hours worked rider/month
