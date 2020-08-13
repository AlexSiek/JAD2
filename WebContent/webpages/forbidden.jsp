<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forbidden</title>
<link href="../css/forbidden.css" rel="stylesheet">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
</head>
<body>
	<div class="container">
		<div class="row imgWrapper justify-content-center">
			<div class="col-8 d-flex justify-content-center ">
				<img src="../images/forbidden.png" alt="forbidden.png"
					class="img-fluid forbiddenImg">
			</div>
		</div>
		<div class="row textWrapper justify-content-center">
			<div class="mainTextWrapper col-8">
				<h1 class="display-1 mainText">Forbidden</h1>
			</div>
			<div class="subTextWrapper col-8">
				<p class="font-weight-normal subText">You Don't Have Permission
					To This Page.</p>
			</div>
		</div>
		<div class="row buttonRow justify-content-center">
			<div class="mainText col-8">
				<%
				String type = (String) session.getAttribute("type");
				if (type != null) {
					if (type.equals("Root")) {
						out.println("<a href=\"viewadmins.jsp\" class=\"btn btn-outline-success\">Return To Home</a>");
					}else{
						out.println("<a href=\"index.jsp.jsp\" class=\"btn btn-outline-success\">Return To Home</a>");
					}
				} else {
					out.println("<a href=\"index.jsp\" class=\"btn btn-outline-success\">Return To Home</a>");
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>