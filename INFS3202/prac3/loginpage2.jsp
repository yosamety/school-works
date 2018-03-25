<%
if(session.getAttribute("username")!=null &&
 session.getAttribute("password")!=null){
 response.sendRedirect("prac3.jsp");
}
%>

<!DOCTYPE html>
<html>
  <head>
  <title>My Restaurants</title>
  </head>
  
  <body>

		<form method="POST" action="login.jsp">
		
		<input type="text" name="username" class="content" placeholder="user name">
		</br>
		<input type="text" name="password" class="content" placeholder="password"> 	
		</br>
		<input type="submit" value="Submit" name="submit" class="content"/><br />	
		</form>
		<p>Incorrect login</p>
	
		<!--<form method="LINK" action="formpass.html"> 
			
		</form>
			-->	
				
	
	
  </body>
</html>