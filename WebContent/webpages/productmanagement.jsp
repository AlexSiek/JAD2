<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="model.purchaseHistory,model.product,model.category"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="purchases" class="model.purchaseHistory" />
<jsp:useBean id="products" class="model.product" />
<jsp:useBean id="categories" class="model.category" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Management</title>
<link rel="stylesheet" href="../css/productmanagement.css" />
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
				<%
					if (currentTable == null) {
				%>
				<%
					//Fetched all past purchases
				String sortbyExt = "";
				if(request.getParameter("sortby") != null && Integer.parseInt(request.getParameter("sortby")) < 6 && Integer.parseInt(request.getParameter("sortby")) >  0){
					sortbyExt = "?sortby="+Integer.parseInt(request.getParameter("sortby"));
				}
						request.getRequestDispatcher("../purchaseOrders"+sortbyExt).include(request, response);
						ArrayList<purchaseHistory> pastPurchases = (ArrayList<purchaseHistory>) request
								.getAttribute("purchaseHistory");
				%>
				<div class="tableHeader d-flex justify-content-center">
					<h2>Recent Purchases</h2>
				</div>
				<div class="sortByDropdown">
					<div class="form-group">
						<select class="form-control" id="selectFormControl"  onchange="location = this.value;">
							<option <%if(request.getParameter("sortby") == null || Integer.parseInt(request.getParameter("sortby")) > 5 || Integer.parseInt(request.getParameter("sortby")) < 1)out.println("selected"); %> disabled>Sort by...</option>
							<option value="productmanagement.jsp?sortby=1" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("1"))out.println("selected"); %>>Customer Name</option>
							<option value="productmanagement.jsp?sortby=2" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("2"))out.println("selected"); %>>Product</option>
							<option value="productmanagement.jsp?sortby=3" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("3"))out.println("selected"); %>>Quantity</option>
							<option value="productmanagement.jsp?sortby=4" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("4"))out.println("selected"); %>>Time</option>
						</select>
					</div>
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
										out.println("<tr><td>" + count + "</td><td>" + username + "</td><td>" + productName + "</td><td>"
												+ qty + "</td><td>" + timeStamp + "</td>");
									}
									if (count == 0) {
										out.println("<tr><td>No Orders Yet</td></tr>");
									}
							%>
						</tbody>
					</table>
				</div>
			</div>
			<%
				} else if (currentTable.equals("productList")) {
			%>
			<%
				//Fetched all past purchases
				String sortbyExt = "";
				if(request.getParameter("sortby") != null && Integer.parseInt(request.getParameter("sortby")) < 6 && Integer.parseInt(request.getParameter("sortby")) >  0){
					sortbyExt = "?sortby="+Integer.parseInt(request.getParameter("sortby"));
				}
					request.getRequestDispatcher("../getAllProducts"+sortbyExt).include(request, response);
					ArrayList<product> productsFetched = (ArrayList<product>) request.getAttribute("products");
			%>
			<div class="tableHeader d-flex justify-content-center">
				<h2>Product Listing</h2>
			</div>
			<div class="sortByDropdown">
				<div class="form-group">
					<select class="form-control" id="selectFormControl"  onchange="location = this.value;">
						<option <%if(request.getParameter("sortby") == null || Integer.parseInt(request.getParameter("sortby")) > 5 || Integer.parseInt(request.getParameter("sortby")) < 1)out.println("selected"); %> disabled>Sort by...</option>
						<option value="productmanagement.jsp?table=productList&sortby=1" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("1"))out.println("selected"); %>>Product Name</option>
						<option value="productmanagement.jsp?table=productList&sortby=2" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("2"))out.println("selected"); %>>Vendor</option>
						<option value="productmanagement.jsp?table=productList&sortby=3" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("3"))out.println("selected"); %>>Quantity</option>
						<option value="productmanagement.jsp?table=productList&sortby=4" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("4"))out.println("selected"); %>>Selling Price</option>
						<option value="productmanagement.jsp?table=productList&sortby=5" <%if(request.getParameter("sortby") != null && request.getParameter("sortby").equals("5"))out.println("selected"); %>>Category Name</option>
					</select>
				</div>
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
									if (qty < 5) {
										tag = "<span class=\"badge badge-danger\">" + qty + "</span>";
									} else if (qty < 10) {
										tag = "<span class=\"badge badge-warning\">" + qty + "</span>";
									} else {
										tag = "<span class=\"badge badge-success\">" + qty + "</span>";
									}
									count++;
									out.println("<tr><td>" + count + "</td><td>" + productName + "</td><td>" + categoryName
											+ "</td><td>" + buyPrice + "</td>" + "</td><td>" + tag
											+ "</td><td><a class=\"btn btn-outline-success\" href=\"editlisting.jsp?id=" + productId
											+ "\">Edit</a></td></tr>");
								}
								if (count == 0) {
									out.println("<tr><td>No Products Yet</td></tr>");
								}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<%
			} else if (currentTable.equals("categoryList")) {
		%>
		<%
			//Fetched all past purchases
				request.getRequestDispatcher("../getAllCategories").include(request, response);
				ArrayList<category> categoriesFetched = (ArrayList<category>) request.getAttribute("categories");
		%>
		<div class="tableHeader d-flex justify-content-center">
			<h2>Category Listing</h2>
		</div>
		<div class="tableWrapper">
			<table class="table table-striped">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Name</th>
						<th scope="col">Desc</th>
						<th scope="col">Action</th>
					</tr>
				</thead>
				<tbody>
					<%
						String catName, catDesc;
							int count = 0, id = 0;
							for (int i = 0; i < categoriesFetched.size(); i++) {
								count++;
								catName = categoriesFetched.get(i).getCategoryName();
								catDesc = categoriesFetched.get(i).getCategoryDesc();
								id = categoriesFetched.get(i).getId();
								out.println("<tr><td>" + count + "</td><td>" + catName + "</td><td>" + catDesc
										+ "</td><td><a class=\"btn btn-outline-success\" href=\"editcategory.jsp?id=" + id
										+ "\">Edit</a></td></tr>");
							}
							if (count == 0) {
								out.println("<tr><td>No Categories Yet</td></tr>");
							}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<%
		}
	%>
	<div class="col-2 justify-content-center">
		<div class="row btnHeader text-center">Functions</div>
		<%
			if (currentTable == null) {
		%>
		<div class="btnRow row">
			<a href="productmanagement.jsp?table=productList"
				class="btn btn-primary">Product List</a>
		</div>
		<div class="btnRow row">
			<a href="productmanagement.jsp?table=categoryList"
				class="btn btn-primary">Category List</a>
		</div>
		<%
			} else if (currentTable.equals("productList")) {
		%>
		<div class="btnRow row">
			<a href="productmanagement.jsp" class="btn btn-primary">Recent
				Purchases</a>
		</div>
		<div class="btnRow row">
			<a href="productmanagement.jsp?table=categoryList"
				class="btn btn-primary">Category List</a>
		</div>
		<%
			} else if (currentTable.equals("categoryList")) {
		%>
		<div class="btnRow row">
			<a href="productmanagement.jsp?table=productList"
				class="btn btn-primary">Product List</a>
		</div>
		<div class="btnRow row">
			<a href="productmanagement.jsp" class="btn btn-primary">Recent
				Purchases</a>
		</div>
		<%
			}
		%>
		<div class="btnRow row">
			<a href="createproduct.jsp" target="_blank" class="btn btn-primary">Add
				Product</a>
		</div>
		<div class="btnRow row">
			<a href="createcategory.jsp" target="_blank" class="btn btn-primary">Add
				Category</a>
		</div>
	</div>
	</div>
	<div class="row productManagementRow"></div>
	</div>
</body>
<style>
.storeViewRow {
	margin-top: 50px;
	margin-bottom: 5vh;
}

.btnRow {
	margin-bottom: 5vh;
}
</style>
</html>