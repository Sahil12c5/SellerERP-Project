package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import Model.Contact_pojo;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

       
        response.setContentType("text/html;charset=UTF-8");
        
       
        String fullName = request.getParameter("uname");
        String emailAddress = request.getParameter("uemail");
        String mobileNumber = request.getParameter("unumber");
        String emailSubject = request.getParameter("usubject");
        String message = request.getParameter("umessage");

        
        Contact_pojo contact = new Contact_pojo();
        
        
        contact.setUname(fullName);
        contact.setUemail(emailAddress);
        contact.setUnumber(mobileNumber);
        contact.setUsubject(emailSubject);
        contact.setUmessage(message);

        PrintWriter out = response.getWriter();
        
        try {
            
            contact.contact_user();
            
            
            out.println("<script>");
            out.println("alert('Message sent successfully!');");
            out.println("window.location.href = 'portfolio1.jsp';"); 
            out.println("</script>");
            
        } catch (Exception e) {
            
            out.println("<script>");
            out.println("alert('An error occurred. Please try again.');");
            out.println("window.location.href = 'portfolio1.jsp';"); 
            out.println("</script>");
            e.printStackTrace();
        }
    }
}