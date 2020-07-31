<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="model.cart,model.product"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import = "javax.ws.rs.core.Response" %>
<jsp:useBean id="cart" class="model.cart" />
<jsp:useBean id="product" class="model.product" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout</title>
<link rel="stylesheet" href="../css/checkout.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
		//Fetching get request from servlet
		request.getRequestDispatcher("../cartDetails").include(request, response);
		ArrayList<cart> fetchedCarts = (ArrayList<cart>) request.getAttribute("carts");
		ArrayList<product> fetchedProducts = (ArrayList<product>) request.getAttribute("products");
		if (fetchedProducts.size() == 0 || fetchedCarts.size() == 0) {
			response.sendRedirect("cart.jsp");
		}
		request.getRequestDispatcher("../currencyConversion").include(request, response);
		Response responseObj = (Response) request.getAttribute("responseObj");
	%>
	<div class="container">
		<div class="row">
			<div class="formColumn col-md-8 col-12">
				<div class="deliverySection">
					<div class="deliveryHeader d-flex justify-content-center">Delivery
						Information</div>
					<form action="../cartDetails" method="POST">
						<div class="form-group">
							<label for="addressLine1">Address Line 1</label> <input
								type="text" class="form-control" id="addressLine1"
								aria-describedby="addressLine"
								placeholder="Enter Address Line 1" name="addressLine1" required> <label
								for="addressLine2">Address Line 2</label> <input type="text"
								class="form-control" id="addressLine2" name="addressLine2"
								aria-describedby="addressLine"
								placeholder="Enter Address Line 2" required> <label
								for="postalCode">Postal Code</label> <input type="number"
								class="form-control" id="postalCode" name="postalCode"
								aria-describedby="postalCode" placeholder="Postal Code" max="999999" required>
							<small id="checkboxLabel" class="form-text text-muted"><input
								type="checkbox" class=" align-center" id="rememberAddress" name="rememberAddress" value="remember">Remember
								Address</small>
						</div>
						<div align="center">
							<button type="submit" class="btn btn-primary">Place Order</button>
						</div>
					</form>
				</div>
			</div>
			<div class="productsContent col-md-4 col-12">
				<div class="orderHeader">Order Summary</div>
				<%
					double totalPrice = 0;
					int count = 0;
					for (int i = 0; i < fetchedProducts.size(); i++) {
						totalPrice += fetchedProducts.get(i).getBuyPrice();
						count++;
						out.println("<div class=\"orderItem\">");
						out.println("<div class=\"d-flex justify-content-between\"><div class=\"font-weight-light\">"
								+ fetchedProducts.get(i).getProductName() + "</div><div class=\"font-weight-normal buyPrice\">$"
								+ String.format("%.2f", fetchedProducts.get(i).getBuyPrice()) + "</div></div>");
						out.println("</div>");
					}
				%>
				<br>
				<div class="subTotal d-flex justify-content-between">
					<div class="font-weight-light">Subtotal</div>
					<div class="font-weight-normal buyPrice">
						$<%=String.format("%.2f", totalPrice)%></div>
				</div>
				<div class="subTotal d-flex justify-content-between">
					<div class="font-weight-light">Shipping Fee($5/Product)</div>
					<div class="font-weight-normal buyPrice">
						$<%=count * 5%></div>
				</div>
				<div class="subTotal d-flex justify-content-between">
					<div class="font-weight-light">GST</div>
					<div class="font-weight-normal buyPrice">
						$<%=String.format("%.2f", totalPrice / 100 * 7)%></div>
				</div>
				<br>
				<div class="total d-flex justify-content-between">
					<div class="font-weight-bold">Total:</div>
					<div class="font-weight-normal buyPrice">
						$<%=String.format("%.2f", totalPrice + count * 5 + totalPrice / 100 * 7)%></div>
				</div>
				<div class="usdPrice d-flex justify-content-between">
					<div class="font-weight-bold">Total(USD):</div>
					<div class="font-weight-normal buyPrice" id="insertPrice"></div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
<script>
	var responseObj = <%=responseObj.readEntity(String.class)%>
	var sgdRate = responseObj.rates.SGD;
	<%double totaledPrice = (totalPrice + count * 5 + totalPrice / 100 * 7);%>
	var totalPrice = <%=totaledPrice%>
	document.getElementById("insertPrice").innerHTML = "$"+Math.round((totalPrice/sgdRate) * 100) / 100;
</script>
</body>
</html>