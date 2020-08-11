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
 * Servlet implementation class deleteCartServlet
 */
@WebServlet("/deleteCartServlet")
public class deleteCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteCartServlet() {
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
		try {
			int userId = (int) session.getAttribute("id");
			int cartId = Integer.parseInt(request.getParameter("cartId"));
			int returnCode = cartService.deleteCartItem(userId, cartId);
			if(returnCode == 1) {
				response.sendRedirect("webpages/cart.jsp");
			}else {
				response.sendRedirect("webpages/error.jsp");
			}
		}catch(Exception e) {
			System.out.println("Error: "+e);
			response.sendRedirect("webpages/error.jsp");
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
