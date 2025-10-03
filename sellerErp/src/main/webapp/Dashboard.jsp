<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.UserPojo" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%

    UserPojo user = (UserPojo) session.getAttribute("user");
    if (user == null) {
   
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Seller Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        .btn-logout:hover { background-color: #E57A00; } 
        .dashboard-container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
        }
        .dashboard-header h1 {
            font-weight: 700;
            color: #001f3f; 
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }
        .dashboard-header p { color: #36454F; / }
        .dashboard-card {
            background: #ffffff;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 31, 63, 0.15); 
        }
        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            text-align: center;
            padding: 2rem;
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #FF8C00; 
        }
        .card-title { font-weight: 600; color: #001f3f;  margin-bottom: 0.5rem; }
        .card-text { color: #36454F;  font-size: 0.9rem; flex-grow: 1; }
        .btn-custom {
            background-color: #FF8C00; 
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-top: 1rem;
        }
        .btn-custom:hover { background-color: #E57A00; color: white; } 
        .footer {
            background-color: #001f3f;
            color: #F5F5DC; 
            padding: 2rem 0;
            margin-top: 4rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
    <div class="container">
        <a class="navbar-brand" href="Dashboard.jsp">
            <i class="fa-solid fa-store"></i> Seller ERP
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="Dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="products"><i class="fa-solid fa-box-open"></i> Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manage_orders?action=view"><i class="fa-solid fa-truck-fast"></i> Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="reports"><i class="fa-solid fa-flag"></i> Reports</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="update_profile.jsp"><i class="fa-solid fa-user-gear"></i> Profile</a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="nav-link text-white me-3">
                        <i class="fa-solid fa-user"></i> 
                        Welcome, <strong><%= user.getName() %></strong> 
                    </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-logout" href="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5 main-content">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="dashboard-container">
                <div class="dashboard-header text-center mb-5">
                    <h1><i class="fa-solid fa-chart-pie"></i> Seller Dashboard</h1>
                    <p class="lead">Manage your business operations from one central place.</p>
                </div>

                <div class="row g-4 justify-content-center">
                    <div class="col-12 col-sm-6 col-lg-5">
                        <div class="dashboard-card">
                            <div class="card-body">
                                <div>
                                    <i class="fa-solid fa-box-open card-icon"></i>
                                    <h5 class="card-title">Product Management</h5>
                                    <p class="card-text">Add new products, update inventory, and manage your catalog.</p>
                                </div>
                                <a href="products" class="btn btn-custom">Manage Products</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-5">
                        <div class="dashboard-card">
                            <div class="card-body">
                                <div>
                                    <i class="fa-solid fa-truck-fast card-icon"></i>
                                    <h5 class="card-title">Order Management</h5>
                                    <p class="card-text">View incoming orders, update status, and manage shipments.</p>
                                </div>
                                <a href="manage_orders?action=view" class="btn btn-custom">Manage Orders</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-5">
                        <div class="dashboard-card">
                            <div class="card-body">
                                <div>
                                    <i class="fa-solid fa-flag card-icon"></i>
                                    <h5 class="card-title">Reported Products</h5>
                                    <p class="card-text">Review and resolve customer reports and issues.</p>
                                </div>
                                <a href="reports" class="btn btn-custom">View Reports</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-5">
                        <div class="dashboard-card">
                            <div class="card-body">
                                <div>
                                    <i class="fa-solid fa-user-gear card-icon"></i>
                                    <h5 class="card-title">Profile Management</h5>
                                    <p class="card-text">Update company details, password, and profile settings.</p>
                                </div>
                                <a href="update_profile.jsp" class="btn btn-custom">Update Profile</a>
                            </div>
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