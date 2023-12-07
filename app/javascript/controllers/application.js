//= require jquery3
//= require popper
//= require bootstrap
import "@hotwired/turbo-rails"
// import { Application } from "@hotwired/stimulus"
import Rails from '@rails/ujs';
import * as bootstrap from "bootstrap"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
Rails.start()

// export { application }
