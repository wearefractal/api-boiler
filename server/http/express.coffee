express = require 'express'
config = require '../config'

app = express()
app.use express.compress()
app.use express.methodOverride()
app.use express.bodyParser()
app.use express.cookieParser()

app.use express.session
  secret: "keyboardcat"
  maxAge: 31536000000

module.exports = app