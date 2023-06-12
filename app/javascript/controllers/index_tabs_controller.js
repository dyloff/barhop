import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="index-tabs"
export default class extends Controller {
  static targets = ["creators", "friends", "public"]
  connect() {
    console.log("connected to index tabs controller");
  }

  hideShowCreators() {
    console.log(this.favouriteBarsTarget);

    this.creatorsTarget.classList.remove("d-none");
    this.savedBarhopsTarget.classList.add("d-none");
    this.savedBarhopsTarget.classList.add("d-none");
    this.savedBarsButtonTarget.classList.remove("active-button")
    this.creatorsButtonTarget.classList.add("active-button")
    this.creatorsButtonTarget.classList.add("active-button")
    }
    hideShowFriends() {
    this.creatorsTarget.classList.add("d-none");
    this.savedBarhopsTarget.classList.remove("d-none");
    this.savedBarhopsTarget.classList.remove("d-none");
    this.savedBarsButtonTarget.classList.add("active-button")
    this.creatorsButtonTarget.classList.remove("active-button")
    this.creatorsButtonTarget.classList.remove("active-button")
    }
    hideShowPublic() {
      this.creatorsTarget.classList.add("d-none");
      this.savedBarhopsTarget.classList.remove("d-none");
      this.savedBarhopsTarget.classList.remove("d-none");
      this.savedBarsButtonTarget.classList.add("active-button")
      this.creatorsButtonTarget.classList.remove("active-button")
      this.creatorsButtonTarget.classList.remove("active-button")
      }
}
