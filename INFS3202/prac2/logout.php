<?php
date_default_timezone_set('Australia/Brisbane');
session_start();
if(session_destroy()) // Destroying All Sessions
{
	if (!file_exists("../logs/logn.txt")){
	$myfile = fopen("../logs/logn.txt", "w") or die("Unable to open file!");
	$txt = date("l jS \of F Y h:i:s A");
	fwrite($myfile, $txt);
	$txt = " user: ";
	fwrite($myfile, $txt);
	$txt = $_SESSION['username'];
	fwrite($myfile, $txt);
	$txt = " logged out\r\n";
	fwrite($myfile, $txt);
	fclose($myfile);
	}
	else{
	$myfile = fopen("../logs/logn.txt", "a+") or die("Unable to open file!");
	$txt = date("l jS \of F Y h:i:s A");
	fwrite($myfile, $txt);
	$txt = " user: ";
	fwrite($myfile, $txt);
	$txt = $_SESSION['username'];
	fwrite($myfile, $txt);
	$txt = " logged out\r\n";
	fwrite($myfile, $txt);
	fclose($myfile);
	}
header("Location: prac22.php"); // Redirecting To Home Page
}
?>