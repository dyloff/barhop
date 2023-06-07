import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'



export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log("This is from map")

    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
    });
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      this.#addLayer()
      // this.#addDirections()
      // this.#addControl()
  }

  #addMarkersToMap(){
    console.log(this.markersValue)
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
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

  #addLayer() {

    const routesCoodinates = [];

    this.markersValue.forEach((marker) => {
      routesCoodinates.push([marker.lng, marker.lat])
    })

    this.map.on('load', () => {
      this.map.addSource('route', {
      'type': 'geojson',
      'data': {
      'type': 'Feature',
      'properties': {},
      'geometry': {
      'type': 'LineString',
      'coordinates': routesCoodinates
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
      'line-color': '#888',
      'line-width': 8
      }
      });
    });
  }
}
