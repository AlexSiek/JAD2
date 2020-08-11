package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
 
public class buyorderService {
	
	public int updateInDeliveryOrder(int id) {
		dbAccess dbConnection = new dbAccess();
		try {
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    Statement stmt = conn.createStatement();
			String updtstr = "UPDATE buyOrder SET orderStatus=2  WHERE id =" + id;
			stmt.executeUpdate(updtstr);
			conn.close();
			return 1;
		} catch (Exception e) {
			System.out.println("Error: " + e);
			return 0;
		}
	}
	
	public int updateDeliveredOrder(int id) {
		dbAccess dbConnection = new dbAccess();
		try {
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    Statement stmt = conn.createStatement();
			String updtstr = "UPDATE buyOrder SET orderStatus=3  WHERE id =" + id;
			stmt.executeUpdate(updtstr);
			conn.close();
			return 1;
		} catch (Exception e) {
			System.out.println("Error: " + e);
			return 0;
		}
	}
	
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
	
	public ArrayList<purchaseHistory> getAllPurchaseHistory(int sortBy,int filterBy) {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedPurchases = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    String sortby = "";
		    String filterby = "";
		    switch(filterBy) {
			case 1:
				filterby = " WHERE buyOrder.createAt > date_sub(now(), interval 1 day)";
				break;
			case 2:
				filterby = " WHERE buyOrder.createAt > date_sub(now(), interval 1 week)";
				break;
			case 3:
				filterby = " WHERE buyOrder.createAt > date_sub(now(), interval 1 month)";
				break;
			default:
				filterby ="";
				break;
			}
			switch(sortBy) {
			case 1:
				sortby = " ORDER BY user.username;";
				break;
			case 2:
				sortby = " ORDER BY product.productName;";
				break;
			case 3:
				sortby = " ORDER BY buyOrder.qty;";
				break;
			case 4:
				sortby = " ORDER BY buyOrder.createAt;";
				break;
			default:
				sortby =";";
				break;
			}
		    PreparedStatement pstmt = conn.prepareStatement("SELECT buyOrder.id,buyOrder.createAt,buyOrder.userid,buyorder.qty,buyOrder.productid,buyOrder.qty,user.username,user.email,product.productName,product.buyPrice FROM buyOrder INNER JOIN user ON buyOrder.userid = user.id INNER JOIN product ON buyOrder.productid = product.id"+filterby+sortby);
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedProduct = new purchaseHistory();
				fetchedProduct.setUsername(rs.getString("user.username"));
				fetchedProduct.setQty(rs.getInt("buyorder.qty"));
		        fetchedProduct.setCreateAt(rs.getString("buyorder.createAt"));
		        fetchedProduct.setId(rs.getInt("buyOrder.userid"));
		        fetchedProduct.setProductName(rs.getString("product.productName"));
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
	
	public ArrayList<purchaseHistory> getTopLowSells(int sortBy,int filterBy) {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedPurchases = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    String sortby = "";
		    String filterby = "";
		    switch(filterBy) {
			case 1:
				filterby = " WHERE b.createAt > date_sub(now(), interval 1 day)";
				break;
			case 2:
				filterby = " WHERE b.createAt > date_sub(now(), interval 1 week)";
				break;
			case 3:
				filterby = " WHERE b.createAt > date_sub(now(), interval 1 month)";
				break;
			default:
				filterby ="";
				break;
			}
			switch(sortBy) {
			case 1:
				sortby = " ORDER BY Total ASC;";
				break;
			default:
				sortby = " ORDER BY Total DESC;";
				break;
			}
		    PreparedStatement pstmt = conn.prepareStatement("SELECT p.qty,p.id,p.productName, SUM(b.qty) Total from buyorder b INNER JOIN product p ON b.productId = p.id"+filterby + " group by b.productId "+sortby);
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedProduct = new purchaseHistory();
				fetchedProduct.setId(rs.getInt("p.id"));
				fetchedProduct.setPastPurchases(rs.getInt("Total"));
		        fetchedProduct.setProductName(rs.getString("p.productName"));
		        fetchedProduct.setQty(rs.getInt("p.qty"));
		        fetchedPurchases.add(fetchedProduct);
		    }
	        conn.close();
	        Connection conn2 = DriverManager.getConnection(dbConnection.getConnURL());
	        switch(sortBy) {
			case 1:
				sortby = " DESC;";
				break;
			default:
				sortby = " ASC;";
				break;
			}
		    pstmt = conn2.prepareStatement("SELECT qty,id,productName from product ORDER BY qty" + sortby);
			rs = pstmt.executeQuery();
			ArrayList<purchaseHistory> AllProducts = new ArrayList<purchaseHistory>();
		    while(rs.next()){
				purchaseHistory fetchedProduct = new purchaseHistory();
				fetchedProduct.setId(rs.getInt("id"));
				fetchedProduct.setPastPurchases(0);
		        fetchedProduct.setProductName(rs.getString("productName"));
		        fetchedProduct.setQty(rs.getInt("qty"));
		        AllProducts.add(fetchedProduct);
		    }
	        conn.close();
	        ArrayList<Integer> indexArray = new ArrayList<Integer>();
		    for(int i = 0; i < AllProducts.size(); i++) {
	    		boolean found = false;
		    	for(int e = 0; e < fetchedPurchases.size(); e++) {
		    		if(fetchedPurchases.get(e).getId() == AllProducts.get(i).getId()) {
		    			found = true;
		    		}
		    	}
	    		if(!found) {
	    			indexArray.add(i);
	    		}
		    }
		    if(sortBy != 1) {
		    for(int i = 0; i < indexArray.size(); i++) {
		    	fetchedPurchases.add(AllProducts.get(indexArray.get(i)));
		    }
		    return fetchedPurchases;
		    }else {
		    	for(int i = indexArray.size(); i > indexArray.size(); i--) {
		    		AllProducts.remove(indexArray.get(i));
		    	}
		    	for(int i = 0; i < fetchedPurchases.size();i++) {
		    		AllProducts.add(fetchedPurchases.get(i));
		    	}
		    	return AllProducts;
		    }
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
	
	public ArrayList<purchaseHistory> getTopPurchased() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedPurchases = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT p.qty,p.id,p.productName,p.categoryId,p.buyPrice,p.imgURL, SUM(b.qty) Total from buyorder b INNER JOIN product p ON b.productId = p.id WHERE b.createAt > date_sub(now(), interval 1 week) group by b.productId order by Total desc");
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedProduct = new purchaseHistory();
				fetchedProduct.setPastPurchases(rs.getInt("Total"));
		        fetchedProduct.setId(rs.getInt("p.id"));
		        fetchedProduct.setProductName(rs.getString("p.productName"));
		        fetchedProduct.setBuyPrice(rs.getInt("p.buyPrice"));
		        fetchedProduct.setCategoryId(rs.getInt("p.categoryId"));
		        fetchedProduct.setImgURL(rs.getString("p.imgURL"));
		        fetchedPurchases.add(fetchedProduct);
		    }
	        conn.close();
		    return fetchedPurchases;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
	
	public ArrayList<purchaseHistory> getTopUserSpending() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedUsers = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT u.id,u.username,SUM(p.buyPrice * b.qty) totalSpending FROM buyorder b INNER JOIN product p  INNER JOIN user u WHERE b.productId = p.id AND b.userId = u.id group by b.userId ORDER BY totalSpending Desc;");
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedUser = new purchaseHistory();
				fetchedUser.setId(rs.getInt("u.id"));
				fetchedUser.setTotalPurchases(rs.getDouble("totalSpending"));
				fetchedUser.setUsername(rs.getString("u.username"));
		        fetchedUsers.add(fetchedUser);
		        System.out.println(rs.getString("u.username"));
		    }
	        conn.close();
		    return fetchedUsers;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
	
	public ArrayList<purchaseHistory> getPendingOrders() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedOrders = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT u.username,u.id,u.email,b.addressline1,b.addressline2,b.postalCode,b.qty,b.id,p.productName FROM buyorder b INNER JOIN user u INNER JOIN product p WHERE b.userId = u.id AND p.id = b.productId AND b.orderStatus = 1;");
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedOrder = new purchaseHistory();
				fetchedOrder.setId(rs.getInt("u.id"));
				fetchedOrder.setBuyOrderId(rs.getInt("b.id"));
				fetchedOrder.setQty(rs.getInt("b.qty"));
				fetchedOrder.setPostalCode(rs.getInt("b.postalCode"));
				fetchedOrder.setAddressline1(rs.getString("b.addressline1"));
				fetchedOrder.setAddressline2(rs.getString("b.addressline2"));
				fetchedOrder.setProductName(rs.getString("p.productName"));
				fetchedOrder.setUsername(rs.getString("u.username"));
				fetchedOrder.setEmail(rs.getString("u.email"));
				fetchedOrders.add(fetchedOrder);
		    }
	        conn.close();
		    return fetchedOrders;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
	
	public ArrayList<purchaseHistory> getOnDeliveryOrders() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedOrders = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT u.username,u.id,u.email,b.addressline1,b.addressline2,b.postalCode,b.qty,b.id,p.productName FROM buyorder b INNER JOIN user u INNER JOIN product p WHERE b.userId = u.id AND p.id = b.productId AND b.orderStatus = 2;");
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedOrder = new purchaseHistory();
				fetchedOrder.setId(rs.getInt("u.id"));
				fetchedOrder.setBuyOrderId(rs.getInt("b.id"));
				fetchedOrder.setQty(rs.getInt("b.qty"));
				fetchedOrder.setPostalCode(rs.getInt("b.postalCode"));
				fetchedOrder.setAddressline1(rs.getString("b.addressline1"));
				fetchedOrder.setAddressline2(rs.getString("b.addressline2"));
				fetchedOrder.setProductName(rs.getString("p.productName"));
				fetchedOrder.setUsername(rs.getString("u.username"));
				fetchedOrder.setEmail(rs.getString("u.email"));
				fetchedOrders.add(fetchedOrder);
		    }
	        conn.close();
		    return fetchedOrders;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
	
	public ArrayList<purchaseHistory> getDeliveredOrders() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<purchaseHistory> fetchedOrders = new ArrayList<purchaseHistory>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT u.username,u.id,u.email,b.addressline1,b.addressline2,b.postalCode,b.qty,b.id,p.productName FROM buyorder b INNER JOIN user u INNER JOIN product p WHERE b.userId = u.id AND p.id = b.productId AND b.orderStatus = 3;");
			ResultSet rs = pstmt.executeQuery();
		    while(rs.next()){
				purchaseHistory fetchedOrder = new purchaseHistory();
				fetchedOrder.setId(rs.getInt("u.id"));
				fetchedOrder.setBuyOrderId(rs.getInt("b.id"));
				fetchedOrder.setQty(rs.getInt("b.qty"));
				fetchedOrder.setPostalCode(rs.getInt("b.postalCode"));
				fetchedOrder.setAddressline1(rs.getString("b.addressline1"));
				fetchedOrder.setAddressline2(rs.getString("b.addressline2"));
				fetchedOrder.setProductName(rs.getString("p.productName"));
				fetchedOrder.setUsername(rs.getString("u.username"));
				fetchedOrder.setEmail(rs.getString("u.email"));
				fetchedOrders.add(fetchedOrder);
		    }
	        conn.close();
		    return fetchedOrders;
		}catch(Exception e){
		    System.out.println("Error: "+e);
		    return null;
		}
	}
}
