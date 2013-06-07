config = require '../config'
app = require './express'
crudify = require 'crudify'
db = require '../database'

crud = crudify db
crud.expose 'User'
crud.expose 'Movie'
crud.expose 'Location'
crud.hook '/v1/', app

module.exports = app