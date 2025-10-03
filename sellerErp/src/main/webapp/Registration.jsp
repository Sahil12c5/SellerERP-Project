<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join as a Seller</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* Color Palette: Beige, Orange, Charcoal, Navy Blue */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F5DC; /* Soft Beige background to match dashboard */
            color: #36454F; /* Charcoal gray for general text */
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 1rem 0;
        }

        .registration-container {
            background-color: rgba(255, 255, 255, 0.95); /* Semi-transparent white to match dashboard container */
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.04);
            border: 1px solid #E0E0E0; /* Light Gray border */
        }

        .registration-header h2 {
            font-weight: 600;
            color: #001f3f; /* Deep Navy Blue to match dashboard headings */
        }

        .registration-header p {
            color: #36454F; /* Charcoal gray for subtext to match dashboard */
        }

        .form-control:focus {
            border-color: #FF8C00; /* Vibrant Orange for focus, consistent with dashboard buttons */
            box-shadow: 0 0 0 0.25rem rgba(255, 140, 0, 0.25);
        }

        .btn-register {
            background-color: #FF8C00; /* Vibrant Orange for button to match dashboard buttons */
            border: none;
            color: #fff;
            font-weight: 600;
            padding: 0.75rem;
            transition: background-color 0.3s ease;
        }

        .btn-register:hover {
            background-color: #E57A00; /* Darker Orange on hover, consistent with dashboard */
        }

        .login-link {
            font-size: 0.9rem;
            color: #36454F; /* Charcoal gray for text to match dashboard */
        }

        .login-link a {
            color: #FF8C00; /* Vibrant Orange for links, consistent with dashboard */
            font-weight: 600;
            text-decoration: none;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .welcome-section {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: #F5F5DC; /* Soft Beige text for contrast */
            background-color: #001f3f; /* Deep Navy Blue background to match dashboard header */
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            height: 100%; /* Ensure it fills the column height */
        }
        
        .welcome-section i {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            color: #FF8C00; /* Vibrant Orange for icon, consistent with dashboard */
        }
        
        @media (max-width: 992px) {
            .welcome-section {
                display: none;
            }
        }
        @media (max-width: 768px) {
            .registration-container {
                padding: 1.5rem;
            }
             body {
                align-items: flex-start;
                padding-top: 2rem;
            }
        }
    </style>
</head>
<body>

<div class="container my-auto">
    <div class="row align-items-center justify-content-center">

        <div class="col-lg-5">
            <div class="welcome-section">
                <i class="fa-solid fa-store"></i>
                <h1>Welcome, Future Seller!</h1>
                <p class="lead mt-3">Join our platform and connect with millions of customers. We provide the tools you need to grow your business.</p>
            </div>
        </div>

        <div class="col-lg-6 col-md-8 col-12">
            <div class="registration-container">
                <div class="registration-header text-center mb-4">
                    <h2>Create Your Seller Account</h2>
                    <p>Let's get you set up so you can start selling.</p>
                </div>
                
            
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>
                
                
                <% if (request.getAttribute("successMessage") != null) { %>
                    <div class="alert alert-success" role="alert">
                        <%= request.getAttribute("successMessage") %>
                    </div>
                <% } %>
                

                <form action="register" method="post">
                    <div class="mb-3">
                        <label for="portId" class="form-label">Unique Port ID</label>
                        <input type="text" name="portId" id="portId" class="form-control" minlength="4" maxlength="64"placeholder="e.g., seller123" required>
                    </div>

                    <div class="mb-3">
                        <label for="name" class="form-label"> Name</label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="Enter your business or personal name" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label"> Email</label>
                        <input type="email" name="email" id="email" class="form-control" placeholder="contact@domain.com" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label"> Password</label>
                        <input type="password" name="password" id="password" class="form-control" minlength="8" maxlength="64" placeholder="Minimum 8 characters" required>
                    </div>

                    <div class="mb-3">
                        <label for="location" class="form-label"> Location</label>
                        <input type="text" name="location" id="location" class="form-control" placeholder="e.g., Pune, India">
                    </div>

                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-primary btn-register">Create Account</button>
                    </div>
                </form>

                <div class="text-center mt-4">
                    <p class="login-link">Already a member? <a href="login.jsp">Log In Now</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
