<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	request.setAttribute("result", "This is the result of the servlet call");
	request.getRequestDispatcher("/cartDetails").forward(request, response);
	%>

</body>
</html>