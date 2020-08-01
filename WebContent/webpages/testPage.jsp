<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "javax.ws.rs.core.Response" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		//Fetching get request from servlet
		request.getRequestDispatcher("../currencyConversion").include(request, response);
		Response responseObj = (Response) request.getAttribute("responseObj");
	%>
	<script>
	var responseObj = <%=responseObj.readEntity(String.class)%>
	sgdRate = responseObj.rates.SGD;
	</script>
</body>
</html>