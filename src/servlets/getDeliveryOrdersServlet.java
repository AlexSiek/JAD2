package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.buyorderService;
import model.purchaseHistory;

/**
 * Servlet implementation class getDeliveryOrdersServlet
 */
@WebServlet("/getDeliveryOrdersServlet")
public class getDeliveryOrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getDeliveryOrdersServlet() {
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
			System.out.println("ran here");
		}else {
			if(request.getParameter("orderStatus") == null) {
				response.sendRedirect("webpages/error.jsp");
			}else {
				try {
					int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));
					buyorderService orderRequest = new buyorderService();
					ArrayList<purchaseHistory> orders = new ArrayList<purchaseHistory>();
					if(orderStatus == 1) {
						orders = orderRequest.getPendingOrders();
					}else if(orderStatus == 2) {
						orders = orderRequest.getOnDeliveryOrders();
					}else {
						orders = orderRequest.getDeliveredOrders();
					}
					request.setAttribute("requestedOrders", orders);
				}catch(Exception e) {
					response.sendRedirect("webpages/error.jsp");
				}
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
