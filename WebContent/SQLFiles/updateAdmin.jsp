<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Root")) {
	response.sendRedirect("../webpages/forbidden.jsp");
}else{
	int id = Integer.parseInt(request.getParameter("id"));
	String username = request.getParameter("username");
	String password1 = request.getParameter("password1");
	String password2 = request.getParameter("password2");
	String email = request.getParameter("email");
	try{
	int mobileNumber = Integer.parseInt(request.getParameter("mobileNumber"));
	if(password1.equals(password2)){
		Class.forName("com.mysql.jdbc.Driver");
		String updtstr = "UPDATE user SET username='"+username+"',password='"+password1+"',email='"+email+"',mobileNumber='"+mobileNumber+"' WHERE id='"+id+"'";
		Connection conn = DriverManager.getConnection(connURL);  
		try{
			Statement stmt = conn.createStatement();
			int count = stmt.executeUpdate(updtstr);
			conn.close(); 
			session.setAttribute("username", username);// if name in session is not reset, change updating name, form will not fetch correct data
			response.sendRedirect("../webpages/viewadmins.jsp");
		}catch(java.sql.SQLIntegrityConstraintViolationException a){
			response.sendRedirect("../webpages/editadmin.jsp?id="+id+"&err=dupEntry");
			conn.close(); 
		}catch(Exception e){
			conn.close(); 
			out.println(e);
		}
	}else{
		response.sendRedirect("../webpages/editadmin.jsp?id="+id+"&err=mmPassword");
	}
	}catch(Exception e){
		response.sendRedirect("../webpages/error.jsp");
	}
}
%>