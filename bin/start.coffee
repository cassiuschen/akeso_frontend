app = require '../app'

app.set 'port', process.env.PORT || 3000
app.set 'env', process.env.NODE_ENV || 'development'

server = app.listen app.get('port'), ->
	console.log 'Express server listening on port ' + server.address().port
	console.log "================ #{app.get 'env'} MODE ==================="
