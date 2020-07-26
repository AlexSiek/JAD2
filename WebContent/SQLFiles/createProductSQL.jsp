<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
String type = (String) session.getAttribute("type");
if (type == null || !type.equals("Admin")) {//Admin checking
	response.sendRedirect("../webpages/forbidden.jsp");
}else{
	String productName= request.getParameter("productName");
	String vendor= request.getParameter("vendor");
	String pdtDesc= request.getParameter("pdtDesc");
	String imgURL= request.getParameter("imgURL");
	int qty = 0,categoryId = 0;
	double price = 0.00,MSRP = 0.00;
	try{
		categoryId = Integer.parseInt(request.getParameter("categoryId"));
		qty = Integer.parseInt(request.getParameter("qty"));
		price = Double.parseDouble(request.getParameter("buyPrice"));
		MSRP = Double.parseDouble(request.getParameter("MSRP"));
		//error redirections incase someone trys to createProduct with using form validation
		if(productName == null||vendor == null||pdtDesc == null||imgURL== null||categoryId == 0){
			response.sendRedirect("../webpages/createproduct.jsp?err=mField");
		}else if(qty <= 0){
			response.sendRedirect("../webpages/createproduct.jsp?err=invalidQty");
		}else if(price <= 0){
			response.sendRedirect("../webpages/createproduct.jsp?err=invalidPrice");
		}else if(MSRP <= 0){
			response.sendRedirect("../webpages/createproduct.jsp?err=invalidMSRP");
		}else{
			Class.forName("com.mysql.jdbc.Driver");
			String insertStr = "INSERT INTO product (categoryId,productName,vendor,pdtDesc,qty,buyPrice,MSRP,imgURL) VALUES (?,?,?,?,?,?,?,?)";
			Connection conn = DriverManager.getConnection(connURL);
			try {
				PreparedStatement pstmt = conn.prepareStatement(insertStr);
				pstmt.setInt(1, categoryId);
				pstmt.setString(2, productName);
				pstmt.setString(3, vendor);
				pstmt.setString(4, pdtDesc);
				pstmt.setInt(5,qty);
				pstmt.setDouble(6,price);
				pstmt.setDouble(7,MSRP);
				pstmt.setString(8,"../images/products/"+imgURL);
				int count = pstmt.executeUpdate();
				// if name in session is not reset, change updating name, form will not fetch correct data
			} catch (java.sql.SQLIntegrityConstraintViolationException a) {
				conn.close();
				response.sendRedirect("../webpages/createproduct.jsp?err=dupEntry");
			} catch (Exception e) {
				conn.close();
				out.println(e);
			}
			try{
				conn = DriverManager.getConnection(connURL);
				Statement stmt = conn.createStatement();
				String sqlStr = "SELECT * FROM product WHERE productName='"+productName+"'";
				ResultSet rs = stmt.executeQuery(sqlStr);
				if(rs.next()){
					int id = rs.getInt("id");
					conn.close();
					response.sendRedirect("../webpages/listing.jsp?id="+id);
				}
			}catch(Exception e){
				out.println(e);
			}
		}
	}catch(java.lang.NumberFormatException a){
		response.sendRedirect("../webpages/error.jsp");
	}
	catch(Exception e){
		out.println(e);
	}
}
%>