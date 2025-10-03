package Model;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import db_config.GetConnection;

public class Contact_pojo {
	private String uname;
	private String uemail;
	private String unumber;
	private String usubject;
	private String umessage;
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	public String getUnumber() {
		return unumber;
	}
	public void setUnumber(String unumber) {
		this.unumber = unumber;
	}
	public String getUsubject() {
		return usubject;
	}
	public void setUsubject(String usubject) {
		this.usubject = usubject;
	}
	public String getUmessage() {
		return umessage;
	}
	public void setUmessage(String umessage) {
		this.umessage = umessage;
	}
	
	public void contact_user() throws Exception {
		  PreparedStatement preparedStatement=GetConnection.getconnection().prepareStatement("INSERT INTO contact_submissions (fullName, emailAddress, mobileNumber, emailSubject, message) VALUES (?, ?, ?, ?, ?)");
		  preparedStatement.setString(1, uname);
		  preparedStatement.setString(2, uemail);
		  preparedStatement.setString(3, unumber);
		  preparedStatement.setString(4, usubject);
		  preparedStatement.setString(5, umessage);
		  preparedStatement.executeUpdate();
		  
		  GetConnection.getconnection().close();
		    
		
	}
	

}