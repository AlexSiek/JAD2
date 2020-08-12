<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	Connection conn = DriverManager.getConnection(connURL);
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
			Class.forName("com.mysql.jdbc.Driver");
			if(searchQuery != null){
				try {
					conn = DriverManager.getConnection(connURL);
					ResultSet rs = fetchSearchQuery(searchQuery,conn);
					int count = 0;
					while(rs.next()) {
						++count;
						if(count == 1){// to insert bootstrap rows
							out.println("<div class=\"row\">");
						}else if(count == 5){
							out.println("</div>");
							out.println("<div class=\"row\">");
							count = 1;
						}
						String imageURL = rs.getString("imgURL");
						int id = rs.getInt("id");
						String productName = rs.getString("productName");
						double price = rs.getDouble("buyPrice");
						String imageTag = "<img src=\""+ imageURL +"\" alt=\""+ imageURL +"\" class=\"productPicture img-fluid\">";
						String nameSpanTag = "<p class=\"text-body\">"+productName+"</p>";
						String priceTag = "<span class=\"badge badge-pill badge-info\">SGD"+String.format("%.2f", price)+"</span>";
						String hrefTag = "<div class=\"productWrapper\"><a href=\"listing.jsp?id="+id+"\">"+imageTag+"<div class=\"productDetails\">"+nameSpanTag+priceTag+"</div></a></div>";
						out.println("<div class=\"gridSeperater col-md-3 col-6\">"+hrefTag+"</div>");
					}
					out.println("</div>");//in case amount of products not divisble by 4
					conn.close();
				}catch(Exception e){
					out.println(e);
				}
			}
		%>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>
<%! 
private ResultSet fetchSearchQuery(String query, Connection conn){
	try{
		Statement stmt = conn.createStatement();
		String sqlStr = "SELECT * FROM product WHERE productName LIKE '%"+query+"%'";
		ResultSet rs = stmt.executeQuery(sqlStr);
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>