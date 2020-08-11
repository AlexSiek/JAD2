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
 * Servlet implementation class createNewAdmin
 */
@WebServlet("/createNewAdmin")
public class createNewAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createNewAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(session.getAttribute("type") != null && session.getAttribute("type").equals("Root")) {
		userService userService = new userService();
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		try{
			int mobileNumber = Integer.parseInt(request.getParameter("mobileNo"));
			if(String.valueOf(mobileNumber).length() == 8) {
				if (!password1.equals(password2)) {
					response.sendRedirect("webpages/addadmin.jsp?err=mmPassword");
				}else {
					int insertsionCode = userService.createNewAdmin(username, email, password1, mobileNumber);
					if(insertsionCode == -1) {
						response.sendRedirect("webpages/addadmin.jsp?err=dupEntry");
					}else if(insertsionCode == -2) {
						response.sendRedirect("webpages/error.jsp");
					}else {
						response.sendRedirect("webpages/viewadmins.jsp");
					}
				}
			}else {
				response.sendRedirect("webpages/addadmin.jsp?err=moNo");
			}
		} catch (java.lang.NumberFormatException a) {
			response.sendRedirect("webpages/addadmin.jsp?err=moNo");
		} catch (Exception e) {
			System.out.print("Error: " + e);
			response.sendRedirect("webpages/error.jsp");
		}
		}else {
			response.sendRedirect("webpages/forbidden.jsp");
		}
	}

}
