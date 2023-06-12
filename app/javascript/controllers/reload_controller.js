import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reload"
export default class extends Controller {
  static targets = ["barsList"]
  static values = {
    bars: Array
  }
  url = `${window.location}&bars=${this.barsValue}`

  connect() {
    console.log("HIIII")
  }


  test(event) {
    console.log(this.url)
    this.url = this.url + `&bar_${event.currentTarget.dataset.bar}=saved`
    console.log(this.url)
  }

  generate() {
    fetch(this.url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.barsListTarget.outerHTML = data;
    })
  }

  reload() {
    location.reload();
  }
}
