// File: controllers/ReportManagementServlet.java

package controllers;

import models.ReportManagement;
import models.UserPojo;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/reports")
public class ReportManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 Session validation
        HttpSession session = request.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");
        if (session == null || user == null) {
            response.sendRedirect("login.jsp?msg=Please+log+in+to+view+reports");
            return;
        }

        String sellerPortId = user.getPortId();
        String statusFilter = request.getParameter("status_filter");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "All"; // Default: show all reports
        }

        try {
            ReportManagement reportPojo = new ReportManagement();
            List<ReportManagement> reportList = reportPojo.getReportsBySellerIdAndStatus(sellerPortId, statusFilter);

            System.out.println("DEBUG: Fetched " + reportList.size() + " reports for " + sellerPortId + " with filter: " + statusFilter);

            request.setAttribute("reportList", reportList);
            request.setAttribute("selectedStatus", statusFilter);

            RequestDispatcher dispatcher = request.getRequestDispatcher("reports.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not retrieve reports.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("reports.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");
        if (session == null || user == null) {
            response.sendRedirect("login.jsp?msg=Session+expired.+Please+log+in+again.");
            return;
        }

        String action = request.getParameter("action");

        try {
            ReportManagement report = new ReportManagement();

            if ("add".equalsIgnoreCase(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String reporterId = request.getParameter("reporterId");
                String reason = request.getParameter("reason");

                report.setProductId(productId);
                report.setReporterId(reporterId);
                report.setReason(reason);
                report.setStatus("open");

                boolean added = report.insertReport();
                if (added) {
                    response.sendRedirect("reports?msg=Report+Added+Successfully");
                } else {
                    response.sendRedirect("reports?error=Failed+to+Add+Report");
                }

            } else if ("update".equalsIgnoreCase(action)) {
                int reportId = Integer.parseInt(request.getParameter("reportId"));
                String status = request.getParameter("status");

                report.setReportId(reportId);
                report.setStatus(status);

                boolean updated = report.updateReportStatus();
                if (updated) {
                    response.sendRedirect("reports?msg=Report+Status+Updated");
                } else {
                    response.sendRedirect("reports?error=Failed+to+Update+Status");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("reports?error=Database+Error");
        }
    }
}