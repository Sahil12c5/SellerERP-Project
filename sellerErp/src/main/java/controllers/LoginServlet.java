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

        // Get parameters from login form
        String portId = request.getParameter("port_id");
        String password = request.getParameter("password");

        // Create a new UserPojo instance
        UserPojo user = new UserPojo();

        try {
            // Call authenticate method (returns populated UserPojo if successful)
            UserPojo authenticatedUser = user.authenticate(portId, password);

            if (authenticatedUser != null) {
                // Authentication successful — create session and store user object
                HttpSession session = request.getSession();
                session.setAttribute("user", authenticatedUser); // Store full user details

                // Redirect to dashboard
                response.sendRedirect("Dashboard.jsp");
            } else {
                // Invalid credentials
                response.sendRedirect("login.jsp?msg=Invalid credentials");
            }
        } catch (SQLException e) {
            // Handle database errors
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=Database error occurred");
        } catch (Exception e) {
            // Handle any other unexpected errors
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=Error during login");
        }
    }
}