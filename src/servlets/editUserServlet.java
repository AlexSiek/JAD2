package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.userService;

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
		String username,emailAddress,password1,password2,mobileNumString;
		int mobileNum;
		String addressline1,addressline2,postalCodeString;
		int postalCode;
		String creditCardNumString,csvString,expDateString;
		long creditCardNum;
		int csv,expDate;
		HttpSession session = request.getSession();
		try {
			id = (int) session.getAttribute("id");
			username = request.getParameter("username");
			emailAddress = request.getParameter("email");
			password1 = request.getParameter("password1");
			password2 = request.getParameter("password2");
			mobileNumString = request.getParameter("mobileNumber");
			
			addressline1 = request.getParameter("addressline1");
			addressline2 = request.getParameter("addressline2");
			postalCodeString = request.getParameter("postalCode");
			
			creditCardNumString = request.getParameter("creditCardNum");
			csvString = request.getParameter("csv");
			expDateString = request.getParameter("expDate");
			
			System.out.println("Addressline1: "+addressline1+"  Addressline2"+addressline2+"   postalCode"+ postalCodeString);
			System.out.println("creditCardNum: "+creditCardNumString+"  csv"+csvString+"   expDate"+ expDateString);
			if(id != 0 && emailAddress != null && password1 != null && password2 != null && password1.equals(password2) && mobileNumString.length() == 8 && mobileNumString != null) {
				mobileNum = Integer.parseInt(mobileNumString);
				userService userService = new userService();
				int returnCode = userService.updateUserDetail(username, password1, emailAddress, id, mobileNum);
				if(returnCode == -2) {
					response.sendRedirect("webpages/error.jsp");
				}else if(returnCode == -1) {
					response.sendRedirect("webpages/profile.jsp?err=dupEntry");
				}else {
					boolean cardAddressFailure = false;
					if(addressline1 != null || addressline2 != null ||postalCodeString != null) {//check if any field is filled
						if(addressline1 != null && addressline2 != null && postalCodeString.length() == 6) {
							postalCode = Integer.parseInt(postalCodeString);
							userService.updateUserAddress(addressline1, addressline2, id, postalCode);
						}else {
							cardAddressFailure = true;
							if(postalCodeString.length() != 6) {
								response.sendRedirect("webpages/profile.jsp?err=invalidPostal");
							}else {
								response.sendRedirect("webpages/profile.jsp?err=missAddress");
							}
						}
					}
					
					if(creditCardNumString != null || csvString != null || expDateString != null) {
						if(creditCardNumString.length() == 16 && csvString.length() == 3 && expDateString.length() == 4) {
							String[] splitExpDate = String.valueOf(expDateString).split("");
							int expMonth = Integer.parseInt(splitExpDate[0]+splitExpDate[1]);
							creditCardNum = Long.parseLong(creditCardNumString);
							csv = Integer.parseInt(csvString);
							expDate = Integer.parseInt(expDateString);
							
							
							if(expMonth <= 12) {
								userService.updateUserCard(creditCardNum, csv, id, expDate);
							}else {
								response.sendRedirect("webpages/profile.jsp?err=invalidExpDate");
							}
						}else {
							cardAddressFailure = true;
							if(creditCardNumString.length() != 16) {
								response.sendRedirect("webpages/profile.jsp?err=invalidCardNum");
							}else if(csvString.length() != 3) {
								response.sendRedirect("webpages/profile.jsp?err=invalidCsv");
							}else {
								response.sendRedirect("webpages/profile.jsp?err=invalidExpDate");
							}
						}
					}
					
					if(!cardAddressFailure) {
						response.sendRedirect("webpages/profile.jsp?success=1");
					}
				}
			}else {
				if(id == 0) {
					response.sendRedirect("webpages/login.jsp");
				}else if(mobileNumString.length() != 8 || mobileNumString == null) {
					response.sendRedirect("webpages/profile.jsp?err=moNo");
				}else if(!password1.equals(password2)) {
					response.sendRedirect("webpages/profile.jsp?err=mmPassword");
				}else {
					response.sendRedirect("webpages/error.jsp");
				}
			}
		}catch(Exception e) {
			System.out.println("Error: " + e);
			response.sendRedirect("webpages/error.jsp");
		}
	}

}
