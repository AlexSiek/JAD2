package model;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.json.JSONException;
import org.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
 

public class userService {
	
	public user getUserLogin(String email, String password) {
		dbAccess dbConnection = new dbAccess();
		user newUser = new user();
		if(email == "" || password == ""){
		    return null;
		}
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
			pstmt.setString(1,email);
			pstmt.setString(2,password);
			ResultSet rs = pstmt.executeQuery();
		    if(rs.next()){
				String type = "",username="";
				int id = 0;
		        id = rs.getInt("id");
		        username = rs.getString("username");
		        type = rs.getString("type");
		        newUser.setUsername(username);
		        newUser.setType(type);
		        newUser.setId(id);
		        conn.close();
		    }else{
		        conn.close();
			    return null;
		    }
		}catch(Exception e){
		    System.out.println(e);
		    return null;
		}
		return newUser;
	}
 
	public user getUserDetail(int id) throws JSONException {
		dbAccess dbConnection = new dbAccess();
		user fetchedUser = new user();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE id=?");
			pstmt.setInt(1,id);
			ResultSet rs = pstmt.executeQuery();
		    if(rs.next()){
		        id = rs.getInt("id");
		        fetchedUser.setEmail(rs.getString("email"));
		        fetchedUser.setPassword(rs.getString("password"));
		        fetchedUser.setUsername(rs.getString("username"));
		        fetchedUser.setType(rs.getString("type"));
		        fetchedUser.setAddressline1(rs.getString("addressline1"));
		        fetchedUser.setAddressline1(rs.getString("addressline2"));
		        fetchedUser.setId(id);
		        fetchedUser.setMobileNumber(rs.getInt("mobileNumber"));
		        fetchedUser.setPostalCode(rs.getInt("postalCode"));
		        conn.close();
		    }else{
		        conn.close();
			    return null;
		    }
		}catch(Exception e){
		    System.out.println(e);
		    return null;
		}
		return fetchedUser;
	}
	
	public ArrayList<user> getAllUserDetail() throws JSONException {
		dbAccess dbConnection = new dbAccess();
		ArrayList<user> fetchedUsers = new ArrayList<user>();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE NOT type='Root' AND NOT type='Admin'");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				user fetchedUser = new user();
		        fetchedUser.setEmail(rs.getString("email"));  
		        fetchedUser.setPassword(rs.getString("password"));
		        fetchedUser.setUsername(rs.getString("username"));
		        fetchedUser.setType(rs.getString("type"));
		        fetchedUser.setAddressline1(rs.getString("addressline1"));
		        fetchedUser.setAddressline2(rs.getString("addressline2"));
		        fetchedUser.setId(rs.getInt("id"));
		        fetchedUser.setMobileNumber(rs.getInt("mobileNumber"));
		        fetchedUser.setPostalCode(rs.getInt("postalCode"));
		        fetchedUsers.add(fetchedUser);
			}
			conn.close();
			return fetchedUsers;
		}catch(Exception e){
		    System.out.println(e);
		    return null;
		}
	}
	
	public String updateUserDetail(String username,String password,String email,String address,int id,int mobileNumber,int postalCode) throws JSONException {
		dbAccess dbConnection = new dbAccess();
		String code = "";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement ps  = conn.prepareStatement("UPDATE user SET username=? ,password=? ,email=? ,address=? ,mobileNumber=? ,postalCode=? WHERE id=?");
			ps.setString(1,username);
			ps.setString(2,password);
			ps.setString(3,email);
			ps.setString(4,address);
			ps.setInt(5,mobileNumber);
			ps.setInt(6,postalCode);
			ps.setInt(7,id);
			try{
				ps.executeUpdate();
				ps.close();
				return code = "success";
			}catch (java.sql.SQLIntegrityConstraintViolationException a) {
				ps.close();
				return code = "dupEntry";
			}
		}catch (Exception e) {
			return code = "internalError";
		}
	}
	
	public String updateUserAddress(String addressline1,String addressline2,int id,int postalCode) throws JSONException {
		dbAccess dbConnection = new dbAccess();
		String code = "";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement ps  = conn.prepareStatement("UPDATE user SET addressline1=?,addressline2=? ,postalCode=? WHERE id=?");
			ps.setString(1,addressline1);
			ps.setString(2,addressline2);
			ps.setInt(3,postalCode);
			ps.setInt(4,id);
			try{
				ps.executeUpdate();
				ps.close();
				return code = "success";
			}catch (java.sql.SQLIntegrityConstraintViolationException a) {
				ps.close();
				return code = "dupEntry";
			}
		}catch (Exception e) {
			return code = "internalError";
		}
	}
	
	public String updateUserCard(Long creditCardNumber,int csv,int id,int expDate) throws JSONException {
		dbAccess dbConnection = new dbAccess();
		String code = "";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement ps  = conn.prepareStatement("UPDATE user SET creditCardNumber=?,csv=? ,expDate=? WHERE id=?");
			ps.setLong(1,creditCardNumber);
			ps.setInt(2,csv);
			ps.setInt(3,expDate);
			ps.setInt(4,id);
			try{
				ps.executeUpdate();
				ps.close();
				return code = "success";
			}catch (java.sql.SQLIntegrityConstraintViolationException a) {
				ps.close();
				return code = "dupEntry";
			}
		}catch (Exception e) {
			return code = "internalError";
		}
	}
	public String checkCreditCard(long creditCard) {
		dbAccess dbConnection = new dbAccess();
		String code ="";
		try {
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM creditcards WHERE cardNumber='"+ creditCard +"'");
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				conn.close();
				return code = "success";
			} else {
				conn.close();
				return code = "failed";
			}
		} catch (Exception e) {
			return code = "internalError";
		}
	}
	public String addCreditCard(String cardType, long cardNumber) {
		dbAccess dbConnection = new dbAccess();
		String code ="";
		try {
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
		    String sqlStr = "INSERT INTO creditcards (id,'" + cardType + "','" + cardNumber + "') VALUES (0,?,?)";
		    PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				conn.close();
				return code = "success";
			} else {
				conn.close();
				return code = "failed";
			}
		} catch (Exception e) {
			System.out.println("exception e");
			return code = "internalError";
		}
	}
}
