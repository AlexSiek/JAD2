package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.user;
import model.userService;

/**
 * Servlet implementation class userServlet
 */
@WebServlet("/userLoginServlet")
public class userLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public userLoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		user loginUser = new user();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		try {
			userService userFetchingService = new userService();
			if (email == "" || password == "") {// if any field missing, immediately redirect
				response.sendRedirect("webpages/login.jsp?err=missingField");
			} else {
				loginUser = userFetchingService.getUserLogin(email, password);
				if (loginUser == null) {
					response.sendRedirect("webpages/login.jsp?err=invalidLogin");
				} else {
					HttpSession session = request.getSession();
					session.setAttribute("id", loginUser.getId());
					session.setAttribute("username", loginUser.getUsername());
					session.setAttribute("type", loginUser.getType());
					if (loginUser.getType().equals("Root")) {
						response.sendRedirect("webpages/viewadmins.jsp");
					} else if (loginUser.getType().equals("Admin")) {
						response.sendRedirect("webpages/orderPage.jsp");
					} else {
						response.sendRedirect("webpages/index.jsp");
					}
				}
			}
		} catch (java.lang.NullPointerException a) {
			response.sendRedirect("webpages/login.jsp?err=invalidLogin");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

}
