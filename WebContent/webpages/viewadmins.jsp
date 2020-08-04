<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%@ page import="model.user"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="user" class="model.user" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Admins</title>
<link rel="stylesheet" href="../css/viewadmin.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<%
	String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Root")) {
	response.sendRedirect("forbidden.jsp");
}
%>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="tableContent col-md-10 col-12">
			<h2 class="infoText">Current Admins</h2>
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">Username</th>
							<th scope="col">Email</th>
							<th scope="col">Password</th>
							<th scope="col">Mobile Number</th>
							<th scope="col">Action</th>
						</tr>
					</thead>
					<tbody>
						<%
							Class.forName("com.mysql.jdbc.Driver");
						try {
							Connection conn = DriverManager.getConnection(connURL);
							ResultSet rs = fetchAllAdmins(conn);
							int count = 0;
							while (rs.next()) {
								count++;
								out.println("<tr> <th scope=\"row\">" + count + "</th>");
								out.println("<td>" + rs.getString("username") + "</td>");
								out.println("<td>" + rs.getString("email") + "</td>");
								out.println("<td>" + rs.getString("password") + "</td>");
								out.println("<td>" + rs.getInt("mobileNumber") + "</td>");
								out.println(
								"<td><a class=\"btn btn-outline-primary\" href=\"editadmin.jsp?id=" + rs.getInt("id") + "\">Edit</a></td>");
								out.println("</tr>");
							}
							conn.close();
						} catch (Exception e) {
							out.println(e);
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row addAdminButtonRow justify-content-center">
			<div class="col-6">
				<div class="btnWrapper d-flex justify-content-between">
					<a href="../SQLFiles/logout.jsp" class="btn btn-outline-danger">Logout</a>
					<a class="btn btn-outline-primary" href="addadmin.jsp">Add Admin</a>
				</div>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="customerTableContent col-md-10 col-12">
			<h2 class="infoText">Customers</h2>
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">Username</th>
							<th scope="col">Email</th>
							<th scope="col">Address</th>
							<th scope="col">Mobile Number</th>
							<th scope="col">Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						request.getRequestDispatcher("../getAllCustomers").include(request, response);
						ArrayList<user> usersFetched = (ArrayList<user>) request.getAttribute("customers");
						int count = 0;
						for(int i = 0; i < usersFetched.size();i++){
							count++;
							out.println("<tr> <th scope=\"row\">" + count + "</th>");
							%>
							<td><%=usersFetched.get(i).getUsername() %></td>
							<td><%=usersFetched.get(i).getEmail() %></td>
							<td><%=usersFetched.get(i).getAddressline1()+"-"+usersFetched.get(i).getAddressline2() %></td>
							<td><%=usersFetched.get(i).getMobileNumber() %></td>
							<td><a class="btn btn-outline-primary" href="editadmin.jsp?id=<%=usersFetched.get(i).getId() %>">Edit</a></td>
							<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<%! 
private ResultSet fetchAllAdmins(Connection conn){
	try{
		Statement stmt = conn.createStatement();
		String sqlStr =  "SELECT * FROM user WHERE type='Admin'";
		ResultSet rs = stmt.executeQuery(sqlStr);
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>