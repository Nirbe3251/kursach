//= require jquery3
//= require popper
//= require bootstrap
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
