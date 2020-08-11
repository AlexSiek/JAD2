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
import model.category;
import model.categoryService;
import model.purchaseHistory;

/**
 * Servlet implementation class getTopLowSellingServlet
 */
@WebServlet("/getTopLowSellingServlet")
public class getTopLowSellingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getTopLowSellingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sortby = request.getParameter("sortby");
		String filterby = request.getParameter("filterby");
		buyorderService buyorderService = new buyorderService();
		ArrayList<purchaseHistory> fetchedPurchases = new ArrayList<purchaseHistory>();
		if(session.getAttribute("type") == null || !session.getAttribute("type").equals("Admin")) {
			response.sendRedirect("/webpages/forbidden.jsp");
		}else {
			try {
				if(sortby == null && filterby == null) {
					fetchedPurchases = buyorderService.getTopLowSells(0, 0);
				}else if(sortby == null  && filterby != null){
					int filterbyCode = Integer.parseInt(filterby);
					fetchedPurchases = buyorderService.getTopLowSells(0, filterbyCode);
				}else if(sortby != null  && filterby == null) {
					int sortbyCode = Integer.parseInt(sortby);
					fetchedPurchases = buyorderService.getTopLowSells(sortbyCode, 0);
				}else if(sortby != null  && filterby != null) {
					int sortbyCode = Integer.parseInt(sortby);
					int filterbyCode = Integer.parseInt(filterby);
					fetchedPurchases = buyorderService.getTopLowSells(sortbyCode, filterbyCode);
				}
			}catch(Exception e){
				System.out.println("Error: " + e);
			}
			System.out.println("here");
			request.setAttribute("topSelling", fetchedPurchases);
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
