
$(document).ready(function(){

  $('#map').hide()  
  $('#trips-left, #map').fadeIn(700)


  // ajax call to retrieve json for mapbox
  $.ajax({
    dataType: 'text',
    url: '/users/13/trips.json',
    success: function(data) {
      var geojson;
      geojson = $.parseJSON(data);
      return map.featureLayer.setGeoJSON(geojson);
    }
  });




}); 