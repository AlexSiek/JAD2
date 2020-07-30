<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile Page</title>
<link rel="stylesheet" href="../css/profile.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
		//check if there is err code form updateAcc's redirect
		if(username == null){
			response.sendRedirect("error.jsp");
		}
		String err = request.getParameter("err");
		String success = request.getParameter("success");
		String updated = "",appendedHTML = "";
		//fetching data for form values
		String password = "",email = "";
		int mobileNumber = 0;
		//user String is in header.jsp
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			ResultSet rs = fetchUserProfile(username,conn);
			if (rs.next()) {
				session.setAttribute("username", rs.getString("username"));
				password = (String) rs.getString("password");
				mobileNumber = (int) rs.getInt("mobileNumber");
				email = (String) rs.getString("email");
				conn.close();
			} else {
				conn.close();
			}
		} catch (Exception e) {
			out.println(e);
		}
		if(success == null){// checks for success or fail codes
				if (err != null) {
					if (err.equals("mmPassword")) {
				appendedHTML = "<p class=\"text-danger\">Passwords Does Not Match</p>";
					} else if (err.equals("dupEntry")) {
				appendedHTML = "<p class=\"text-danger\">The Username,Email Or Mobile Number You Are Trying To Set Is Already In Use</p>";
					}else if(err.equals("moNo")){
						appendedHTML = "<p class=\"text-danger\">Invalid Mobile Number</p>";
					}
				}
		}else {
			updated = "<h1 class=\"text-success\" align=\"center\">Successfully Updated</h1>";
		}
	%>
	<div class="container">
		<div class="row justify-content-center">
			<div class="form-spacing col-md-6 col-10">
				<div class="buttonWrapper" align="center">
					<form action="../SQLFiles/logout.jsp">
						<button type="submit" class="btn btn-outline-primary">Logout</button>
					</form>
				</div>
				<%=updated%>
				<h1 class="headerText">Edit Profile</h1>
				<form class="form-tag" action="../userDetails"
					method="POST">
					<div class="form-group">
						<label for="username">Username</label> <input type="text"
							class="form-control" id="username" value="<%=username%>"
							name="username" required>
					</div>
					<div class="form-group">
						<label for="email">Email address</label> <input type="email"
							class="form-control" id="email" aria-describedby="emailHelp"
							placeholder="Enter email" value="<%=email%>" name="email"
							required>
					</div>
					<div class="form-group">
						<label for="password1">New Password</label> <input type="password"
							class="form-control" id="password1" placeholder="Password"
							value="<%=password%>" name="password1" required>
					</div>
					<div class="form-group">
						<label for="password2">Confirm Password</label> <input
							type="password" class="form-control" id="password2"
							placeholder="Password" value="<%=password%>" name="password2"
							required>
					</div>
					<div class="form-group">
						<label for="mobileNo">Phone Number</label> <input type="number"
							class="form-control" id="mobileNo" placeholder="+65"
							value="<%=mobileNumber%>" name="mobileNumber" required>
					</div>
					<%=appendedHTML%>
					<div align="center">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>
<%! 
private ResultSet fetchUserProfile(String username, Connection conn){
	try{
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE username=?");
		pstmt.setString(1,username);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}catch(Exception e){
		System.out.println(e);
	}
	return null;
}
%>