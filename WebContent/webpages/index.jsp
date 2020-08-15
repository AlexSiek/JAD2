<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
<%@ page import="model.purchaseHistory"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="purchaseHistory" class="model.purchaseHistory" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home Page</title>
<link href="../css/index.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="bannerWrapper">
		<img src="../images/banner.png" alt="storeBanner.png"
			class="storeBanner img-fluid">
	</div>
	<div class="productArea container">
		<div class="row titleRow">Top Weekly Sellers</div>
		<div class="row">
			<%
			if(type.equals("Root")){
				response.sendRedirect("viewadmins.jsp");
			}
				request.getRequestDispatcher("../topPurchases").include(request, response);
			ArrayList<purchaseHistory> fetchedTopProducts = (ArrayList<purchaseHistory>) request.getAttribute("topProducts");
			int limit = 4;
			if (fetchedTopProducts != null) {
				if (fetchedTopProducts.size() < 4) {
					limit = fetchedTopProducts.size();
				}
				for (int i = 0; i < limit; i++) {
			%>
			<div class="gridSeperater col-md-3 col-6">
				<div class="productWrapper">
					<a href="listing.jsp?id=<%=fetchedTopProducts.get(i).getId()%>"><img
						src="<%=fetchedTopProducts.get(i).getImgURL()%>"
						alt="<%=fetchedTopProducts.get(i).getImgURL()%>"
						class="productPicture img-fluid">
						<div class="productDetails">
							<p class="text-body text-truncate"><%=fetchedTopProducts.get(i).getProductName()%></p>
							<div class="numberSold">
								<img alt="fireIcon" src="../images/topSeller.png"><%=fetchedTopProducts.get(i).getPastPurchases()%>
								Sold
							</div>
							<span class="badge badge-pill badge-info">SGD<%=fetchedTopProducts.get(i).getBuyPrice()%></span>
						</div></a>
				</div>
			</div>
			<%
				}
			}
			%>
		</div>
		<div class="row titleRow">Other Products</div>
		<%
		request.getRequestDispatcher("../getAllProductNormal").include(request, response);
		ArrayList<product> fetchedProducts  = (ArrayList<product>) request.getAttribute("products");
		int count = 0;
		if(fetchedProducts != null){
			for(int i=0;i<fetchedProducts.size();i++){
				++count;
				if (count == 1) {// to insert bootstrap rows
			out.println("<div class=\"row\">");
				} else if (count == 5) {
			out.println("</div>");
			out.println("<div class=\"row\">");
			count = 1;
				}
				//Printing of products in grids
				String imageTag = "<img src=\"" + fetchedProducts.get(i).getImgURL() + "\" alt=\"" + fetchedProducts.get(i).getImgURL() + "\" class=\"productPicture img-fluid\">";
				String nameSpanTag = "<p class=\"text-body text-truncate\">" + fetchedProducts.get(i).getProductName() + "</p>";
				String priceTag = "<span class=\"badge badge-pill badge-info\">SGD" + String.format("%.2f", fetchedProducts.get(i).getBuyPrice()) + "</span>";
				String hrefTag = "<div class=\"productWrapper\"><a href=\"listing.jsp?id=" + fetchedProducts.get(i).getId() + "\">" + imageTag
				+ "<div class=\"productDetails\">" + nameSpanTag + priceTag + "</div></a></div>";
				out.println("<div class=\"gridSeperater col-md-3 col-6\">" + hrefTag + "</div>");
			}
		}
			
		%>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>