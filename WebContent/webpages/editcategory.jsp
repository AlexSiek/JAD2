<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="model.category"%>
<jsp:useBean id="categories" class="model.category" />
<!DOCTYPE html>
<%
	//check for failure updates
	String err = request.getParameter("err");
	String appendedHTML = "";
	if (err != null) {
		if (err.equals("mField")) {
			appendedHTML += "<p class=\"text-danger\">Please Do Not Leave Any Empty Fields</p>";
		}else if (err.equals("dupEntry")) {
			appendedHTML += "<p class=\"text-danger\">Product Name Already Exist</p>";
		}
	}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Category</title>
<link rel="stylesheet" href="../css/editlisting.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
		if (type == null || !type.equals("Admin")) {
			response.sendRedirect("forbidden.jsp");
		}
		request.getRequestDispatcher("../editCategory?id="+request.getParameter("id")).include(request, response);
		category categoryFetched = (category) request.getAttribute("category");
	%>
	<div class="container">
		<div class="row contentRow justify-content-center">
			<div class="imgWrapper col-md-4 col-8">
				<img src="<%=categoryFetched.getCategoryImg() %>" alt="catImg" class="img-fluid">
			</div>
			<br>
			<div class="productForm col-md-10 col-12">
				<form action="../editCategory"
					class="form-tag" method="POST" enctype="multipart/form-data">
					<%=appendedHTML%>
					<input type="number" value="<%=categoryFetched.getId()%>" name="id" hidden>
					<div class="form-group">
						<label for="productNameLabel">Category Name</label> <input
							type="text" class="form-control" id="categoryName"
							name="categoryName" value="<%=categoryFetched.getCategoryName() %>" required>
					</div>
					<div class="form-group">
						<label for="descLabel">Category Description</label> <textarea
							class="form-control" id="categoryDesc" name="categoryDesc"
							required><%=categoryFetched.getCategoryDesc() %></textarea>
					</div>
					<div class="form-group">
					<label for="imgURLLabel">Image</label> <br>
					<input type="file" name="categoryImg" required accept=".jpg,.png,.jpeg" />
				</div>
					<button type="submit" class="btn btn-primary">Save</button> <a class="btn btn-danger deleteButton" href="deletecategory.jsp?id=<%=categoryFetched.getId()%>">Delete</a>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>