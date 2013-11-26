mongoose = require "mongoose"
{Schema} = mongoose

noWrite = ->
  perms =
    read: true
    write: false
  return perms

hidden = ->
  perms =
    read: false
    write: false
  return perms

Item = new Schema
  author:
    type: Schema.Types.ObjectId
    ref: 'User'
    authorize: noWrite

  name:
    type: String
    required: true

  # Dates
  created_at:
    type: Date
    default: Date.now
    authorize: noWrite

  updated_at:
    type: Date
    default: Date.now
    authorize: noWrite

Item.methods.authorize = (req) ->
  isAuthor = String(req.user._id) is String(this.author)
  perms =
    read: isAuthor
    write: isAuthor
    delete: isAuthor
  return perms

Item.statics.authorize = (req) ->
  loggedIn = req.user?
  perms =
    read: loggedIn
    write: loggedIn
  return perms

module.exports = Item