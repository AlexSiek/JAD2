package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class cartService {
	
	public Map<ArrayList<product>,ArrayList<cart>> getCartDetail(int id) {
		ArrayList<cart> fetchedCarts = new ArrayList<cart>();
		ArrayList<product> fetchedProducts = new ArrayList<product>();
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/j2ee?user=root&password=1qazxsw2&serverTimezone=UTC");
		    PreparedStatement pstmt = conn.prepareStatement("SELECT product.id,product.productName,product.qty,product.buyPrice,product.imgURL,cart.id,cart.qty FROM cart INNER JOIN product ON cart.productId=product.Id AND cart.userId = ?");
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
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
		    Map<ArrayList<product>,ArrayList<cart>> map = new HashMap();
		    map.put(fetchedProducts,fetchedCarts);
		    return map;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
}
