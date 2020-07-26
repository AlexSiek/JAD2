<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Listing</title>
<link rel="stylesheet" href="../css/deletelisting.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<body>
	<%
		String type = (String) session.getAttribute("type");
		String productName = "";
		int productId = Integer.parseInt(request.getParameter("id"));
		if (type == null || !type.equals("Admin")) {
			response.sendRedirect("forbidden.jsp");
		} else {
			try {
				Connection connDup = DriverManager.getConnection(connURL);
				ResultSet rs = fetchProductName(productId,connDup);
				while (rs.next()) {
			productName = rs.getString("productName");
				}
				out.println("</div>");//in case amount of products not divisble by 4
				connDup.close();
			} catch (Exception e) {
				out.println(e);
			}
		}
	%>
	<div class="container">
		<div class="row">
			<div class="col-12">
				<h2 class="text-center">
					Deleting
					<%=productName%>.<br>Are You Sure?
				</h2>
				<div class="buttonWrapper d-flex justify-content-center">
					<a href="../SQLFiles/deleteProduct.jsp?id=<%=productId %>" class="deleteBtn btn btn-outline-danger">Delete</a> <a href="listing.jsp?id=<%=productId%>" class="backBtn btn btn-outline-primary">Go Back</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%!
private ResultSet fetchProductName(int productId,Connection conn){
	try{
		PreparedStatement pstmt = conn.prepareStatement("SELECT productName FROM product WHERE id=?");
		pstmt.setInt(1,productId);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>