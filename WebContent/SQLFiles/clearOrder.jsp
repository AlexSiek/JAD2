<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
	String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {
	response.sendRedirect("../webpages/forbidden.jsp");
} else {
	try {
		int orderid = Integer.parseInt(request.getParameter("id"));
		Connection conn = DriverManager.getConnection(connURL);
		Statement stmt = conn.createStatement();
		String updtstr = "DELETE FROM buyOrder WHERE id =" + orderid;
		stmt.executeUpdate(updtstr);
		conn.close();
		response.sendRedirect("../webpages/orderPage.jsp");
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
}
%>