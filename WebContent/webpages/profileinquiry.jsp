<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="model.user"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="user" class="model.user" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Page</title>
<link rel="stylesheet" href="../css/profileinquiry.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
		String userType = (String) session.getAttribute("type");
		if (userType == null) {
			response.sendRedirect("forbidden.jsp");
		} else if (!userType.equals("Admin") && !userType.equals("Root")) {
			response.sendRedirect("forbidden.jsp");
		}
		request.getRequestDispatcher("../userDetails?userId="+request.getParameter("id")).include(request, response);
		user fetchedUser = (user) request.getAttribute("userDetails");
	%>
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="row formContainer">
					<div class="col-5 profilePic">
						<div class="imgWrapper">
							<img alt="profileIcon.png" src="../images/profileIcon.png">
						</div>
					</div>
					<div class="col-7 profileDetails">
						<label for="usernameLabel">Username</label>
						<div class="usernameContainer"><%=fetchedUser.getUsername()%></div>
						<label for="emailLabel">Email</label>
						<div class="emailContainer"><%=fetchedUser.getEmail()%></div>
						<label for="mobileNumLabel">Mobile Number</label>
						<div class="mobileNumContainer"><%=fetchedUser.getMobileNumber()%></div>
						<div class="deliveryHeader text-center">
							<h2>Delivery Information</h2>
						</div>
						<small>*This information is their default delivery, please
							only mail to the address stated in their order.</small><br> <label
							for="addressline1Label">Address Line 1</label>
						<div class="addressline1Container"><%=fetchedUser.getAddressline1()%></div>
						<label for="addressline2Label">Address Line 2</label>
						<div class="addressline2Container"><%=fetchedUser.getAddressline2()%></div>
						<label for="postalCodeLabel">Postal Code</label>
						<div class="postalCodeContainer"><%=fetchedUser.getPostalCode()%></div>
						<%if(userType.equals("Root")){%>
						<div class="cardInformation text-center">
							<h2>Credit Information</h2>
						</div>
						<small>*This information is their default credit card, please keep confidential as well as charging the card stated in the order.</small><br> <label
							for="cardNumLabel">Credit Card Number</label>
						<div class="cardNumContainer"></div>
						<label for="csvLabel">CSV</label>
						<div class="csvContainer"></div>
						<label for="expDateLabel">Exp Date</label>
						<div class="expDateContainer"></div>
						<%}%>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>