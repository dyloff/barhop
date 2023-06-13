import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="favourites-map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log("this is from favourites map")

    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      // center: [markers[0].longitude, markers[0].latitude],
      // zoom: 10,
    });

      this.#addMarkersToMap()
      this.#fitMapToMarkers()

      // this.map.resize();

      // setTimeout(() => {
      //   console.log("Hi timeout")

      //   // this.map.on('load', function() {
      //     this.map.resize();
      //   // });
      // }, 1000);

      const favBtn = document.querySelector(".favourite-btn")
      console.log(favBtn)

      favBtn.addEventListener("click", () => {
        this.map.resize();
      })
    }

    #addMarkersToMap(){
      console.log(this.markersValue)

      this.markersValue.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

        const customMarker = document.createElement("div");
        customMarker.innerHTML = marker.marker_html;

      //  console.log(customMarker.innerHTML);

        new mapboxgl.Marker(customMarker)
        new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
      })
    }

    #fitMapToMarkers() {
      const bounds = new mapboxgl.LngLatBounds()
      this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
