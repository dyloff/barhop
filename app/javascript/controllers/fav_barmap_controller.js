import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fav-barmap"
export default class extends Controller {
  static targets = ["map", "barCards"]
  connect() {
    console.log("CONNECTED")
  }

  toggle() {
    this.mapTarget.classList.toggle("hidden")
    this.barCardsTarget.classList.toggle("hidden")
  }
}
