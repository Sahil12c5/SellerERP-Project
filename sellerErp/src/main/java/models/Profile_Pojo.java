package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import db_config.GetConnection;

public class Profile_Pojo {
	private String portId;
	private String name;
	private String email;
	private String password;
	private String location;

	// Getter and Setter methods using standard conventions
	public String getPortId() { return portId; }
	public void setPortId(String portId) { this.portId = portId; }

	public String getName() { return name; }
	public void setName(String name) { this.name = name; }

	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }

	public String getPassword() { return password; }
	public void setPassword(String password) { this.password = password; }

	public String getLocation() { return location; }
	public void setLocation(String location) { this.location = location; }

	// Method to fetch user details from the database
	public boolean fetchUserDetails() throws SQLException {
	    String query = "SELECT name, email, location FROM users WHERE port_id = ?";
	    try (Connection con = GetConnection.getConnection();
	         PreparedStatement preparedStatement = con.prepareStatement(query)) {
	        preparedStatement.setString(1, this.portId);
	        try (ResultSet rs = preparedStatement.executeQuery()) {
	            if (rs.next()) {
	                this.name = rs.getString("name");
	                this.email = rs.getString("email");
	                this.location = rs.getString("location");
	                return true;
	            }
	        }
	    }
	    return false;
	}

	public boolean updateProfile() throws SQLException {
	    // Corrected parameter order and SQL. `password` is a separate update.
	    String query = "UPDATE users SET name=?, email=?, location=? WHERE port_id=?";
	    try (Connection con = GetConnection.getConnection();
	         PreparedStatement preparedStatement = con.prepareStatement(query)) {
	        preparedStatement.setString(1, this.name);
	        preparedStatement.setString(2, this.email);
	        preparedStatement.setString(3, this.location);
	        preparedStatement.setString(4, this.portId);
	        return preparedStatement.executeUpdate() > 0;
	    }
	}

	public boolean updatePassword() throws SQLException {
		String query = "UPDATE users SET password=? WHERE port_id=?";
	    try (Connection con = GetConnection.getConnection();
	         PreparedStatement preparedStatement = con.prepareStatement(query)) {
	        preparedStatement.setString(1, this.password);
	        preparedStatement.setString(2, this.portId);
	        return preparedStatement.executeUpdate() > 0;
	    }
	}
	
	public boolean deleteProfile() throws SQLException {
	    String query = "DELETE FROM users WHERE port_id=?";
	    try (Connection con = GetConnection.getConnection();
	         PreparedStatement preparedStatement = con.prepareStatement(query)) {
	        preparedStatement.setString(1, this.portId); // Corrected parameter index
	        return preparedStatement.executeUpdate() > 0;
	    }
	}

	// Method to check current password for validation
	public boolean checkPassword(String currentPassword) throws SQLException {
		String query = "SELECT password FROM users WHERE port_id = ?";
		try (Connection con = GetConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(query)) {
			ps.setString(1, this.portId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next() && rs.getString("password").equals(currentPassword)) {
					return true;
				}
			}
		}
		return false;
	}
}