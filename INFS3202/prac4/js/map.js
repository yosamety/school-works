function initialize() {
	
	var x = document.getElementById("demo");
//function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
//}
//function showPosition(position) {
    x.innerHTML = "Latitude: " + position.coords.latitude + 
    "<br>Longitude: " + position.coords.longitude; 
//}
	
	
	var latlon = x.coords.latitude + "," + x.coords.longitude;
	
    var mapCanvas = document.getElementById('map-canvas');
    var mapOptions = {
//center: new google.maps.LatLng(-27.0651857,152.968756),
        center: new google.maps.LatLng(latlon),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(mapCanvas, mapOptions)
		
	var markerA = new google.maps.Marker({
		position: new google.maps.LatLng(-26.629472,153.086457),
		map: map,
		title: 'The Loose Goose'
	});
	var markerB = new google.maps.Marker({
		position: new google.maps.LatLng(-26.67141,153.047798),
		map: map,
		title: "Harry's On Buderim"
		});
	}
    google.maps.event.addDomListener(window, 'load', initialize);