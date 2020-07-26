<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
Class.forName("com.mysql.jdbc.Driver");
String email = request.getParameter("email");
String password = request.getParameter("password");
String type = "",username="";
int id = 0;
if(email == "" || password == ""){//if any field missing, immediately redirect
    response.sendRedirect("../webpages/login.jsp?err=missingField");
}
try{
    Connection conn = DriverManager.getConnection(connURL);
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
	pstmt.setString(1,email);
	pstmt.setString(2,password);
	ResultSet rs = pstmt.executeQuery();
    if(rs.next()){
        id = rs.getInt("id");
        username = rs.getString("username");
        type = rs.getString("type");
        session.setAttribute("id", id);
        session.setAttribute("username", username);
        session.setAttribute("type",type);
        conn.close();
    }else{
        conn.close();
        response.sendRedirect("../webpages/login.jsp?err=invalidLogin");
    }
    if(type.equals("Root")){
        response.sendRedirect("../webpages/viewadmins.jsp");
    }else if(type.equals("Admin")){
    	response.sendRedirect("../webpages/orderPage.jsp");
    }else{
        response.sendRedirect("../webpages/index.jsp");
    }
}catch(Exception e){
    out.println(e);
}

%>