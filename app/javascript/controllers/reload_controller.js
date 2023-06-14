import { Controller } from "@hotwired/stimulus";
// import Rails from "rails-ujs";

// Connects to data-controller="reload"
export default class extends Controller {
  static targets = ["barsList"];
  static values = {
    bars: Array,
  };

  url = `${window.location}&bars=${this.barsValue}`;

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
        // console.log(data);
        this.element.outerHTML = data;

        // this.barsListTarget.outerHTML = data;

        const mapContainer = document.querySelector(".crawl-map");
        // console.log(mapContainer);

        // console.log(this.element);

        document.querySelectorAll(".new-crawl-bars-map").forEach((map) => {
          map.classList.add("d-none");
        });

        const barsMaps = document.querySelectorAll(".new-crawl-bars-map");

        // console.log(barsMaps[barsMaps.length - 1]);

        barsMaps[barsMaps.length - 1].classList.remove("d-none");

        // Rails.ajax({
        //   url: this.data.get("url").replace(":id", id),
        //   type: "PATCH",
        //   data: data,
        //   success: function () {
        //     console.log("Try to get a updated map");
        //     // document.location.reload();

        //     fetch(`/routes/${routeId}/map`)
        //       // .then((res) => res.json())
        //       // .then((data) => {
        //       //   console.log(data.json);
        //       //   console.log(data.template);
        //       //   console.log(data.map);
        //       // });
        //       .then((res) => {
        //         console.log(res);
        //         // console.log(res.text());
        //         return res.text();
        //       })
        //       .then((data) => {
        //         console.log("Checking Fetch Get Response");
        //         // console.log(data);

        //         mapContainer.innerHTML = data;
        //         // mapContainer.insertAdjacentHTML("beforeend", data);
        //       });
        //   },
        // });
      });
  }

  reload() {
    location.reload();
  }
}
