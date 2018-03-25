<?php
date_default_timezone_set('Australia/Brisbane');
session_start();
if($_REQUEST['username']=="infs" && $_REQUEST['password']=="3202"){
	$_SESSION['username'] = "infs";
	$_SESSION['password'] = "3202";
	$_SESSION['timeStart'] = time();
	$_SESSION['timeEnd'] = time() + $_POST['timeout'];
	
	if (!file_exists("../logs/logn.txt")){
	$myfile = fopen("../logs/logn.txt", "w") or die("Unable to open file!");
	$txt = date("l jS \of F Y h:i:s A");
	fwrite($myfile, $txt);
	$txt = " user: ";
	fwrite($myfile, $txt);
	$txt = $_SESSION['username'];
	fwrite($myfile, $txt);
	$txt = " logged in\r\n";
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
	$txt = " logged in\r\n";
	fwrite($myfile, $txt);
	fclose($myfile);
	}
	
	header('Location: prac22.php');
}
else{
	header('Location: loginpage2.php');
}
	/*	if($_REQUEST['username']=="infs" && $_REQUEST['password']=="3202"){

			header('Location: prac22.php');

		}
		else{
			header('Location: loginpage.php');
			}
			*/
?>