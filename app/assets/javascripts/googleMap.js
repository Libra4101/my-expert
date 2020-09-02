function initMap() {
  // 宣言
  let map;
  let geocoder;
  let centerp;
  let marker;

  geocoder = new google.maps.Geocoder()

  if (gon.latitude && gon.longitude) {
    centerp = {lat: gon.latitude, lng: gon.longitude}
  } else {
    centerp = {lat: 33.60639, lng: 130.41806}
  }

  map = new google.maps.Map(document.getElementById('map'), {
    center: centerp,
    zoom: 12,
  });

  marker = new google.maps.Marker({
    position: centerp,
    map: map
  });
}