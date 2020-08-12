package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.productService;

/**
 * Servlet implementation class deleteProductServlet
 */
@WebServlet("/deleteProductServlet")
public class deleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(session.getAttribute("type") != null && session.getAttribute("type").equals("Admin")) {
			productService productService = new productService();
			try {
				int productId = Integer.parseInt(request.getParameter("id"));
				int returnCode = productService.deleteProduct(productId);
				if(returnCode == 0) {
					response.sendRedirect("webpages/productmanagement.jsp?table=productList");
				}else {
					response.sendRedirect("webpages/error.jsp");
				}
			}catch(Exception e) {
				System.out.println("Error: "+e);
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
		doGet(request, response);
	}

}
