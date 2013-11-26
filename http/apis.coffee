config = require "../config"
app = require "./express"
db = require "../mongodb"
crudify = require "crudify"

crud = crudify db
crud.expose api for api in config.apis
crud.hook "/v1/", app

# dont let users mess us around
crud.get('Item').pre 'handle', (req, res, next) ->
  if req.body and req.method is 'POST'
    req.body.author = req.user?._id
  next()

module.exports = app