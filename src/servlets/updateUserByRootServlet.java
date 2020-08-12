package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.userService;

/**
 * Servlet implementation class updateUserByRootServlet
 */
@WebServlet("/updateUserByRootServlet")
public class updateUserByRootServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateUserByRootServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if (session.getAttribute("type") != null || session.getAttribute("type").equals("Root")) {
			try {
				int id = Integer.parseInt(request.getParameter("id"));
				String username = request.getParameter("username");
				String password1 = request.getParameter("password1");
				String password2 = request.getParameter("password2");
				String email = request.getParameter("email");
				int mobileNumber = Integer.parseInt(request.getParameter("mobileNumber"));
				if(password1.equals(password2)){
					if(String.valueOf(mobileNumber).length() == 8) {
						userService userService = new userService();
						int returnCode = userService.updateUserDetail(username, password1, email, id, mobileNumber);
						if(returnCode == 0) {
							response.sendRedirect("webpages/viewadmins.jsp");
						}else if(returnCode == -1) {
							response.sendRedirect("webpages/editadmin.jsp?id="+id+"&err=dupEntry");
						}else {
							response.sendRedirect("webpages/error.jsp");
						}
					}else{
						response.sendRedirect("webpages/editadmin.jsp?id="+id+"&err=InvalidNumber");
					}
				}else {
					response.sendRedirect("webpages/editadmin.jsp?id="+id+"&err=mmPassword");
				}
			} catch (Exception e) {
				System.out.println("Error: " + e);
				response.sendRedirect("webpages/error.jsp");
			}
		} else {
			response.sendRedirect("webpages/forbidden.jsp");
		}
	}

}
