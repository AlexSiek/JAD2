<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
//set up access details according to your connection
String dbuser = "root";
String dbpassword = "1qazxsw2";
int port = 3306;
String connURL = "jdbc:mysql://localhost:"+port+"/j2ee?user="+dbuser+"&password="+dbpassword+"&serverTimezone=UTC";
%>