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
import model.userService;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {// response with user cart details
		// TODO Auto-generated method stub
		cartService cartService = new cartService();
		HttpSession session = request.getSession();
		Map<ArrayList<product>, ArrayList<cart>> mappedArrList = cartService
				.getCartDetail((int) session.getAttribute("id"));
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if (session.getAttribute("id") != null) {
			try {
				// Address
				String addressLine1 = request.getParameter("addressLine1");
				String addressLine2 = request.getParameter("addressLine2");
				int postalCode = Integer.parseInt(request.getParameter("postalCode"));
				String rememberAddress = request.getParameter("rememberAddress");
				// Credit Card
				String rememberCard = request.getParameter("rememberCard");
				String creditCardNumber = request.getParameter("creditcard");
				String expDateString = request.getParameter("expDate");
				String[] splitExpDate = expDateString.split("");
				int expMonth = Integer.parseInt(splitExpDate[0] + splitExpDate[1]);
				int expDate = Integer.parseInt(request.getParameter("expDate"));
				int csv = Integer.parseInt(request.getParameter("csv"));

				System.out.print(creditCardNumber.length());
				System.out.print(String.valueOf(csv).length());
				System.out.print(expMonth);
				if (expMonth <= 12 && creditCardNumber.length() == 16 && String.valueOf(csv).length() == 3) {// Verify expDate is valid
					Long creditCardNumberLong = Long.parseLong(creditCardNumber);
					if (addressLine1 != null && addressLine2 != null && String.valueOf(postalCode).length() == 6) {

						if (rememberAddress != null) {// if address checkbox is ticked
							userService userService = new userService();
							userService.updateUserAddress(addressLine1, addressLine2, (int) session.getAttribute("id"),
									postalCode);
						}

						if (rememberCard != null) {// if card checkbox is ticked
							userService userService = new userService();
							userService.updateUserCard(creditCardNumberLong, csv, (int) session.getAttribute("id"),
									expDate);
						}
						
						cartService checkoutCartService = new cartService();
						int successCheckout = checkoutCartService.checkoutCart((int) session.getAttribute("id"), addressLine1, addressLine2, postalCode, creditCardNumberLong, csv, expDate);
						if(successCheckout == 0) {
							response.sendRedirect("webpages/success.jsp");
						}else if(successCheckout == -1) {
							response.sendRedirect("webpages/error.jsp");
						}else {
							response.sendRedirect("webpages/cart.jsp?errId=" + successCheckout);
						}
					} else {
						response.sendRedirect("webpages/checkout.jsp?errCode=invalidAddress");
					}

				} else {
					response.sendRedirect("webpages/checkout.jsp?errCode=invalidCard");
				}

			} catch (Exception e) {
				System.out.println("Error: " + e);
				response.sendRedirect("webpages/error.jsp");
			}
		} else {
			response.sendRedirect("webpages/error.jsp");
		}
//			System.out.println("here0");
//			//this checks if credit is in db, if not it'll add
//			if (cardType == "American Express") { //amex is 15 digits
//				System.out.println("here1");
//				if ((request.getParameter("creditcard").length()) == 15) {
//					System.out.println("here2");
//					userService userService = new userService();
//					String creditcardnum = userService.checkCreditCard(creditCardInfo);
//					System.out.println("here3");
//					if (creditcardnum == "success") { //card is in db
//						response.sendRedirect("webpages/success.jsp");
//						System.out.println("success");
//					} else {
//						userService.addCreditCard(cardType, creditCardInfo);
//						System.out.println("added card");
//					}
//				} else {
//					System.out.println("card needs to be 15 digits long");
//					response.sendRedirect("webpages/error.jsp");
//				}
//			} else if (cardType == "MasterCard" || cardType == "Visa") { //mastercard n visa are 16 digits
//				if ((request.getParameter("creditcard").length()) == 16) {
//					userService userService = new userService();
//					String creditcardnum = userService.checkCreditCard(creditCardInfo);
//					if (creditcardnum == "success") { //card is in db
//						response.sendRedirect("webpages/success.jsp");
//						System.out.println("success");
//					} else {
//						userService.addCreditCard(cardType, creditCardInfo);
//						System.out.println("added card");
//					}
//				} else {
//					System.out.println("card needs to be 16 digits long");
//					System.out.println(request.getParameter("creditcard").length());
//					response.sendRedirect("webpages/error.jsp");
//				}
//			}
	}
}
