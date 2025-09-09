// app/javascript/application.js

import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

// Stimulus start
const application = Application.start()
application.debug = false
window.Stimulus   = application

// Import your controllers (if you have them)
// import "./controllers"

// Import reply functionality
import "../assets/javascripts/reply"
