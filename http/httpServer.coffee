app = require "./express"
config = require "../config"
logger = require "../logger"
http = require "http"

server = http.createServer(app).listen config.port

logger.log "info", "Started on port", config.port

module.exports = server