package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.cartService;
import model.userService;

/**
 * Servlet implementation class addToCartServlet
 */
@WebServlet("/addToCartServlet")
public class addToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addToCartServlet() {
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
		cartService cartService = new cartService();
		try {
			int userId = (int) session.getAttribute("id");
			int qty = Integer.parseInt(request.getParameter("qty"));
			int productId = Integer.parseInt(request.getParameter("productId"));
			int returnCode = cartService.addToCart(userId, qty, productId);
			if(returnCode == 1) {
				response.sendRedirect("webpages/cart.jsp");
			}else {
				response.sendRedirect("webpages/error.jsp");
			}
		}catch(Exception e) {
			System.out.println("Error: "+e);
			response.sendRedirect("webpages/error.jsp");
			
		}
		doGet(request, response);
	}

}
