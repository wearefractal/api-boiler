config = require './config'
db     = require './database'
app    = require './http/express'
apis   = require './http/apis'

httpServer = require './http/httpServer'

console.log "Server running on #{config.port}"