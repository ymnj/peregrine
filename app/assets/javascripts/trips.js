function showMap() {
  L.mapbox.accessToken = 'pk.eyJ1IjoieWVvbWFubmluamEiLCJhIjoiY2ltYmo2bzBnMDQ1NHR5a2ltOWZmeXI3aCJ9.jVpanoyAmB-eexrQsXpWdA';
  window.map_box_obj = L.mapbox.map('map', 'yeomanninja.phb28ak1', {
    // tileLayer: {
    //     continuousWorld: true,
    //     noWrap: true
    // }
  }).setView([28.072, -1.494], 2);

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
        console.log(marker);
        marker.setIcon(L.icon(feature.properties.icon));

        $('.collection a.trip-'+ marker.feature.properties.id).on('click', function(){
          map_box_obj.setView(marker.getLatLng(), 14);
             marker.openPopup();
        });  

      });
      
      myLayer.setGeoJSON(geojson);

      //var panClick = $('.collection a, .marker-icon');

      // panClick.on('click', function(e){
      //   map_box_obj.setView(myLayer.getLatLng(), 14);

      // });

      //Map panning doesn't work
      // map_box_obj.featureLayer.on('click', function(e) {
      //     map_box_obj.panTo(e.layer.getLatLng());
      // });
    }
  });
}


// map.featureLayer.on('ready', function(e) {
//       map.featureLayer.eachLayer(function(layer) {
//           var item = markerList.appendChild(document.createElement('li'));
//           item.innerHTML = layer.toGeoJSON().properties.title;
//           item.onclick = function() {
//              map.setView(layer.getLatLng(), 14);
//              layer.openPopup();
//           };
//       });
//   });