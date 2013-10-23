express = require 'express'
http = require 'http'
path = require 'path'

app = express()
app.set 'port', process.env.PORT || 5000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'hjs'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use require('less-middleware')(src: __dirname + '/public')
app.use require('coffee-middleware')(src: __dirname + '/public')
app.use express.static(path.join(__dirname, 'public'))

app.use express.errorHandler() if app.get('env') == 'development'

app.get '/', (req, res) ->
  res.render 'index'

server = http.createServer(app)
io = require('socket.io').listen(server)

require('./sio')(io)

server.listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
