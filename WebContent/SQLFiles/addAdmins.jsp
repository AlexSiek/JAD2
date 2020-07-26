<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
	String type = (String) session.getAttribute("type");
	if (type == null || !type.equals("Root")) {
		response.sendRedirect("../webpages/forbidden.jsp");
	}
%>
<%
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String password1 = request.getParameter("password1");
	String password2 = request.getParameter("password2");
	int mobileNumber = 0;
	try {
		mobileNumber = Integer.parseInt(request.getParameter("mobileNumber"));
		if (!password1.equals(password2)) {
			response.sendRedirect("../webpages/addadmin.jsp?err=mmPassword");
		} else if (username == null || email == null || password1 == null || password2 == null|| mobileNumber == 0) {
			response.sendRedirect("../webpages/addadmin.jsp?err=mmField");
		} else {//without else data will still be inserted
			Class.forName("com.mysql.jdbc.Driver");
			String insertStr = "INSERT INTO user (username,password,email,mobileNumber,type) VALUES (?,?,?,?,'Admin')";
			Connection conn = DriverManager.getConnection(connURL);
			try {
				PreparedStatement pstmt = conn.prepareStatement(insertStr);
				pstmt.setString(1, username);
				pstmt.setString(2, password1);
				pstmt.setString(3, email);
				pstmt.setInt(4, mobileNumber);
				int count = pstmt.executeUpdate();
				response.sendRedirect("../webpages/viewadmins.jsp");
			} catch (java.sql.SQLIntegrityConstraintViolationException a) {
				conn.close();
				response.sendRedirect("../webpages/addadmin.jsp?err=dupEntry");
			} catch (Exception e) {
				conn.close();
				out.println(e);
			}
		}
	}catch (java.lang.NumberFormatException a) {
		response.sendRedirect("../webpages/addadmin.jsp?err=moNum");
	} catch (Exception e) {
		out.println(e);
	}
%>