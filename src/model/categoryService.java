package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class categoryService {

	public int addCategory(String catName, String catDesc, String imgURL) {
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
			// if name in session is not reset, change updating name, form will not fetch
			// correct data
		} catch (java.sql.SQLIntegrityConstraintViolationException a) {
			return -2;
		} catch (Exception e) {
			System.out.println(e);
			return -1;
		}
		return 0;
	}

	public ArrayList<category> getAllCategory() {
		dbAccess dbConnection = new dbAccess();
		ArrayList<category> fetchedCategory = new ArrayList<category>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			String insertStr = "SELECT * FROM category";
			PreparedStatement pstmt = conn.prepareStatement(insertStr);
			ResultSet rs = pstmt.executeQuery();
			;
			while (rs.next()) {
				category singleCat = new category();
				singleCat.setId(rs.getInt("id"));
				singleCat.setCategoryName(rs.getString("categoryName"));
				singleCat.setCategoryDesc(rs.getString("categoryDesc"));
				singleCat.setCategoryImg(rs.getString("categoryImg"));
				fetchedCategory.add(singleCat);
			}
			return fetchedCategory;
			// if name in session is not reset, change updating name, form will not fetch
			// correct data
		} catch (Exception e) {
			System.out.println("Error: " + e);
			return null;
		}
	}

	public category getCategory(int id) {
		dbAccess dbConnection = new dbAccess();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			String insertStr = "SELECT * FROM category WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(insertStr);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			category singleCat = new category();
			if (rs.next()) {
				singleCat.setId(rs.getInt("id"));
				singleCat.setCategoryName(rs.getString("categoryName"));
				singleCat.setCategoryDesc(rs.getString("categoryDesc"));
				singleCat.setCategoryImg(rs.getString("categoryImg"));
			}
			return singleCat;
			// if name in session is not reset, change updating name, form will not fetch
			// correct data
		} catch (Exception e) {
			System.out.println("Error: " + e);
			return null;
		}
	}

	public int updateCategory(int id, String catName, String catDesc, String catImg) {
		dbAccess dbConnection = new dbAccess();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(dbConnection.getConnURL());
			PreparedStatement pstmt = conn
					.prepareStatement("UPDATE category SET categoryName=?,categoryDesc=?,categoryImg=? WHERE id=?");
			pstmt.setString(1, catName);
			pstmt.setString(2, catDesc);
			pstmt.setString(3, catImg);
			pstmt.setInt(4, id);
			pstmt.executeUpdate();
		} catch (java.sql.SQLIntegrityConstraintViolationException a) {
			System.out.println(a);
			return -2;
		} catch (Exception e) {
			System.out.println(e);
			return -1;
		}
		return 0;
	}

}
