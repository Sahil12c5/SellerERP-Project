package db_config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetConnection {

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

            String dbUrl = System.getenv("DATABASE_URL");

           
            if (dbUrl == null || dbUrl.isEmpty()) {
                dbUrl = "jdbc:mysql://localhost:3306/importexport?user=root&password=";
            }

            
            con = DriverManager.getConnection(dbUrl);

        } catch (SQLException e) {
            System.err.println("FATAL: Failed to connect to the database!");
            e.printStackTrace();
        }
        return con;
    }
}