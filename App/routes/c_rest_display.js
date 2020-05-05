/* required for database connection */
var express = require('express');
var router = express.Router();

const sql_query = require('../database/allQueries');

const { Pool } = require('pg')
const pool = new Pool({
    connectionString: process.env.DATABASE_URL
})
/* required for database connection */

var selectedRestId = 1;
var currOrders = [];

function getRestList(req, res, next) {
    pool.query(sql_query.query.list_restaurants, (err, data) => {
        if (err) {
            return next(err);
        }

        req.restList = data.rows;
        return next();
    });
}

function getRestInfo(req, res, next) {
    pool.query(sql_query.query.get_restaurant_info, [selectedRestId], (err, data) => {
        if (err) {
            return next(err);
        }
        req.restInfo = data.rows;
        return next();
    });
}

function getMenu(req, res, next) {
    pool.query(sql_query.query.get_restaurant_menu, [selectedRestId], (err, data) => {
        if (err) {
            return next(err);
        }

        req.menuInfo = data.rows;
        console.log("itemname: " + req.menuInfo[0].itemname);
        return next();
    });
}

function loadPage(req, res, next) {
    res.render('c_rest_display', {
        restList: req.restList,
        restInfo: req.restInfo,
        menuInfo: req.menuInfo,
        currOrder: currOrders
    });
}

router.get('/', getRestList, getRestInfo, getMenu, loadPage);

router.post('/getRest', function (req, res, next) {
    console.log("RestId Selected: " + req.body.restId);
    selectedRestId = req.body.restId;
    res.redirect('/c_rest_display');
});

// CURR NOT WORKING
// Add a order but does not actually insert into the db yet
router.post('/addOrder', function (req, res, next) {
    pool.query(sql_query.query.add_to_order, [selectedRestId, req.body.orderItemName, req.body.orderQuantity], (err, data) => {
        if (err) {
            return next(err);
        }

        currOrders.push(data.rows[0]);
    });
    res.redirect('/c_rest_display');
});

// The acutal db insert here
router.post('/submitOrder', function (req, res, next) {

});
module.exports = router;