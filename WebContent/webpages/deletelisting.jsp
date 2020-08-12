<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="model.product"%>
<jsp:useBean id="product" class="model.product" />
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
		if (type == null || !type.equals("Admin")) {
			response.sendRedirect("forbidden.jsp");
		} else {
			try {
				int productId = Integer.parseInt(request.getParameter("id"));
				request.getRequestDispatcher("../getProductWithId?productId=" + productId).include(request, response);
				product productFetched = (product) request.getAttribute("product");
				if (productFetched != null) {
	%>
	<div class="container">
		<div class="row">
			<div class="col-12">
				<h2 class="text-center">
					Deleting
					<%=productFetched.getProductName()%>.<br>Are You Sure?
				</h2>
				<div class="buttonWrapper d-flex justify-content-center">
					<a href="../productDeletion?id=<%=productId%>"
						class="deleteBtn btn btn-outline-danger">Delete</a> <a
						href="listing.jsp?id=<%=productId%>"
						class="backBtn btn btn-outline-primary">Go Back</a>
				</div>
			</div>
		</div>
	</div>
	<%
		} else {
					response.sendRedirect("error.jsp");
				}
			} catch (Exception e) {
				out.println(e);
				response.sendRedirect("error.jsp");
			}
		}
	%>
</body>
</html>