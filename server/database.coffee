config = require './config'
db = require('goosestrap') config.db.url, config.paths.models
db.on 'error', (err) -> console.log err

module.exports = db