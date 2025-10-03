<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to the Import-Export ERP</title>
    
    <!-- Bootstrap and Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        /* Color Palette: Beige, Orange, Charcoal, Navy Blue */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F5DC; /* Soft Beige background to match dashboard */
            color: #36454F; /* Charcoal gray for general text */
        }
        .navbar-custom {
            background-color: #001f3f; /* Deep Navy Blue to match dashboard */
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .navbar-brand, .nav-link {
            font-weight: 700;
            color: #F5F5DC !important; /* Beige text for contrast */
        }
        .btn-login {
            background-color: #FF8C00; /* Vibrant Orange to match dashboard */
            color: white !important;
            border-radius: 50px;
            padding: 0.5rem 1.5rem !important;
            transition: background-color 0.3s ease;
        }
        .btn-login:hover {
            background-color: #E57A00;
        }
        
        /* Hero Section */
        .hero-section {
            padding: 10rem 0;
            text-align: center;
        }
        .hero-section h1 {
            font-weight: 700;
            font-size: 3.5rem;
            color: #001f3f; 
            text-shadow: none;
        }
        .hero-section .lead {
            font-size: 1.25rem;
            max-width: 600px;
            margin: 1.5rem auto;
            color: #36454F; /* Charcoal gray for readability */
        }
        .btn-hero-primary {
            background-color: #FF8C00;
            color: #fff;
            font-weight: 600;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-hero-primary:hover {
            background-color: #E57A00;
            transform: translateY(-2px);
        }
        .btn-hero-secondary {
            background-color: transparent;
            color: #FF8C00;
            font-weight: 600;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            border: 2px solid #FF8C00;
            transition: all 0.3s ease;
        }
        .btn-hero-secondary:hover {
            background-color: #FF8C00;
            color: #fff;
        }

        /* Features Section */
        .features-section {
            padding: 4rem 0;
            background-color: #F8F8F0; /* Slightly different beige for section background */
        }
        .feature-card {
            background-color: #fff;
            color: #36454F; /* Charcoal text */
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.04);
            text-align: center;
            height: 100%;
            transition: transform 0.3s ease;
            border: 1px solid #E0E0E0;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }
        .feature-icon {
            font-size: 3rem;
            color: #FF8C00; /* Vibrant Orange icon */
            margin-bottom: 1.5rem;
        }
        .feature-card h4 {
            font-weight: 600;
            margin-bottom: 1rem;
            color: #001f3f; /* Navy Blue title */
        }
        
        /* Footer */
        .footer {
            background-color: #001f3f; /* Deep Navy Blue to match dashboard */
            color: #F5F5DC; /* Beige text */
            padding: 2rem 0;
            margin-top: 4rem;
        }
    </style>
</head>
<body>

<!-- Public Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="fa-solid fa-store"></i> Seller ERP
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#publicNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="publicNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="Registration.jsp">Register</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-login" href="login.jsp">Seller Login</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero-section">
    <div class="container">
        <h1 class="display-4">Empower Your Global Trade</h1>
        <p class="lead">
            An all-in-one ERP solution designed for the modern import-export business. Manage products, track orders, and streamline your operations with ease.
        </p>
        <div class="d-flex justify-content-center gap-3 mt-4">
            <a href="Registration.jsp" class="btn-hero-primary">Get Started for Free</a>
            <a href="login.jsp" class="btn-hero-secondary">Seller Login</a>
        </div>
    </div>
</div>

<!-- Features Section -->
<div class="features-section">
    <div class="container">
        <div class="row g-4 justify-content-center">
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fa-solid fa-box-open feature-icon"></i>
                    <h4>Product Management</h4>
                    <p>Effortlessly add, update, and manage your entire product catalog with our intuitive inventory system.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fa-solid fa-truck-fast feature-icon"></i>
                    <h4>Order Tracking</h4>
                    <p>Keep a close eye on all your orders, from initial placement to final delivery, all in one place.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fa-solid fa-shield-halved feature-icon"></i>
                    <h4>Secure & Reliable</h4>
                    <p>Built on a secure and scalable platform to ensure your business data is always safe and accessible.</p>
                </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
