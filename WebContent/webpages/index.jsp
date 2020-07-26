<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
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
		<%
		Class.forName("com.mysql.jdbc.Driver");
		try {
			conn = DriverManager.getConnection(connURL);
			int count = 0;
			String imageURL,productName;
			int id;
			double price;
			ResultSet rs = fetchAllProducts(conn);
			while(rs.next()) {
				//Div wrapping
				++count;
				if(count == 1){// to insert bootstrap rows
					out.println("<div class=\"row\">");
				}else if(count == 5){
					out.println("</div>");
					out.println("<div class=\"row\">");
					count = 1;
				}
				//Result setting
				imageURL = rs.getString("imgURL");
				id = rs.getInt("id");
				productName = rs.getString("productName");
				price = rs.getDouble("buyPrice");
				//Printing of products in grids
				String imageTag = "<img src=\""+ imageURL +"\" alt=\""+ imageURL +"\" class=\"productPicture img-fluid\">";
				String nameSpanTag = "<p class=\"text-body text-truncate\">"+productName+"</p>";
				String priceTag = "<span class=\"badge badge-pill badge-info\">SGD"+String.format("%.2f", price)+"</span>";
				String hrefTag = "<div class=\"productWrapper\"><a href=\"listing.jsp?id="+id+"\">"+imageTag+"<div class=\"productDetails\">"+nameSpanTag+priceTag+"</div></a></div>";
				out.println("<div class=\"gridSeperater col-md-3 col-6\">"+hrefTag+"</div>");
			}
			out.println("</div>");//in case amount of products not divisble by 4
			conn.close();
		}catch(Exception e){
			out.println(e);
		}
		%>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>
<%! 
private ResultSet fetchAllProducts(Connection conn){
	try{
		String simpleProc = "{ call findAllProduct() }";//Routine name with                                                                 // corresponding argument
		CallableStatement cs = conn.prepareCall(simpleProc);
		ResultSet rs=cs.executeQuery();   
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>