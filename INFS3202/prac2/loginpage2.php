<?php
session_start();
if(isset($_SESSION['username']) && isset($_SESSION['password'])){
 header('Location: prac22.php');
}
?>

<!DOCTYPE html>
<html>
  <head>
  <title>My Restaurants</title>
  </head>
  
  <body>

		<form method="POST" action="login.php">
		
		<input type="text" name="username" class="content" placeholder="user name">
		</br>
		<input type="text" name="password" class="content" placeholder="password"> 	
		</br>
		Stay logged in for:
		<select name="timeout">
			<option value="15">15 seconds</option>
			<option value="86400">1 day</option>
		</select>
		</br>
		<input type="submit" value="Submit" name="submit" class="content"/><br />	
		</form>
		<p>Incorrect login</p>
	
		<!--<form method="LINK" action="formpass.html"> 
			
		</form>
			-->	
				
	
	
  </body>
</html>