"use strict"

React = require "react"

Header = module.exports = React.createClass
  render: ->
    <header className="navbar navbar-static-top bs-docs-nav" id="top" role="banner">
      <div className="container">
        <div className="navbar-header">
          <button className="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
            <span className="sr-only">Fluent Dispatcher Manager</span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
          </button>
          <a href="../" className="navbar-brand">Fluent Dispatcher Manager</a>
        </div>
        <nav className="collapse navbar-collapse bs-navbar-collapse">
          <ul className="nav navbar-nav">
            <li>
              <a href="../getting-started/">Getting started</a>
            </li>
          </ul>
          <ul className="nav navbar-nav navbar-right">
            <li><a href="http://fluentd.org">Fluentd</a></li>
          </ul>
        </nav>
      </div>
    </header>
