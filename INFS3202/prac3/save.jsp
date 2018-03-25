
<%@page import="java.io.*"%>

<%
	String name = request.getParameter("resName");
	String address = request.getParameter("resAdd");
	String phone = request.getParameter("resPhone");
	String images = request.getParameter("resImgs");
	String description = request.getParameter("resDes");
	String file = request.getParameter("file");
	
    PrintWriter pw = new PrintWriter(file);
	pw.println(name);
	pw.println(address);
	pw.println(phone);
	pw.println(images);
	pw.println(description);
	pw.close();

	
response.sendRedirect("admin.jsp");
%>
    PrintWriter pw = new PrintWriter(new FileOutputStream("/var/www/htdocs/prac3/harrys.txt"));
    pw.println(name);
	pw.println(address);
	pw.println(phone);
	pw.println(images);
	pw.println(description);
    //clean up
    pw.close();
		FileWriter filewriter = new FileWriter("/var/www/htdocs/prac3/harrys.txt", true);
	filewriter.write(name+"\n");
    filewriter.write(address+"\n");
	filewriter.write(phone+"\n");
	filewriter.write(images+"\n");
    filewriter.write(description);
    filewriter.close();