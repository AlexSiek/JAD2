package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class userCreditCardDetailsServlet
 */
@WebServlet("/userCreditCardDetailsServlet")
public class userCreditCardDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userCreditCardDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String cardNumber = request.getParameter("cardnum");
		System.out.println(cardNumber);
		try {
			if (cardNumber.length() == 16) {
				HttpSession session = request.getSession();
				session.setAttribute("cardnum", cardNumber);
				response.sendRedirect("webpages/cart.jsp");
			} else {
				System.out.println("Error1");
			}
		} catch (Exception e) {
			System.out.println("Error2");
		}
	}

}
