<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.UserPojo" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
   
    UserPojo user = (UserPojo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+log+in+to+update+your+profile");
        return;
    }

  
    String message = (String) request.getAttribute("message");
    if (message == null) {
        message = (String) session.getAttribute("flash");
        if (message != null) {
            session.removeAttribute("flash");
        }
    }
%>

<%!
   
    public static String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Management</title>

  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
   
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F7F1E3; 
            min-height: 100vh;
            padding-top: 5rem;
            display: flex;
            flex-direction: column;
            margin: 0;
        }
        .main-content { flex: 1; }
        .navbar-custom { 
            background-color: #001f3f; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
        }
        .navbar-brand, .nav-link { 
            font-weight: 700; 
            color: #F5F5DC !important; 
        }
        .nav-link.active {
            color: #FF8C00 !important;
        }
        .nav-link:hover {
            color: #FF8C00 !important;
        }
        .btn-logout { 
            background-color: #FF8C00; 
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
            color: #001f3f; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            gap: 1rem; 
        }
        h4 {
            color: #36454F; 
        }
        .form-control:focus { 
            border-color: #FF8C00; 
            box-shadow: 0 0 0 0.25rem rgba(255, 140, 0, 0.25); 
        }
        .btn-custom { 
            background-color: #FF8C00; 
            border: none; 
            color: white; 
            font-weight: 600; 
            padding: 0.75rem; 
            transition: background-color 0.3s ease; 
        }
        .btn-custom:hover { 
            background-color: #E57A00; 
        }
        .btn-danger {
            background-color: #DC3545;
            border-color: #DC3545;
        }
        .btn-danger:hover {
            background-color: #C82333;
            border-color: #C82333;
        }

      
        .nav-tabs .nav-link {
            font-weight: 600;
            border-bottom: 3px solid transparent;
            background-color: transparent;
            transition: all 0.2s ease;
        }
        .nav-tabs .nav-link:hover:not(.active) {
            color: #001f3f !important;          
            border-color: #001f3f;
            background-color: #F8F8F0;
        }
        .nav-tabs .nav-link.active {
            color: #FF8C00 !important;          
            border-color: #FF8C00;
            background-color: #FFF8E7;
        }

        
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
        
        .error-popup {
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
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            animation: popupAnimation 3s ease-in-out forwards;
        }
        
        .error-popup i {
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }
        
       
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

        .footer {
            background-color: #001f3f;
            color: #F5F5DC;
            padding: 2rem 0;
            margin-top: 4rem;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
    <div class="container">
        <a class="navbar-brand" href="Dashboard.jsp"><i class="fa-solid fa-store"></i> Seller ERP</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="Dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="products"><i class="fa-solid fa-box-open"></i> Products</a></li>
                <li class="nav-item"><a class="nav-link" href="manage_orders?action=view"><i class="fa-solid fa-truck-fast"></i> Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="reports"><i class="fa-solid fa-flag"></i> Reports</a></li>
                <li class="nav-item"><a class="nav-link active" href="ProfileServlet"><i class="fa-solid fa-user-gear"></i> Profile</a></li>
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

<!-- Success/Error Message Popups - COPIED FROM PRODUCT MANAGEMENT -->
<% if (message != null) { %>
    <% if (message.toLowerCase().contains("success")) { %>
        <div class="success-popup">
            <i class="fa-solid fa-check-circle"></i> <%= escapeHtml(message) %>
        </div>
    <% } else { %>
        <div class="error-popup">
            <i class="fa-solid fa-exclamation-triangle"></i> <%= escapeHtml(message) %>
        </div>
    <% } %>
<% } %>
<% if (request.getParameter("msg") != null) { %>
    <div class="success-popup">
        <i class="fa-solid fa-check-circle"></i> <%= escapeHtml(request.getParameter("msg")) %>
    </div>
<% } %>

<!-- Main Content -->
<div class="container my-5 main-content">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="management-container">
                <!-- Header -->
                <div class="management-header text-center mb-4">
                    <h2><i class="fa-solid fa-user-gear"></i> Profile Management</h2>
                </div>

                <!-- Tabs -->
                <ul class="nav nav-tabs nav-fill mb-4" id="profileTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="update-tab" data-bs-toggle="tab" data-bs-target="#update" type="button" role="tab">
                            Update Profile
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="password-tab" data-bs-toggle="tab" data-bs-target="#password" type="button" role="tab">
                            Change Password
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="delete-tab" data-bs-toggle="tab" data-bs-target="#delete" type="button" role="tab">
                            Delete Profile
                        </button>
                    </li>
                </ul>

                <div class="tab-content" id="profileTabsContent">
                    <!-- Update Profile Tab -->
                    <div class="tab-pane fade show active" id="update" role="tabpanel">
                        <h4 class="mb-3">Update Your Information</h4>
                        <form action="ProfileServlet" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Port ID</label>
                                <input type="text" class="form-control" value="${user.portId}" readonly>
                                <div class="form-text">Your Port ID cannot be changed.</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Name</label>
                                <input type="text" name="name" class="form-control" value="${user.name}" placeholder="Enter your full name" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Email</label>
                                <input type="email" name="email" class="form-control" value="${user.email}" placeholder="Enter your email address" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Location</label>
                                <input type="text" name="location" class="form-control" value="${user.location}" placeholder="Enter your city or location" required>
                            </div>
                            <input type="hidden" name="action" value="update">
                            <div class="d-grid">
                                <button type="submit" class="btn btn-custom rounded-pill">Update Profile</button>
                            </div>
                        </form>
                    </div>

                    <!-- Change Password Tab -->
                    <div class="tab-pane fade" id="password" role="tabpanel">
                        <h4 class="mb-3">Change Your Password</h4>
                        <form action="ProfileServlet" method="post">
                            <input type="hidden" name="portid" value="${user.portId}">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Current Password</label>
                                <input type="password" name="currentPassword" class="form-control" minlength="8" maxlength="64" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">New Password</label>
                                <input type="password" name="newPassword" class="form-control" minlength="8" maxlength="64" required>
                            </div>
                            <input type="hidden" name="action" value="changePassword">
                            <div class="d-grid">
                                <button type="submit" class="btn btn-custom rounded-pill">Change Password</button>
                            </div>
                        </form>
                    </div>

                    <!-- Delete Profile Tab -->
                    <div class="tab-pane fade" id="delete" role="tabpanel">
                        <h4 class="mb-3 text-danger">Delete Your Profile</h4>
                        <p class="text-muted">This action is irreversible. All your data will be permanently deleted.</p>
                        <button type="button" class="btn btn-danger rounded-pill" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal">
                            Delete My Account
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger" id="confirmDeleteModalLabel">
                    <i class="fa-solid fa-exclamation-triangle"></i> Confirm Account Deletion
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete your account?</p>
                <p class="text-danger"><strong>This action cannot be undone.</strong></p>
                <p>All your products, orders, and reports will be permanently removed.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form action="ProfileServlet" method="post" style="display: inline;">
                    <input type="hidden" name="portid" value="${user.portId}">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="btn btn-danger">Delete My Account</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container text-center">
        <p class="mb-0">&copy; 2025 Import-Export ERP System. All Rights Reserved.</p>
    </div>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>