<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {
	response.sendRedirect("../webpages/forbidden.jsp");
}else{
	int productId = 0, categoryId = 0;
	String productName= request.getParameter("productName");
	String vendor= request.getParameter("vendor");
	String pdtDesc= request.getParameter("pdtDesc");
	String imgURL= request.getParameter("imgURL");
	int qty = 0;
	double price = 0.00,MSRP = 0.00;
	try{
	qty = Integer.parseInt(request.getParameter("qty"));
	price = Double.parseDouble(request.getParameter("buyPrice"));
	MSRP = Double.parseDouble(request.getParameter("MSRP"));
	productId = Integer.parseInt(request.getParameter("id"));
	categoryId = Integer.parseInt(request.getParameter("categoryId"));
	}catch(Exception e){
		response.sendRedirect("../webpages/error.jsp");
	}
	if(productName == null||vendor == null||pdtDesc == null||imgURL== null||categoryId == 0){
		response.sendRedirect("../webpages/editlisting.jsp?id="+productId+"&err=mField");
	}else if(qty <= 0){
		response.sendRedirect("../webpages/editlisting.jsp?id="+productId+"&err=invalidQty");
	}else if(price <= 0){
		response.sendRedirect("../webpages/editlisting.jsp?id="+productId+"&err=invalidPrice");
	}else if(MSRP <= 0){
		response.sendRedirect("../webpages/editlisting.jsp?id="+productId+"&err=invalidMSRP");
	}else{
		Class.forName("com.mysql.jdbc.Driver");
		String updateStr = "UPDATE product SET categoryId='"+categoryId+"',productName='"+productName+"',vendor='"+vendor+"',pdtDesc='"+pdtDesc+"',qty='"+qty+"',buyPrice='"+price+"',MSRP='"+MSRP+"',imgURL='"+imgURL+"' WHERE id="+productId;
		Connection conn = DriverManager.getConnection(connURL);
		try {
			Statement stmt = conn.createStatement();
			int count = stmt.executeUpdate(updateStr);
			if (count > 0) out.println (count + " records updated");
			conn.close();
			response.sendRedirect("../webpages/listing.jsp?id="+productId+"&success=true");
			// if name in session is not reset, change updating name, form will not fetch correct data
		} catch (java.sql.SQLIntegrityConstraintViolationException a) {
			conn.close();
			response.sendRedirect("../webpages/editlisting.jsp?id="+productId+"&err=dupEntry");
		} catch (Exception e) {
			conn.close();
			response.sendRedirect("../webpages/error.jsp");
		}
	}
}
%>