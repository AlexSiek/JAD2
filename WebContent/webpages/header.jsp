<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<link rel="stylesheet" href="../css/header.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<%//Reading session
String username = (String) session.getAttribute("username");
String type = (String) session.getAttribute("type");
%>
<%
String navLink = "<a class=\"nav-link\" href=\"login.jsp\">Login</a>";//Default to login
if (username != null) {
	navLink = "<a class=\"nav-link\" href=\"profile.jsp\">" + username + "</a>";//If user is logged in, link is to their profile
}
%>
<link rel="stylesheet" href="../css/header.css">
<header>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="wrapper">
			<a class="navbar-brand" href="index.jsp"><img
				src="../images/logo.png" alt="storelogo.png" class="storeLogo"></a>
		</div>
		<div class="wrapper">
			<form class="form-inline my-2 my-lg-0" method="POST" action="searchproduct.jsp">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search Product" aria-label="Search" name="searchQuery">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
		<div class="link-wrapper collapse navbar-collapse justify-content-end"
			id="navbarSupportedContent">
			<div class="wrapperForJustify">
				<ul class="navbar-nav mr-auto">
					<%
					if(type != null){
						if (type.equals("Admin")) {
							String button = "<a href=\"createproduct.jsp\" class=\"btn btn-outline-primary\" role=\"button\">Add Product</a>";
							out.println("<li class=\"nav-item\">"+button+"</li>");
							String catButton = "<a href=\"createcategory.jsp\" class=\"btn btn-outline-primary\" role=\"button\">Add Category</a>";
							out.println("<li class=\"nav-item\">"+catButton+"</li>");
							String orderPageButton = "<a href=\"orderPage.jsp\" class=\"btn btn-outline-warning\" role=\"button\">View Orders</a>";
							out.println("<li class=\"nav-item viewOrderBtn\">"+orderPageButton+"</li>");
						}else if(type.equals("Member")){
							String button = "<a href=\"cart.jsp\" class=\"cartBtn\"><img src=\"../images/cart.png\" alt=\"cart.png\" class=\"cartBtnImg\"></a>";
							out.println("<li class=\"nav-item\">"+button+"</li>");
						}
					}
					%>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> Category</a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<%
								Class.forName("com.mysql.jdbc.Driver");
								Connection conn = DriverManager.getConnection(connURL);
							try {
								ResultSet rs = fetchAllCategories(conn);
								int count = 0;
								while (rs.next()) {
									String category = rs.getString("categoryName");
									int categoryID = rs.getInt("id");
									out.println("<a class=\"nav-link\" href=\"category.jsp?category=" + categoryID + "\">" + category + "</a>");
								}
								conn.close();
							} catch (Exception e) {
								out.println(e);
								conn.close();
							}
							%>
						</div></li>
					<li class="nav-item"><%=navLink%></li>
				</ul>
			</div>
		</div>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	</nav>
</header>
<%!
private ResultSet fetchAllCategories(Connection conn){
	try{

		Statement stmt = conn.createStatement();
		String sqlStr = "SELECT * FROM category";
		ResultSet rs = stmt.executeQuery(sqlStr);
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>