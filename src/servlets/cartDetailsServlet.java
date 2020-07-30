package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.Response;

import model.cart;
import model.cartService;
import model.product;

/**
 * Servlet implementation class cartDetailsServlet
 */
@WebServlet("/cartDetailsServlet")
public class cartDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cartDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {//response with user cart details
		// TODO Auto-generated method stub
		cartService cartService = new cartService();
		HttpSession session = request.getSession();
		Map<ArrayList<product>,ArrayList<cart>> mappedArrList = cartService.getCartDetail((int) session.getAttribute("id"));
		ArrayList<product> products = new ArrayList<product>();
		ArrayList<cart> cart = new ArrayList<cart>();
		for (Map.Entry<ArrayList<product>, ArrayList<cart>> me : mappedArrList.entrySet()) { 
			products = me.getKey(); 
			cart = me.getValue(); 
        } 
		request.setAttribute("products", products);
		request.setAttribute("carts", cart);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
