<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
	String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {
	response.sendRedirect("../webpages/forbidden.jsp");
} else {
	String productName = "";
	try {
		int productId = Integer.parseInt(request.getParameter("id"));
		Connection conn = DriverManager.getConnection(connURL);
		Statement stmt = conn.createStatement();
		String updtstr = "DELETE FROM product WHERE id =" + productId;
		int count = stmt.executeUpdate(updtstr);
		if (count > 0) {
	out.println(count + " records deleted");
		}
		out.println("</div>");//in case amount of products not divisble by 4
		conn.close();
		response.sendRedirect("../webpages/index.jsp");
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
}
%>