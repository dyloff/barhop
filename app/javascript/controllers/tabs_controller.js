import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="index-tabs"
export default class extends Controller {

  static targets = ["creatorsButton", "friendsButton", "publicButton", "creatorsCards", "publicCards", "friendsCards"]
  connect() {
    console.log("connected to index tabs controller");
  }

  hideShowCreators() {
    console.log(this.creatorsButtonTarget);
      this.creatorsButtonTarget.classList.add("active-button");
      this.creatorsCardsTarget.classList.remove("d-none");
      this.friendsCardsTarget.classList.add("d-none");
      this.publicCardsTarget.classList.add("d-none");
      this.friendsButtonTarget.classList.remove("active-button")
      this.publicButtonTarget.classList.remove("active-button")
    }
    hideShowFriends() {
      console.log("connected hideShowFriends");
      this.creatorsCardsTarget.classList.add("d-none");
      this.creatorsButtonTarget.classList.remove("active-button");
      this.friendsCardsTarget.classList.remove("d-none");
      this.publicCardsTarget.classList.add("d-none");
      this.friendsButtonTarget.classList.add("active-button")
      this.publicButtonTarget.classList.remove("active-button")
    }
    hideShowPublic() {
      console.log("connected hideShowPublic");
      this.creatorsCardsTarget.classList.add("d-none");
      this.creatorsButtonTarget.classList.remove("active-button");
      this.friendsCardsTarget.classList.add("d-none");
      this.publicCardsTarget.classList.remove("d-none");
      this.friendsButtonTarget.classList.remove("active-button")
      this.publicButtonTarget.classList.add("active-button")
      }
}
