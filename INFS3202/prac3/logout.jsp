<%

if(session != null){
    session.invalidate();
	}
response.sendRedirect("prac3.jsp");
%>