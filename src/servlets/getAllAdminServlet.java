package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.user;
import model.userService;

/**
 * Servlet implementation class getAllAdminServlet
 */
@WebServlet("/getAllAdminServlet")
public class getAllAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getAllAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("type") == null || !session.getAttribute("type").equals("Root")) {
			response.sendRedirect("webpages/forbidden.jsp");
		}else {
			userService userService = new userService();
			try {
				ArrayList<user> fetchedUser = userService.fetchAllAdmins();
				request.setAttribute("fetchedAdmins", fetchedUser);
			}catch(Exception e) {
				response.sendRedirect("webpages/error.jsp");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
