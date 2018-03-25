<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
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
hello admin
<!-- MAKE THE NAMES HERE CHANGE DEPENDING ON FILE!!!!!!!-->
<table>
<tr><td> Harry's on Buderim</td><td><input type="button" onclick="toggle_visibility2('harry_form')" value="Edit"></td></tr>
<tr><td> The Loose Goose</td><td><input type="button" onclick="toggle_visibility2('goose_form')" value="Edit"></td></tr>
</table>


	       <%
            
            BufferedReader reader = new BufferedReader(new FileReader("/var/www/htdocs/prac3/harrys.txt"));
            StringBuilder sb = new StringBuilder();
            String line;
			int count =0;
            while((line = reader.readLine())!= null){
				if (count == 0){
					out.println("<form id='harry_form' action='save.jsp' method='POST' style='display: none;'><table><tr><td> Name:</td><td> <input type='text' name='resName' id='nameHinput' value=\""+line+"\"></td></tr>");
				}
				if (count == 1){
					out.println("<tr><td>Address:</td><td> <input type='text' name='resAdd' value=\""+line+"\"></td></tr>");
				}
				if (count == 2){
					out.println("<tr><td>Phone:</td><td> <input type='text' name='resPhone' value=\""+line+"\"></td></tr>");
				}
				if (count == 3){
					out.println("<tr><td>Images:</td><td> <input type='text' name='resImgs' value=\""+line+"\"></td></tr>");
				}
				

				if (count > 3){
					sb.append(line+"\n");
				}
                
				count += 1;
            }
			out.print("<input type='text' name='file' value='/var/www/htdocs/prac3/harrys.txt' style='display:none;'>");
            out.println("<tr><td>Description:</td><td> <textarea name='resDes' ROWS='8' COLS='50'>"+ sb.toString()+"</textarea></td></tr></table>");
			out.print("<input type='submit' id='submitH' value='Save'><input type='button' value='cancel' onclick='toggle_visibility2(\"harry_form\")'></form>");
			reader.close();
			
			BufferedReader reader2 = new BufferedReader(new FileReader("/var/www/htdocs/prac3/goose.txt"));
            StringBuilder sb2 = new StringBuilder();
            String line2;
			int count2 =0;
            while((line2 = reader2.readLine())!= null){
				if (count2 == 0){
					out.println("<form id='goose_form' action='save.jsp' method='POST' style='display: none;'><table><tr><td> Name:</td><td> <input type='text' id='nameGinput' name='resName' value=\""+line2+"\"></td></tr>");
				}
				if (count2 == 1){
					out.println("<tr><td>Address:</td><td> <input type='text' name='resAdd' value=\""+line2+"\"></td></tr>");
				}
				if (count2 == 2){
					out.println("<tr><td>Phone:</td><td> <input type='text' name='resPhone' value=\""+line2+"\"></td></tr>");
				}
				if (count2 == 3){
					out.println("<tr><td>Images:</td><td> <input type='text' name='resImgs' value=\""+line2+"\"></td></tr>");
				}
				

				if (count2 > 3){
					sb2.append(line2+"\n");
				}
                
				count2 += 1;
            }
			out.print("<input type='text' name='file' value='/var/www/htdocs/prac3/goose.txt' style='display:none;'>");
            out.println("<tr><td>Description:</td><td> <textarea name='resDes' ROWS='8' COLS='50'>"+ sb2.toString()+"</textarea></td></tr></table>");
			out.print("<input type='submit' id='submitG' value='Save' class=''><input type='button' value='cancel' onclick='toggle_visibility2(\"goose_form\")'></form>");
			reader2.close();
        %>







  </body>
</html>