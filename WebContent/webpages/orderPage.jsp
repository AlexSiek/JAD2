<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="model.purchaseHistory"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="orders" class="model.purchaseHistory" />
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
				<a href="index.jsp" class="btn btn-warning storeViewBtn">View
					Store Page</a> <a href="productmanagement.jsp"
					class="btn btn-warning storeViewBtn">Product Management Page</a>
			</div>
		</div>
		<div class="row generalStatRow justify-content-center">
			<div class="tableContent col-md-10 col-12">
				<div class="row">
					<%
						String currentStats = request.getParameter("stats");
					%>
					<div class="col-3"></div>
					<div class="infoText col-6">General Statistics</div>
					<div class="btnWrapper col-3">
						<%
							if (currentStats == null) {
						%>
						<a href="orderPage.jsp?stats=customer"
							class="btn btn-warning storeViewBtn">Top 10 Customer</a>
					</div>
					<%
						} else {
					%>
					<a href="orderPage.jsp" class="btn btn-warning storeViewBtn">Order
						Statistics</a>
				</div>
				<%
					}
				%>
			</div>
			<hr>
			<%
				if (currentStats == null) {
			%>
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
			<%
				} else {
			%>
			<div class="tableWrapper">
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">Customer</th>
							<th scope="col">Total Spending</th>
						</tr>
					</thead>
					<tbody>
					<%
					request.getRequestDispatcher("../getTopSpenders").include(request, response);
					ArrayList<purchaseHistory> topCustomers = (ArrayList<purchaseHistory>) request.getAttribute("topUsers");
					if(topCustomers == null){
						out.println("<tr><td>No Top Spending Customer Yet</td></tr>");
					}else{
						int limit = 10;
						if(limit > topCustomers.size()){
							limit = topCustomers.size();
						}
						for(int i = 0; i < limit; i++){
							%>
							<tr>
							<td scope="col"><%=i+1%></th>
							<td scope="col"><%=topCustomers.get(i).getUsername()%></th>
							<td scope="col">$<%=topCustomers.get(i).getTotalPurchases()%></th>
							</tr>
							<%
						}
					}
					%>
					</tbody>
				</table>
			</div>
			<%
				}
			%>
			<hr>
		</div>
	</div>
	<div class="row tableButtonRow d-flex justify-content-center">
		<div class="tableView col-8 d-flex justify-content-between">
			<a href="orderPage.jsp?table=pendingOrder"
				class="btn btn-primary storeViewBtn">Pending Orders</a> <a
				href="orderPage.jsp?table=inDelivery"
				class="btn btn-primary storeViewBtn">In Delivery Orders</a> <a
				href="orderPage.jsp?table=devliered"
				class="btn btn-primary storeViewBtn">Delivered Orders</a>
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
							request.getRequestDispatcher("../getOrders?orderStatus=1").include(request, response);
						ArrayList<purchaseHistory> orderFetched = (ArrayList<purchaseHistory>) request.getAttribute("requestedOrders");
						if (orderFetched == null) {
							out.println("<tr><td>No Pending Orders</td></tr>");
						} else {
							int count = 0;
							for (int i = 0; i < orderFetched.size(); i++) {
								count++;
						%>
						<tr>
							<td><%=count%></td>
							<td><a href="profileinquiry.jsp?id=<%=orderFetched.get(i).getId()%>"><%=orderFetched.get(i).getUsername()%></a></td>
							<td><%=orderFetched.get(i).getEmail()%></td>
							<td><%=orderFetched.get(i).getAddressline1() + " - " + orderFetched.get(i).getAddressline2()%></td>
							<td><%=orderFetched.get(i).getPostalCode()%></td>
							<td><%=orderFetched.get(i).getProductName()%></td>
							<td><%=orderFetched.get(i).getQty()%></td>
							<td><a
								href="../SQLFiles/shippedOrder.jsp?id=<%=orderFetched.get(i).getBuyOrderId()%>"
								class="btn btn-outline-success">Shipped</a></td>
						</tr>
						<%
							}
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
							request.getRequestDispatcher("../getOrders?orderStatus=2").include(request, response);
						ArrayList<purchaseHistory> orderFetched = (ArrayList<purchaseHistory>) request.getAttribute("requestedOrders");
						if (orderFetched == null) {
							out.println("<tr><td>No Pending Orders</td></tr>");
						} else {
							int count = 0;
							for (int i = 0; i < orderFetched.size(); i++) {
								count++;
						%>
						<tr>
							<td><%=count%></td>
							<td><a href="profileinquiry.jsp?id=<%=orderFetched.get(i).getId()%>"><%=orderFetched.get(i).getUsername()%></a></td>
							<td><%=orderFetched.get(i).getEmail()%></td>
							<td><%=orderFetched.get(i).getAddressline1() + " - " + orderFetched.get(i).getAddressline2()%></td>
							<td><%=orderFetched.get(i).getPostalCode()%></td>
							<td><%=orderFetched.get(i).getProductName()%></td>
							<td><%=orderFetched.get(i).getQty()%></td>
							<td><a
								href="../SQLFiles/deliveredOrder.jsp?id=<%=orderFetched.get(i).getBuyOrderId()%>"
								class="btn btn-outline-success">Delivered</a></td>
						</tr>
						<%
							}
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
							request.getRequestDispatcher("../getOrders?orderStatus=3").include(request, response);
						ArrayList<purchaseHistory> orderFetched = (ArrayList<purchaseHistory>) request.getAttribute("requestedOrders");
						if (orderFetched == null) {
							out.println("<tr><td>No Pending Orders</td></tr>");
						} else {
							int count = 0;
							for (int i = 0; i < orderFetched.size(); i++) {
								count++;
						%>
						<tr>
							<td><%=count%></td>
							<td><a href="profileinquiry.jsp?id=<%=orderFetched.get(i).getId()%>"><%=orderFetched.get(i).getUsername()%></a></td>
							<td><%=orderFetched.get(i).getEmail()%></td>
							<td><%=orderFetched.get(i).getAddressline1() + " - " + orderFetched.get(i).getAddressline2()%></td>
							<td><%=orderFetched.get(i).getPostalCode()%></td>
							<td><%=orderFetched.get(i).getProductName()%></td>
							<td><%=orderFetched.get(i).getQty()%></td>
							<td><a href="#" class="btn btn-outline-success">Completed</a></td>
						</tr>
						<%
							}
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
	}%>