<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
<%@ page import="model.user"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="user" class="model.user" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Management</title>
<link rel="stylesheet" href="../css/productmanagement.css" />
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<%
	String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {
	response.sendRedirect("forbidden.jsp");
}
%>
</head>
<body>
	<div class="container">
		<div class="row storeViewRow">
			<div class="storeView col d-flex justify-content-around">
				<a href="index.jsp" class="btn btn-warning storeViewBtn">View
					Store Page</a><a href="orderPage.jsp	"
					class="btn btn-warning storeViewBtn">View Order Page</a> <a
					href="orderPage.jsp" class="btn btn-warning storeViewBtn">View
					Delivery</a>
			</div>
		</div>
		<div class="row tableRow d-flex justify-content-center">
			<div class="col-10">
				<div class="tableHeader d-flex justify-content-center">
					<h2>Customer Management</h2>
				</div>
				<div class="timeFilterDropdown">
					<div class="form-group">
						<select class="form-control" id="selectFormControl"
							onchange="location = this.value">
							<option value="http://localhost:8080/JADCA2/webpages/customermanagement.jsp?filterby=0"
								<%if (request.getParameter("filterby") == null || Integer.parseInt(request.getParameter("filterby")) > 5 || Integer.parseInt(request.getParameter("filterby")) < 1) out.println("selected");%>disabled>Sort by...</option>
							<option value="http://localhost:8080/JADCA2/webpages/customermanagement.jsp?filterby=1"
								<%if (request.getParameter("filterby") != null && request.getParameter("filterby").equals("1")) out.println("selected");%>>Name</option>
							<option value="http://localhost:8080/JADCA2/webpages/customermanagement.jsp?filterby=2"
								<%if (request.getParameter("filterby") != null && request.getParameter("filterby").equals("2")) out.println("selected");%>>Address</option>
							<option value="http://localhost:8080/JADCA2/webpages/customermanagement.jsp?filterby=3"<%if (request.getParameter("filterby") != null && request.getParameter("filterby").equals("3")) out.println("selected");%>>Mobile Number</option>
						</select>
					</div>
				</div>
				<div class="tableWrapper">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Name</th>
								<th scope="col">Email</th>
								<th scope="col">Address</th>
								<th scope="col">Mobile Number</th>
								<th scope="col">View</th>
							</tr>
						</thead>
						<tbody>
							<%
							String sortbyExt = "";
							if (request.getParameter("filterby") != null && Integer.parseInt(request.getParameter("filterby")) < 4
									&& Integer.parseInt(request.getParameter("filterby")) > 0) {
								sortbyExt = "?sortby=" + Integer.parseInt(request.getParameter("filterby"));
							}
							request.getRequestDispatcher("../getAllCustomers" + sortbyExt).include(request, response);
							ArrayList<user> usersFetched = (ArrayList<user>) request.getAttribute("customers");
							int count = 0;
							for (int i = 0; i < usersFetched.size(); i++) {
								count++;
							%>
							<tr>
								<td><%=count%></td>
								<td><%=usersFetched.get(i).getUsername()%></td>
								<td><%=usersFetched.get(i).getEmail()%></td>
								<td><%=usersFetched.get(i).getAddressline1() + " - " + usersFetched.get(i).getAddressline2()%></td>
								<td><%=usersFetched.get(i).getMobileNumber()%></td>
								<td><a
									href="profileinquiry.jsp?id=<%=usersFetched.get(i).getId()%>"
									class="btn btn-outline-success">View</a></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<style>
.storeViewRow {
	margin-top: 50px;
	margin-bottom: 5vh;
}

.btnRow {
	margin-bottom: 5vh;
}
</style>
</html>