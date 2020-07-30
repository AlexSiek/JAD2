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
</head>
<body>
	<%@ include file="header.jsp"%>
	<div>
	asdkuyhasdfkuyasfgdkujyahsdvkujyahsdgvkuyasdvbkuashdvgbiakshjdgvbaksgdgvkyug
	</div>

	<%
	ArrayList<cart> fetchedCarts = (ArrayList<cart>) request.getAttribute("carts");
	ArrayList<product> fetchedProducts = (ArrayList<product>) request.getAttribute("products");
	System.out.println(fetchedProducts.size());
	for(int i = 0; i < fetchedProducts.size(); i++){
		System.out.println(fetchedProducts.get(i).getProductName());
		out.println("<div>"+fetchedProducts.get(i).getProductName()+"</div>");
		System.out.println(fetchedCarts.get(i).getId());
		out.println("<div>"+fetchedCarts.get(i).getId()+"</div>");
	}
	out.println("asdasdas");
	%>
</body>
</html>