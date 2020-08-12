<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Category</title>
<link href="../css/index.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	
	Connection conn = DriverManager.getConnection(connURL);
	int categoryid = 0;
	try {
		categoryid = Integer.parseInt(request.getParameter("category"));
		request.getRequestDispatcher("../getCategoryWithId?id="+categoryid).include(request, response);
		category categoryFetched = (category) request.getAttribute("category");
		if(categoryFetched != null){
			%>
			<div class="container">
			<div class="IntroRow row justify-content-center">
				<div class="imgHolder col-md-4 col-8">
					<img src="<%=categoryFetched.getCategoryImg()%>" alt="<%=categoryFetched.getCategoryName()%>.png"
						class="img-fluid">
				</div>
				<div class="descWrapper col-md-8 col-10">
					<h1 class="display-2 text-center"><%=categoryFetched.getCategoryName()%></h1>
					<span class="catDescWrapper font-weight-light"><%=categoryFetched.getCategoryDesc()%></span>
				</div>
			</div>
		</div>
			<%
		}else {
			response.sendRedirect("../webpages/error.jsp");
		}
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
	%>
	<div class="productArea container">
		<%
		try {
			categoryid = Integer.parseInt(request.getParameter("category"));
			request.getRequestDispatcher("../getProductInCat?catId="+categoryid).include(request, response);
			ArrayList<product> productsFetched = (ArrayList<product>) request.getAttribute("productsInCat");
			if(productsFetched != null){
				int count = 0;
				for(int i = 0; i < productsFetched.size(); i++){
					++count;
					if (count == 1) {// to insert bootstrap rows
				out.println("<div class=\"row\">");
					} else if (count == 5) {
				out.println("</div>");
				out.println("<div class=\"row\">");
				count = 1;
					}
					String imageURL = productsFetched.get(i).getImgURL();
					int id = productsFetched.get(i).getId();
					String productName = productsFetched.get(i).getProductName();
					double price = productsFetched.get(i).getBuyPrice();
					
					String imageTag = "<img src=\"" + imageURL + "\" alt=\"" + imageURL
					+ "\" class=\"productPicture img-fluid\">";
					String nameSpanTag = "<p class=\"text-body text-truncate\">" + productName + "</p>";
					String priceTag = "<span class=\"badge badge-pill badge-info\">SGD" + String.format("%.2f", price) + "</span>";
					String hrefTag = "<div class=\"productWrapper\"><a href=\"listing.jsp?id=" + id + "\">" + imageTag
					+ "<div class=\"productDetails\">" + nameSpanTag + priceTag + "</div></a></div>";
					out.println("<div class=\"gridSeperater col-md-3 col-6\">" + hrefTag + "</div>");
				}
			}else {
				response.sendRedirect("../webpages/error.jsp");
			}
		} catch (Exception e) {
			response.sendRedirect("../webpages/error.jsp");
		}
		
		%>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>