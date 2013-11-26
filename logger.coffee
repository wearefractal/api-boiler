winston = require "winston"
config = require "./config"

# file logging
winston.add winston.transports.File,
  filename: config.logFile
  json: false

module.exports = winston