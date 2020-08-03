package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.json.JSONException;
import org.json.JSONObject;
 
@Path("/ctofservice")
public class buyorderService {
	public ArrayList<purchaseHistory> getPurchaseHistory(int id) {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedPurchases = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT product.id,product.productName,product.buyPrice,product.imgURL,buyorder.id,buyorder.qty,buyorder.createAt,buyorder.orderStatus FROM buyorder INNER JOIN product ON buyorder.productId=product.Id AND buyorder.userId = ?");
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedProduct = new purchaseHistory();
				fetchedProduct.setQty(rs.getInt("buyorder.qty"));
		        fetchedProduct.setCreateAt(rs.getString("buyorder.createAt"));
		        fetchedProduct.setOrderStatus(rs.getInt("buyorder.orderStatus"));
		        fetchedProduct.setId(rs.getInt("product.id"));
		        fetchedProduct.setProductName(rs.getString("product.productName"));
		        fetchedProduct.setBuyPrice(rs.getDouble("product.buyPrice"));
		        fetchedProduct.setQty(rs.getInt("buyorder.qty"));
		        fetchedProduct.setBuyPrice(rs.getInt("product.buyPrice"));
		        fetchedProduct.setImgURL(rs.getString("product.imgURL"));
		        fetchedPurchases.add(fetchedProduct);
		    }
	        conn.close();
		    return fetchedPurchases;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
	
	public ArrayList<purchaseHistory> getAllPurchaseHistory() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedPurchases = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT buyOrder.id,buyOrder.createAt,buyOrder.userid,buyorder.qty,buyOrder.productid,buyOrder.qty,user.username,user.email,product.productName,product.buyPrice FROM buyOrder INNER JOIN user ON buyOrder.userid = user.id INNER JOIN product ON buyOrder.productid = product.id");
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedProduct = new purchaseHistory();
				fetchedProduct.setUsername(rs.getString("user.username"));
				fetchedProduct.setQty(rs.getInt("buyorder.qty"));
		        fetchedProduct.setCreateAt(rs.getString("buyorder.createAt"));
		        fetchedProduct.setId(rs.getInt("buyOrder.productid"));
		        fetchedProduct.setProductName(rs.getString("product.productName"));
		        fetchedProduct.setQty(rs.getInt("buyorder.qty"));
		        fetchedProduct.setBuyPrice(rs.getInt("product.buyPrice"));
		        fetchedPurchases.add(fetchedProduct);
		    }
	        conn.close();
		    return fetchedPurchases;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
}
