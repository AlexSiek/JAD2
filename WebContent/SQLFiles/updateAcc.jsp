<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
	int id = (int) session.getAttribute("id");
	String username = request.getParameter("username");
	String password1 = request.getParameter("password1");
	String password2 = request.getParameter("password2");
	String email = request.getParameter("email");

	try {
		int mobileNumber = Integer.parseInt(request.getParameter("mobileNumber"));
		if(String.valueOf(mobileNumber).length() == 8){//accept only 8 digit numbers
			if (password1.equals(password2)) {
				Class.forName("com.mysql.jdbc.Driver");
				String updtstr = "UPDATE user SET username='" + username + "',password='" + password1 + "',email='"
						+ email + "',mobileNumber='" + mobileNumber + "' WHERE id='" + id + "'";
				Connection conn = DriverManager.getConnection(connURL);
				try {
					Statement stmt = conn.createStatement();
					int count = stmt.executeUpdate(updtstr);
					conn.close();
					session.setAttribute("username", username);// if name in session is not reset, change updating name, form will not fetch correct data
					response.sendRedirect("../webpages/profile.jsp?success=1");
				} catch (java.sql.SQLIntegrityConstraintViolationException a) {
					response.sendRedirect("../webpages/profile.jsp?err=dupEntry");
					conn.close();
				}
			} else {
				response.sendRedirect("../webpages/profile.jsp?err=mmPassword");
			}
		}else{
			response.sendRedirect("../webpages/profile.jsp?err=moNo");
		}
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
%>