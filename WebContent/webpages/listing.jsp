<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Listing</title>
<link rel="stylesheet" href="../css/listing.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	Connection conn = DriverManager.getConnection(connURL);
		//check for successful updates
	String success = request.getParameter("success");
	String appendedHTML = "";
	if (success != null) {
		if (success.equals("true")) {
			appendedHTML += "<h2 class=\"text-success\">Successfully Updated</h2>";
		}
	}
	%>
	<%
	product fetchedProduct = new product();
	int productId = 0;
	try {
		productId = Integer.parseInt(request.getParameter("id"));
		request.getRequestDispatcher("../getProductWithId?productId="+productId).include(request, response);
		fetchedProduct = (product) request.getAttribute("product");
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
	%>
	<div class="container">
		<div class="row successText justify-content-center">
			<div class="col-md-6 col-12 d-flex justify-content-center">
				<%=appendedHTML%>
			</div>
		</div>
		<div class="row contentRow justify-content-center">
			<div class="imgWrapper col-md-6 col-8">
				<img src="<%=fetchedProduct.getImgURL()%>" alt="productImg" class="img-fluid">
			</div>
			<div class="descWrapper col-md-6 col-12">
				<div class="productNameWrapper">
					<h2><%=fetchedProduct.getProductName()%></h2>
				</div>
				<p>
					Sold By:
					<%=fetchedProduct.getVendor()%></p>
				<hr>
				<div class="productDesc">
					<p class="text-break"><%=fetchedProduct.getPdtDesc()%></p>
				</div>
				<hr>
				<h3>
					<p class="font-weight-bolder priceTag">
						SGD<%=String.format("%.2f", fetchedProduct.getBuyPrice())%></p>
				</h3>
				<%
					//badge color
				String badge = "";
				int qty = fetchedProduct.getQty();
				if (qty == 0) {
					badge = "<span class=\"badge badge-danger\">" + 0 + "</span>";
				}else if (qty < 5) {
					badge = "<span class=\"badge badge-danger\">" + qty + "</span>";
				} else if (qty < 15) {
					badge = "<span class=\"badge badge-warning\">" + qty + "</span>";
				} else {
					badge = "<span class=\"badge badge-success\">" + qty + "</span>";
				}
				%>
				<div class="badgeWrapper">
					Quantity:
					<%=badge%>
				</div>
				<%
					String appendedButton = "";
				if (type != null) {
					if (type.equals("Admin")) {
						appendedButton = "<a class=\"btn btn-primary editButton\" href=\"editlisting.jsp?id=" + productId
						+ "\">Edit</a>";
						appendedButton += "<a class=\"btn btn-danger deleteButton\" href=\"deletelisting.jsp?id=" + productId
						+ "\">Delete</a>";
					} else if(qty == 0){
						appendedButton = "<a class=\"btn btn-danger editButton\" href=\"#"
								+ "\">Out Of Stock</a>";
					} else{
						appendedButton = "<form method=\"POST\" action=\"../addingToCart?productId=" + productId
						+ "\" class=\"\"><div class=\"row\"><div class=\"col\"><input type=\"number\" class=\"form-control\" id=\"orderQty\"  min=\"1\" value=\"1\" name=\"qty\" required> </div> <div class=\"col\"><button type=\"submit\" class=\"btn btn-warning atcButton\">Add To Cart</button></form></div></div>";
					}
				} else {
					appendedButton = "<a class=\"btn btn-warning editButton\" href=\"login.jsp\">Sign In First</a>";
				}
				%>
				<%=appendedButton%>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>