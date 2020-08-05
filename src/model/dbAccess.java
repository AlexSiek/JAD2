package model;

public class dbAccess {
	String dbuser = "root";
	String dbpassword = "ubuntu1";
	int port = 3306;
	String connURL = "jdbc:mysql://localhost:"+port+"/j2ee?user="+dbuser+"&password="+dbpassword+"&serverTimezone=UTC";
	public String getConnURL() {
		return connURL;
	}
}
