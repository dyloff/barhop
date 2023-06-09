import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourites"
export default class extends Controller {

  static targets = ["favouriteBars", "savedBarhops", "favouriteBarsButton", "savedBarsButton"]
  connect() {
    console.log("connected to favourites");

  }

  hideShowFavourites() {
  console.log(this.favouriteBarsTarget);

  this.favouriteBarsTarget.classList.remove("d-none");
  this.savedBarhopsTarget.classList.add("d-none");
  this.savedBarsButtonTarget.classList.remove("active-button")
  this.favouriteBarsButtonTarget.classList.add("active-button")
  }
  hideShowSavedBarhops() {
  this.favouriteBarsTarget.classList.add("d-none");
  this.savedBarhopsTarget.classList.remove("d-none");
  this.savedBarsButtonTarget.classList.add("active-button")
  this.favouriteBarsButtonTarget.classList.remove("active-button")
  }
}
