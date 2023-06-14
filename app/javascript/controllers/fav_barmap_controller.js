import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fav-barmap"
export default class extends Controller {
  static targets = ["map", "barCards", "buttonText"]
  connect() {
    console.log("CONNECTED")
  }

  toggle() {
    this.mapTarget.classList.toggle("hidden")
    this.barCardsTarget.classList.toggle("hidden")
    console.log(this.buttonTextTarget.innerHTML)
    if (this.buttonTextTarget.innerHTML === "Map of Bars 🗺️") {
      this.buttonTextTarget.innerHTML = "Bars 🍻"
    } else {
      this.buttonTextTarget.innerHTML = "Map of Bars 🗺️"
    }
  }
}
