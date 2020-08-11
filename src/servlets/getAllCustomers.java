package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.product;
import model.productService;
import model.user;
import model.userService;

/**
 * Servlet implementation class getAllCustomers
 */
@WebServlet("/getAllCustomers")
public class getAllCustomers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getAllCustomers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String sortby = request.getParameter("sortby");
		if(session.getAttribute("type") == null || (!session.getAttribute("type").equals("Root") && !session.getAttribute("type").equals("Admin"))) {
			response.sendRedirect("webpages/forbidden.jsp");
		}else {
			userService userService = new userService();
			if(sortby != null) {
				int sortbyCode = Integer.parseInt(sortby);
				ArrayList<user> fetchedUsers = userService.getAllUserDetail(sortbyCode);
				request.setAttribute("customers", fetchedUsers);
				
			}else {
				ArrayList<user> fetchedUsers = userService.getAllUserDetail(0);
				request.setAttribute("customers", fetchedUsers);
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
