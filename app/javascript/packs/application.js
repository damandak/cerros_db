// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import "@fortawesome/fontawesome-free/css/all"


require('datatables.net-bs4')

import $ from 'jquery';
global.$ = jQuery;
window.$ = $

// Add DataTables jQuery plugin
require('imports-loader?define=>false!datatables.net')(window, $)
require('imports-loader?define=>false!datatables.net-select')(window, $)

// Load datatables styles
import 'datatables.net-dt/css/jquery.dataTables.css'
import 'datatables.net-select-dt/css/select.dataTables.css'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
