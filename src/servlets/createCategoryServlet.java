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

import model.categoryService;
import model.productService;

/**
 * Servlet implementation class createCategoryServlet
 */
@WebServlet("/createCategoryServlet")
public class createCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createCategoryServlet() {
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
		if (ServletFileUpload.isMultipartContent(request)) {
			HttpSession session = request.getSession();
			String type = (String) session.getAttribute("type");
			if (type == null || !type.equals("Admin")) {// Admin checking
				response.sendRedirect("/webpages/forbidden.jsp");
			} else {
				try {
					String catName = "", catDesc = "", imgURL = "";
					
					try {
						List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory())
								.parseRequest(request);

						for (FileItem item : multiparts) {
							if (!item.isFormField()) {
								String name = new File(item.getName()).getName();
								item.write(new File(this.getServletContext().getRealPath("images/category")
										+ File.separator + name));
								imgURL = "../images/category/" + name;
							}else {
								switch(item.getFieldName()){
								case "catName":
									catName = item.getString();
									break;
								case "catDesc":
									catDesc = item.getString();
									break;
								}
							}
						}
						if (catName.equals("") || catDesc.equals("") || imgURL.equals("")) {
							response.sendRedirect("webpages/createproduct.jsp?err=mField");
						} else {
							categoryService categoryService = new categoryService();
							int code = categoryService.addCategory(catName, catDesc, imgURL);
							if (code == -1) {
								response.sendRedirect("webpages/error.jsp");
							} else if (code == -2) {
								response.sendRedirect("webpages/createcategory.jsp?err=dupEntry");
							} else {
								response.sendRedirect("webpages/productmanagement.jsp");
							}
						}
						//ERROR DIRECTION
					} catch (Exception ex) {
						System.out.println("Error: " +ex);
						response.sendRedirect("webpages/error.jsp");
					}
				} catch (Exception e) {
					System.out.println("Error: " +e);
					response.sendRedirect("webpages/error.jsp");
				}
			}
		} else {
			response.sendRedirect("webpages/error.jsp");
		}
	}

}
