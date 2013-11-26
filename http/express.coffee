express = require "express"
connect = require "connect"
MongoStore = require("connect-mongo")(connect)

passport = require "passport"
config = require "../config"
db = require "../mongodb"

app = express()
app.use express.compress()
app.use express.methodOverride()
app.use express.bodyParser()
app.use express.cookieParser()

sessionStore = new MongoStore
  mongoose_connection: db

app.use express.session
  store: sessionStore
  secret: config.cookieSecret
  maxAge: 31536000000

app.use passport.initialize()
app.use passport.session()

if process.env.NODE_ENV is "production"
  app.disable "verbose errors"

if process.env.NODE_ENV is "development"
  app.use express.logger "dev"

module.exports = app