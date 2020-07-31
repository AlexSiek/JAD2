<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>

<div class="container">
	<form action="../addcreditcard" method="POST" class="form-tag col-md-6 col-10">
		<div class="form-group">
            <label for="cardnum">Card Number</label>
            <input type="text" class="form-control" id="cardnum" name="cardnum">
        </div>
    </form>
</div>