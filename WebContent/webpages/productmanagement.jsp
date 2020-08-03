<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="model.purchaseHistory,model.product"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="purchases" class="model.purchaseHistory" />
<jsp:useBean id="products" class="model.purchaseHistory" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Management</title>
<link rel="stylesheet" href="../css/productmanagement.css"/>
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
				<a href="index.jsp" class="btn btn-warning storeViewBtn">View
					Store Page</a> <a href="orderPage.jsp"
					class="btn btn-warning storeViewBtn">View Delivery</a>
			</div>
		</div>
		<div class="row productSoldRow d-flex justify-content-center">
			<div class="col-10">
			<%if(currentTable == null){  %>
			<%
				//Fetched all past purchases
			request.getRequestDispatcher("../purchaseOrders").include(request, response);
			ArrayList<purchaseHistory> pastPurchases = (ArrayList<purchaseHistory>) request.getAttribute("purchaseHistory");
			%>
				<div class="tableHeader d-flex justify-content-center">
					<h2>Recent Purchases</h2>
				</div>
				<div class="tableWrapper">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Customer</th>
								<th scope="col">Product Name</th>
								<th scope="col">Qty</th>
								<th scope="col">Time</th>
							</tr>
						</thead>
						<tbody>
							<%
							String username, productName, timeStamp;
							int count = 0, qty;
							for (int i = 0; i < pastPurchases.size(); i++) {
								username = pastPurchases.get(i).getUsername();
								productName = pastPurchases.get(i).getProductName();
								qty = pastPurchases.get(i).getQty();
								timeStamp = pastPurchases.get(i).getCreateAt();
								count++;
								out.println("<tr><td>" + count + "</td><td>" + username + "</td><td>" + productName + "</td><td>" + qty
								+ "</td><td>" + timeStamp + "</td>");
							}
							if (count == 0) {
								out.println("<tr><td>No Orders Yet</td></tr>");
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
			 <%}else{ %>
			 <%
				//Fetched all past purchases
			request.getRequestDispatcher("../getAllProducts").include(request, response);
			ArrayList<product> productsFetched = (ArrayList<product>) request.getAttribute("products");
			%>
			 <div class="tableHeader d-flex justify-content-center">
					<h2>Product Listing</h2>
				</div>
				<div class="tableWrapper">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Name</th>
								<th scope="col">Category</th>
								<th scope="col">Price</th>
								<th scope="col">Stock</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
						<%
							String categoryName, productName;
							double buyPrice;
							int count = 0, qty, productId;
							for (int i = 0; i < productsFetched.size(); i++) {
								productName = productsFetched.get(i).getProductName();
								categoryName = productsFetched.get(i).getCategoryName();
								buyPrice = productsFetched.get(i).getBuyPrice();
								qty = productsFetched.get(i).getQty();
								productId = productsFetched.get(i).getId();
								String tag = "";
								if(qty < 5){
									tag = "<span class=\"badge badge-danger\">"+qty+"</span>";
								}else if(qty < 10){
									tag = "<span class=\"badge badge-warning\">"+qty+"</span>";
								}else{
									tag = "<span class=\"badge badge-success\">"+qty+"</span>";
								}
								count++;
								out.println("<tr><td>" + count + "</td><td>" + productName + "</td><td>" + categoryName + "</td><td>"+ buyPrice + "</td>"+ "</td><td>" + tag + "</td><td><a class=\"btn btn-outline-success\" href=\"editlisting.jsp?id="+productId+"\">Edit</a></td></tr>");
							}
							if (count == 0) {
								out.println("<tr><td>No Orders Yet</td></tr>");
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
			 <%} %>
			<div class="col-2">
			<%if(currentTable == null){ %>
				<div class="btnRow row"><a href="productmanagement.jsp?table=productList" class="btn btn-primary">Product List</a></div>
			<%}else{ %>
				<div class="btnRow row"><a href="productmanagement.jsp" class="btn btn-primary">Recent Purchases</a></div>
			<%}%>
				<div class="btnRow row"><a href="createproduct.jsp" target="_blank" class="btn btn-primary">Add Product</a></div>
				<div class="btnRow row"><a href="createcategory.jsp" target="_blank" class="btn btn-primary">Add Category</a></div>
			</div>
		</div>
		<div class="row productManagementRow"></div>
	</div>
</body>
<style>
.storeViewRow{
	margin-top:50px;
	margin-bottom:5vh;
}

.btnRow {
	margin-bottom:5vh;
}
</style>
</html>