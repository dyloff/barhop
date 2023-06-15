import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="generate-button"
export default class extends Controller {
  static targets = ["button", "spinner", "page"]

  connect() {
    // console.log("this is long")
    console.log(this.buttonTarget)
    // console.log(this.spinnerTarget)
    // console.log(this.pageTarget)

    const spinner = document.querySelector("#spinner")
    const page = document.querySelector("#page")

    console.log(page)

    spinner.className = "container loading-page hidden"
    page.className = ""

  }

  generate() {
    console.log("generate function")

    const spinner = document.querySelector("#spinner")
    const page = document.querySelector("#page")

    spinner.classList.toggle("hidden");
    page.classList.toggle("hidden");
    
  }


}
