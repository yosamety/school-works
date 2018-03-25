<%
 String user = request.getParameter("username");
 String pswd = request.getParameter("password");

 if(user.equals("infs") && pswd.equals("3202")){
 session.setAttribute("username", user);
 session.setAttribute("password", pswd);
 response.sendRedirect("prac3.jsp");
 }
 else if(user.equals("admin") && pswd.equals("password")){
 session.setAttribute("username", user);
 session.setAttribute("password", pswd);
 response.sendRedirect("admin.jsp");
 }
 else{
 response.sendRedirect("loginpage2.jsp");
 }
%>