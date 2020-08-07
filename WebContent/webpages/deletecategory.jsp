<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="model.category"%>
<jsp:useBean id="categories" class="model.category" />
<%@ include file="../dbaccess/dbDetails.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Category</title>
<link rel="stylesheet" href="../css/deletelisting.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<body>
	<%
		String type = (String) session.getAttribute("type");
		int id = Integer.parseInt(request.getParameter("id"));
		if (type == null || !type.equals("Admin")) {
			response.sendRedirect("forbidden.jsp");
		}
		request.getRequestDispatcher("../editCategory?id="+request.getParameter("id")).include(request, response);
		category categoryFetched = (category) request.getAttribute("category");
	%>
	<div class="container">
		<div class="row">
			<div class="col-12">
				<h2 class="text-center">
					Deleting
					<%=categoryFetched.getCategoryName()%>.<br>Are You Sure?
				</h2>
				<div class="buttonWrapper d-flex justify-content-center">
					<form action="../deleteCategory?id=<%= id %>" method="POST">
					<button type="submit" class="deleteBtn btn btn-outline-danger">Delete</button> <a href="editcategory.jsp?id=<%=id%>" class="backBtn btn btn-outline-primary">Go Back</a>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>