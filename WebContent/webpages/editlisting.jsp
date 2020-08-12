<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<%
	//check for failure updates
	String err = request.getParameter("err");
	String appendedHTML = "";
	if (err != null) {
		if (err.equals("mField")) {
			appendedHTML += "<p class=\"text-danger\">Please Do Not Leave Any Empty Fields</p>";
		} else if (err.equals("invalidQty")) {
			appendedHTML += "<p class=\"text-danger\">Quantity Cannot Be Less Than Or Equal To 0</p>";
		} else if (err.equals("invalidPrice")) {
			appendedHTML += "<p class=\"text-danger\">Price Entered Is Invalid</p>";
		} else if (err.equals("invalidMSRP")) {
			appendedHTML += "<p class=\"text-danger\">MSRP Entered Is Invalid</p>";
		} else if (err.equals("dupEntry")) {
			appendedHTML += "<p class=\"text-danger\">Product Name Already Exist</p>";
		}
	}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Listing</title>
<link rel="stylesheet" href="../css/editlisting.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	Connection conn = DriverManager.getConnection(connURL);
		if (type == null || !type.equals("Admin")) {
			response.sendRedirect("forbidden.jsp");
		}
		String vendor = "",productName = "",pdtDesc = "",imgURL = "";
		int qty = 0,categoryId = 0;
		double buyPrice = 0.00,MSRP = 0;
		int productId = Integer.parseInt(request.getParameter("id"));
		Class.forName("com.mysql.jdbc.Driver");
		try {
			Connection connDup = DriverManager.getConnection(connURL);
			ResultSet rs = fetchProductDetails(productId,connDup);
			while (rs.next()) {
				vendor = rs.getString("vendor");
				categoryId = rs.getInt("categoryId");
				productName = rs.getString("productName");
				pdtDesc = rs.getString("pdtDesc");
				imgURL = rs.getString("imgURL");
				qty = rs.getInt("qty");
				buyPrice = rs.getDouble("buyPrice");
				MSRP = rs.getDouble("MSRP");
			}
			out.println("</div>");//in case amount of products not divisble by 4
			connDup.close();
		} catch (Exception e) {
			out.println(e);
		}
	%>
	<div class="container">
		<div class="row contentRow justify-content-center">
			<div class="imgWrapper col-md-4 col-8">
				<img src="<%=imgURL%>" alt="productImg" class="img-fluid">
			</div>
			<br>
			<div class="productForm col-md-10 col-12">
				<form action="../editProduct"
					class="form-tag" method="POST" enctype="multipart/form-data">
					<%=appendedHTML%>
					<input type="number" value="<%=productId%>" name="id" hidden>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">Categories</label>
						</div>
						<select class="custom-select" id="inputGroupSelect01"
							name="categoryId" required>
							<%
							Class.forName("com.mysql.jdbc.Driver");
							conn = DriverManager.getConnection(connURL);
							try {
								ResultSet rs = fetchCategories(conn);
								int count = 0;
								while (rs.next()) {
									String category = rs.getString("categoryName");
									int categoryID = rs.getInt("id");
									if (categoryID == categoryId) {
								out.println("<option value=\"" + categoryID + "\" selected>" + category + "</option>");
									} else {
								out.println("<option value=\"" + categoryID + "\">" + category + "</option>");
									}
								}
								conn.close();
							} catch (Exception e) {
								out.println(e);
								conn.close();
							}
							%>
						</select>
					</div>
					<div class="form-group">
						<label for="productNameLabel">Name Of Product</label> <input
							type="text" class="form-control" id="productName"
							name="productName" value="<%=productName%>" required>
					</div>
					<div class="form-group">
						<label for="vendorLabel">Vendor</label> <input type="text"
							class="form-control" id="vendor" name="vendor"
							value="<%=vendor%>" required>
					</div>
					<div class="form-group">
						<label for="pdtDescLabel">Product Description</label>
						<textarea class="form-control" id="pdtDesc" name="pdtDesc" rows=8
							required><%=pdtDesc%></textarea>
					</div>
					<div class="form-group">
						<label for="qtyLabel">Quantity</label> <input type="number"
							class="form-control" id="qty" name="qty" value="<%=qty%>"
							required>
					</div>
					<div class="form-group">
						<label for="buyPriceLabel">Price</label> <input type="number"
							class="form-control" id="buyPrice" name="buyPrice" min="0.01"
							step="0.01" placeholder="SGD" value="<%=buyPrice%>" required></input>
					</div>
					<div class="form-group">
						<label for="MSRPLabel">MSRP</label> <input type="number"
							class="form-control" id="MSRP" name="MSRP" placeholder="SGD"
							min="0.01" step="0.01" value="<%=MSRP%>" required></input>
					</div>
					<div class="form-group">
					<label for="imgURLLabel">Image</label> <br>
					<input type="file" name="pdtImg" required accept=".jpg,.png,.jpeg" />
				</div>
					<button type="submit" class="btn btn-primary">Save</button> <a class="btn btn-danger deleteButton" href="deletelisting.jsp?id=<%=productId%>">Delete</a>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>
<%! 
private ResultSet fetchProductDetails(int productId,Connection conn){
	try{
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM product WHERE id=?");
		pstmt.setInt(1,productId);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}

private ResultSet fetchCategories(Connection conn){
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