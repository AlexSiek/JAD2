package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

import model.user;
import model.userService;


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
		HttpSession session = request.getSession();
		String type = (String) session.getAttribute("type");
		if (type == null) {
			response.sendRedirect("webpages/forbidden.jsp");
		}else if( !type.equals("Root") && !type.equals("Admin")){
			response.sendRedirect("webpages/forbidden.jsp");
		}else {
			try {
				int id = Integer.parseInt(request.getParameter("userId"));
			userService userService = new userService();
			user fetchedUser = userService.getUserDetail(id);
			request.setAttribute("userDetails",fetchedUser);
			}catch(Exception e) {
				System.out.println("Error: " + e);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
