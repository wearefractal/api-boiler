mongoose = require "mongoose"
{Schema} = mongoose

URL = new Schema
  name:
    type: String

  # Dates
  created_at:
    type: Date
    default: Date.now

  updated_at:
    type: Date
    default: Date.now

module.exports = URL