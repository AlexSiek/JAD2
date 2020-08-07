package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;

public class categoryService {
	
	public int addCategory(String catName, String catDesc,String imgURL) {
		dbAccess dbConnection = new dbAccess();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			String insertStr = "INSERT INTO category (categoryName,categoryDesc,categoryImg) VALUES (?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(insertStr);
			pstmt.setString(1, catName);
			pstmt.setString(2, catDesc);
			pstmt.setString(3, imgURL);
			int count = pstmt.executeUpdate();
			// if name in session is not reset, change updating name, form will not fetch correct data
		} catch (java.sql.SQLIntegrityConstraintViolationException a) {
			return -2;
		} catch (Exception e) {
			System.out.println(e);
			return -1;
		}
		return 0;
	}
	
}
