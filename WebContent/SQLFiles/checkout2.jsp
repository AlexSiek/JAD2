<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbaccess/dbDetails.jsp"%>
<%
	int productId, qty, cartId, cartQty, newQty;
	int notEnoughId = 0;//used to store productId of product without enough qty
	Class.forName("com.mysql.jdbc.Driver");
	boolean notEnoughStock = false;
	try {
		int userId = (int) session.getAttribute("id");//if null is thrown, exception will be caught
		
		try {
			Connection connDup = DriverManager.getConnection(connURL);
			Statement stmt = connDup.createStatement();
			String sqlStr = "SELECT product.id,product.qty,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId ="
					+ userId;
			ResultSet rs = stmt.executeQuery(sqlStr);
			while (rs.next()) {//checks if enough quanity for orders
				productId = rs.getInt("product.id");
				qty = rs.getInt("product.qty");
				cartId = rs.getInt("cart.id");
				cartQty = rs.getInt("cart.qty");
				if (cartQty > qty) {
					notEnoughStock = true;
					notEnoughId = cartId;
				}
			}
			rs.close();
			if (notEnoughStock) {
				connDup.close();
				response.sendRedirect("../webpages/cart.jsp?errId=" + notEnoughId);
			} else {//if enough stock
				sqlStr = "SELECT product.id,product.qty,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId ="
						+ userId;
				ResultSet rs2 = stmt.executeQuery(sqlStr);
				Connection connDup2 = DriverManager.getConnection(connURL);//creating a second connection as first connection is used for result set which will close if another connection would use it
				Statement stmt2 = connDup.createStatement();
				String updtstr,intStr;//updtstr for updating cart and product table intStr for inserting buyOrder table;
				while (rs2.next()) {
					productId = rs2.getInt("product.id");
					qty = rs2.getInt("product.qty");
					cartId = rs2.getInt("cart.id");
					cartQty = rs2.getInt("cart.qty");
					newQty = qty - cartQty;//new amount qty, used to update product table

					updtstr = "UPDATE product SET qty=" + newQty + " WHERE id='" + productId + "'";//updating products table
					stmt2.executeUpdate(updtstr);
					
					intStr = "INSERT INTO buyorder (productId,userId,qty,orderStatus) VALUES (?,?,?,1)";//inserting order into buyorder Table
					PreparedStatement pstmt = connDup2.prepareStatement(intStr);
					pstmt.setInt(1, productId);
					pstmt.setInt(2, userId);
					pstmt.setInt(3, cartQty);
					pstmt.executeUpdate();

					updtstr = "DELETE FROM cart WHERE id =" + cartId;//Deleting Cart Row
					stmt2.executeUpdate(updtstr);
				}
				connDup2.close();
				response.sendRedirect("../webpages/successcheckout.jsp");
			}
			connDup.close();
		} catch (Exception e) {
			out.println(e);
		}
	} catch (NullPointerException a) {
		response.sendRedirect("../webpages/error.jsp");
	}
%>