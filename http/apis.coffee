config = require "../config"
app = require "./express"
db = require "../mongodb"
crudify = require "crudify"

crud = crudify db

crud.expose "URL"

crud.hook "/v1/", app

module.exports = app