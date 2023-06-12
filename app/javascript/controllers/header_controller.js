import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
  static targets = ["smallDiv", "formDiv"]

  connect() {
    console.log("header controller")
  }

  maximize() {
    this.smallDivTarget.classList.remove("search-box-minimized");
    this.smallDivTarget.classList.add("search-box-small");
    setTimeout(() => {
      this.smallDivTarget.classList.add("d-none");
      this.formDivTarget.classList.remove("d-none");
    }, 1000)
    // delay(1000).then(() =>
    //   this.smallDivTarget.classList.add("d-none");
    //   this.formDivTarget.classList.remove("d-none");
    //   );
  }
}
