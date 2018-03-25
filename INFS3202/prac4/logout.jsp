<%

if(session != null){
    session.invalidate();
	}
response.sendRedirect("prac4.jsp");
%>