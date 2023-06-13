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
        // console.log(data)

        const routes = data.routes[0].geometry.coordinates;
        // console.log("This is routes");
        // console.log(routes);

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


        // const geojson = {
        //   type: "Feature",
        //   properties: {},
        //   geometry: {
        //     type: "LineString",
        //     coordinates: routes,
        //   }
        // }

        // this.map.addLayer({
        //   id: "routes",
        //   type: "line",
        //   source: {
        //     type: "geojson",
        //     data: geojson
        //   },
        //   layout: {
        //     "line-join": "round",
        //     "line-cap": "round",
        //   },
        //   paint: {
        //     "line-color": "#D94124",
        //     "line-width": 5,
        //     "line-opacity": 0.75,
        //   }
        // })
      })

      // const routesCoodinates = [];
      // this.markersValue.forEach((marker) => {
      //   routesCoodinates.push([marker.lng, marker.lat])
      // })

      // console.log("This is routesCoodinates")
      // console.log(routesCoodinates)

      // this.map.on('load', () => {
      //   this.map.addSource('route', {
      //   'type': 'geojson',
      //   'data': {
      //   'type': 'Feature',
      //   'properties': {},
      //   'geometry': {
      //   'type': 'LineString',
      //   'coordinates': routesCoodinates
      //   }
      //   }
      // });

      //   this.map.addLayer({
      //   'id': 'route',
      //   'type': 'line',
      //   'source': 'route',
      //   'layout': {
      //   'line-join': 'round',
      //   'line-cap': 'round'
      //   },
      //   'paint': {
      //   'line-color': '#888',
      //   'line-width': 8
      //   }
      //   });
      // });
    }
}
