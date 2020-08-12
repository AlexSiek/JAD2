<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import="java.sql.*"%>
<%@ page import="model.user"%>
<jsp:useBean id="user" class="model.user" />
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editing Admin</title>
<link rel="stylesheet" href="../css/editadmin.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
<%
	String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Root")) {
	response.sendRedirect("forbidden.jsp");
}
%>
</head>
<body>
	<%
		//check if there is err code form updateAcc's redirect
		String err = request.getParameter("err");
		String appendedHTML = "";
		//fetching data for form values
		String password = "";
		int mobileNumber = 0;
		String email = "";
		String username ="";
		int id = 0;
		//user String is in header.jsp
		user fetchedAdmin = new user();
		try {
			id = Integer.parseInt(request.getParameter("id"));
			request.getRequestDispatcher("../getAdminWithId?id="+id).include(request, response);
			fetchedAdmin = (user) request.getAttribute("fetchedAdmin");
		} catch (Exception e) {
			System.out.println("Error: "+e);
		}
		if (err != null) {
			if (err.equals("mmPassword")) {
				appendedHTML = "<p class=\"text-danger\">Passwords Does Not Match</p>";
			} else if (err.equals("dupEntry")) {
				appendedHTML = "<p class=\"text-danger\">The Username,Email Or Mobile Number You Are Trying To Set Is Already In Use</p>";
			} else if (err.equals("InvalidNumber")) {
				appendedHTML = "<p class=\"text-danger\">Invalid Phone Number</p>";
			}
		}
	%>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-10">
				<form class="form-tag" action="../updateUserWithPerms?id=<%=fetchedAdmin.getId()%>" method="POST">
					<h1 class="headerText">Edit Profile</h1>
						<div class="form-group">
							<label for="username">Username</label> <input type="text"
								class="form-control" id="username" value="<%=fetchedAdmin.getUsername()%>"
								name="username" required>
						</div>
						<div class="form-group">
							<label for="email">Email address</label> <input type="email"
								class="form-control" id="email" aria-describedby="emailHelp"
								placeholder="Enter email" value="<%=fetchedAdmin.getEmail()%>" name="email"
								required>
						</div>
						<div class="form-group">
							<label for="password1">New Password</label> <input
								type="password" class="form-control" id="password1"
								placeholder="Password" value="<%=fetchedAdmin.getPassword()%>" name="password1"
								required>
						</div>
						<div class="form-group">
							<label for="password2">Confirm Password</label> <input
								type="password" class="form-control" id="password2"
								placeholder="Password" value="<%=fetchedAdmin.getPassword()%>" name="password2"
								required>
						</div>
						<div class="form-group">
							<label for="mobileNo">Phone Number</label> <input type="number"
								class="form-control" id="mobileNo" placeholder="+65"
								value="<%=fetchedAdmin.getMobileNumber()%>" name="mobileNumber" required>
						</div>
						<%=appendedHTML%>
						<div align="center">
							<button type="submit" class="btn btn-primary">Update</button>
						</div>
					</form>
						<a href="../userDeletion?id=<%=fetchedAdmin.getId()%>" class="btn btn-danger">Delete</a>
			</div>
		</div>
	</div>
</body>
</html>