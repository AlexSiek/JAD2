<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Adding Category</title>
<link rel="stylesheet" href="../css/createproduct.css">
</head>
<%
	String err = request.getParameter("err");
	String appendedHTML ="";
	if(err != null){
		if(err.equals("mField")){
			appendedHTML += "<p class=\"text-danger\">Please Do Not Leave Any Empty Fields</p>";
		}else if(err.equals("dupEntry")){
			appendedHTML += "<p class=\"text-danger\">Category Already Exist</p>";
		}
	}
%>
<body>
	<%@ include file="header.jsp"%>
	<%if(type == null || !type.equals("Admin")){
		response.sendRedirect("forbidden.jsp");
	} 
	%>
	<div class="container">
		<div class="row">
			<div class="spacing col-md-3 col-1"></div>
			<form action="../SQLFiles/createCategorySQL.jsp"
				class="form-tag col-md-6 col-10" method="POST">
				<h1 class="welcomeText" align="center">Adding Category</h1>
				<div class="form-group">
					<label for="productNameLabel">Name Of Category</label> <input
						type="text" class="form-control" id="productName"
						name="catName" required>
				</div>
				<div class="form-group">
					<label for="pdtDescLabel">Category Description</label>
					<textarea class="form-control" id="pdtDesc" name="catDesc" rows=8 required></textarea>
				</div>
				<div class="form-group">
					<label for="imgURLLabel">Image</label> <input
						type="text" class="form-control" id="imgURL" name="imgURL" required></input>
				</div>
				<%= appendedHTML %>
				<button type="submit" class="btn btn-primary">Create</button>
			</form>
			<div class="spacing col-md-3 col-1"></div>
		</div>
	</div>
	<%@ include file="footer.html"%>
	
</body>
</html>