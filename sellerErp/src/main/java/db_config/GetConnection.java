package db_config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/importexport";
    private static final String USER = "root";       // TODO: change
    private static final String PASS = "";   // TODO: change

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    public static Connection getConnection() {
        Connection con = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return con;
    }
}