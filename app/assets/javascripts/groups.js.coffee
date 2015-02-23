$('#map_data').ready ->

  initialize = ->
    maps_hash = JSON.parse(document.getElementById('map_data').getAttribute('data'))
    mapOptions =
      zoom: 1
      center: new (google.maps.LatLng)(37.77, -122.43)
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

    return

  google.maps.event.addDomListener window, 'load', initialize