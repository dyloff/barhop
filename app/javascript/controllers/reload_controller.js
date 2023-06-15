import { Controller } from "@hotwired/stimulus";
// import Rails from "rails-ujs";

// Connects to data-controller="reload"
export default class extends Controller {
  static targets = ["barsList"];
  static values = {
    bars: Array,
  };

  url = `${window.location.href}&bars=${this.barsValue}`;

  connect() {

    // console.log("This is from reload stimulus");
    // console.log(this.barsListTarget);

  }

  keepBar(event) {
    // console.log(this.barsValue);
    // console.log(this.url);

    console.log(event.currentTarget.dataset.bar);

    // * This dataset.bar is from "_barcards_regeneration.html.erb"
    console.log(event.currentTarget.dataset.barIndex);

    this.url = this.url + `&bar_${event.currentTarget.dataset.bar}=saved`;
    // console.log(this.url);
    event.currentTarget.classList.add("selectedBarColor")
  }

  generate() {
    const all_bars = document.querySelector("#select").dataset.allBars
    this.url += `&all_bar_list=${all_bars}`
    console.log(this.url)

    fetch(this.url, { headers: { Accept: "text/plain" } })
      .then((response) => response.text())
      .then((data) => {
        console.log("This is reload controller element")
        console.log(this.element);

        console.log("This is data")
        console.log(data);
        this.element.outerHTML = data;

        // this.barsListTarget.outerHTML = data;

        const mapContainer = document.querySelector(".crawl-map");
        console.log(mapContainer);


        document.querySelectorAll(".new-crawl-bars-map").forEach((map) => {
          map.classList.add("d-none");
        });

        const barsMaps = document.querySelectorAll(".new-crawl-bars-map");

        console.log(barsMaps[barsMaps.length - 1]);

        barsMaps[barsMaps.length - 1].classList.remove("d-none");
      });
  }

  reload() {
    location.reload();
  }
}
