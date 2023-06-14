import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="generate-button"
export default class extends Controller {
  static targets = ["button", "spinner"]
  connect() {
    // console.log("this is long")
    console.log(this.buttonTarget)
  }

  generate() {
    this.spinnerTarget.classList.remove("invisible")
    this.buttonTarget.classList.add(disabled)
  }


}
