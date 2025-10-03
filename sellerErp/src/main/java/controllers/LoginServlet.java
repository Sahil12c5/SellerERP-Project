package controllers;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import models.UserPojo;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

     
        String portId = request.getParameter("port_id");
        String password = request.getParameter("password");

    
        UserPojo user = new UserPojo();

        try {
           
            UserPojo authenticatedUser = user.authenticate(portId, password);

            if (authenticatedUser != null) {
               
                HttpSession session = request.getSession();
                session.setAttribute("user", authenticatedUser); 

                
                response.sendRedirect("Dashboard.jsp");
            } else {
               
                response.sendRedirect("login.jsp?msg=Invalid credentials");
            }
        } catch (SQLException e) {
            
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=Database error occurred");
        } catch (Exception e) {
           
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=Error during login");
        }
    }
}