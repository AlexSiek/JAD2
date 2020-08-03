<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Management</title>
<link rel="stylesheet" href="../css/productmanagement.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<%
	String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {
	response.sendRedirect("forbidden.jsp");
}
String currentTable = request.getParameter("table");
%>
</head>
<body>
	<div class="container">
		<div class="row storeViewRow">
			<div class="storeView col d-flex justify-content-around">
				<a href="index.jsp" class="btn btn-warning storeViewBtn">View Store Page</a> <a href="orderPage.jsp"
					class="btn btn-warning storeViewBtn">View Delivery</a>
			</div>
		</div>
	</div>
				<a href="createproduct.jsp" class="btn btn-warning storeViewBtn">Add Product</a> 
				<a href="createcategory.jsp" class="btn btn-warning storeViewBtn">Add Category</a>

</body>
</html>