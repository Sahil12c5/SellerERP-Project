package controllers;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import models.OrderManagement_pojo;
import models.UserPojo;

@WebServlet("/manage_orders")
public class OrderManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 Get session and user object
        HttpSession session = request.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");

        if (session == null || user == null) {
            response.sendRedirect("login.jsp?msg=Please+log+in+to+manage+orders");
            return;
        }

        String sellerPortId = user.getPortId();

        // Handle action and filters
        String action = request.getParameter("action");
        action = (action == null) ? "view" : action;

        String statusFilter = request.getParameter("status_filter");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "All";
        }

        try {
            // Fetch orders for this seller
            List<OrderManagement_pojo> orderList = OrderManagement_pojo.getAllOrdersBySeller(sellerPortId, statusFilter);
            request.setAttribute("orderList", orderList);
            request.setAttribute("selectedStatus", statusFilter);

            // Handle specific actions
            switch (action) {
                case "new":
                    request.setAttribute("order", new OrderManagement_pojo());
                    break;

                case "edit":
                    try {
                        int orderId = Integer.parseInt(request.getParameter("id"));
                        OrderManagement_pojo orderToEdit = OrderManagement_pojo.getOrderById(orderId);

                        if (orderToEdit != null && orderToEdit.getSeller_port_id().equals(sellerPortId)) {
                            request.setAttribute("order", orderToEdit);
                        } else {
                            session.setAttribute("errorMessage", "Unauthorized access or order not found.");
                            response.sendRedirect("manage_orders?action=view");
                            return;
                        }
                    } catch (NumberFormatException e) {
                        session.setAttribute("errorMessage", "Invalid order ID.");
                        response.sendRedirect("manage_orders?action=view");
                        return;
                    }
                    break;

                case "view":
                default:
                    // Just display the list
                    break;
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("manage_orders.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading orders", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");

        if (session == null || user == null) {
            response.sendRedirect("login.jsp?msg=Your+session+has+expired.+Please+log+in+again.");
            return;
        }

        String sellerPortId = user.getPortId();

        try {
            OrderManagement_pojo order = new OrderManagement_pojo();
            order.setOrder_id(Integer.parseInt(request.getParameter("order_id")));
            order.setStatus(request.getParameter("status"));
            order.setDelivery_address(request.getParameter("delivery_address"));
            order.setTotal_amount(new BigDecimal(request.getParameter("total_amount")));
            order.setSeller_port_id(sellerPortId);

            String successMessage;

            if (order.getOrder_id() == 0) {
                // New order
                String buyerId = request.getParameter("buyer_id");
                if (buyerId == null || buyerId.trim().isEmpty()) {
                    session.setAttribute("errorMessage", "Buyer ID is required.");
                    response.sendRedirect("manage_orders?action=new");
                    return;
                }
                order.setBuyer_id(buyerId);
                order.insertOrder();
                successMessage = "✅ Order created successfully!";
            } else {
                // Existing order update
                OrderManagement_pojo existingOrder = OrderManagement_pojo.getOrderById(order.getOrder_id());
                if (existingOrder == null || !existingOrder.getSeller_port_id().equals(sellerPortId)) {
                    session.setAttribute("errorMessage", "Unauthorized to update this order.");
                    response.sendRedirect("manage_orders?action=view");
                    return;
                }
                order.updateOrder();
                successMessage = "✅ Order updated successfully!";
            }

            // Store success message in session
            session.setAttribute("successMessage", successMessage);

            // Redirect to view page
            response.sendRedirect("manage_orders?action=view");

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid number format for ID or amount.");
            response.sendRedirect("manage_orders?action=view");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            response.sendRedirect("manage_orders?action=view");
        }
    }
}