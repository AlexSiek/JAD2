<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Admin</title>
<link rel="stylesheet" href="../css/addadmin.css">
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
	//user String is in header.jsp
	if (err != null) {
		if (err.equals("mmPassword")) {
			appendedHTML = "<p class=\"text-danger\">Passwords Does Not Match</p>";
		} else if (err.equals("dupEntry")) {
			appendedHTML = "<p class=\"text-danger\">The Username,Email Or Mobile Number You Are Trying To Set Is Already In Use</p>";
		}else if (err.equals("mmField")) {
			appendedHTML = "<p class=\"text-danger\">Please Don't Leave Any Fields Missing</p>";
		}else if (err.equals("moNum")) {
			appendedHTML = "<p class=\"text-danger\">Mobile Number Is Invalid</p>";
		}
	}
	%>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-10">
				<form class="form-tag"
					action="../SQLFiles/addAdmins.jsp" method="POST">
					<h1 class="headerText">Add Profile</h1>
					<div class="form-group">
						<label for="username">Username</label> <input type="text"
							class="form-control" id="username" placeholder="John Smith"
							name="username" required>
					</div>
					<div class="form-group">
						<label for="email">Email address</label> <input type="email"
							class="form-control" id="email" aria-describedby="emailHelp"
							placeholder="Enter email" name="email"
							required>
					</div>
					<div class="form-group">
						<label for="password1">New Password</label> <input type="password"
							class="form-control" id="password1" placeholder="Password"
							 name="password1" required>
					</div>
					<div class="form-group">
						<label for="password2">Confirm Password</label> <input
							type="password" class="form-control" id="password2"
							placeholder="Password" name="password2"
							required>
					</div>
					<div class="form-group">
						<label for="mobileNo">Phone Number</label> <input type="number"
							class="form-control" id="mobileNo" placeholder="+65"
							name="mobileNumber" required>
					</div>
					<%=appendedHTML%>
					<div align="center">
						<button type="submit" class="btn btn-primary">Create</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>