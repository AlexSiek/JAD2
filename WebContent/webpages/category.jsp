<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
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
	String categoryName = "";
	String categoryDesc = "";
	String categoryImg = "";
	int categoryid = 0;
	try {
		categoryid = Integer.parseInt(request.getParameter("category"));
	} catch (Exception e) {
		response.sendRedirect("../webpages/error.jsp");
	}
	Class.forName("com.mysql.jdbc.Driver");
	try {
		Connection connDup = DriverManager.getConnection(connURL);
		ResultSet rs = fetchCategoryDetails(categoryid,connDup);
		while (rs.next()) {
			categoryName = rs.getString("categoryName");
			categoryDesc = rs.getString("categoryDesc");
			categoryImg = rs.getString("categoryImg");
		}
		connDup.close();
	} catch (Exception e) {
		out.println(e);
	}
	%>
	<div class="container">
		<div class="IntroRow row justify-content-center">
			<div class="imgHolder col-md-4 col-8">
				<img src="<%=categoryImg%>" alt="<%=categoryName%>.png"
					class="img-fluid">
			</div>
			<div class="descWrapper col-md-8 col-10">
				<h1 class="display-2 text-center"><%=categoryName%></h1>
				<span class="catDescWrapper font-weight-light"><%=categoryDesc%></span>
			</div>
		</div>
	</div>
	<div class="productArea container">
		<%
			Class.forName("com.mysql.jdbc.Driver");
		try {
			conn = DriverManager.getConnection(connURL);
			ResultSet rs = fetchProductInCategory(categoryid,conn);
			int count = 0;
			while (rs.next()) {
				++count;
				if (count == 1) {// to insert bootstrap rows
			out.println("<div class=\"row\">");
				} else if (count == 5) {
			out.println("</div>");
			out.println("<div class=\"row\">");
			count = 1;
				}
				String imageURL = rs.getString("imgURL");
				int id = rs.getInt("id");
				String productName = rs.getString("productName");
				double price = rs.getDouble("buyPrice");
				
				String imageTag = "<img src=\"" + imageURL + "\" alt=\"" + imageURL
				+ "\" class=\"productPicture img-fluid\">";
				String nameSpanTag = "<p class=\"text-body text-truncate\">" + productName + "</p>";
				String priceTag = "<span class=\"badge badge-pill badge-info\">SGD" + String.format("%.2f", price) + "</span>";
				String hrefTag = "<div class=\"productWrapper\"><a href=\"listing.jsp?id=" + id + "\">" + imageTag
				+ "<div class=\"productDetails\">" + nameSpanTag + priceTag + "</div></a></div>";
				out.println("<div class=\"gridSeperater col-md-3 col-6\">" + hrefTag + "</div>");
			}
			out.println("</div>");//in case amount of products not divisble by 4
			conn.close();
		} catch (Exception e) {
			out.println(e);
		}
		%>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>
<%! 
private ResultSet fetchCategoryDetails(int catId, Connection conn){
	try{
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM category WHERE id =?");
		pstmt.setInt(1,catId);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}

private ResultSet fetchProductInCategory(int catId, Connection conn){
	try{
		String simpleProc = "{ call findProductFromCat(?) }";//Routine name with                                                                 // corresponding argument
		CallableStatement cs = conn.prepareCall(simpleProc);
		cs.setInt(1,catId);
		ResultSet rs=cs.executeQuery();   
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>