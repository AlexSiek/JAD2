<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="../css/login.css">
    <%@ include file="../css/bootstrap/importBSnJQ.jsp"%>
</head>

<body>
<%
String err = request.getParameter("err");
String appendedHTML = "";
if(err != null){
	if(err.equals("missingField")){
		appendedHTML += "<p class=\"text-danger\">Please Do Not Leave Any Empty Fields</p>";
	}else if(err.equals("invalidLogin")){
		appendedHTML += "<p class=\"text-danger\">Invalid User Or Password</p>";
	}
}
%>
    <div class="container">
        <div class="row">
            <div class="spacing col-md-3 col-1"></div>
            <form action="../SQLFiles/verifyUserLogin.jsp" class="form-tag col-md-6 col-10">
                <div class="text-center">
                    <img src="../images/logo2.png" alt="storelogo.png" class="storeLogo">
                </div>
                <h1 class="welcomeText">Welcome! Please Login.</h1>
                <div class="form-group">
                    <label for="InputEmail1">Email address</label>
                    <input type="email" class="form-control" id="InputEmail1" aria-describedby="emailHelp" name="email">
                </div>
                <div class="form-group">
                    <label for="InputPassword1">Password</label>
                    <input type="password" class="form-control" id="InputPassword1" name="password">
                </div>
                <%=  appendedHTML %>
                <small class="createAcc form-text text-muted">Don't Have An Account? <a href="createaccount.jsp">Create
                        One</a></small>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <div class="spacing col-md-3 col-1"></div>
        </div>
    </div>
</body>

</html>