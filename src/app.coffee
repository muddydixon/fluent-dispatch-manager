"use strict"

http = require "http"
Fs = require "fs"
commander = require "commander"
Redis = require "redis"
express = require "express"
Static = require "serve-static"
BodyParser = require "body-parser"
CookieParser = require "cookie-parser"
Promise = require "bluebird"

Constants = require "./constants"

program = commander
.option("-p,--port <port>", "port", Number, 8080)


redis = Redis.createClient(host: "localhost", port: 6379)
index = Fs.readFileSync("public/index.html", "utf8")

["keys", "get", "set"].forEach (name)->
  redis[name].d = ->
    args = [].slice.apply arguments
    new Promise (resolve, reject)->
      args.push (err, results)->
        return reject(err) if err
        resolve(results)

      redis[name].apply(redis, args)

app = express()
app.use Static("./public", {index: ["index.html"]})
app.use BodyParser()
app.use CookieParser()

app.get "/api/0.0/tags", (req, res, next)->
  redis.keys.d("#{Constants.TAGPREFIX}:*")
  .then((keys)->
    Promise.map(keys, (key)->
      redis.get.d(key)
      .then((val)->
        [host, port] = val.split(":")
        tag: key.replace(/^fluent:dispatch:/, ""), host: host, port: port
      )
    )
  )
  .then((tags)->
    res.json {tags: tags}
  )
  .catch(next)

app.post "/api/0.0/tags", (req, res, next)->
  redis.set.d([Constants.TAGPREFIX, req.body.tag].join(":"), [req.body.host, req.body.port].join(":"))
  .then(->
    res.json tag: req.body
  )
  .catch(next)

app.use (err, req, res, next)->
  console.log err
  res.json 500, {error: err}

server = http.createServer(app)

server.listen program.port
server.on "listening", ->
  console.log "server start on #{program.port}"
