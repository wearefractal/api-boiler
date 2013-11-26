db = require '../mongodb'
User = db.model 'User'

passport = require "passport"
TwitterStrategy = require("passport-twitter").Strategy

config = require '../config'
app = require './express'

handleFunction = (token, tokenSecret, profile, cb) ->
  User.findOne {handle:profile.username}, (err, user) ->
    return cb err if err?
    profileUpdate =
      id: String profile._json.id
      token: token
      tokenSecret: tokenSecret
      name: profile._json.name
      handle: profile._json.screen_name
      description: profile._json.description
      followers: profile._json.followers_count
      location: profile._json.location
      banner: profile._json.profile_banner_url
      image: profile._json.profile_image_url_https
      website: profile._json.url
      verified: profile._json.verified
    if user?
      user.set profileUpdate
      user.save cb
    else
      User.create profileUpdate, (err, doc) ->
        return cb err if err?
        cb null, doc

strategy = new TwitterStrategy
  consumerKey: config.twitter.consumerKey
  consumerSecret: config.twitter.secretKey
  callbackURL: config.twitter.callback
, handleFunction

passport.use strategy

passport.serializeUser (user, cb) ->
  cb null, user._id

passport.deserializeUser (id, cb) ->
  User.findById id, cb

app.get '/auth/twitter', passport.authenticate 'twitter'
app.get '/auth/twitter/callback', passport.authenticate 'twitter',
  successRedirect: '/'
  failureRedirect: '/login?failed=true'

app.get '/logout', (req, res) ->
  req.logout()
  res.redirect '/'

module.exports = passport