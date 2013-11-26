express = require "express"
passport = require "passport"
config = require "../config"

app = express()
app.use express.compress()
app.use express.methodOverride()
app.use express.bodyParser()
app.use express.cookieParser()

app.use express.session
  secret: config.cookieSecret
  maxAge: 31536000000

app.use passport.initialize()
app.use passport.session()

module.exports = app