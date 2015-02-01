"use strict"

React = require "react"
TagStore = require "../stores/tag-store"

NewTag = module.exports = React.createClass
  onSubmit: (ev)->
    ev.preventDefault()

    tag = @refs.tag.getDOMNode().value.trim()
    host = @refs.host.getDOMNode().value.trim()
    port = @refs.port.getDOMNode().value.trim()

    TagStore.create {tag, host, port}

  render: ->
    <div className="row">
      <h2 className="well">Create New Tag</h2>
      <form className="form-inline" onSubmit={@onSubmit}>
        <div className="form-group">
          <label>Tag</label>
          <input type="text" ref="tag" /><br />
        </div>
        <div className="form-group">
          <label>Host</label>
          <input type="text" ref="host" /><br />
        </div>
        <div className="form-group">
          <label>Port</label>
          <input type="text" ref="port" /><br />
        </div>
        <button className="btn btn-default" type="submit">Submit</button>
      </form>
    </div>
