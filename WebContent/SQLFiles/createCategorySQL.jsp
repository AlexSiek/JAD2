<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {//Admin checking
	response.sendRedirect("../webpages/forbidden.jsp");
}else{
	String catName= request.getParameter("catName");
	String catDesc= request.getParameter("catDesc");
	String imgURL= request.getParameter("imgURL");
	try{
		//error redirections incase someone trys to createProduct with using form validation
		if(catName == null||catDesc == null||imgURL== null){
			response.sendRedirect("../webpages/createcategory.jsp?err=mField");
		}else{
			Class.forName("com.mysql.jdbc.Driver");
			String insertStr = "INSERT INTO category (categoryName,categoryDesc,categoryImg) VALUES (?,?,?)";
			Connection conn = DriverManager.getConnection(connURL);
			try {
				PreparedStatement pstmt = conn.prepareStatement(insertStr);
				pstmt.setString(1, catName);
				pstmt.setString(2, catDesc);
				pstmt.setString(3,"../images/"+imgURL);
				int count = pstmt.executeUpdate();
				// if name in session is not reset, change updating name, form will not fetch correct data
			} catch (java.sql.SQLIntegrityConstraintViolationException a) {
				conn.close();
				response.sendRedirect("../webpages/createcategory.jsp?err=dupEntry");
			} catch (Exception e) {
				conn.close();
				out.println(e);
			}
			try{
				conn = DriverManager.getConnection(connURL);
				Statement stmt = conn.createStatement();
				String sqlStr = "SELECT * FROM category WHERE categoryName='"+catName+"'";
				ResultSet rs = stmt.executeQuery(sqlStr);
				if(rs.next()){
					int id = rs.getInt("id");
					conn.close();
					response.sendRedirect("../webpages/category.jsp?category="+id);
				}
			}catch(Exception e){
				out.println(e);
			}
		}
	}catch(Exception e){
		out.println(e);
	}
}
%>