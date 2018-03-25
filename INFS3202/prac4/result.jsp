
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*" %>

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
<%
String url = "jdbc:mysql://localhost:3306/infs3202";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url,"test", "test");

Statement statement = con.createStatement();

ResultSet rs = statement.executeQuery("SELECT * FROM restaurants WHERE Name LIKE \'%"+request.getParameter("name")+ "%\' AND Address LIKE \'%"+request.getParameter("address")+ "%\' AND Contact LIKE \'%"+request.getParameter("phone")+ "%\' ");
int countA =0;
while (rs.next()) {
countA +=1;
out.println("<input type='text' id=\"name"+Integer.toString(countA)+"\" value=\""+rs.getString("Name") + "\" style='display: none;'>");
out.println("<input type='text' id=\"lat"+Integer.toString(countA)+"\" value=\""+rs.getString("Latitude") + "\" style='display: none;'>");
out.println("<input type='text' id=\"lon"+Integer.toString(countA)+"\" value=\""+rs.getString("Longitude") + "\" style='display: none;'>");
}
rs.close();
out.println("<input type='text' id='countA' value="+countA+" style='display: none;'>");
%> 

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
	<form action='search.jsp'>	
		<button type='submit' class='infoButton' >Search</button>
	</form>
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
	Restaurants<br>
	
	
	<%
	int count = 0;
	out.println("<table>");
	ResultSet rs2 = statement.executeQuery("SELECT * FROM restaurants WHERE Name LIKE \'%"+request.getParameter("name")+ "%\' AND Address LIKE \'%"+request.getParameter("address")+ "%\' AND Contact LIKE \'%"+request.getParameter("phone")+ "%\' ");
	while (rs2.next()) {
		count += 1;
		out.println("<tr><td><h3>" + rs2.getString("Name") + "</h3>");
		out.println(rs2.getString("Address")+"</br>");
		out.println(rs2.getString("Contact")+"</br>");
		out.println("<input id='more' type='button' onclick='toggle_visibility2(\""+Integer.toString(count)+"\")' class='infoButton' value='More Info'></input>");
		out.println("<textarea rows='8' cols='50' id="+count+" style='display: none;' readonly>");
		out.println(rs2.getString("Description"));
		out.println("</textarea></td><td>");
		String[] splitted = rs2.getString("Images").split("\\s+");
					for (int i = 0; i < splitted.length; i++) {
						out.print("<a href=\""+splitted[i]+"\"data-lightbox="+count+">");
						if (i==0) {
							out.print("<img src=\""+splitted[i]+"\"alt=\""+count+"\"class='img'>");
						}
						out.print("</a>");
					}
					
		out.println("</td></tr>");
	}
	rs.close();
	out.println("</table>");
	if (count == 0) {
		out.println("Sorry no results found");
	}
	%>
	

	</div>
	
  </body>
</html>

