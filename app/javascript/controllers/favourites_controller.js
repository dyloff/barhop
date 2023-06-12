import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourites"
export default class extends Controller {

  static targets = ["favouriteBars", "savedBarhops", "favouriteBarsButton", "savedBarsButton", "showFriends", "showFriendsButton"]
  connect() {
    console.log("connected to favourites");

  }

  hideShowFavourites() {
  console.log(this.favouriteBarsTarget);

  this.favouriteBarsTarget.classList.remove("d-none");
  this.savedBarhopsTarget.classList.add("d-none");
  this.savedBarsButtonTarget.classList.remove("active-button")
  this.favouriteBarsButtonTarget.classList.add("active-button")
  this.showFriendsTarget.classList.add("d-none")
  this.showFriendsTarget.classList.remove("active-button")
  }
  hideShowSavedBarhops() {
  this.favouriteBarsTarget.classList.add("d-none");
  this.savedBarhopsTarget.classList.remove("d-none");
  this.savedBarsButtonTarget.classList.add("active-button")
  this.favouriteBarsButtonTarget.classList.remove("active-button")
  this.showFriendsTarget.classList.add("d-none")
  this.showFriendsTarget.classList.remove("active-button")
  }
  hideShowFriendsButton() {

  console.log(this.showFriendsTarget)
  this.favouriteBarsTarget.classList.add("d-none");
  this.savedBarhopsTarget.classList.add("d-none");
  this.savedBarsButtonTarget.classList.remove("active-button")
  this.favouriteBarsButtonTarget.classList.remove("active-button")
  this.showFriendsTarget.classList.remove("d-none")
  this.showFriendsButtonTarget.classList.add("active-button")
  }
}
