
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
  <head>
  <title>My Restaurants</title>
  <meta charset="utf-8" />  
  
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<!-- lightbox -->
	<script src="js/jquery-1.11.0.min.js"></script>
	<script src="js/lightbox.min.js"></script>
	<script src="js/other.js"></script>
	<link href="css/lightbox.css" rel="stylesheet" />
	<!-- google map -->
	
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
    <script type="text/javascript" src="js/map2.js"></script>
	
  </head>
  
  
  
<body>



  <header>
	<p id="user_location"> null </p>

	<%
if(session.getAttribute("username")!=null &&
 session.getAttribute("password")!=null){
%>
	<form action='logout.jsp'>	
	<button type='submit' class='infoButton' >Logout</button>
	</form>
	<% } else { %>
	<form action='loginpage.jsp'>	
	<button type='submit' class='infoButton' >Login</button>
	</form>
<% } %>
	<%
if(session.getAttribute("username")!=null &&
	session.getAttribute("username").equals("admin")){
%>
	<form action='admin.jsp'>	
	<button type='submit' class='infoButton' >Admin</button>
	</form>
	<% } %>
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
	
	
	       <%
            
            BufferedReader reader = new BufferedReader(new FileReader("/var/www/htdocs/prac3/harrys.txt"));
            StringBuilder sb = new StringBuilder();
            String line;
			int count =0;
            while((line = reader.readLine())!= null){
				if (count == 0){
					out.println("<tr><td><h3>"+line+"</h3>");
				}
				if (count > 0 && count <= 2){
					out.println(line+"</br>");
				}
				if (count == 3){
					out.println("<input id='harry_button' type='button' onclick='toggle_visibility(\"more_harry\", \"harry_button\")' class='infoButton' value='More Info'></input></td><td>");
					String[] splitted = line.split("\\s+");
					for (int i = 0; i < splitted.length; i++) {
						out.print("<a href=\""+splitted[i]+"\"data-lightbox=\"harrys\">");
						if (i==0) {
							out.print("<img src=\""+splitted[i]+"\"alt=\"Harry's on Buderim\" class='img'>");
						}
						out.print("</a>");
					}
					out.print("</td></tr><tr><td>");
				}

				if (count > 3){
					sb.append(line+"</br>");
				}
                
				count += 1;
            }
            out.println("<p id='more_harry' style='display: none;'>"+ sb.toString()+"</p></td></tr>");
			reader.close();
			
			
			
			BufferedReader reader2 = new BufferedReader(new FileReader("/var/www/htdocs/prac3/goose.txt"));
            StringBuilder sb2 = new StringBuilder();
            String line2;
			int count2 =0;
            while((line2 = reader2.readLine())!= null){
				if (count2 == 0){
					out.println("<tr><td><h3>"+line2+"</h3>");
				}
				if (count2 > 0 && count2 <= 2){
					out.println(line2+"</br>");
				}
				if (count2 == 3){
					out.println("<input id='goose_button' type='button' onclick='toggle_visibility(\"more_goose\", \"goose_button\")' class='infoButton' value='More Info' ></input></td><td>");
					String[] splitted2 = line2.split("\\s+");
					for (int i = 0; i < splitted2.length; i++) {
						out.print("<a href=\""+splitted2[i]+"\"data-lightbox=\"gosse\">");
						if (i==0) {
							out.print("<img src=\""+splitted2[i]+"\"alt=\"The Loose Goose\" class='img'>");
						}
						out.print("</a>");
					}
					out.print("</td></tr><tr><td>");
				}

				if (count2 > 3){
					sb2.append(line2+"</br>");
				}
                
				count2 += 1;
            }
            out.println("<p id='more_goose' style='display: none;'>"+ sb2.toString()+"</p></td></tr>");
			reader2.close();
			
			out.print("</table>");
        %>
	
	

	</div>
	
  </body>
</html>

