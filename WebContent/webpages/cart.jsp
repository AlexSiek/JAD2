<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shopping Cart</title>
<link rel="stylesheet" href="../css/cart.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
		String errId;//made it a string so we can check if it's not null
	type = (String) session.getAttribute("type");
	int userId = (int) session.getAttribute("id");
	if (type == null) {
		response.sendRedirect("login.jsp");
	} else if (type.equals("Admin") || type.equals("Root")) {
		response.sendRedirect("error.jsp");
	}
	errId = request.getParameter("errId");
	%>
	<div class="container">
		<div class="initialRow row">
			<!-- SHOWING CART ITEMS -->
			<div class="productsContent col-md-8 col-12">
				<%
					double totalPrice = 0.00;
				int amountOfProduct = 0;
				Class.forName("com.mysql.jdbc.Driver");
				boolean notEnoughStock = false;
				try {
					Connection connDup = DriverManager.getConnection(connURL);
					ResultSet rs = fetchUserCart(userId, connDup);//Fetches everything in user cart

					while (rs.next()) {
						int productId = rs.getInt("product.id");
						String productName = rs.getString("product.productName");
						double buyPrice = rs.getDouble("buyPrice");
						int qty = rs.getInt("product.qty");
						String imgURL = rs.getString("product.imgURL");
						int cartId = rs.getInt("cart.id");//used to delete cart items
						int cartQty = rs.getInt("cart.qty");
						totalPrice += cartQty * buyPrice;
						amountOfProduct++;
						if (cartQty > qty) {
							notEnoughStock = true;
						}
						out.println("<div class=\"indiCartItem row\"><div class=\"col-4\">");
						out.println("<a href=\"listing.jsp?id=" + productId
						+ "\" class=\"text-decoration-none\"><img class=\"img-fluid\" src=\"../images/" + imgURL + "\"></a>");
						out.println("</div>");
						String removeIcon = "<a href=\"../SQLFiles/deleteCartItem.jsp?cartId=" + cartId
						+ "\"><img src=\"../images/removeIcon.png\" class=\"trashImg img-fluid\" alt=\"removeIcon.png\"></a>";
						out.println("<div class=\"col-8\"><h4><a href=\"listing.jsp?id=" + productId
						+ "\" class=\"text-decoration-none text-reset\">" + productName + "</a>" + removeIcon + "</h4>");
						out.println(
						"<span class=\"text-warning font-weight-bold\">" + String.format("%.2f", buyPrice) + " SGD</span><br>");
						if (qty < 5) {
							out.println("Stock: <span class=\"badge badge-danger\">" + qty + "</span>");
						} else if (qty < 15) {
							out.println("Stock: <span class=\"badge badge-warning\">" + qty + "</span>");
						} else {
							out.println("Stock: <span class=\"badge badge-success\">" + qty + "</span>");
						}
						out.println("<br>Requested Qty: " + cartQty + "<br>");
						out.println("<p class=\"text-right font-weight-bold text-primary\">Subtotal: "
						+ String.format("%.2f", cartQty * buyPrice) + " SGD</p>");
						out.println("</div>");
						out.println("</div><hr>");//closes row
					}
					connDup.close();
				} catch (Exception e) {
					out.println(e);
				}
				%>
				<%
					if (amountOfProduct == 0) {
					out.println("<div class=\"emptyContentWrapper\">");
					out.println(
					"<div class=\"emptyCartWrapper d-flex justify-content-center\"><img src=\"../images/emptyCartIcon.png\" alt=\"EmptyCart.png\" class=\"emptyCart img-fluid\"></div>");
					out.println("<p class=\"text-center font-weight-light\">Your Cart is Empty</p>");
					out.println(
					"<div class=\"btnWrapper d-flex justify-content-center\"><a href=\"index.jsp\" class=\"btn btn btn-outline-primary\">Continue Shopping</a></div>");
					out.println("</div>");
				}
				%>
			</div>
			<!-- CHECKOUT SUMMARY -->
			<div class="checkOutSummary col-md-4 col-12">
			<p class="font-weight-bolder">Your Order Summary</p>
					
				<p class="font-weight-bolder">Your Order Summary</p>
				<%
					if (amountOfProduct == 0) {
						out.println("<p class=\"font-weight-light\">Your Cart is Empty</p>");
						out.println("<a href=\"index.jsp\" class=\"btn btn btn-outline-primary\">Continue Shopping</a>");
					}  else {
					double totalWShipping = (double) totalPrice + (amountOfProduct * 5);
					double totalWGST = (double) totalWShipping * 107 / 100;
					out.println("<div><span class=\"font-weight-light\">Subtotal (" + amountOfProduct
					+ " items)</span><span class=\"font-weight-normal totalPrice\">$" + String.format("%.2f", totalPrice)
					+ "</span></div>");
					out.println(
					"<div><span class=\"font-weight-light\">Shipping Fee($5/Product)</span><span class=\"font-weight-normal totalPrice\">$"
							+ amountOfProduct * 5 + "</span></div>");
					out.println(
					"<div><span class=\"font-weight-light\">GST(Including Shipping)</span><span class=\"font-weight-normal totalPrice\">$"
							+ String.format("%.2f", totalWGST - totalWShipping) + "</span></div>");

					out.println("<br><div><span class=\"font-weight-bold\">Total:</span><span class=\"font-weight-bold totalPrice\">$"
					+ String.format("%.2f", totalWGST) + "</span></div>");
					out.println(
					"<div class=\"checkoutBtn d-flex justify-content-center\"><a href=\"checkout.jsp\" class=\"btn btn-outline-warning btn-lg\">Checkout</a></div>");
					if (errId != null) {
						try {
							int pdtErrId = Integer.parseInt(errId);
							out.println("<br><div><span class=\"font-weight-bold text-danger\">There isn't enough stock for one or more of your requested product.</span></div>");
						} catch (Exception e) {
							out.println(e);
						}
					}
				}
			%>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>
<%!private ResultSet fetchUserCart(int userId, Connection conn) {
	try {
		PreparedStatement pstmt = conn.prepareStatement(
				"SELECT product.id,product.productName,product.qty,product.buyPrice,product.imgURL,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId = ?");
		pstmt.setInt(1, userId);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	} catch (Exception e) {
		System.out.println(e);
	}
	return null;
}%>