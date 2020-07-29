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
 
@Path("/userService")
public class userService {
	
	public user getUserLogin(String email, String password) {
		user newUser = new user();
		if(email == "" || password == ""){
		    return null;
		}
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/j2ee?user=root&password=ubuntu1&serverTimezone=UTC");
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
		user fetchedUser = new user();
		try{
			Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/j2ee?user=root&password=ubuntu1&serverTimezone=UTC");
		    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE id=?");
			pstmt.setInt(1,id);
			ResultSet rs = pstmt.executeQuery();
		    if(rs.next()){
				String type = "",username="",email="",address="",password="";
				int mobileNumber = 0, postalCode = 0;
		        id = rs.getInt("id");
		        mobileNumber = rs.getInt("mobileNumber");
		        postalCode = rs.getInt("postalCode");
		        username = rs.getString("username");
		        type = rs.getString("type");
		        email = rs.getString("email");
		        address = rs.getString("address");
		        password = rs.getString("password");

		        fetchedUser.setType(type);
		        fetchedUser.setEmail(email);
		        fetchedUser.setPassword(password);
		        fetchedUser.setUsername(username);
		        fetchedUser.setType(type);
		        fetchedUser.setAddress(address);
		        fetchedUser.setId(id);
		        fetchedUser.setMobileNumber(mobileNumber);
		        fetchedUser.setPostalCode(postalCode);
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
}
