<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Success</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
<div class="jumbotron text-center">
  <h1 class="display-3">Thank You!</h1>
  <p class="lead"><strong>Please check your email</strong> for further updates on your purchase.</p>
  <hr>
  <p>
    Having trouble? <a href="">Contact Alex @12345678 And Cleavon @98765432</a>
  </p>
  	<%
	String type = (String) session.getAttribute("type");
	if (type != null) {
		if (type.equals("Root")) {
			out.println("<a href=\"viewadmins.jsp\" class=\"btn btn-outline-success\">Return To Home</a>");
		}else{
			out.println("<a href=\"index.jsp\" class=\"btn btn-outline-success\">Return To Shop</a>");
		}
	} else {
		out.println("<a href=\"index.jsp\" class=\"btn btn-outline-success\">Return To Shop</a>");
	}
	%>
</div>     
</body>
</html>