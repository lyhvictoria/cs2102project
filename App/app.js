var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
require('dotenv').config();

/* -------Page Routers-------- */
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var aboutRouter = require('./routes/about');
var selectRouter = require('./routes/select'); // database connect
var c_rest_displayRouter = require('./routes/c_rest_display');
/* ---------------------------- */

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

/* --------Pages---------- */
app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/about', aboutRouter);
app.use('/select', selectRouter); // database connect
app.use('/c_rest_display', c_rest_displayRouter);
/* ---------------------------- */

/* ----- Error Handler Section ----- */
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
/* ---------------------------- */

/* --------Render Pages-------- */
app.get('/', (req, res) => {
	res.render('index');
});

app.get('/about', (req, res) => {
	res.render('about');
});

app.get('/c_rest_display', (req, res) => {
	res.render('c_rest_display');
});
/* ---------------------------- */

module.exports = app;
