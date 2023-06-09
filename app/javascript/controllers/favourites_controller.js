import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourites"
export default class extends Controller {
  connect() {
    console.log("connected to favourites");

  }

  new() {
    console.log(this.element)
  }

}
