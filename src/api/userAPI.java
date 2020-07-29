package api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.GET;
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
	
	@Path("/getUserById")
	@GET
	@Produces("application/json")
	public Response getSingleUserDetail(@Context HttpServletRequest request) {

		HttpSession session = request.getSession();
		user fetchUser = new user();
		userService userFetchingService = new userService();
		try {
			int id = (int) session.getAttribute("id");
			fetchUser = userFetchingService.getUserDetail(id);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("username", fetchUser.getUsername());
			jsonObject.put("mobileNumber", fetchUser.getMobileNumber());
			jsonObject.put("id", fetchUser.getId());
			jsonObject.put("email", fetchUser.getEmail());
			jsonObject.put("address", fetchUser.getAddress());
			jsonObject.put("password", fetchUser.getPassword());
			jsonObject.put("postalCode", fetchUser.getPostalCode());
			jsonObject.put("type", fetchUser.getType());
			
			Response test = Response.status(200).entity(fetchUser).build();
			return test;

		}catch(Exception e) {
			System.out.println("here");
		}
        return Response.status(404).build();
	}
}
