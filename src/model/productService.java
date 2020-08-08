package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class productService {
	public ArrayList<product> getAllProducts(int sortBy) {
		dbAccess dbConnection = new dbAccess();
		ArrayList<product> products = new ArrayList<product>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			String sortby = "";
			switch(sortBy) {
			case 1:
				sortby = " ORDER BY product.productName;";
				break;
			case 2:
				sortby = " ORDER BY product.vendor;";
				break;
			case 3:
				sortby = " ORDER BY product.qty;";
				break;
			case 4:
				sortby = " ORDER BY product.buyPrice;";
				break;
			case 5:
				sortby = " ORDER BY category.categoryName;";
				break;
			default:
				sortby =";";
				break;
			}
			PreparedStatement pstmt = conn
					.prepareStatement("SELECT * FROM product INNER JOIN category ON product.categoryId = category.id" + sortby);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				product tempProduct = new product();
				tempProduct.setProductName(rs.getString("product.productName"));
				tempProduct.setPdtDesc(rs.getString("product.pdtDesc"));
				tempProduct.setVendor(rs.getString("product.vendor"));
				tempProduct.setCategoryName(rs.getString("category.categoryName"));
				tempProduct.setImgURL(rs.getString("product.imgURL"));
				tempProduct.setBuyPrice(rs.getDouble("product.buyPrice"));
				tempProduct.setMSPR(rs.getDouble("product.MSRP"));
				tempProduct.setId(rs.getInt("product.id"));
				tempProduct.setCategoryId(rs.getInt("category.id"));
				tempProduct.setQty(rs.getInt("product.qty"));
				products.add(tempProduct);
			}
			conn.close();
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
		return products;
	}
	
	public int addProduct(int categoryId, String productName, String vendor, String pdtDesc, int qty, double price, double MSRP,String imgURL) {
		dbAccess dbConnection = new dbAccess();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO product (categoryId,productName,vendor,pdtDesc,qty,buyPrice,MSRP,imgURL) VALUES (?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, categoryId);
			pstmt.setString(2, productName);
			pstmt.setString(3, vendor);
			pstmt.setString(4, pdtDesc);
			pstmt.setInt(5,qty);
			pstmt.setDouble(6,price);
			pstmt.setDouble(7,MSRP);
			pstmt.setString(8,imgURL);
			pstmt.executeUpdate();
			conn.close();
		}	catch (java.sql.SQLIntegrityConstraintViolationException a) {
			return -2;
		} catch (Exception e) {
			System.out.println(e);
			return -1;
		}
		return 0;
	}
	
	public int updateProduct(int productId,int categoryId, String productName, String vendor, String pdtDesc, int qty, double price, double MSRP,String imgURL) {
		dbAccess dbConnection = new dbAccess();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement pstmt = conn.prepareStatement("UPDATE product SET categoryId=?,productName=?,vendor=?,pdtDesc=?,qty=?,buyPrice=?,MSRP=?,imgURL=? WHERE id=?");
			pstmt.setInt(1, categoryId);
			pstmt.setString(2, productName);
			pstmt.setString(3, vendor);
			pstmt.setString(4, pdtDesc);
			pstmt.setInt(5,qty);
			pstmt.setDouble(6,price);
			pstmt.setDouble(7,MSRP);
			pstmt.setString(8,imgURL);
			pstmt.setInt(9, productId);
			pstmt.executeUpdate();
			conn.close();
		}	catch (java.sql.SQLIntegrityConstraintViolationException a) {
			System.out.println(a);
			return -2;
		} catch (Exception e) {
			System.out.println(e);
			return -1;
		}
		return 0;
	}
}
