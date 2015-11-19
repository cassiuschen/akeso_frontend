express        = require 'express'
http           = require('http').Server express
app            = express()

favicon        = require 'serve-favicon'
routes         = require './config/routes'
adminRoutes    = require './config/admin_routes'

path           = require 'path'
logger         = require 'morgan'
cookieParser   = require 'cookie-parser'
bodyParser     = require 'body-parser'
expressSession = require 'express-session'
methodOverride = require 'method-override'

jade           = require 'jade'
fs             = require 'fs'

leancloud      = require 'avoscloud-sdk'

# uncomment after placing your favicon in /public
# app.use favicon(__dirname + '/public/favicon.ico')

app.use logger('dev')

app.all '*', (req, res, next) ->
    res.header("Access-Control-Allow-Origin", "*")
    res.header("Access-Control-Allow-Headers", "X-Requested-With")
    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS")
    #res.header("Content-Type", "application/json;charset=utf-8;")
    next()

#app.engine 'jade', (filePath, options, callback) ->
#	fs.readFile filePath, (err, content) ->
#		if err
#			return callback(new Error(err))
#		else
#			rendered = slm.render content.toString()
#			callback null, rendered
app.engine('jade', require('jade').__express);
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/app/views'
app.use express.static __dirname + '/public'
app.use bodyParser.json()
app.use methodOverride()
app.use bodyParser.urlencoded extended: false
app.use cookieParser()
app.use expressSession secret: 'secret key'



app.use('/', routes)
app.use('/admin', adminRoutes)

# catch 404 and forward to error handler
app.use (req, res, next) ->
	err        = new Error('Not Found')
	err.status = 404
	next err

# error handlers

# development error handler
# will print stacktrace
if app.get('env') == 'development'
	app.use (err, req, res, next) ->
		res.status(err.status || 500)
		console.log err.message
		res.render 'error',
			message: err.message,
			error: err

app.use (err, req, res, next) ->
	res.status(err.status || 500)
	res.render 'error', 
		message: err.message,
		error: {}

module.exports = app