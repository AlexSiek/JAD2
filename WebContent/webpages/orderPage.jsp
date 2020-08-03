<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Orders</title>
<link rel="stylesheet" href="../css/orderPage.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<%
	String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {
	response.sendRedirect("forbidden.jsp");
}
String currentTable = request.getParameter("table");
%>
</head>
<body>
	<%
		//Selecting all the rows from buyOrder table
	int pendingOrders = 0;//status 1
	int inDelivery = 0;//status 2
	int delivered = 0;
	int orderStatus;
	int productId;
	double profit = 0.00;
	Connection conn = DriverManager.getConnection(connURL);
	ResultSet rs = getOrders(conn);
	while (rs.next()) {
		orderStatus = rs.getInt("orderStatus");
		productId = rs.getInt("productId");
		if (orderStatus == 1) {
			pendingOrders++;
		} else if (orderStatus == 2) {
			inDelivery++;
		} else {
			delivered++;
		}
		Connection secondConn = DriverManager.getConnection(connURL);
		profit += getProfitFromProduct(productId, secondConn, connURL);
	}
	conn.close();
	%>
	<div class="container-fluid">
		<div class="row storeViewRow">
			<div class="storeView col d-flex justify-content-around">
				<a href="index.jsp" class="btn btn-warning storeViewBtn">View Store Page</a> 
				<a href="productmanagement.jsp" class="btn btn-warning storeViewBtn">Product Management Page</a> 
			</div>
		</div>
		<div class="row generalStatRow justify-content-center">
			<div class="tableContent col-md-10 col-12">
				<h2 class="infoText">General Statistics</h2>
				<hr>
				<div class="row boxesRow">
					<div class="col-4 d-flex justify-content-center individualCell">
						<div class="cardWrapper">
							<span class="font-weight-normal cell">Pending Orders</span>
							<div class="amountWrapper d-flex justify-content-center">
								<span class="font-weight-normal text-danger pendingOrders"><%=pendingOrders%></span>
							</div>
						</div>
					</div>
					<div class="col-4 d-flex justify-content-center individualCell">
						<div class="cardWrapper">
							<span class="font-weight-normal cell">Total Profits</span>
							<div class="amountWrapper d-flex justify-content-center">
								<span class="font-weight-normal text-success pendingOrders"><%=String.format("%.2f", profit)%></span>
							</div>
						</div>
					</div>
					<div class="col-4 d-flex justify-content-center individualCell">
						<div class="cardWrapper">
							<span class="font-weight-normal cell">Delivered Order</span>
							<div class="amountWrapper d-flex justify-content-center">
								<span class="font-weight-normal text-primary pendingOrders"><%=delivered%></span>
							</div>
						</div>
					</div>
				</div>
				<hr>
			</div>
		</div>
		<div class="row tableButtonRow d-flex justify-content-center">
			<div class="tableView col-8 d-flex justify-content-between">
				<a href="orderPage.jsp?table=pendingOrder" class="btn btn-primary storeViewBtn">Pending Orders</a> 
				<a href="orderPage.jsp?table=inDelivery" class="btn btn-primary storeViewBtn">In Delivery Orders</a> 
				<a href="orderPage.jsp?table=devliered" class="btn btn-primary storeViewBtn">Delivered Orders</a>
			</div>
		</div>
		<%
			if (currentTable == null || currentTable.equals("pendingOrder")) {
		%>
		<div class="row pendingOrderRow justify-content-center">
			<div class="col-10">
				<div class="tableHeader d-flex justify-content-center">
					<h2>
						Pending Orders(<%=pendingOrders%>)
					</h2>
				</div>
				<div class="tableWrapper">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Customer</th>
								<th scope="col">Email</th>
								<th scope="col">Address</th>
								<th scope="col">PostalCode</th>
								<th scope="col">Product Name</th>
								<th scope="col">Qty</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
							<%
							conn = DriverManager.getConnection(connURL);
							ResultSet pendingRs = getOrdersByStatus(1, conn, connURL);
							String username, email, productName, addressline1,addressline2;
							int count = 0, qty, userid, id, postalCode;
							try {
								while (pendingRs.next()) {
									id = pendingRs.getInt("buyOrder.id");
									userid = pendingRs.getInt("buyorder.userid");
									username = pendingRs.getString("user.username");
									email = pendingRs.getString("user.email");
									addressline1 = pendingRs.getString("user.addressline1");
									addressline2 = pendingRs.getString("user.addressline2");
									postalCode = pendingRs.getInt("user.postalCode");
									productName = pendingRs.getString("product.productName");
									qty = pendingRs.getInt("buyOrder.qty");
									count++;
									out.println("<tr><td>" + count + "</td><td>" + username + "</td><td>" + email + "</td><td>"+ addressline1+"-"+addressline2  + "</td><td>" + postalCode + "</td><td>" + productName
									+ "</td><td>" + qty + "</td><td><a href=\"../SQLFiles/shippedOrder.jsp?id=" + id
									+ "\" class=\"btn btn-outline-success\">Shipped<a></td></tr>");
								}
								if (count == 0) {
									out.println("<tr><td>No Orders Yet</td></tr>");
								}
							} catch (Exception e) {
								out.println(e);
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<%
			}
		%>
		<%
			if (currentTable != null) {
		%>
		<%
			if (currentTable.equals("inDelivery")) {
		%>
		<div class="row inDeliveryOrder justify-content-center">
			<div class="col-10">
				<div class="tableHeader d-flex justify-content-center">
					<h2>
						In Delivery Orders(<%=inDelivery%>)
					</h2>
				</div>
				<div class="tableWrapper">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Customer</th>
								<th scope="col">Email</th>
								<th scope="col">Address</th>
								<th scope="col">PostalCode</th>
								<th scope="col">Product Name</th>
								<th scope="col">Qty</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
							<%
								conn = DriverManager.getConnection(connURL);
							ResultSet shippedRs = getOrdersByStatus(2, conn, connURL);
							//reseting values;
							String username, email, productName, addressline1,addressline2;
							int count = 0, qty, userid, id, postalCode;
							id = 0;
							username = "";
							email = "";
							productName = "";
							count = 0;
							userid = 0;
							qty = 0;
							try {
								while (shippedRs.next()) {
									id = shippedRs.getInt("buyOrder.id");
									userid = shippedRs.getInt("buyorder.userid");
									username = shippedRs.getString("user.username");
									email = shippedRs.getString("user.email");
									addressline1 = shippedRs.getString("user.addressline1");
									addressline2 = shippedRs.getString("user.addressline2");
									postalCode = shippedRs.getInt("user.postalCode");
									productName = shippedRs.getString("product.productName");
									qty = shippedRs.getInt("buyOrder.qty");
									count++;
									out.println("<tr><td>" + count + "</td><td>" + username + "</td><td>" + email + "</td><td>"+ addressline1+"-"+addressline2  + "</td><td>" + postalCode + "</td><td>" + productName
									+ "</td><td>" + qty + "</td><td><a href=\"../SQLFiles/deliveredOrder.jsp?id=" + id
									+ "\" class=\"btn btn-outline-success\">Delivered<a></td></tr>");
								}
								if (count == 0) {
									out.println("<tr><td>No Orders Yet</td></tr>");
								}
							} catch (Exception e) {
								out.println(e);
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<%
			}
		%>


		<%
			if (currentTable.equals("devliered")) {
		%>
		<div class="row deliveredOrder justify-content-center">
			<div class="col-10">
				<div class="tableHeader d-flex justify-content-center">
					<h2>
						Delivered Orders(<%=delivered%>)
					</h2>
				</div>
				<div class="tableWrapper">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Customer</th>
								<th scope="col">Email</th>
								<th scope="col">Address</th>
								<th scope="col">PostalCode</th>
								<th scope="col">Product Name</th>
								<th scope="col">Qty</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
							<%
								conn = DriverManager.getConnection(connURL);
							ResultSet deliveredRs = getOrdersByStatus(3, conn, connURL);
							String username, email, productName, addressline1,addressline2;
							int count = 0, qty, userid, id, postalCode;
							//reseting values;
							id = 0;
							username = "";
							email = "";
							productName = "";
							count = 0;
							userid = 0;
							qty = 0;
							try {
								while (deliveredRs.next()) {
									id = deliveredRs.getInt("buyOrder.id");
									userid = deliveredRs.getInt("buyorder.userid");
									username = deliveredRs.getString("user.username");
									email = deliveredRs.getString("user.email");
									addressline1 = deliveredRs.getString("user.addressline1");
									addressline2 = deliveredRs.getString("user.addressline2");
									postalCode = deliveredRs.getInt("user.postalCode");
									productName = deliveredRs.getString("product.productName");
									qty = deliveredRs.getInt("buyOrder.qty");
									count++;
									out.println("<tr><td>" + count + "</td><td>" + username + "</td><td>" + email+ "</td><td>"+ addressline1+"-"+addressline2  + "</td><td>" + postalCode +  "</td><td>" + productName + "</td><td>" + qty + "</td><td><a href=\"#\" class=\"btn btn-outline-success\">Completed<a></td></tr>");
								}
								if (count == 0) {
									out.println("<tr><td>No Orders Yet</td></tr>");
								}
							} catch (Exception e) {
								out.println(e);
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	%>
	<%
		}
	%>
</body>
</html>
<%!private ResultSet getOrders(Connection conn) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Statement stmt = conn.createStatement();
			String sqlStr = "SELECT * FROM buyOrder";
			ResultSet rs = stmt.executeQuery(sqlStr);
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}

	private double getProfitFromProduct(int productId, Connection secondConn, String connURL) {//Fetches specific product to get the profit from order
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String sqlStr = "SELECT buyPrice,MSRP FROM product WHERE id =" + productId;
			Statement stmt = secondConn.createStatement();
			ResultSet rs = stmt.executeQuery(sqlStr);
			if (rs.next()) {
				double MSRP = rs.getDouble("MSRP");
				double price = rs.getDouble("buyPrice");
				double profit = price - MSRP;
				secondConn.close();
				return profit;
			}
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return 0;
	}

	private ResultSet getOrdersByStatus(int orderStatus, Connection conn, String connURL) {
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT buyOrder.id,buyOrder.userid,buyOrder.productid,user.addressline1,user.addressline2,user.postalCode,buyOrder.qty,user.username,user.email,product.productName FROM buyOrder INNER JOIN user ON buyOrder.userid = user.id INNER JOIN product ON buyOrder.productid = product.id WHERE orderstatus=?");
			pstmt.setInt(1, orderStatus);
			ResultSet rs = pstmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>