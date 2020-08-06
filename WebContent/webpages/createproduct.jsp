<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Adding Products</title>
<link rel="stylesheet" href="../css/createproduct.css">
</head>
<%
	String err = request.getParameter("err");
	String appendedHTML ="";
	if(err != null){
		if(err.equals("mField")){
			appendedHTML += "<p class=\"text-danger\">Please Do Not Leave Any Empty Fields</p>";
		}else if(err.equals("invalidQty")){
			appendedHTML += "<p class=\"text-danger\">Quantity Cannot Be Less Than Or Equal To 0</p>";
		}else if(err.equals("invalidPrice")){
			appendedHTML += "<p class=\"text-danger\">Price Entered Is Invalid</p>";
		}else if(err.equals("invalidMSRP")){
			appendedHTML += "<p class=\"text-danger\">MSRP Entered Is Invalid</p>";
		}else if(err.equals("dupEntry")){
			appendedHTML += "<p class=\"text-danger\">Product Name Already Exist</p>";
		}
	}
%>
<body>
	<%@ include file="header.jsp"%>
	<%if(type == null || !type.equals("Admin")){
		response.sendRedirect("forbidden.jsp");
	} 
	%>
	<div class="container">
		<div class="row">
			<div class="spacing col-md-3 col-1"></div>
			<form action="../addProduct"
				class="form-tag col-md-6 col-10" method="POST" enctype="multipart/form-data">
				<h1 class="welcomeText" align="center">Adding Products</h1>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<label class="input-group-text" for="inputGroupSelect01">Categories</label>
					</div>
					<select class="custom-select" id="inputGroupSelect01" name="categoryId" required>
						<option selected value="0">Choose...</option>
						<%
						Class.forName("com.mysql.jdbc.Driver");
						conn = DriverManager.getConnection(connURL);
						try {
							ResultSet rs = getAllCategory(conn);
							int count = 0;
							while (rs.next()) {
								String category = rs.getString("categoryName");
								int categoryID = rs.getInt("id");
								out.println("<option value=\"" + categoryID + "\">" + category + "</option>");
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
						name="productName" required>
				</div>
				<div class="form-group">
					<label for="vendorLabel">Vendor</label> <input type="text"
						class="form-control" id="vendor" name="vendor" required>
				</div>
				<div class="form-group">
					<label for="pdtDescLabel">Product Description</label>
					<textarea class="form-control" id="pdtDesc" name="pdtDesc" rows=8 required></textarea>
				</div>
				<div class="form-group">
					<label for="qtyLabel">Quantity</label> <input type="number"
						class="form-control" id="qty" name="qty" required>
				</div>
				<div class="form-group">
					<label for="buyPriceLabel">Price</label> <input
						type="number" class="form-control" id="buyPrice" name="buyPrice" min="0.01" step="0.01"
						placeholder="SGD" required></input>
				</div>
				<div class="form-group">
					<label for="MSRPLabel">MSRP</label> <input
						type="number" class="form-control" id="MSRP" name="MSRP" min="0.01" step="0.01"
						placeholder="SGD" required></input>
				</div>
				<div class="form-group">
					<label for="imgURLLabel">Image</label> <br>
					<input type="file" name="pdtImg" required accept=".jpg,.png,.jpeg" />
				</div>
				<%= appendedHTML %>
				<button type="submit" class="btn btn-primary">Create</button>
			</form>
			<div class="spacing col-md-3 col-1"></div>
		</div>
	</div>
	<%@ include file="footer.html"%>
	
</body>
</html>
<%!
private ResultSet getAllCategory(Connection conn){
	try{
		Statement stmt = conn.createStatement();
		String sqlStr = "SELECT categoryName,id FROM category";
		ResultSet rs = stmt.executeQuery(sqlStr);
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	
	return null;
}
%>