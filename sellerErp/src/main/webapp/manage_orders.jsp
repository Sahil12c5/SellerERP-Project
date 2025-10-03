<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.UserPojo" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    // 🔐 Session-based authentication using UserPojo object
    UserPojo user = (UserPojo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+log+in+to+manage+orders");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        /* Color Palette: Beige, Orange, Charcoal, Navy Blue */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F5DC; /* Soft Beige background to match dashboard */
            min-height: 100vh;
            padding-top: 5rem;
            display: flex;
            flex-direction: column;
        }
        .main-content { flex: 1; }
        .navbar-custom { 
            background-color: #001f3f; /* Deep Navy Blue to match dashboard */
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
        }
        .navbar-brand, .nav-link { 
            font-weight: 700; 
            color: #F5F5DC !important; /* Beige text for contrast */
        }
        .nav-link.active {
            color: #FF8C00 !important; /* Orange accent for active link */
        }
        .nav-link:hover {
            color: #FF8C00 !important; /* Orange on hover */
        }
        .btn-logout { 
            background-color: #FF8C00; /* Vibrant Orange */
            color: white !important; 
            border-radius: 50px; 
            padding: 0.5rem 1.5rem !important; 
            transition: background-color 0.3s ease; 
        }
        .btn-logout:hover { 
            background-color: #E57A00; 
        }
        .management-container { 
            background-color: rgba(255, 255, 255, 0.95); 
            border-radius: 15px; 
            padding: 2.5rem; 
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); 
        }
        .management-header h2 { 
            font-weight: 700; 
            color: #001f3f; /* Deep Navy Blue */
            display: flex; 
            align-items: center; 
            justify-content: center; 
            gap: 1rem; 
        }
        h4 {
            color: #36454F; /* Charcoal Gray for subheadings */
        }
        .form-control:focus, .form-select:focus { 
            border-color: #FF8C00; 
            box-shadow: 0 0 0 0.25rem rgba(255, 140, 0, 0.25); 
        }
        .btn-custom { 
            background-color: #FF8C00; 
            border: none; 
            color: white; 
            font-weight: 600; 
            padding: 0.6rem 1.5rem; 
            transition: background-color 0.3s ease; 
        }
        .btn-custom:hover { 
            background-color: #E57A00; color: white; 
        }
        .btn-secondary-custom { 
            background-color: #6c757d; 
            border: none; 
            color: white; 
            font-weight: 600; 
            padding: 0.6rem 1.5rem; 
            transition: background-color 0.3s ease; 
        }
        .btn-secondary-custom:hover{ 
            background-color: #5a6268; color: white; 
        }
        .table thead th { 
            background-color: #001f3f; /* Deep Navy Blue */
            font-weight: 600; 
            color: #F5F5DC; /* Beige text */
        }
        .table-hover tbody tr:hover { 
            background-color: rgba(0, 31, 63, 0.05); /* Navy Blue hover effect */
        }
        .no-orders-message { 
            text-align: center; 
            padding: 2rem; 
            background-color: #f8f9fa; 
            border-radius: 8px; 
            color: #36454F; /* Charcoal gray text */
        }
        .footer {
            background-color: #001f3f; /* Deep Navy Blue */
            color: #F5F5DC; /* Beige text */
            padding: 2rem 0;
            margin-top: 4rem;
        }

        /* Success message popup styling */
        .success-popup {
            position: fixed;
            top: 100px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1050;
            font-weight: 500;
            font-size: 0.95rem;
            padding: 1rem 2rem;
            border-radius: 10px;
            text-align: center;
            width: auto;
            max-width: 500px;
            min-width: 300px;
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            animation: popupAnimation 3s ease-in-out forwards;
        }
        
        .success-popup i {
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }
        
        .error-message {
            font-weight: 500;
            font-size: 0.95rem;
            padding: 1rem;
            border-radius: 8px;
            text-align: center;
            width: 100%;
            margin-bottom: 1.5rem;
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }

        /* CSS Animation for popup effect */
        @keyframes popupAnimation {
            0% {
                opacity: 0;
                transform: translateX(-50%) translateY(-100px) scale(0.8);
            }
            15% {
                opacity: 1;
                transform: translateX(-50%) translateY(0) scale(1.05);
            }
            30% {
                transform: translateX(-50%) translateY(0) scale(1);
            }
            70% {
                opacity: 1;
                transform: translateX(-50%) translateY(0) scale(1);
            }
            100% {
                opacity: 0;
                transform: translateX(-50%) translateY(-100px) scale(0.8);
                visibility: hidden;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
    <div class="container">
        <a class="navbar-brand" href="Dashboard.jsp"><i class="fa-solid fa-store"></i> Seller ERP</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="Dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="products"><i class="fa-solid fa-box-open"></i> Products</a></li>
                <li class="nav-item"><a class="nav-link active" href="manage_orders?action=view"><i class="fa-solid fa-truck-fast"></i> Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="reports"><i class="fa-solid fa-flag"></i> Reports</a></li>
                <li class="nav-item"><a class="nav-link" href="ProfileServlet"><i class="fa-solid fa-user-gear"></i> Profile</a></li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="nav-link text-white me-3">
                        <i class="fa-solid fa-user"></i> 
                        Welcome, <strong>${user.name}</strong>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-logout" href="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Success Message Popup -->
<c:if test="${not empty sessionScope.successMessage}">
    <div class="success-popup">
        <i class="fa-solid fa-check-circle"></i> ${sessionScope.successMessage}
    </div>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<div class="container my-5 main-content">
    <div class="row justify-content-center">
        <div class="col-lg-11">
            <div class="management-container">
                <div class="management-header text-center mb-4">
                    <h2><i class="fa-solid fa-truck-fast"></i> Order Management</h2>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty param.error}">
                    <div class="error-message">
                        <i class="fa-solid fa-exclamation-circle me-2"></i>${param.error}
                    </div>
                </c:if>

                <!-- Edit/Create Order Form -->
                <c:if test="${not empty order}">
                    <div class="card mb-4 border-0 bg-light p-4 rounded-3">
                        <h4 class="mb-3">
                            <c:if test="${order.order_id > 0}">
                                <i class="fa-solid fa-pen-to-square"></i> Update Order #${order.order_id}
                            </c:if>
                            <c:if test="${order.order_id == 0}">
                                <i class="fa-solid fa-plus-circle"></i> Create New Order
                            </c:if>
                        </h4>
                        <form action="manage_orders" method="post">
                            <input type="hidden" name="order_id" value="${order.order_id}">
                            <c:if test="${order.order_id == 0}">
                                <div class="mb-3">
                                    <label for="buyer_id" class="form-label fw-bold">Buyer ID</label>
                                    <input type="text" class="form-control" id="buyer_id" name="buyer_id" required>
                                </div>
                            </c:if>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="total_amount" class="form-label fw-bold">Total Amount</label>
                                    <input type="number" step="0.01" class="form-control" id="total_amount" name="total_amount" value="${order.total_amount}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="status" class="form-label fw-bold">Status</label>
                                    <select class="form-select" id="status" name="status">
                                        <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                                        <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Shipped</option>
                                        <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Delivered</option>
                                        <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="delivery_address" class="form-label fw-bold">Delivery Address</label>
                                <input type="text" class="form-control" id="delivery_address" name="delivery_address" value="${order.delivery_address}" required>
                            </div>
                            <button type="submit" class="btn btn-custom rounded-pill"><i class="fa-solid fa-save"></i> Save Changes</button>
                            <a href="manage_orders?action=view" class="btn btn-secondary-custom rounded-pill">Cancel</a>
                        </form>
                    </div>
                </c:if>

                <!-- Filter Section -->
                <div class="card mb-4 border-0">
                    <div class="card-body bg-light rounded-3 d-flex align-items-center justify-content-start">
                        <form action="manage_orders" method="get" class="row g-3 align-items-center">
                            <input type="hidden" name="action" value="view">
                            <div class="col-auto">
                                <label for="status_filter" class="form-label fw-bold mb-0">Filter by Status:</label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" id="status_filter" name="status_filter">
                                    <option value="All" ${selectedStatus == 'All' ? 'selected' : ''}>All</option>
                                    <option value="pending" ${selectedStatus == 'pending' ? 'selected' : ''}>Pending</option>
                                    <option value="shipped" ${selectedStatus == 'shipped' ? 'selected' : ''}>Shipped</option>
                                    <option value="delivered" ${selectedStatus == 'delivered' ? 'selected' : ''}>Delivered</option>
                                    <option value="cancelled" ${selectedStatus == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-custom">Show</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Orders Table -->
                <div class="card border-0">
                    <div class="card-header bg-transparent border-bottom-0 ps-0">
                        <h4 class="mb-0"><i class="fa-solid fa-list-ul"></i> All Orders</h4>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-hover text-center align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Buyer ID</th>
                                        <th>Order Date</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Delivery Address</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty orderList}">
                                        <tr>
                                            <td colspan="7">
                                                <div class="no-orders-message">
                                                    <p class="mb-0">No orders found.</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="currentOrder" items="${orderList}">
                                        <tr>
                                            <td>${currentOrder.order_id}</td>
                                            <td>${currentOrder.buyer_id}</td>
                                            <td>${currentOrder.order_date}</td>
                                            <td>$${currentOrder.total_amount}</td>
                                            <td>${currentOrder.status}</td>
                                            <td>${currentOrder.delivery_address}</td>
                                            <td>
                                                <a href="manage_orders?action=edit&id=${currentOrder.order_id}" 
                                                   class="btn btn-custom btn-sm rounded-pill">Update</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="container text-center">
        <p class="mb-0">&copy; 2025 Import-Export ERP System. All Rights Reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>