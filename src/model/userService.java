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
	
//	@Path("/userLogin")
//	@POST
//	@Produces("application/json")
	public user getUserLogin(@PathParam("email") String email,@PathParam("password") String password) {
		user newUser = new user();
		if(email == "" || password == ""){//if any field missing, immediately redirect
//		    response.sendRedirect("../webpages/login.jsp?err=missingField");
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
 
	@Path("{c}")
	@GET
	@Produces("application/json")
	public Response convertFtoCfromInput(@PathParam("f") float f) throws JSONException {
		 
		JSONObject jsonObject = new JSONObject();
		float celsius;
		celsius = (f - 32) * 5 / 9;
		jsonObject.put("F Value", f);
		jsonObject.put("C Value", celsius);
 
		String result = "@Produces(\"application/json\") Output: \n\nF to C Converter Output: \n\n" + jsonObject;
		return Response.status(200).entity(result).build();
	}
}
