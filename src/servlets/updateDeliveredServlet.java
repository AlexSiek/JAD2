package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.buyorderService;

/**
 * Servlet implementation class updateDeliveredServlet
 */
@WebServlet("/updateDeliveredServlet")
public class updateDeliveredServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateDeliveredServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		buyorderService buyorderService = new buyorderService();
		if(session.getAttribute("type") != null && session.getAttribute("type").equals("Admin")) {
			int orderid = Integer.parseInt(request.getParameter("id"));
			int returnCode = buyorderService.updateDeliveredOrder(orderid);
			if(returnCode == 1) {
				response.sendRedirect("webpages/orderPage.jsp?table=inDelivery");
			}else {
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
