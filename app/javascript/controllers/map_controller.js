import { Controller } from "@hotwired/stimulus"
import maplibregl from "maplibre-gl"

export default class extends Controller {
  connect() {
    const map = new maplibregl.Map({
      container: "map",
      style: "https://demotiles.maplibre.org/style.json",
      center: [-122.086830, 37.695685],
      zoom: 9.3,
    })

    map.on("load", () => {
      const stations = JSON.parse(this.element.dataset.stations)

      map.addSource("bart-network", {
        type: "geojson",
        data: {
          type: "FeatureCollection",
          features: stations.map((station) => ({
            type: "Feature",
            geometry: {
              type: "Point",
              coordinates: [station.gtfs_longitude, station.gtfs_latitude],
            },
          })),
        },
      })

      map.addLayer({
        id: "station",
        type: "circle",
        source: "bart-network",
        paint: {
          "circle-radius": 3,
          "circle-color": "#000000",
        },
        filter: ["==", "$type", "Point"]
      })
    })
  }
}
