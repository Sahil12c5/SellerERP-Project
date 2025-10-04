package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

// Imports for Tomcat 10 and newer
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import models.UserPojo;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String PASSWORD_PATTERN = "^(?=.*[A-Z])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$";
    private static final Pattern pattern = Pattern.compile(PASSWORD_PATTERN);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String portId = request.getParameter("portId");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String location = request.getParameter("location");

        if (!isValidPassword(password)) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters long and contain at least one uppercase letter and one special character.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Registration.jsp");
            dispatcher.forward(request, response);
            return;
        }

        UserPojo reg = new UserPojo();
        reg.setPortId(portId);
        reg.setPassword(password); // Reminder: For security, this should be hashed.
        reg.setName(name);
        reg.setEmail(email);
        reg.setLocation(location);

        try {
            boolean inserted = reg.insert_user();

            if (inserted) {
                request.setAttribute("successMessage", "Registration successful! Please log in.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to register. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Registration.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            if (e.getSQLState().startsWith("23")) {
                request.setAttribute("errorMessage", "A user with this Port ID or Email already exists. Please use a different one.");
            } else {
                e.printStackTrace();
                request.setAttribute("errorMessage", "An error occurred during registration.");
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Registration.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred during registration.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Registration.jsp");
            dispatcher.forward(request, response);
        }
    }

    private boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }
}