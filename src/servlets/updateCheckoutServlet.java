package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.cartService;

/**
 * Servlet implementation class updateCheckoutServlet
 */
@WebServlet("/updateCheckoutServlet")
public class updateCheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateCheckoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		cartService cartService = new cartService();
		if(session.getAttribute("id") != null) {
			try {
				int id = (int) session.getAttribute("id");
				int returnCode = cartService.checkoutStockCheck(id);
				if(returnCode == 0) {
					returnCode = cartService.checkoutToBuyOrder(id);
					if(returnCode == 0) {
						response.sendRedirect("webpages/successcheckout.jsp");
					}else {
						response.sendRedirect("webpages/error.jsp");
					}
				}else if(returnCode == -1) {
					response.sendRedirect("webpages/error.jsp");
				}else {
					response.sendRedirect("webpages/cart.jsp?errId="+returnCode);
				}
			}catch(Exception e) {
				System.out.println("Error: " + e);
				response.sendRedirect("webpages/error.jsp");
			}
		}else {
			response.sendRedirect("webpages/forbidden.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
