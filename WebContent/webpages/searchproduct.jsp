<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Product</title>
<link href="../css/index.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	String searchQuery = request.getParameter("searchQuery");
	%>
	<div class="productArea container">
<div class="searchQueryRow row justify-content-center">
<div class="col-12 col-md-10">
	<h2 align="center">
		Searching Product: "<%=searchQuery %>"
	</h2>
</div>
</div>
		<%
		request.getRequestDispatcher("../getProductSearch?query="+searchQuery).include(request, response);
		ArrayList<product> fetchedProducts = (ArrayList<product>) request.getAttribute("products");
		if(fetchedProducts == null){
			response.sendRedirect("error.jsp");
		}else{
			int count = 0;
			for(int i = 0; i < fetchedProducts.size();i++){
				++count;
				if(count == 1){// to insert bootstrap rows
					out.println("<div class=\"row\">");
				}else if(count == 5){
					out.println("</div>");
					out.println("<div class=\"row\">");
					count = 1;
				}
				String imageTag = "<img src=\""+ fetchedProducts.get(i).getImgURL() +"\" alt=\""+ fetchedProducts.get(i).getImgURL() +"\" class=\"productPicture img-fluid\">";
				String nameSpanTag = "<p class=\"text-body\">"+fetchedProducts.get(i).getProductName()+"</p>";
				String priceTag = "<span class=\"badge badge-pill badge-info\">SGD"+String.format("%.2f", fetchedProducts.get(i).getBuyPrice())+"</span>";
				String hrefTag = "<div class=\"productWrapper\"><a href=\"listing.jsp?id="+fetchedProducts.get(i).getId()+"\">"+imageTag+"<div class=\"productDetails\">"+nameSpanTag+priceTag+"</div></a></div>";
				out.println("<div class=\"gridSeperater col-md-3 col-6\">"+hrefTag+"</div>");
			}
			out.println("</div>");//in case amount of products not divisble by 4
		}
		%>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>