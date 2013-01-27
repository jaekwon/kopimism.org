{hotswap} = require 'cardamom'
http    = require 'http'
express = require 'express'
log     = require('nogg').logger('server')
config  = require './config'
cm      = require 'coffeemugg'
# RedisStore = require('connect-redis')(express)
# connect = require 'connect'
# Session = connect.middleware.session.Session

log.info "Server starting..."
process.on 'uncaughtException', (err) ->
  log.error "________________"
  log.error "http://debuggable.com/posts/node-js-dealing-with-uncaught-exceptions:4c933d54-1428-443c-928d-4e1ecbdd56cb"
  log.error err.message
  log.error err.stack
  log.error "^^^^^^^^^^^^^^^^"

# parseCookie = (cookieString) ->
#   return connect.utils.parseSignedCookies(
#     require('cookie').parse(decodeURIComponent(cookieString)),
#     config.secret
#   )

## Init express
app = express()
server = http.createServer app # needed for socket.io (https://github.com/visionmedia/express/wiki/Migrating-from-2.x-to-3.x)
app.use express.logger()
app.use express.staticCache()
app.use express.static __dirname + '/static'
app.use express.cookieParser config.secret
app.use express.query()
app.use express.bodyParser()
# app.use express.session {
#   store:  gSessionStore = new RedisStore()
#   cookie: { maxAge: 1000*60*60*24*30 }
#   secret: config.secret
# }

## CoffeeMugg (templating engine) plugins
cm.install_plugin require('./plugins/marked')
cm.install_plugin require('./plugins/partials')(require, './templates')

## Request handling
app.get '/', (req, res) ->
  html = cm.render hotswap(require, './templates/index.coffee').template, {format:yes}
  res.end html

## Init server
server.listen(config.server.port, '0.0.0.0')
log.info "Server started on port #{config.server.port}"
