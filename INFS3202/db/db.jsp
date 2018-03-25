<%@ page import ="java.sql.*" %>

<%

String driverName="com.mysql.jdbc.Driver";
String url="jdbc:mysql://localhost:3306/";
String databaseName="infs3202";
String userName="infs";
String password="3202";
Connection con = null;
try{
  Class.forName(driverName);
  con=(Connection) DriverManager.getConnection(url+databaseName, userName, password);
  out.println("Connection : "+con);
}
catch(Exception e){
  out.println("Database not connected");
  e.printStackTrace();
}
Statement statement = con.createStatement(); 
ResultSet rs = statement.executeQuery("SELECT * FROM infs3202.restaurants");
while (rs.next()) {
out.println(rs.getString("Name") + "<br>");
}
rs.close();

%>
