tryparse = require "try-parse"
process.env = tryparse.parse process.env

cc = require "config-chain"
path = require "path"
{argv} = require "optimist"
env = argv.env or process.env.NODE_ENV or "development"

configWithEnv = path.join __dirname, "./config/", "#{env}.json"
configDefault = path.join __dirname, "./config/", "default.json"
logFile = path.join process.cwd(), "#{env}.log"

conf = cc argv, cc.env("api_"), configWithEnv, configDefault, logFile: logFile

out = conf.snapshot
delete out.$0

module.exports = out