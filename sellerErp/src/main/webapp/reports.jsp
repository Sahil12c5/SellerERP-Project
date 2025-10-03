<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.UserPojo" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
   
    UserPojo user = (UserPojo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+log+in+to+view+reports");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F5DC; 
            min-height: 100vh;
            padding-top: 5rem;
            display: flex;
            flex-direction: column;
            margin: 0;
        }
        .main-content {
            flex: 1;
        }
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
        .btn-custom { 
            background-color: #FF8C00; 
            border: none; 
            color: white; 
            font-weight: 600; 
            padding: 0.6rem 1.2rem; 
            transition: background-color 0.3s ease; 
        }
        .btn-custom:hover { 
            background-color: #E57A00; 
            color: white; 
        }
        .table thead th { 
            background-color: #001f3f; 
            font-weight: 600; 
            color: #F5F5DC; 
            vertical-align: middle; 
        }
        .table tbody td { 
            vertical-align: middle; 
            color: #36454F; 
        }
        .table-hover tbody tr:hover { 
            background-color: rgba(0, 31, 63, 0.05); 
        }
        .status-badge { 
            padding: 0.4em 0.7em; 
            border-radius: 50px; 
            font-size: 0.8rem; 
            font-weight: 600; 
            text-transform: capitalize; 
        }
        .status-open { 
            background-color: #f8d7da; 
            color: #721c24; 
        }
        .status-resolved { 
            background-color: #d4edda; 
            color: #155724; 
        }
        .message { 
            font-weight: 500; 
            font-size: 0.95rem; 
            padding: 1rem; 
            border-radius: 8px; 
            text-align: center; 
            width: 100%; 
            margin-bottom: 1.5rem; 
        }
        .success { 
            color: #155724; 
            background-color: #d4edda; 
        }
        .error { 
            color: #721c24; 
            background-color: #f8d7da; 
        }
        .footer {
            background-color: #001f3f;
            color: #F5F5DC; 
            padding: 2rem 0;
            margin-top: 4rem;
        }

   
        .btn-outline-primary {
            color: #001f3f !important;     
            border-color: #001f3f;
        }
        .btn-outline-warning {
            color: #8B4513 !important;    
            border-color: #FF8C00;
        }
        .btn-outline-success {
            color: #006400 !important;     
            border-color: #28a745;
        }

      
        .btn-primary, .btn-warning, .btn-success {
            color: white !important;
        }

  
        .btn-group .btn {
            font-weight: 500;
            transition: all 0.2s ease;
        }
        
   
        .popup {
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
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            animation: popupAnimation 3s ease-in-out forwards;
        }
        
        .popup.success {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        
        .popup.error {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        
        .popup i {
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
        
    </style>
</head>
<body>

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
                <li class="nav-item"><a class="nav-link active" href="reports"><i class="fa-solid fa-flag"></i> Reports</a></li>
                <li class="nav-item"><a class="nav-link" href="update_profile.jsp"><i class="fa-solid fa-user-gear"></i> Profile</a></li>
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

<% if (request.getParameter("msg") != null) { %>
    <div class="popup success">
        <i class="fa-solid fa-check-circle"></i> <%= request.getParameter("msg") %>
    </div>
<% } %>

<% if (request.getParameter("error") != null) { %>
    <div class="popup error">
        <i class="fa-solid fa-exclamation-circle"></i> <%= request.getParameter("error") %>
    </div>
<% } %>

<div class="container my-5 main-content">
    <div class="row justify-content-center">
        <div class="col-lg-11">
            <div class="management-container">
                <div class="management-header text-center mb-4">
                    <h2><i class="fa-solid fa-flag"></i> Report Management</h2>
                </div>

                <div class="text-center mb-4">
                    <p class="d-inline-block me-3 mb-0 fw-bold" style="color: #001f3f; font-size: 1.1rem;">Filter By Status:</p>
                    <div class="btn-group" role="group" aria-label="Filter by status">
                        <a href="reports?status_filter=All" 
                           class="btn ${selectedStatus == 'All' ? 'btn-primary text-white' : 'btn-outline-primary text-dark'} btn-sm rounded-pill px-4 py-2 me-2">
                            <i class="fa-solid fa-list-check"></i> All
                        </a>
                        <a href="reports?status_filter=open" 
                           class="btn ${selectedStatus == 'open' ? 'btn-warning text-white' : 'btn-outline-warning text-dark'} btn-sm rounded-pill px-4 py-2 me-2">
                            <i class="fa-solid fa-circle-exclamation"></i> Open
                        </a>
                        <a href="reports?status_filter=resolved" 
                           class="btn ${selectedStatus == 'resolved' ? 'btn-success text-white' : 'btn-outline-success text-dark'} btn-sm rounded-pill px-4 py-2">
                            <i class="fa-solid fa-check-circle"></i> Resolved
                        </a>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center">
                        <thead>
                            <tr>
                                <th>Report ID</th>
                                <th>Product ID</th>
                                <th>Reporter ID</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="report" items="${reportList}">
                                <tr>
                                    <td>${report.reportId}</td>
                                    <td>${report.productId}</td>
                                    <td>${report.reporterId}</td>
                                    <td>${report.reason}</td>
                                    <td>
                                        <span class="status-badge ${report.status == 'open' ? 'status-open' : 'status-resolved'}">
                                            ${report.status}
                                        </span>
                                    </td>
                                    <td>
                                        <form action="reports" method="post" class="d-flex justify-content-center align-items-center gap-2">
                                            <input type="hidden" name="reportId" value="${report.reportId}">
                                            <input type="hidden" name="action" value="update">
                                            <select name="status" class="form-select form-select-sm w-auto">
                                                <option value="open" ${report.status == 'open' ? 'selected' : ''}>Open</option>
                                                <option value="resolved" ${report.status == 'resolved' ? 'selected' : ''}>Resolved</option>
                                            </select>
                                            <button type="submit" class="btn btn-custom btn-sm">Update</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reportList}">
                                <tr>
                                    <td colspan="6" class="text-center p-4">No reports found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
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