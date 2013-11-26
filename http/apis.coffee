config = require "../config"
app = require "./express"
db = require "../mongodb"
crudify = require "crudify"

crud = crudify db
crud.expose api for api in config.apis
crud.hook "/v1/", app

module.exports = app