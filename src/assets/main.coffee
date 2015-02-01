"use strict"

React = require "react"
Router = require "react-router"
DefaultRouter = Router.DefaultRouter
RouteHandler = Router.RouteHandler
Route = Router.Route

Header = require "./components/header"
Tags = require "./components/tags"

App = module.exports = React.createClass
  render: ->
    <div className="container">
      <Header />
      <RouteHandler />
    </div>

routes =
  <Route path="" handler={App}>
    <Route name="tags" handler={Tags}/>
  </Route>


Router.run routes, (Handler)->
  React.render <Handler />, document.body
