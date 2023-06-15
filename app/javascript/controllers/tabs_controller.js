import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="index-tabs"
export default class extends Controller {

  static targets = ["creatorsButton", "plusMinusNumber" , "friendsButton", "publicButton", "creatorsCards", "publicCards", "friendsCards"]
  static values = { numbers: Array };
  connect() {
    console.log("connected to index tabs controller");
  }

  hideShowCreators() {
    console.log(this.creatorsButtonTarget);
      this.creatorsButtonTarget.classList.add("activeTabIndex");
      // this.creatorsButtonTarget.classList.add("active-button");
      this.creatorsCardsTarget.classList.remove("d-none");
      this.friendsCardsTarget.classList.add("d-none");
      this.publicCardsTarget.classList.add("d-none");
      this.friendsButtonTarget.classList.remove("activeTabIndex")
      this.publicButtonTarget.classList.remove("activeTabIndex")
    }
    hideShowFriends() {
      console.log("connected hideShowFriends");
      this.creatorsCardsTarget.classList.add("d-none");
      this.creatorsButtonTarget.classList.remove("activeTabIndex");
      this.friendsCardsTarget.classList.remove("d-none");
      this.publicCardsTarget.classList.add("d-none");
      this.friendsButtonTarget.classList.add("activeTabIndex")
      this.publicButtonTarget.classList.remove("activeTabIndex")
    }
    hideShowPublic() {
      console.log("connected hideShowPublic");
      this.creatorsCardsTarget.classList.add("d-none");
      this.creatorsButtonTarget.classList.remove("activeTabIndex");
      this.friendsCardsTarget.classList.add("d-none");
      this.publicCardsTarget.classList.remove("d-none");
      this.friendsButtonTarget.classList.remove("activeTabIndex")
      this.publicButtonTarget.classList.add("activeTabIndex")
      }


      updateSelectedNumber() {
        this.selectedNumberTarget.value = this.numbersValue[this.selectedIndex];
      }
      minus() {
        if (this.splusMinusNumberTarget.value >=3 && this.splusMinusNumberTarget.value <= 6 ) {
          this.splusMinusNumberTarget.value = this.splusMinusNumberTarget.value - 1
        }
        else {
          this.elementTarget.setAttribute("disabled", true)
        }

      }

      plus() {
        if (this.splusMinusNumberTarget.value >=3 && this.splusMinusNumberTarget.value <= 6 ) {
          this.splusMinusNumberTarget.value = this.splusMinusNumberTarget.value + 1
        }
        else {
          this.elementTarget.setAttribute("disabled", true)
        }


      }
}
