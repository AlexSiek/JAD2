<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
	int userId = (int) session.getAttribute("id");
	try {
		int cartId = Integer.parseInt(request.getParameter("cartId"));
		if (cartId == 0 || userId == 0) {
			response.sendRedirect("index.jsp");
		} else {
			Connection conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			String updtstr = "DELETE FROM cart WHERE id =" + cartId + " AND userId=" + userId;
			int count = stmt.executeUpdate(updtstr);
			if (count > 0) {
				out.println(count + " records deleted");
			}
			conn.close();
			response.sendRedirect("../webpages/cart.jsp");

		}
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
%>