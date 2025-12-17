import { Controller } from "@hotwired/stimulus"
import "cocoon-js"

export default class extends Controller {
  connect() {
    // Cocoon automatically initializes on page load
    console.log("Cocoon JavaScript loaded")
  }
}

