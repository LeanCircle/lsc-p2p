$('#map_data').ready ->

  maps_hash = JSON.parse(document.getElementById('map_data').getAttribute('groups_data'))
  current_location = JSON.parse(document.getElementById('map_data').getAttribute('location_data'))
  markers = []
  mapOptions =
    zoom: 2
    center: new (google.maps.LatLng)(current_location[0]['lat'], current_location[0]['lng'])
  map = new (google.maps.Map)(document.getElementById('groups_map'), mapOptions)

  i = 0
  while i < maps_hash.length
    marker = new (google.maps.Marker)(
      position: new (google.maps.LatLng)(maps_hash[i]['lat'], maps_hash[i]['lng'])
      map: map
      html: (i + 1).toString())
    markers.push marker
    i++

  mc = new MarkerClusterer(map, markers)