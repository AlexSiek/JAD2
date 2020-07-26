<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>

<%
String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Root")) {
	response.sendRedirect("../webpages/forbidden.jsp");
} else {
	String productName = "";
	int id = Integer.parseInt(request.getParameter("id"));
	try {
		Connection conn = DriverManager.getConnection(connURL);
		Statement stmt = conn.createStatement();
		String updtstr = "DELETE FROM user WHERE id ="+id;
		int count = stmt.executeUpdate(updtstr);
		if (count > 0) {
			out.println(count + " records deleted");
		}
		conn.close();
		response.sendRedirect("../webpages/viewadmins.jsp");
	} catch (Exception e) {
		out.println(e);
	}
}
%>