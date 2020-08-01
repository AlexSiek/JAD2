package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.buyorderService;
import model.cart;
import model.cartService;
import model.product;
import model.purchaseHistory;

/**
 * Servlet implementation class purchaseHistoryServlet
 */
@WebServlet("/purchaseHistoryServlet")
public class purchaseHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public purchaseHistoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		buyorderService buyOrderService = new buyorderService();
		HttpSession session = request.getSession();
		ArrayList<purchaseHistory> purchases = buyOrderService.getPurchaseHistory((int) session.getAttribute("id"));
		request.setAttribute("purchaseHistory", purchases);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
