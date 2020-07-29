package api;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.json.JSONException;
import org.json.JSONObject;

import model.user;
import model.userService;

@Path("/user")
public class userAPI {

	@Path("/getUser")
	@GET
	@Produces("application/json")
	public Response getSingleUserDetail(@Context HttpServletRequest request) {

		HttpSession session = request.getSession();
		user fetchUser = new user();
		userService userFetchingService = new userService();
		try {
			int id = (int) session.getAttribute("id");
			fetchUser = userFetchingService.getUserDetail(id);
			JSONObject jsonObject = new JSONObject(fetchUser);
			return Response.status(200).entity(jsonObject.toString()).build();
		} catch (Exception e) {
			System.out.println("Error in fetching user");
		}
		return Response.status(404).build();
	}

	@Path("/getAllUser")
	@GET
	@Produces("application/json")
	public Response getAllUserDetail(@Context HttpServletRequest request) {
		userService userFetchingService = new userService();
		HttpSession session = request.getSession();
		ArrayList<user> fetchedUsers = new ArrayList<user>();
		ArrayList<JSONObject> myJSONObjects = new ArrayList<JSONObject>();
		try {
			String type = (String) session.getAttribute("type");
			if (type == null) {
				return Response.status(403).entity("Forbidden Access").build();
			} else if (type.equals("Admin") || type.equals("Root")) {
				fetchedUsers = userFetchingService.getAllUserDetail();
				for (user individualUser : fetchedUsers) {
					JSONObject jsonObject = new JSONObject(individualUser);
					myJSONObjects.add(jsonObject);
				}
				return Response.status(200).entity(myJSONObjects.toString()).build();
			} else {
				return Response.status(403).entity("Forbidden Access").build();
			}
		} catch (Exception e) {
			System.out.println("Error in fetching users");
		}
		return Response.status(404).build();
	}

	@Path("/updateUser")
	@PUT
	@Produces("application/json")
	public Response updateUserDetails(@QueryParam("username") String username, @QueryParam("email") String email,
			@QueryParam("address") String address, @QueryParam("password1") String password1,@QueryParam("password2") String password2,
			@QueryParam("mobileNumber") int mobileNumber, @QueryParam("postalCode") int postalCode,@Context HttpServletRequest request) {
		userService userUpdateService = new userService();
		HttpSession session = request.getSession();
		int id = (int) session.getAttribute("id");
		try {
			// process validation
			if (String.valueOf(mobileNumber).length() == 8) {// accept only 8 digit numbers
				if (password1.equals(password2)) {
					String code = userUpdateService.updateUserDetail(username, password1, email, address, id, mobileNumber, postalCode);
					if(code.equals("success")) {
						return Response.status(200).build();
					}else if(code.equals("dupEntry")) {
						JSONObject jsonObj = new JSONObject();
						jsonObj.put("message", "duplicate entry");
						return Response.status(400).entity(jsonObj.toString()).build();
					}else if(code.equals("internalError")) {
						JSONObject jsonObj = new JSONObject();
						jsonObj.put("message", "Internal Server Error");
						return Response.status(500).entity(jsonObj.toString()).build();
					}
				} else {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("message", "Mismatch Password");
					return Response.status(400).entity(jsonObj.toString()).build();
				}
			} else {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("message", "Invalid Phone Number");
				return Response.status(400).entity(jsonObj.toString()).build();
			}
		} catch (Exception e) {
			System.out.println("Error: "+e);
		}
		return Response.status(500).build();
	}
}
