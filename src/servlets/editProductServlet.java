package servlets;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import model.productService;

/**
 * Servlet implementation class editProductServlet
 */
@WebServlet("/editProductServlet")
public class editProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editProductServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (ServletFileUpload.isMultipartContent(request)) {
			HttpSession session = request.getSession();
			String type = (String) session.getAttribute("type");
			if (type == null || !type.equals("Admin")) {// Admin checking
				response.sendRedirect("/webpages/forbidden.jsp");
			} else {
				try {
					String productName = "", vendor = "", pdtDesc = "", imgURL = "";
					int categoryId = 0, qty = 0, productId = 0;
					double price = 0, MSRP = 0;

					try {
						List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory())
								.parseRequest(request);

						for (FileItem item : multiparts) {
							if (!item.isFormField()) {
								String name = new File(item.getName()).getName();
								item.write(new File(this.getServletContext().getRealPath("images/products")
										+ File.separator + name));
								imgURL = "../images/products/" + name;
								System.out.println(name);
							} else {
								switch (item.getFieldName()) {
								case "productName":
									productName = item.getString();
									break;
								case "vendor":
									vendor = item.getString();
									break;
								case "pdtDesc":
									pdtDesc = item.getString();
									break;
								case "categoryId":
									categoryId = Integer.parseInt(item.getString());
									break;
								case "qty":
									qty = Integer.parseInt(item.getString());
									break;
								case "buyPrice":
									price = Double.parseDouble(item.getString());
									break;
								case "MSRP":
									MSRP = Double.parseDouble(item.getString());
									break;
								case "id":
									productId = Integer.parseInt(item.getString());
									break;
//								case "originalURL":
//									originalURL = item.getString();
//									break;
								}
							}
						}
						if (productName.equals("") || vendor.equals("") || vendor.equals("") || pdtDesc.equals("") || imgURL.equals("")
								|| categoryId == 0 || productId == 0) {
							response.sendRedirect("webpages/editlisting.jsp?id="+productId+"&err=mField");
						} else if (qty <= 0) {
							response.sendRedirect("webpages/editlisting.jsp?id="+productId+"&err=invalidQty");
						} else if (price <= 0) {
							response.sendRedirect("webpages/editlisting.jsp?id="+productId+"&err=invalidPrice");
						} else if (MSRP <= 0) {
							response.sendRedirect("webpages/editlisting.jsp?id="+productId+"&err=invalidMSRP");
						} else {
							productService productService = new productService();
							int code = productService.updateProduct(productId, categoryId, productName, vendor, pdtDesc,
									qty, price, MSRP, imgURL);
							if (code == -1) {
								response.sendRedirect("webpages/error.jsp");
							} else if (code == -2) {
								response.sendRedirect("webpages/editlisting.jsp?err=dupEntry");
							} else {
								response.sendRedirect("webpages/productmanagement.jsp");
							}
						}
						// ERROR DIRECTION
					} catch (Exception ex) {
						System.out.println("Error: " + ex);
						response.sendRedirect("webpages/error.jsp");
					}
				} catch (Exception e) {
					System.out.println("Error: " + e);
					response.sendRedirect("webpages/error.jsp");
				}
			}
		} else {
			response.sendRedirect("webpages/error.jsp");
		}
	}

}
