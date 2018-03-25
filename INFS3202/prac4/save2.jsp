<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*" %>

<%
	String name = request.getParameter("resName");
	String address = request.getParameter("resAdd");
	String phone = request.getParameter("resPhone");
	String images = request.getParameter("resImgs");
	String description = request.getParameter("resDes");
	String lat = request.getParameter("resLat");
	String lon = request.getParameter("resLon");
	String rowName = request.getParameter("row");
	
	String url = "jdbc:mysql://localhost:3306/infs3202";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url,"test", "test");

Statement statement = con.createStatement();

	String update = "UPDATE restaurants SET Name=\""+name+"\",Address=\""+address+"\",Contact=\""+phone+"\",Latitude=\""+lat+"\",Longitude=\""+lon+"\",Description=\""+description+"\",Images=\""+images+"\" WHERE Name=\""+rowName+"\"";
	out.println(update);

	
	statement.executeUpdate(update);

	response.sendRedirect("admin.jsp");
   
   
%>