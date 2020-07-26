<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error</title>
<link rel="stylesheet" href="../css/error.css">
<%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
</head>
<body>
	<div class="container">
		<div class="row detailRow justify-content-center">
			<div class="col-10">
				<div class="d-flex justify-content-center imageWrapper">
					<img src="../images/error.png" alt="error.png" class="img-fluid">
				</div>
				<div class="textWrapper">
						<p class="display-4 text-center">Oops, looks like we ran into an error</p>
					<blockquote class="blockquote text-center">
						<p class="">"Sorry, it's me, not you."
						<footer class="blockquote-footer">
							Cleavon
						</footer>
					</blockquote>
				</div>
				<div class="buttonWrapper d-flex justify-content-center">
				<%
				String type = (String) session.getAttribute("type");
				if (type != null) {
					if (type.equals("Root")) {
						out.println("<a href=\"viewadmins.jsp\" class=\"btn btn-outline-success\">Return To Home</a>");
					}else{
						out.println("<a href=\"index.jsp\" class=\"btn btn-outline-success\">Return To Home</a>");
					}
				} else {
					out.println("<a href=\"index.jsp\" class=\"btn btn-outline-success\">Return To Home</a>");
				}
				%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>