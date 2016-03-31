function showMap() {
  L.mapbox.accessToken = 'pk.eyJ1IjoieWVvbWFubmluamEiLCJhIjoiY2ltYmo2bzBnMDQ1NHR5a2ltOWZmeXI3aCJ9.jVpanoyAmB-eexrQsXpWdA';
  window.map_box_obj = L.mapbox.map('map', 'yeomanninja.phb28ak1', {
    // These options apply to the tile layer in the map.
    tileLayer: {
        // This map option disables world wrapping. by default, it is false.
        continuousWorld: false,
        // This option disables loading tiles outside of the world bounds.
        noWrap: true
    }
  }).setView([28.072, -1.494], 2);

  map_box_obj.scrollWheelZoom.disable();
  console.log('rendered map');
  placeMarkersOnMap();
}

function placeMarkersOnMap() {
  current_user_id = $("meta[name='current-user-id']").attr("content");
  $.ajax({
    dataType: 'text',
    url: "/users/"+ current_user_id + "/trips.json",
    success: function(data) {
      var geojson;
      geojson = $.parseJSON(data);
      L.mapbox.featureLayer(geojson).addTo(map_box_obj);
    }
  });
}
