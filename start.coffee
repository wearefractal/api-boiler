config = require "./config"
logger = require "./logger"
db = require "./mongodb"
http = require "./http"

logger.log "info", "Starting with config", config