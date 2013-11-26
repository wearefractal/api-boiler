mongoose = require "mongoose"
async = require "async"
requireDir = require "require-dir"
path = require "path"
config = require "../config"

db = mongoose.createConnection config.mongodb.uri

models = requireDir path.join __dirname, "./models/"

db.loadModel = (k) ->
  # set up some stuff for every model
  models[k].pre "save", (next) ->
    @updated_at = new Date()
    next()

  models[k].set 'toJSON',
    getters: true
    virtuals: true

  models[k].set 'toObject',
    getters: true
    virtuals: true

  models[k].set 'strict', true

  # dont recreate indexes in prod
  if process.env.NODE_ENV is "production"
    models[k].set "autoIndex", false

  db.model k, models[k]

db.wipe = (cb) ->
  fns = db.modelNames().map (k) -> db.model k
  fns = fns.map (m) ->
    return (done) ->
      async.parallel [
        m.remove.bind(m),
        m.collection.dropAllIndexes.bind(m.collection)
      ], done

  async.parallel fns, cb
  return db

db.dump = (modelName, cb) ->
  if typeof modelName is "string"
    Model = db.model modelName
  else
    Model = modelName
  Model.find {}, cb
  return db

db.import = (modelName, models, cb) ->
  if typeof modelName is "string"
    Model = db.model modelName
  else
    Model = modelName
  async.map models, Model.create.bind(Model), cb
  return db

# load all of the models in
Object.keys(models).forEach db.loadModel

module.exports = db