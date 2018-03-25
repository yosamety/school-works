<?php
	session_start();
	if(isset($_SESSION['username']) && isset($_SESSION['password'])){
		if(time() > $_SESSION['timeEnd']){
		header("Location: timeout.php");
		}
	}
?>

<!DOCTYPE html>
<html>
  <head>
  <title>My Restaurants</title>
  <meta charset="utf-8" />  
  
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<!-- lightbox -->
	<script src="js/jquery-1.11.0.min.js"></script>
	<script src="js/lightbox.min.js"></script>
	<link href="css/lightbox.css" rel="stylesheet" />
	<!-- google map -->
	
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
    <script type="text/javascript" src="js/map2.js"></script>
	
  </head>
  
  
  
<body>
	<div id = "get-time-start" style="display: none;">
		<?php
			echo htmlspecialchars(time());
		?>
	</div>
	<div id = "get-time-end" style="display: none;">
		<?php
			echo htmlspecialchars($_SESSION['timeEnd']);
		?>
	</div>
	


  <header>
	<p id="user_location"> null </p>
	<?php
	
	if(!isset($_SESSION['username']) || !isset($_SESSION['password'])){
	
	

		echo "<form action='loginpage.php'>	<button type='submit' class='infoButton' >Login</button></form>";
		}
	else{ 
	echo "<form action='logout.php'><button type='submit' class='infoButton'>Logout</button></form>Time out in:<span id='countdown' class='timer'></span>";
		}
	?>
	<script>
    var div = document.getElementById("get-time-start");
    var startTime = parseInt(div.textContent);
	var div2 = document.getElementById("get-time-end");
    var endTime = parseInt(div2.textContent);
	var seconds = endTime - startTime;
	function secondPassed() {
	var hours   = Math.floor(seconds / 3600);
    var minutes = Math.floor((seconds - (hours * 3600)) / 60);
    var remainingSeconds = seconds - (hours * 3600) - (minutes * 60);

    if (hours   < 10) {hours   = "0"+hours;}
    if (minutes < 10) {minutes = "0"+minutes;}
    if (remainingSeconds < 10) {remainingSeconds = "0"+remainingSeconds;}
    var time    = hours+':'+minutes+':'+remainingSeconds;

	
    
	/*
	var hours = Math.round((seconds-30)/3600);
    var minutes = Math.round((seconds - 30)/60);
    var remainingSeconds = seconds % 60;
    if (remainingSeconds < 10) {
        remainingSeconds = "0" + remainingSeconds; 
    }*/
    document.getElementById('countdown').innerHTML = time;
    if (seconds == 0) {
        clearInterval(countdownTimer);
		window.alert("user timout");
        window.location.href = "timeout.php";
    } else {    
        seconds--;
    }
    }
	var countdownTimer = setInterval('secondPassed()', 1000);
	</script>	
	</header>
	<div class="map">
	Locations <br>
	<!--
	<iframe src="https://www.google.com/maps/d/embed?mid=z4LszZSOuta0.kszC6bFy__-4" width="640" height="480"></iframe>
	-->
	<!--<div id="map-canvas"></div> -->
	<div id="mapholder"></div>
	</div>
	<div class="rest">
	
	</div>
	<div class="rest">
	Restaurants<br>
	<table>
		<tr>
		<td>
		<h3>A. Harry's On Buderim</h3>
		11 Harrys Lane, Buderim QLD 4556, Australia<br>
		(07) 5445 6661<br>
		<form action="http://www.harrysonbuderim.com.au/"> 
			<button type="submit" class="infoButton" >More Info</button>
		</form>
		</td>
		<td>
	<!-- Harrys On Buderim-->
	<a href="img/myrest/HarrysonBuderim_outside.jpg" data-lightbox="harrys" data-title="Outside"><img src="img/myrest/HarrysonBuderim_outside.jpg" alt="Harry's on Buderim" class="img"></a>
	<a href="img/myrest/harrys_deck.jpg" data-lightbox="harrys" data-title="Deck"></a>
	<a href="img/myrest/inside-harrys-restaurant-sm.jpg" data-lightbox="harrys" data-title="Inside"></a>
		</td>
		</tr>
		<tr>
		<td>
		<h3>B. The Loose Goose</h3>
		3/175 Ocean Drive, Twin Waters QLD 4564, Australia<br>
		(07) 5457 0887<br>
		<form action="http://www.theloosegoose.com.au/"> 
			<button type="submit" class="infoButton" >More Info</button>
		</form>
		</td>
		<td>
	<!-- The Loose Goose-->
	<a href="img/myrest/goose_inside.jpg" data-lightbox="goose" data-title="inside"><img src="img/myrest/goose_inside.jpg" alt="The Loose Goose" class="img"></a>
	<a href="img/myrest/goose_deck.jpg" data-lightbox="goose" data-title="Deck"></a>
	<a href="img/myrest/loosegooseLogo.jpg" data-lightbox="goose" data-title="logo"></a>
	</td>
	</tr>
	</table>
	</div>
	
  </body>
</html>

