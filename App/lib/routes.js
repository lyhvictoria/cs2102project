var util = require('util');
var express = require('express');
var app = express();
var passport = require("passport");

var fs = require('fs');
var request = require('request');
const { Pool, Client } = require('pg')
const bcrypt= require('bcrypt')
const uuidv4 = require('uuid/v4');
//TODO
//Add forgot password functionality
//Add email confirmation functionality
//Add edit account page


app.use(express.static('public'));

const LocalStrategy = require('passport-local').Strategy;
//const connectionString = process.env.DATABASE_URL;

var currentAccountsData = [{email: "hihi"}];

const pool = new Pool({
	user: process.env.PGUSER,
	host: process.env.PGHOST,
	database: process.env.PGDATABASE,
	password: process.env.PGPASSWORD,
	port: process.env.PGPORT,
	// ssl: true
});

module.exports = function (app) {
	var user = '';

	app.get('/', function (req, res, next) { //http://localhost:3000/
		res.render('index', {title: "Home", userData: req.user, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
		
		console.log(req.user);
	});

	
	app.get('/join', function (req, res, next) { //http://localhost:3000/join/
		res.render('join', {title: "Join", userData: req.user, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
	});
	
	
	app.post('/join', async function (req, res) {
		
		try{
			const client = await pool.connect()
			await client.query('BEGIN')
			var pwd = await bcrypt.hash(req.body.password, 5);
			await JSON.stringify(client.query('SELECT "username" FROM "users" WHERE "username"=$1', [req.body.username], function(err, result) {
				if(result.rows[0]){
					req.flash('warning', "This email address is already registered. <a href='/login'>Log in!</a>");
					res.redirect('/join');
				}
				else{
					client.query('INSERT INTO Users (name, type, username, password) VALUES ($1, $2, $3, $4)', [req.body.name, req.body.type ,req.body.username, pwd], function(err, result) {
						if(err){console.log(err);}
						else {
						
						client.query('COMMIT')
							console.log(result)
							req.flash('success','User created.')
							res.redirect('/login');
							return;
						}
					});
					
					
				}
				
			}));
			client.release();
		} 
		catch(e){throw(e)}
	});

	app.get('/account', function (req, res, next) {
		res.render('account', {title: "Account Page", userData: [{email:"test"}], messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
	});

	app.get('/manager', function (req, res, next) {
		res.render('manager', {title: "Manager Page", userData: [{email:"test"}], messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
	});

	app.get('/select', function (req, res, next) {
		res.render('select', {title: "Select" + " user type", selectData: true, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
	});

	app.post('/select', async function (req, res) {
		try{
			const client = await pool.connect()
			await client.query('BEGIN')
			await JSON.stringify(client.query('SELECT "uid", "username", "type" FROM "users" WHERE "username"=$1', [req.body.username], function(err, result) {
				if(result.rows[0]){
					//* res.redirect('/account');
					// res.render('account', {title: "Account Profile" , usernameData: result.rows[0].username, uidData: result.rows[0].uid, typeData: result.rows[0].type, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
					if(result.rows[0].type === 'Customer') {
						res.render('customer', {title: "Customer", usernameData: result.rows[0].username, uidData: result.rows[0].uid, typeData: result.rows[0].type, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
					} else if(result.rows[0].type === 'FDSManager') {
						res.render('fdsmanager', {title: "FDS Manager", usernameData: result.rows[0].username, uidData: result.rows[0].uid, typeData: result.rows[0].type, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
					} else if(result.rows[0].type === 'RestaurantStaff') {
						res.render('restaurantstaff', {title: "Restaurant Staff", usernameData: result.rows[0].username, uidData: result.rows[0].uid, typeData: result.rows[0].type, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
					} else if(result.rows[0].type === 'DeliveryRider') {
						res.render('deliveryrider', {title: "Delivery Riders", usernameData: result.rows[0].username, uidData: result.rows[0].uid, typeData: result.rows[0].type, messages: {danger: req.flash('danger'), warning: req.flash('warning'), fail: req.flash('failure')}});
					}
				}
				else{
					res.render('login', {title: "Login", messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
				}

			}));
			client.release();
		}
		catch(e){throw(e)}
	});
	
	app.get('/login', function (req, res, next) {
		if (req.isAuthenticated()) {
			res.redirect('/account');
			// res.render('account', {title: "Account1", userData: req.user, userData: req.user, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
		}
		else{
			res.render('login', {title: "Log in", userData: req.user, messages: {danger: req.flash('danger'), warning: req.flash('warning'), success: req.flash('success')}});
		}
		
	});
	
	app.get('/logout', function(req, res){
		
		console.log(req.isAuthenticated());
		req.logout();
		console.log(req.isAuthenticated());
		req.flash('success', "Logged out. See you soon!");
		res.redirect('/');
	});
	
	app.post('/login',	passport.authenticate('local', {
		successRedirect: '/select',
		failureRedirect: '/login',
		failureFlash: true,
		successFlash: 'Welcome!'
		}), function(req, res) {
		if (req.body.remember) {
			req.session.cookie.maxAge = 30 * 24 * 60 * 60 * 1000; // Cookie expires after 30 days
			} else {
			req.session.cookie.expires = false; // Cookie expires at end of session
		}
		res.redirect('/');
	});


	
}

passport.use('local', new  LocalStrategy({passReqToCallback : true}, (req, username, password, done) => {
	
	loginAttempt();
	async function loginAttempt() {
		
		
		const client = await pool.connect()
		try{
			await client.query('BEGIN')
			var currentAccountsData = (await JSON.stringify(client.query('SELECT "username", "password" FROM "users" WHERE "username"=$1', [username], function(err, result) {
				if(err) {
					return done(err)
				}	
				if(result.rows[0] == null){
					req.flash('danger', "Oops. Incorrect login details.");
					return done(null, false);
				}
				else{
					bcrypt.compare(password, result.rows[0].password, function(err, check) {
						if (err){
							console.log('Error while checking password');
							return done();
						}
						else if (check){
							return done(null, [{email: result.rows[0].email}]);
						}
						else{
							req.flash('danger', "Oops. Incorrect login details.");
							return done(null, false);
						}
					});
				}
			})))

		}
		
		catch(e){throw (e);}
	};
	
}
))




passport.serializeUser(function(user, done) {
	done(null, user);
});

passport.deserializeUser(function(user, done) {
	done(null, user);
});		