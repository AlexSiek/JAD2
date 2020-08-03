package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class productService {
	public ArrayList<product> getAllProducts() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<product> products = new ArrayList<product>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement pstmt = conn
					.prepareStatement("SELECT * FROM product INNER JOIN category ON product.categoryId = category.id;");
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
}
