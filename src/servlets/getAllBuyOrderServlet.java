package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.buyorder;
import model.buyorderService;
import model.purchaseHistory;
import model.user;
import model.userService;

/**
 * Servlet implementation class getAllBuyOrderServlet
 */
@WebServlet("/getAllBuyOrderServlet")
public class getAllBuyOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getAllBuyOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(session.getAttribute("type") == null || !session.getAttribute("type").equals("Admin")) {
			response.sendRedirect("webpages/forbidden.jsp");
		}else {
			buyorderService buyorderService = new buyorderService();
			try {
				ArrayList<purchaseHistory> fetchOrders = buyorderService.getAllBuyOrder();
				request.setAttribute("fetchOrders", fetchOrders);
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
