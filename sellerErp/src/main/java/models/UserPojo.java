package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import db_config.GetConnection;

public class UserPojo {
    private String portId;
    private String password;
    private String name;
    private String email;
    private String location;
    

    public UserPojo() {
	}

	public UserPojo(String portId, String name, String email, String location) {
		this.portId = portId;
		this.name = name;
		this.email = email;
		this.location = location;
	}
	
    public String getPortId() {
        return portId;
    }
    public void setPortId(String portId) {
        this.portId = portId;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    
  
    
    public boolean insert_user() throws Exception {
        Connection con = null;
        PreparedStatement preparedStatement = null;
        int rowsAffected = 0;
        try {
            con = GetConnection.getConnection();
            preparedStatement = con.prepareStatement("INSERT INTO users(port_id, password, name, email, location) VALUES (?, ?, ?, ?, ?)");
            preparedStatement.setString(1, portId);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, name);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, location);
            
            rowsAffected = preparedStatement.executeUpdate();
            
        } catch (SQLException e) {
          
            throw e;
        } finally {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return rowsAffected > 0;
    }
    public boolean validateUser() throws Exception {
        
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE port_id = ? AND password = ?")) {
            
            ps.setString(1, this.portId);
            ps.setString(2, this.password);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); 
            }
        }
    }
    public UserPojo authenticate(String portId, String password) throws SQLException {
        String sql = "SELECT port_id, name, email, location FROM users WHERE port_id=? AND password = ? ";
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, portId);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserPojo(
                        rs.getString("port_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("location")
                    );
                }
            }
        }
        return null;
    }
}