<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<link rel="stylesheet" href="../css/createaccount.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
</head>

<body>
	<%
		//check if there is err code form updateAcc's redirect
		String err = request.getParameter("err");
		String appendedHTML = "";
		if (err != null) {
			if (err.equals("mmPassword")) {
				appendedHTML = "<p class=\"text-danger\">Passwords Does Not Match</p>";
			} else if (err.equals("dupEntry")) {
				appendedHTML = "<p class=\"text-danger\">The Username,Email Or Mobile Number You Are Trying To Set Is Already In Use</p>";
			} else if (err.equals("moNo")) {
				appendedHTML = "<p class=\"text-danger\">Invalid Mobile Number</p>";
			}
		}
	%>
	<div class="container">
		<div class="row">
			<div class="spacing col-md-3 col-1"></div>
			<form action="../SQLFiles/createAcc.jsp"
				class="form-tag col-md-6 col-10">
				<div class="text-center">
					<img src="../images/logo2.png" alt="storelogo.png"
						class="storeLogo">
				</div>
				<h1 class="welcomeText">Creating Account.</h1>
				<div class="form-group">
					<label for="username">Username</label> <input type="text"
						class="form-control" id="usernameInput" name="username"
						placeholder="John Smith" required>
				</div>
				<div class="form-group">
					<label for="InputEmail1">Email address</label> <input type="email"
						class="form-control" id="InputEmail1" aria-describedby="emailHelp"
						name="email" required>
				</div>
				<div class="form-group">
					<label for="InputPassword1">Password</label> <input type="password"
						class="form-control" id="InputPassword1" name="password1" required>
				</div>
				<div class="form-group">
					<label for="InputPassword2">Confirm Password</label> <input
						type="password" class="form-control" id="InputPassword2"
						name="password2" required>
				</div>
				<div class="form-group">
					<label for="mobileNumber">Mobile Number</label> <input
						type="number" class="form-control" id="mobileNo" name="mobileNo"
						placeholder="+65" required>
				</div>
				<%=appendedHTML %>
				<small class="loginAcc form-text text-muted">Already Have An
					Account? <a href="login.jsp">Login Here</a>
				</small>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
			<div class="spacing col-md-3 col-1"></div>
		</div>
	</div>
</body>

</html>