<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="javax.ws.rs.core.Response"%>
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
	Connection conn = DriverManager.getConnection(connURL);
		//Fetching get request from servlet
	request.getRequestDispatcher("../cartDetails").include(request, response);
	ArrayList<cart> fetchedCarts = (ArrayList<cart>) request.getAttribute("carts");
	ArrayList<product> fetchedProducts = (ArrayList<product>) request.getAttribute("products");
	if (fetchedProducts.size() == 0 || fetchedCarts.size() == 0) {
		response.sendRedirect("cart.jsp");
	}
	String errCode = request.getParameter("errCode");
	request.getRequestDispatcher("../currencyConversion").include(request, response);
	Response responseObj = (Response) request.getAttribute("responseObj");
	request.getRequestDispatcher("../getUserBySessionId").include(request, response);
	user currentUser = (user) request.getAttribute("userDetails");
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
								placeholder="Enter Address Line 1" name="addressLine1" value="<% String s = null; if (currentUser.getAddressline1() == null) {s = "";} else {s = currentUser.getAddressline1();}%><%=s%>" required>
							<label for="addressLine2">Address Line 2</label> <input
								type="text" class="form-control" id="addressLine2"
								name="addressLine2" aria-describedby="addressLine"
								placeholder="Enter Address Line 2" value="<% if (currentUser.getAddressline2() == null) {s = "";} else {s = currentUser.getAddressline2();}%><%=s%>" required> <label
								for="postalCode">Postal Code</label> <input type="number"
								class="form-control" id="postalCode" name="postalCode"
								aria-describedby="postalCode" placeholder="Postal Code"
								max="999999" value="<% if (currentUser.getPostalCode() == 0) {s = "";} else {s = String.valueOf(currentUser.getPostalCode());}%><%=s%>" required> <small id="checkboxLabel"
								class="form-text text-muted"> <input type="checkbox"
								class=" align-center" id="rememberAddress"
								name="rememberAddress" value="remember">Remember Address
							</small>
							<!--<label for="cardType">Choose a card type:</label>
							  <select name="cardType" id="cardType">
							    <option value="American Express">American Express</option>
							    <option value="MasterCard">MasterCard</option>
							    <option value="Visa">Visa</option>
							  </select>  -->
							<label for="creditcard">Credit Card</label> <input type="number"
								class="form-control" id="creditcard" name="creditcard"
								aria-describedby="creditcard" placeholder="1111222233334444"
								max="9999999999999999" min="1000000000000000" value="<% if (currentUser.getCreditCardNumber() == 0) {s = "";} else {s = String.valueOf(currentUser.getCreditCardNumber());}%><%=s%>" required>
							<div class="row">
								<div class="col">
									<label for="creditcard">CSV</label> <input type="number"
										class="form-control" id="csv" name="csv"
										aria-describedby="creditcard" placeholder="999" max="999"
										min="100" value="<% if (currentUser.getCsv() == 0) {s = "";} else {s = String.valueOf(currentUser.getCsv());}%><%=s%>" required>
								</div>
								<div class="col">
									<label for="creditcard">Expiry Date</label> <input type="number"
										class="form-control" id="expDate" name="expDate"
										aria-describedby="creditcard" placeholder="MM/YY"
										value="<% if (currentUser.getExpDate() == 0) {s = "";} else {s = String.valueOf(currentUser.getExpDate());}%><%=s%>" required>
								</div>
							</div>
							<small id="checkboxLabel" class="form-text text-muted">
								<input type="checkbox" class=" align-center" id="rememberAddress" name="rememberCard" value="remember">Set Default Credit Card
							</small>
							<small>*Card will be saved to your account.</small>
						</div>
						<div align="center">
						<div class="errorCode" style="text-align:left;color:red">
						<% if(errCode != null){
							if(errCode.equals("invalidCard")){
								out.println("The entered credit card information is invalid");
							}else if(errCode.equals("invalidAddress")){
								out.println("The entered address information is invalid");
							}
						} %>
						</div>
							<button type="submit" class="btn btn-primary">Place
								Order</button>
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