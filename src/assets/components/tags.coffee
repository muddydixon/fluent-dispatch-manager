"use strict"

React = require "react"

Constants = require "../../constants"
TagStore = require "../stores/tag-store"
NewTag = require "./new-tag"

Tags = module.exports = React.createClass
  getInitialState: ->
    tags: []
  onChange: (event, payload)->
    @setState tags: TagStore.getAll()

  componentWillMount: ->
    TagStore.on(Constants.CHANGE_EVENT, @onChange)
    TagStore.fetchAll()
  componentWillUnmount: ->
    TagStore.off(Constants.CHANGE_EVENT, @onChange)

  render: ->
    <div>
      <table className="table table-striped">
        <thead>
          <tr>
            <th>Tag</th>
            <th>Host</th>
            <th>Port</th>
          </tr>
        </thead>
        <tbody>
          {@state.tags.map (tag)->
            <tr>
              <td>{tag.tag}</td>
              <td>{tag.host}</td>
              <td>{tag.port}</td>
            </tr>
          }
        </tbody>
      </table>
      <NewTag />
    </div>
