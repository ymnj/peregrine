function showMap() {
  L.mapbox.accessToken = 'pk.eyJ1IjoieWVvbWFubmluamEiLCJhIjoiY2ltYmo2bzBnMDQ1NHR5a2ltOWZmeXI3aCJ9.jVpanoyAmB-eexrQsXpWdA';
  window.map_box_obj = L.mapbox.map('map', 'yeomanninja.phb28ak1', {
    // tileLayer: {
    //     continuousWorld: true,
    //     noWrap: true
    // }
  }).setView([16.072, -1.494], 2);

  //map_box_obj.scrollWheelZoom.disable();
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
      var myLayer = L.mapbox.featureLayer().addTo(map_box_obj);

      myLayer.on('layeradd', function(e) {
        var marker = e.layer,
            feature = marker.feature;
        
        // This sets the icons with user image
        marker.setIcon(L.icon(feature.properties.icon));


        // Create custom popup content
        var popupContent =  '<a class="popup" href="' + feature.properties.url + '">' + 
                            feature.properties.title +
                            '</a>' +
                            '<p>hihihi</p>';

        marker.bindPopup(popupContent,{
            closeButton: false,
            minWidth: 320
        });

        // This pans to the marker on the map when a trip is clicked
        $('.collection').on('click', 'a.trip-'+ marker.feature.properties.id ,function(){
          map_box_obj.setView(marker.getLatLng(), 10);
             marker.openPopup();
        });  

      });
      
      myLayer.setGeoJSON(geojson);

    }
  });
}
