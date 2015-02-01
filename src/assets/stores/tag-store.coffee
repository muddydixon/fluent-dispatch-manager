"use strict"

request = require "superagent"
Constants = require "../../constants"

tags = []
callbacks = {}

TagStore = module.exports =
  getAll: ->
    tags

  create: (tag)->
    request.post("/api/0.0/tags")
      .send(tag)
      .end((err, data)=>
        tags.push data.body.tag
        @onChange(Constants.CHANGE_EVENT, data.body.tag)
      )

  fetchAll: ->
    request.get("/api/0.0/tags")
      .set("Content-type", "application/json")
      .end((err, data)=>
        tags = data.body.tags
        @onChange(Constants.CHANGE_EVENT, data.body.tags)
      )

  on: (event, callback)->
    callbacks[event] ?= [callback] or callbacks[event].push callback

  off: (event, callback)->
    unless callback
      delete callbacks[event]
    else
      callbacks[callback].splice(callbacks[event].indexOf(callback), 1)
  onChange: (event, payload)->
    if callbacks[event]
      callbacks[event].forEach (callback)->
        callback(event, payload)
