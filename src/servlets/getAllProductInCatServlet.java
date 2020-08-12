package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.category;
import model.categoryService;
import model.product;
import model.productService;

/**
 * Servlet implementation class getAllProductInCatServlet
 */
@WebServlet("/getAllProductInCatServlet")
public class getAllProductInCatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getAllProductInCatServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			productService productService = new productService();
			ArrayList<product> fetchedProduct = productService.getAllProductsInACat(Integer.parseInt(request.getParameter("catId")));
			request.setAttribute("productsInCat", fetchedProduct);
		}catch(Exception e) {
			System.out.println("Error: " + e);
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
