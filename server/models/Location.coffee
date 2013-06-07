{Schema} = require 'mongoose'

Location = new Schema
  name:
    type: String
    required: true
  latitude:
    type: Number
    required: true
  longitude:
    type: Number
    required: true

module.exports = Location