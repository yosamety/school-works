var x = document.getElementById("demo");
var geocoder;
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else { 
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
geocoder = new google.maps.Geocoder();
    lat = position.coords.latitude;
    lon = position.coords.longitude;
    latlon = new google.maps.LatLng(lat, lon)
    mapholder = document.getElementById('mapholder')
    mapholder.style.height = '250px';
    mapholder.style.width = '500px';

	
	
    var myOptions = {
    center:latlon,zoom:7,
    mapTypeId:google.maps.MapTypeId.ROADMAP,
    mapTypeControl:false,
    navigationControlOptions:{style:google.maps.NavigationControlStyle.SMALL}
    }
   
    var map = new google.maps.Map(document.getElementById("mapholder"), myOptions);
    var marker = new google.maps.Marker({position:latlon,map:map,title:"You are here!"});
	
	for (i = 1; i <= document.getElementById("countA").value; i++) {
		var latA = document.getElementById("lat"+i).value;
		var lonA = document.getElementById("lon"+i).value;
		var marker = new google.maps.Marker({
		position: new google.maps.LatLng(latA,lonA),
		map: map,
		title: document.getElementById("name"+i).value
		});
	}
	/*var latA = document.getElementById("lat1").value;
	var lonA = document.getElementById("lon1").value;
	var latB = document.getElementById("lat2").value;
	var lonB = document.getElementById("lon2").value;
	
	var markerA = new google.maps.Marker({
		position: new google.maps.LatLng(latA,lonA),
		map: map,
		icon: "http://maps.google.com/mapfiles/marker" + "A" + ".png",
		title: "The Loose Goose"
	});
	var markerB = new google.maps.Marker({
		position: new google.maps.LatLng(latB,lonB),
		map: map,
		icon: "http://maps.google.com/mapfiles/marker" + "B" + ".png",
		title: "Harry's On Buderim"
		});
		*/
		
	//reverse geocoding by google	
	var input = lat+","+lon;
	var latlngStr = input.split(',', 2);
	var lat = parseFloat(latlngStr[0]);
	var lng = parseFloat(latlngStr[1]);
	var latlng = new google.maps.LatLng(lat, lng);
	geocoder.geocode({'latLng': latlng}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
		if (results[1]) {
		document.getElementById("user_location").innerHTML = "You are at " + results[1].formatted_address;
		} else {
			alert('No results found');
		}
		} else {
		alert('Geocoder failed due to: ' + status);
		}
	});

	
}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            x.innerHTML = "User denied the request for Geolocation."
            break;
        case error.POSITION_UNAVAILABLE:
            x.innerHTML = "Location information is unavailable."
            break;
        case error.TIMEOUT:
            x.innerHTML = "The request to get user location timed out."
            break;
        case error.UNKNOWN_ERROR:
            x.innerHTML = "An unknown error occurred."
            break;
    }
}




google.maps.event.addDomListener(window, 'load', getLocation);