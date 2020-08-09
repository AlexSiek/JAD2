package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class editUserServlet
 */
@WebServlet("/editUserServlet")
public class editUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editUserServlet() {
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
		int id = 0;
		String username,emailAddress,password1,password2;
		int mobileNum = 0;
		String addressline1,addressline2;
		int postalCode;
		long creditCardNum;
		int csv,expDate;
		HttpSession session = request.getSession();
		try {
			id = (int) session.getAttribute("id");
			username = request.getParameter("username");
			emailAddress = request.getParameter("email");
			password1 = request.getParameter("password1");
			password2 = request.getParameter("password2");
			mobileNum = Integer.parseInt(request.getParameter("mobileNumber"));
			
			addressline1 = request.getParameter("addressline1");
			addressline2 = request.getParameter("addressline2");
			postalCode = Integer.parseInt(request.getParameter("postalCode"));
			
			creditCardNum = Long.parseLong(request.getParameter("creditCardNum"));
			csv = Integer.parseInt(request.getParameter("csv"));
			expDate = Integer.parseInt(request.getParameter("expDate"));
			if(id != 0 || emailAddress != null|| password1 != null|| password2 != null|| mobileNum != 0) {
				
			}else {
				
			}
		}catch(Exception e) {
			System.out.println("Error: " + e);
		}
	}

}
