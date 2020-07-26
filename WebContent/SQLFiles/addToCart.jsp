<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%;
int userId = (int) session.getAttribute("id");
try{
int qty = Integer.parseInt(request.getParameter("qty"));
int productId = Integer.parseInt(request.getParameter("productId"));
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(connURL);
	try {
		Statement stmt = conn.createStatement();
		String sqlStr = "SELECT id,qty FROM cart WHERE productId ="+productId+" AND userId="+userId;//ensure that user does not insert multiple individual row for same product
		ResultSet rs = stmt.executeQuery(sqlStr);
		if(rs.next()){//if there is existing item in cart, update to increase amount
			int id = rs.getInt("id");
			int cartQty = rs.getInt("qty");
			int newQty = qty+cartQty;
			
			String updateStr = "UPDATE cart SET qty="+newQty+" WHERE id="+id;
			Connection conn2 = DriverManager.getConnection(connURL);
			Statement stmt2 = conn2.createStatement();
			stmt2.executeUpdate(updateStr);
			conn2.close();
			
			response.sendRedirect("../webpages/cart.jsp");
		}else{//if no existing item in cart, insert new ones
			String insertStr = "INSERT INTO cart (userId,productId,qty) VALUES (?,?,?)";
			Connection conn2 = DriverManager.getConnection(connURL);
			try {
				PreparedStatement pstmt = conn2.prepareStatement(insertStr);
				pstmt.setInt(1, userId);
				pstmt.setInt(2, productId);
				pstmt.setInt(3, qty);
				int count = pstmt.executeUpdate();
				conn2.close();
				response.sendRedirect("../webpages/cart.jsp");
			}catch (Exception e) {
				conn2.close();
				out.println(e);
			}
		}
	}catch (Exception e) {
		conn.close();
		out.println(e);
	}
}catch(java.sql.SQLIntegrityConstraintViolationException a){
	response.sendRedirect("../webpages/error.jsp");
}catch (Exception e) {
	out.println(e);
}
%>