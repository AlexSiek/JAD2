package servlets;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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

import model.category;
import model.categoryService;
import model.productService;

/**
 * Servlet implementation class editCategoryServlet
 */
@WebServlet("/editCategoryServlet")
public class editCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		System.out.println(request.getParameter("id"));
		if(session.getAttribute("type") == null || !session.getAttribute("type").equals("Admin")) {
			response.sendRedirect("webpages/forbidden.jsp");
		}else if(request.getParameter("id") == null){
			response.sendRedirect("webpages/error.jsp");
		}else{
			categoryService categoryService = new categoryService();
			category fetchedCategory = categoryService.getCategory(Integer.parseInt(request.getParameter("id")));
			request.setAttribute("category", fetchedCategory);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (ServletFileUpload.isMultipartContent(request)) {
			HttpSession session = request.getSession();
			String type = (String) session.getAttribute("type");
			if (type == null || !type.equals("Admin")) {// Admin checking
				response.sendRedirect("/webpages/forbidden.jsp");
			} else {
				try {
					String categoryName = "",categoryDesc = "", imgURL = "";
					int categoryId = 0;

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
								case "categoryName":
									categoryName = item.getString();
									break;
								case "categoryDesc":
									categoryDesc = item.getString();
									break;
								case "id":
									categoryId = Integer.parseInt(item.getString());
									break;
								}
							}
						}
						if (categoryName.equals("") || categoryDesc.equals("") || imgURL.equals("") || categoryId == 0) {
							response.sendRedirect("webpages/createproduct.jsp?err=mField");
						} else {
							categoryService categoryService = new categoryService();
							int code = categoryService.updateCategory(categoryId, categoryName, categoryDesc, imgURL);
							if (code == -1) {
								response.sendRedirect("webpages/error.jsp");
							} else if (code == -2) {
								response.sendRedirect("webpages/editcategory.jsp?err=dupEntry");
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
