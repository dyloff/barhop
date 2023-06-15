import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="plus-minus"
export default class extends Controller {
  static targets = ["numberOfBars", "finalBars"]
  connect() {
    console.log("connect to plus minus");

  }

  plusButton() {
    if (this.numberOfBarsTarget.innerText < 6) {

      document.getElementById("plus").disabled = true;
      const number = this.numberOfBarsTarget.innerText
      this.numberOfBarsTarget.innerText = parseInt(number) + 1
      this.finalBarsTarget.value = parseInt(this.numberOfBarsTarget.innerText)

    }
    else {
      document.getElementById("plus").disabled = true;
    }
  }
  minusButton() {
    if (this.numberOfBarsTarget.innerText > 3) {
      document.getElementById("plus").disabled = false;
      const number = this.numberOfBarsTarget.innerText
      this.numberOfBarsTarget.innerText = parseInt(number) - 1
      this.finalBarsTarget.value = parseInt(this.numberOfBarsTarget.innerText)
    }
    else {
      document.getElementById("minus").disabled = true
    }
  }

}
