import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// fetch ("https://api.mapbox.com/directions/v5/")
//   .then (response => response.json ())
//   .then (data = {
//   });

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // console.log("This is from map")

    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
    });

      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      // this.#addLayer()
      // this.#getRoute()
      // this.#addDirections()
      // this.#addControl()

      let fetchQueryString = "https://api.mapbox.com/directions/v5/mapbox/walking/";

      let i = 1;
      this.markersValue.forEach((marker) => {
        if (i == this.markersValue.length) {
          fetchQueryString = fetchQueryString + marker.lng + "," + marker.lat + `?geometries=geojson&access_token=${this.apiKeyValue}`;
        } else {
          fetchQueryString = fetchQueryString + marker.lng + "," + marker.lat + ";";
        }
        i += 1
      });

      // console.log(fetchQueryString)
      this.#getRoute(fetchQueryString)
    }

    #addMarkersToMap(){
      // console.log(this.markersValue)

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

  #getRoute(fetchQueryString) {
    fetch(fetchQueryString)
      .then((response) => response.json())
      .then((data) => {

        // console.log("This is route duration")
        // console.log(data.routes[0].duration)

        const routes = data.routes[0].geometry.coordinates;
        // console.log("This is routes");
        // console.log(routes);

        // console.log("THIS ELEMENT " + this.element)
        let counter = 0
        this.markersValue.forEach((marker) => {
          counter += 1
        })

        let totalTimeMins = (Math.round(data.routes[0].duration / 60) + (45 * counter)) % 60
        let totalTimeMins = (Math.round(data.routes[0].duration / 60) + (45 * counter))/60
        console.log("------------------")
        console.log(totalTimeHours)
        console.log("------------------")
        this.element.parentElement.parentElement.parentElement.children[0].querySelector(".estimated-time").innerHTML = `Est BarHop duration: ${Math.round(data.routes[0].duration / 60) + (45 * counter)}mins`
        // console.log("-------------")
        // console.log(this.element.parentElement.parentElement.parentElement.children[0].children[1])
        // console.log("-------------")
        // var durationInfo = document.querySelector(".estimated-time").innerHTML("Est duration: ${data.routes[0].duration / 60}")

        // insertAdjacentHTML("afterend", `<p>Est duration: ${data.routes[0].duration / 60}</p>`);

        this.map.on('load', () => {
          this.map.addSource('route', {
          'type': 'geojson',
          'data': {
          'type': 'Feature',
          'properties': {},
          'geometry': {
          'type': 'LineString',
          'coordinates': routes
          }
          }
        });

          this.map.addLayer({
          'id': 'route',
          'type': 'line',
          'source': 'route',
          'layout': {
          'line-join': 'round',
          'line-cap': 'round'
          },
          'paint': {
          'line-color': '#D94124',
          'line-width': 5,
          }
          });
        });
      })

    }
}
