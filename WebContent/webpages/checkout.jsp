<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.cart,model.product" %>
<%@ page import="java.util.ArrayList" %>
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
	%>
	<div class="container">
			<div class="formColumn col-md-8 col-12">
			</div>
			<div class="productsContent col-md-4 col-12">
				<div class="orderHeader">Order Summary</div>
				<%
					double totalPrice = 0;
					int count = 0;
					for(int i = 0; i < fetchedProducts.size(); i++){
						totalPrice += fetchedProducts.get(i).getBuyPrice();
						count++;
						out.println("<div class=\"orderItem\">");
						out.println("<div class=\"d-flex justify-content-between\"><div class=\"font-weight-light\">"+fetchedProducts.get(i).getProductName()+"</div><div class=\"font-weight-normal buyPrice\">$"+String.format("%.2f", fetchedProducts.get(i).getBuyPrice())+"</div></div>");
						out.println("</div>");
					}
				%>
				<br>
				<div class="subTotal d-flex justify-content-between"><div class="font-weight-light">Subtotal</div><div class="font-weight-normal buyPrice">$<%=String.format("%.2f", totalPrice) %></div></div>
				<div class="subTotal d-flex justify-content-between"><div class="font-weight-light">Shipping Fee($5/Product)</div><div class="font-weight-normal buyPrice">$<%=count*5 %></div></div>
				<div class="subTotal d-flex justify-content-between"><div class="font-weight-light">GST</div><div class="font-weight-normal buyPrice">$<%=String.format("%.2f", totalPrice/100*7) %></div></div>
				<br>
				<div class="total d-flex justify-content-between"><div class="font-weight-bold">Total:</div><div class="font-weight-normal buyPrice">$<%=String.format("%.2f", totalPrice+count*5+totalPrice/100*7) %></div></div>
			</div>
	</div>
	<%@ include file="footer.html"%>
</body> 
</html>