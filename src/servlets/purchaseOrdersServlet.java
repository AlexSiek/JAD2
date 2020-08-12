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
 * Servlet implementation class purchaseOrdersServlet
 */
@WebServlet("/purchaseOrdersServlet")
public class purchaseOrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public purchaseOrdersServlet() {
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
		ArrayList<purchaseHistory> purchases = new ArrayList<purchaseHistory>();
		String sortby = request.getParameter("sortby");
		String filterby = request.getParameter("filterby");
		try {
			if(sortby == null && filterby == null) {
				 purchases = buyOrderService.getAllPurchaseHistory(0,0);
			}else if(sortby == null  && filterby != null){
				int filterbyCode = Integer.parseInt(filterby);
				 purchases = buyOrderService.getAllPurchaseHistory(0,filterbyCode);
			}else if(sortby != null  && filterby == null) {
				int sortbyCode = Integer.parseInt(sortby);
				 purchases = buyOrderService.getAllPurchaseHistory(sortbyCode,0);
			}else if(sortby != null  && filterby != null) {
				int sortbyCode = Integer.parseInt(sortby);
				int filterbyCode = Integer.parseInt(filterby);
				 purchases = buyOrderService.getAllPurchaseHistory(sortbyCode,filterbyCode);
			}
		}catch(Exception e){
			System.out.println("Error: " + e);
		}
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
