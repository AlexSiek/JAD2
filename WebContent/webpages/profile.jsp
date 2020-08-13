<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="model.purchaseHistory"%>
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
	String err = request.getParameter("err");
	String success = request.getParameter("success");
	String updated = "", appendedHTML = "";
	//fetching data for form values
	String password = "", email = "";
	int mobileNumber = 0;
	//user String is in header.jsp
	if (success == null) {// checks for success or fail codes
		if (err != null) {
			if (err.equals("mmPassword")) {
		appendedHTML = "<p class=\"text-danger\">Passwords Does Not Match</p>";
			} else if (err.equals("dupEntry")) {
		appendedHTML = "<p class=\"text-danger\">The Username,Email Or Mobile Number You Are Trying To Set Is Already In Use</p>";
			} else if (err.equals("moNo")) {
		appendedHTML = "<p class=\"text-danger\">Invalid Mobile Number</p>";
			}	else if (err.equals("invalidPostal")) {
		appendedHTML = "<p class=\"text-danger\">Invalid Postal Code</p>";
			} else if (err.equals("missAddress")) {
		appendedHTML = "<p class=\"text-danger\">Please Fill In All Address Details Or Leave It Empty</p>";
			}	else if (err.equals("invalidExpDate")) {
		appendedHTML = "<p class=\"text-danger\">Invalid Expiry Date</p>";
			} else if (err.equals("invalidCardNum")) {
		appendedHTML = "<p class=\"text-danger\">Invalid Card Number</p>";
			} else if (err.equals("invalidCsv")) {
		appendedHTML = "<p class=\"text-danger\">Invalid CSV</p>";
			}
		}
	} else {
		updated = "<h1 class=\"text-success\" align=\"center\">Successfully Updated</h1>";
	}
	
	%>
	<%
	request.getRequestDispatcher("../getUserBySessionId").include(request, response);
	user fetchedUser = (user) request.getAttribute("userDetails");
	%>
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="form-spacing col-md-6 col-10">
				<div class="buttonWrapper" align="center">
					<form action="../logout">
						<button type="submit" class="btn btn-outline-primary">Logout</button>
					</form>
				</div>
				<%=updated%>
				<h1 class="headerText">Edit Profile</h1>
				<form class="form-tag" action="../editUserDetail"
					method="POST">
					<%=appendedHTML%>
					<div class="form-group">
						<label for="username">Username</label> <input type="text"
							class="form-control" id="username" value="<%=fetchedUser.getUsername()%>"
							name="username" required>
					</div>
					<div class="form-group">
						<label for="email">Email address</label> <input type="email"
							class="form-control" id="email" aria-describedby="emailHelp"
							placeholder="Enter email" value="<%=fetchedUser.getEmail()%>" name="email"
							required>
					</div>
					<div class="form-group">
						<label for="password1">New Password</label> <input type="password"
							class="form-control" id="password1" placeholder="Password"
							value="<%=fetchedUser.getPassword()%>" name="password1" required>
					</div>
					<div class="form-group">
						<label for="password2">Confirm Password</label> <input
							type="password" class="form-control" id="password2"
							placeholder="Password" value="<%=fetchedUser.getPassword()%>" name="password2"
							required>
					</div>
					<div class="form-group">
						<label for="mobileNo">Phone Number</label> <input type="number"
							class="form-control" id="mobileNo" placeholder="+65"
							value="<%=fetchedUser.getMobileNumber()%>" name="mobileNumber" required>
					</div>
					<div class="addressHeader text-center"><h3>Default Address</h3></div>
					<div class="form-group">
					<label for="addressline1">Address Line 1</label> <input type="text"
							class="form-control" id="addressline1" value="<%=fetchedUser.getAddressline1()%>" name="addressline1">
					</div>
					<div class="form-group">
					<label for="addressline2">Address Line 2</label> <input type="text"
							class="form-control" id="addressline2" value="<%=fetchedUser.getAddressline2()%>" name="addressline2">
					</div>  
					<div class="form-group">
					<label for="postalCode">Postal Code</label> <input type="number"
							class="form-control" id="postalCode" value="<%=fetchedUser.getPostalCode()%>" name="postalCode">
					</div>  
					<div class="cardHeader text-center"><h3>Default Card Details</h3></div>
					<div class="form-group">
					<label for="creditCardNum">Credit Card Number</label> <input type="number"
							class="form-control" id="creditCardNum" value="<%=fetchedUser.getCreditCardNumber()%>" name="creditCardNum">
					</div> 
					<div class="row">
					<div class="form-group col">
					<label for="csv">CSV</label> <input type="number"
							class="form-control" id="csv" value="<%=fetchedUser.getCsv()%>" name="csv">
					</div> 
					<div class="form-group col">
					<label for="expDate">Expiry Date</label> <input type="number"
							class="form-control" id="expDate" value="<%=fetchedUser.getExpDate()%>" name="expDate">
					</div> 
					</div>
					<div align="center">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</form>
			</div>
			<%
			if(type.equals("Member")){
			//Purchase history
			request.getRequestDispatcher("../purchaseHistory").include(request, response);
			ArrayList<purchaseHistory> pastPurchases = (ArrayList<purchaseHistory>) request.getAttribute("purchaseHistory");
			%>
			<div class="purchaseHistory col-md-5 col-6">
			<div class="purchaseHeader d-flex justify-content-center" style="font-size:25px;margin:2vh 0;">Past purchases</div>
			<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">Product Name</th>
							<th scope="col">Cost</th>
							<th scope="col">Qty</th>
							<th scope="col">Status</th>
							<th scope="col">Date</th>
						</tr>
					</thead>
					<tbody>
					<%
					int status = 0;
					String badge = "";
					for(int i = 0; i < pastPurchases.size();i++){
						status = pastPurchases.get(i).getOrderStatus();
						if (status == 1) {
							badge = "<span class=\"badge badge-primary\">Processing</span>";
						} else if (status == 2) {
							badge = "<span class=\"badge badge-warning\">In Delivery</span>";
						} else {
							badge = "<span class=\"badge badge-success\">Delivered</span>";
						}
					%>
					<tr>
						<td><a href="listing.jsp?id=<%=pastPurchases.get(i).getId() %>"><%=pastPurchases.get(i).getProductName() %></a></td>
						<td><%=pastPurchases.get(i).getBuyPrice()*pastPurchases.get(i).getQty() %></td>
						<td><%=pastPurchases.get(i).getQty() %></td>
						<td><%=badge %></td>
						<td><%=pastPurchases.get(i).getCreateAt()%></td>
					</tr>
					<%} %>
					
					</tbody>
				</table>
			
		</div>
		<%} %>
	</div>
	<%@ include file="footer.html"%>
</body>
</html>