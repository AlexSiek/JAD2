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
import model.product;
import model.productService;
import model.purchaseHistory;

/**
 * Servlet implementation class getProductsServlet
 */
@WebServlet("/getProductsServlet")
public class getProductsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getProductsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stubbuyorderService buyOrderService = new buyorderService();
		HttpSession session = request.getSession();
		if(session.getAttribute("type") == null || !(session.getAttribute("type").equals("Admin") || session.getAttribute("type").equals("Root"))) {
			response.sendRedirect("/webpages/forbidden.jsp");
		}else {
			productService productService = new productService();
			ArrayList<product> products = productService.getAllProducts();
			request.setAttribute("products", products);
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
