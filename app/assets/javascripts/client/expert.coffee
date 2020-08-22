$(document).on 'turbolinks:load', ->
  if $('#map').length
    initMap();