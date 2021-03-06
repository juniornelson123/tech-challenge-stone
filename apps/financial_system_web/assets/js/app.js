// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import React from 'react'
import ReactDOM from 'react-dom'
import FormTransfer from './components/FormTransfer'
import FormExchange from './components/FormExchange'

if (document.getElementById('newTransfer')) {
  ReactDOM.render(<FormTransfer link={document.getElementById('accountId').getAttribute("data-link")} accountId={document.getElementById('accountId').getAttribute("data-id")}/>, document.getElementById('newTransfer'))
}
if (document.getElementById('exchangeDiv')) {
  ReactDOM.render(<FormExchange currencies={document.getElementById('exchangeDiv').getAttribute("data-coins")} />, document.getElementById('exchangeDiv'))
}