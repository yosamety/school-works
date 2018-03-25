<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*" %>

<%
if(session.getAttribute("username")!=null &&
	!session.getAttribute("username").equals("admin") ||
	session.getAttribute("username")==null){

	response.sendRedirect("loginpage.jsp");
} %>

<!DOCTYPE html>
<html>
  <head>
  <title>My Restaurants</title>
  <meta charset="utf-8" />  
  <script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/other.js"></script>
	<script type="text/javascript" src="js/formval.js"></script>
  </head>
  
  
<body>
hello admin</br>
<!-- MAKE THE NAMES HERE CHANGE DEPENDING ON FILE!!!!!!!-->
<%
String url = "jdbc:mysql://localhost:3306/infs3202";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url,"test", "test");

Statement statement = con.createStatement();


	int count = 0;
	out.println("<table>");
	ResultSet rs = statement.executeQuery("SELECT * FROM restaurants");
	while (rs.next()) {
		count += 1;
		out.println("<tr><td>" + rs.getString("Name") + "</td><td><input type='button' onclick='toggle_visibility2(\""+Integer.toString(count)+"\")' value='Edit'></td>");
		out.println("<td><form action='remove.jsp'><input type='text' name='row' value=\""+rs.getString("Name") + "\" style='display:none;'><input type='submit' value='Remove' onclick='return confirm(\"Are you sure\")'></form></td></tr>");
		
	}
	rs.close();
	count += 1;
	out.println("<tr><td></td><td><input type='button' onclick='toggle_visibility2(\""+Integer.toString(count)+"\")' value='Add'></td></tr></table>");

	int count2 = 0;
ResultSet rs2 = statement.executeQuery("SELECT * FROM restaurants");
while (rs2.next()) {
count2 += 1;
out.println("<form id=\""+Integer.toString(count2)+"\" name=\""+Integer.toString(count2)+"\" action='save2.jsp' onsubmit='return validateForm(\"name"+Integer.toString(count2)+"input\")' method='POST' style='display: none;'><table><tr><td> Name:</td><td> <input type='text' name='resName' id=\"name"+Integer.toString(count2)+"input\" value=\""+rs2.getString("Name") + "\"></td></tr>");
out.println("<tr><td>Address:</td><td> <input type='text' name='resAdd' value=\""+rs2.getString("Address") + "\"></td></tr>");
out.println("<tr><td>Phone:</td><td> <input type='text' name='resPhone' value=\""+rs2.getString("Contact") + "\"></td></tr>");
out.println("<tr><td>Images:</td><td> <input type='text' name='resImgs' value=\""+rs2.getString("Images") + "\"></td></tr>");
out.println("<tr><td>Latitude:</td><td> <input type='text' name='resLat' value=\""+rs2.getString("Latitude") + "\"></td></tr>");
out.println("<tr><td>Longitude:</td><td> <input type='text' name='resLon' value=\""+rs2.getString("Longitude") + "\"></td></tr>");
out.println("<tr><td>Description:</td><td> <textarea name='resDes' ROWS='8' COLS='50'>"+ rs2.getString("Description")+"</textarea></td></tr></table>");
out.print("<input type='text' name='row' value=\""+rs2.getString("Name") + "\" style='display:none;'>");
out.print("<input type='submit' id=\"submit"+Integer.toString(count2)+"\" value='Save'><input type='button' value='cancel' onclick='toggle_visibility2(\""+Integer.toString(count2)+"\")'></form>");


}
rs2.close();
count2 += 1;
out.println("<form id=\""+Integer.toString(count2)+"\" name='add' action='add.jsp' onsubmit=\"return validateForm(\'name"+Integer.toString(count2)+"input\')\" method='POST' style='display: none;'><table><tr><td> Name:</td><td> <input type='text' name='resName' id=\"name"+Integer.toString(count2)+"input\" value=''></td></tr>");
out.println("<tr><td>Address:</td><td> <input type='text' name='resAdd' value=''></td></tr>");
out.println("<tr><td>Phone:</td><td> <input type='text' name='resPhone' value=''></td></tr>");
out.println("<tr><td>Images:</td><td> <input type='text' name='resImgs' value=''></td></tr>");
out.println("<tr><td>Latitude:</td><td> <input type='text' name='resLat' value=''></td></tr>");
out.println("<tr><td>Longitude:</td><td> <input type='text' name='resLon' value=''></td></tr>");
out.println("<tr><td>Description:</td><td> <textarea name='resDes' ROWS='8' COLS='50'></textarea></td></tr></table>");
out.print("<input type='submit' id='submitAdd' value='Save'><input type='button' value='cancel' onclick='toggle_visibility2(\""+Integer.toString(count2)+"\")'></form>");

%>
  </body>
</html>