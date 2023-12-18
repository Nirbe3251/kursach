// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import Turbolinks from 'turbolinks'
import "bootstrap"
import '@popperjs/core'
import Rails from '@rails/ujs'
// import 'bootstrap-icons/font/bootstrap-icons.css'
import * as channels from "./channels"

import jQuery from 'jquery'
window.jQuery = jQuery
window.$ = jQuery

Turbolinks.start()
Rails.start()
channels.createRoom()

import * as scripts from './scripts'

$(document).on('turbo:load load ready turbo:before-render', function() {
    channels.UserOnlineSubscriptions()
    scripts.Check();
    scripts.CheckBan();
})
