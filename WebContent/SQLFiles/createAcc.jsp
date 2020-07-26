<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String password1 = request.getParameter("password1");
	String password2 = request.getParameter("password2");
	try {
		int mobileNumber = Integer.parseInt(request.getParameter("mobileNo"));//if null or string, will be caught.
		if(String.valueOf(mobileNumber).length() == 8){
			if (!password1.equals(password2)) {
				response.sendRedirect("../webpages/createaccount.jsp?err=mmPassword");
			} else {//without else data will still be inserted
				Class.forName("com.mysql.jdbc.Driver");
				String insertStr = "INSERT INTO user (username,password,email,mobileNumber,type) VALUES (?,?,?,?,'Member')";
				Connection conn = DriverManager.getConnection(connURL);
				try {
					PreparedStatement pstmt = conn.prepareStatement(insertStr);
					pstmt.setString(1, username);
					pstmt.setString(2, password1);
					pstmt.setString(3, email);
					pstmt.setInt(4, mobileNumber);
					int count = pstmt.executeUpdate();
					// if name in session is not reset, change updating name, form will not fetch correct data
				} catch (java.sql.SQLIntegrityConstraintViolationException a) {
					conn.close();
					response.sendRedirect("../webpages/createaccount.jsp?err=dupEntry");
				} catch (Exception e) {
					conn.close();
					out.println(e);
				}
				try {
					conn = DriverManager.getConnection(connURL);
					Statement stmt = conn.createStatement();
					String sqlStr = "SELECT * FROM user WHERE email='" + email + "' AND password='" + password1
							+ "'";
					ResultSet rs = stmt.executeQuery(sqlStr);
					if (rs.next()) {
						session.setAttribute("id", rs.getInt("id"));
						session.setAttribute("username", rs.getString("username"));
						session.setAttribute("type", rs.getString("type"));
						conn.close();
					}
					response.sendRedirect("../webpages/index.jsp");
				} catch (Exception e) {
					out.println(e);
				}
			}
		}else{//if mobile number != 8digit
			response.sendRedirect("../webpages/createaccount.jsp?err=moNo");
		}
	} catch (java.lang.NumberFormatException a) {
		response.sendRedirect("../webpages/createaccount.jsp?err=moNo");
	}
%>