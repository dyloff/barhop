import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-loading"
export default class extends Controller {

  static targets = ["page", "spinner"]

  connect() {
    console.log("new loading controller")
  }

  switch() {
    this.pageTarget.classList.toggle("hidden")
    this.spinnerTarget.classList.toggle("hidden")
  }
}
