<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
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
	String vendor = "",productName = "",pdtDesc = "",imgURL = "";
	int qty = 0,productId = 0;
	double buyPrice = 0.00;
	try {
		productId = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
	Class.forName("com.mysql.jdbc.Driver");
	try {
		Connection connDup = DriverManager.getConnection(connURL);
		ResultSet rs = fetchProductInfo(productId,connDup);
		while (rs.next()) {
			vendor = rs.getString("vendor");
			productName = rs.getString("productName");
			pdtDesc = rs.getString("pdtDesc");
			imgURL = rs.getString("imgURL");
			qty = rs.getInt("qty");
			buyPrice = rs.getDouble("buyPrice");
		}
		out.println("</div>");//in case amount of products not divisble by 4
		connDup.close();
	} catch (Exception e) {
		out.println(e);
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
				<img src="<%=imgURL%>" alt="productImg" class="img-fluid">
			</div>
			<div class="descWrapper col-md-6 col-12">
				<div class="productNameWrapper">
					<h2><%=productName%></h2>
				</div>
				<p>
					Sold By:
					<%=vendor%></p>
				<hr>
				<div class="productDesc">
					<p class="text-break"><%=pdtDesc%></p>
				</div>
				<hr>
				<h3>
					<p class="font-weight-bolder priceTag">
						SGD<%=String.format("%.2f", buyPrice)%></p>
				</h3>
				<%
					//badge color
				String badge = "";
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
<%! 
private ResultSet fetchProductInfo(int productId,Connection conn){
	try{
		String simpleProc = "{ call findProduct(?) }";//Routine name with                                                                 // corresponding argument
		CallableStatement cs = conn.prepareCall(simpleProc);
		cs.setInt(1,productId);
		ResultSet rs=cs.executeQuery();   
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>