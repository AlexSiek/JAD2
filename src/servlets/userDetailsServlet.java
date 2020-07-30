package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
//import javax.ws.rs.client.Client;
//import javax.ws.rs.client.ClientBuilder;
//import javax.ws.rs.client.Entity;
//import javax.ws.rs.client.Invocation;
//import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;


/**
 * Servlet implementation class userDetailsServlet
 */
@WebServlet("/userDetailsServlet")
public class userDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userDetailsServlet() {//single user details
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Client client = ClientBuilder.newClient();
        WebTarget target = client
                .target("http://localhost:8080/JADCA2/api/user")
                .path("updateUser")
                .queryParam("username", request.getParameter("username"))
                .queryParam("email", request.getParameter("email"))
                .queryParam("address", request.getParameter("address"))
                .queryParam("password1", request.getParameter("password1"))
                .queryParam("password2", request.getParameter("password2"))
                .queryParam("mobileNumber", request.getParameter("mobileNumber"))
                .queryParam("postalCode", request.getParameter("postalCode")); 
        Invocation.Builder invocationBuilder = target.request();

        Response response1 = invocationBuilder.put(Entity.entity("", "application/json"));
        System.out.println("status: " + response1.getStatus());

        if (response1.getStatus() == Response.Status.CREATED.getStatusCode()) {
            System.out.println("success");
        } else {
            System.out.println("failed");
        }

	}

}
