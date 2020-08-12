package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class cartService {

	public int checkoutStockCheck(int id) {
		dbAccess dbConnection = new dbAccess();
		int cartQty,qty,notEnoughId;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			Statement stmt = conn.createStatement();
			String sqlStr = "SELECT product.id,product.qty,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId =" + id;
			ResultSet rs = stmt.executeQuery(sqlStr);
			while (rs.next()) {//checks if enough quanity for orders
				qty = rs.getInt("product.qty");
				cartQty = rs.getInt("cart.qty");
				if (cartQty > qty) {
					return 1;
				}
			}
			return 0;
		}catch(Exception e) {
			System.out.println(e);
			return -1;
		}
	}
	
	public int checkoutToBuyOrder(int id) {
		dbAccess dbConnection = new dbAccess();
		int productId, qty, cartId, cartQty, newQty;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			Statement stmt = conn.createStatement();
			String sqlStr = "SELECT product.id,product.qty,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId =" + id;
			ResultSet rs = stmt.executeQuery(sqlStr);
			String updtstr,intStr;
			while (rs.next()) {//checks if enough quanity for orders
				productId = rs.getInt("product.id");
				qty = rs.getInt("product.qty");
				cartId = rs.getInt("cart.id");
				cartQty = rs.getInt("cart.qty");
				newQty = qty - cartQty;//new amount qty, used to update product table

				updtstr = "UPDATE product SET qty=" + newQty + " WHERE id='" + productId + "'";//updating products table
				stmt.executeUpdate(updtstr);
				
				intStr = "INSERT INTO buyorder (productId,userId,qty,orderStatus) VALUES (?,?,?,1)";//inserting order into buyorder Table
				PreparedStatement pstmt = conn.prepareStatement(intStr);
				pstmt.setInt(1, productId);
				pstmt.setInt(2, id);
				pstmt.setInt(3, cartQty);
				pstmt.executeUpdate();

				updtstr = "DELETE FROM cart WHERE id =" + cartId;//Deleting Cart Row
				stmt.executeUpdate(updtstr);
			}
			return 0;
		}catch(Exception e) {
			System.out.println(e);
			return -1;
		}
	}
	
	public int addToCart(int userId, int qty, int productId) {
		dbAccess dbConnection = new dbAccess();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			try {
				Statement stmt = conn.createStatement();
				String sqlStr = "SELECT id,qty FROM cart WHERE productId =" + productId + " AND userId=" + userId;
				ResultSet rs = stmt.executeQuery(sqlStr);
				if (rs.next()) {// if there is existing item in cart, update to increase amount
					int id = rs.getInt("id");
					int cartQty = rs.getInt("qty");
					int newQty = qty + cartQty;

					String updateStr = "UPDATE cart SET qty=" + newQty + " WHERE id=" + id;
					Connection conn2 = DriverManager.getConnection(dbConnection.getConnURL());
					Statement stmt2 = conn2.createStatement();
					stmt2.executeUpdate(updateStr);
					conn2.close();
					return 1;
				} else {// if no existing item in cart, insert new ones
					String insertStr = "INSERT INTO cart (userId,productId,qty) VALUES (?,?,?)";
					Connection conn2 = DriverManager.getConnection(dbConnection.getConnURL());
					try {
						PreparedStatement pstmt = conn2.prepareStatement(insertStr);
						pstmt.setInt(1, userId);
						pstmt.setInt(2, productId);
						pstmt.setInt(3, qty);
						int count = pstmt.executeUpdate();
						conn2.close();
						return 1;
					} catch (Exception e) {
						System.out.println(e);
						return 0;
					}
				}
			} catch (Exception e) {
				System.out.println(e);
				return 0;
			}
		} catch (Exception e) {
			System.out.println(e);
			return 0;
		}
	}

	public int deleteCartItem(int userId, int cartId) {
		dbAccess dbConnection = new dbAccess();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			if (cartId == 0 || userId == 0) {
				return 0;
			} else {
				Statement stmt = conn.createStatement();
				String updtstr = "DELETE FROM cart WHERE id =" + cartId + " AND userId=" + userId;
				int count = stmt.executeUpdate(updtstr);
				conn.close();
				return 1;

			}
		} catch (Exception e) {
			System.out.println(e);
			return 0;
		}
	}

	public Map<ArrayList<product>, ArrayList<cart>> getCartDetail(int id) {
		dbAccess dbConnection = new dbAccess();
		ArrayList<cart> fetchedCarts = new ArrayList<cart>();
		ArrayList<product> fetchedProducts = new ArrayList<product>();

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT product.id,product.productName,product.qty,product.buyPrice,product.imgURL,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId = ?");
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				cart fetchedCart = new cart();
				product fetchedProduct = new product();
				fetchedCart.setId(rs.getInt("cart.id"));
				fetchedCart.setQty(rs.getInt("cart.qty"));
				fetchedProduct.setId(rs.getInt("product.id"));
				fetchedProduct.setProductName(rs.getString("product.productName"));
				fetchedProduct.setBuyPrice(rs.getDouble("product.buyPrice"));
				fetchedProduct.setQty(rs.getInt("product.qty"));
				fetchedProduct.setBuyPrice(rs.getInt("product.buyPrice"));
				fetchedProduct.setImgURL(rs.getString("product.imgURL"));
				fetchedCarts.add(fetchedCart);
				fetchedProducts.add(fetchedProduct);
			}
			conn.close();
			Map<ArrayList<product>, ArrayList<cart>> map = new HashMap();
			map.put(fetchedProducts, fetchedCarts);
			return map;
		} catch (Exception e) {
			System.out.println("Error: " + e);
			return null;
		}
	}

	public int checkoutCart(int id, String addressline1, String addressline2, int postalCode, long creditCardNumber,
			int csv, int expDate) {
		dbAccess dbConnection = new dbAccess();
		int productId, qty, cartId, cartQty, newQty;
		int notEnoughId = 0;// used to store productId of product without enough qty
		boolean notEnoughStock = false;
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
				Statement stmt = conn.createStatement();
				String sqlStr = "SELECT product.id,product.qty,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId ="
						+ id;
				ResultSet rs = stmt.executeQuery(sqlStr);
				while (rs.next()) {// checks if enough quanity for orders
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
					conn.close();
					return notEnoughId;
				} else {// if enough stock
					sqlStr = "SELECT product.id,product.qty,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId ="
							+ id;
					ResultSet rs2 = stmt.executeQuery(sqlStr);
					Connection connDup2 = DriverManager.getConnection(dbConnection.getConnURL());// creating a second
																									// connection as
																									// first connection
																									// is used for
																									// result set which
																									// will close if
																									// another
																									// connection would
																									// use it
					Statement stmt2 = conn.createStatement();
					String updtstr, intStr;// updtstr for updating cart and product table intStr for inserting buyOrder
											// table;
					while (rs2.next()) {
						productId = rs2.getInt("product.id");
						qty = rs2.getInt("product.qty");
						cartId = rs2.getInt("cart.id");
						cartQty = rs2.getInt("cart.qty");
						newQty = qty - cartQty;// new amount qty, used to update product table

						updtstr = "UPDATE product SET qty=" + newQty + " WHERE id='" + productId + "'";// updating
																										// products
																										// table
						stmt2.executeUpdate(updtstr);

						intStr = "INSERT INTO buyorder (productId,userId,qty,orderStatus,addressline1,addressline2,postalCode,creditCardNumber,csv,expDate) VALUES (?,?,?,?,?,?,?,?,?,?)";// inserting
																																															// order
																																															// into
																																															// buyorder
																																															// Table
						PreparedStatement pstmt = connDup2.prepareStatement(intStr);
						pstmt.setInt(1, productId);
						pstmt.setInt(2, id);
						pstmt.setInt(3, cartQty);
						pstmt.setInt(4, 1);
						pstmt.setString(5, addressline1);
						pstmt.setString(6, addressline2);
						pstmt.setInt(7, postalCode);
						pstmt.setLong(8, creditCardNumber);
						pstmt.setInt(9, csv);
						pstmt.setInt(10, expDate);
						pstmt.executeUpdate();

						updtstr = "DELETE FROM cart WHERE id =" + cartId;// Deleting Cart Row
						stmt2.executeUpdate(updtstr);
					}
					connDup2.close();
				}
				conn.close();
				return 0;
			} catch (Exception e) {
				System.out.println("Error: " + e);
				return -1;
			}
		} catch (NullPointerException a) {
			return -1;
		}
	}
}
