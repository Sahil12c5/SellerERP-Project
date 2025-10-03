package controllers;

import models.Profile_Pojo;
import models.UserPojo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");

        if (session == null || user == null) {
            resp.sendRedirect("login.jsp?msg=Please+log+in+to+view+your+profile.");
            return;
        }

      
        req.setAttribute("message", req.getAttribute("message")); 
        req.getRequestDispatcher("update_profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");

        if (session == null || user == null) {
            resp.sendRedirect("login.jsp?msg=Your+session+has+expired.+Please+log+in+again.");
            return;
        }

        Profile_Pojo profile = new Profile_Pojo();
        profile.setPortId(user.getPortId());

        String message = "";

        try {
            if ("update".equals(action)) {
              
                user.setName(req.getParameter("name"));
                user.setEmail(req.getParameter("email"));
                user.setLocation(req.getParameter("location"));

                profile.setName(user.getName());
                profile.setEmail(user.getEmail());
                profile.setLocation(user.getLocation());

                if (profile.updateProfile()) {
                    message = "Success! Profile updated successfully.";
                    // ✅ user is already updated — stays in session
                } else {
                    message = "Error: Failed to update profile.";
                }

            } else if ("changePassword".equals(action)) {
                String currentPassword = req.getParameter("currentPassword");
                String newPassword = req.getParameter("newPassword");

                if (profile.checkPassword(currentPassword)) {
                    profile.setPassword(newPassword);
                    if (profile.updatePassword()) {
                        message = "Success! Password changed successfully.";
                    } else {
                        message = "Error: Failed to change password.";
                    }
                } else {
                    message = "Error: Current password is incorrect.";
                }

            } else if ("delete".equals(action)) {
                if (profile.deleteProfile()) {
                    session.invalidate();
                    resp.sendRedirect("login.jsp?msg=Your+account+has+been+deleted.");
                    return;
                } else {
                    message = "Error: Account deletion failed.";
                }

            } else {
                message = "Error: Invalid action requested.";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            message = "An SQL error occurred: " + e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            message = "An unexpected error occurred: " + e.getMessage();
        }

        req.setAttribute("message", message);
        doGet(req, resp);
    }
}