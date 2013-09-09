{resolve} = require 'path'
module.exports =
  port: process.env.PORT or 8080
  db: 
    url: process.env.MONGODB or "mongodb://localhost/apitest"
  paths:
    models: resolve './server/models/*'