<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login as a Seller</title>
  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
       
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F5DC; 
            color: #36454F;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 1rem 0; 
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.95); 
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid #E0E0E0;
        }

        .login-header h2 {
            font-weight: 600;
            color: #001f3f;
        }

        .login-header p {
            color: #36454F; 
        }

        .form-control:focus {
            border-color: #FF8C00; 
            box-shadow: 0 0 0 0.25rem rgba(255, 140, 0, 0.25);
        }

        .btn-login {
            background-color: #FF8C00; 
            border: none;
            font-weight: 600;
            padding: 0.75rem;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #E57A00; 
        }

        .signup-link {
            font-size: 0.9rem;
            color: #36454F; 
        }

        .signup-link a {
            color: #FF8C00; 
            font-weight: 600;
            text-decoration: none;
        }
        
        .signup-link a:hover {
            text-decoration: underline;
        }
        
        .welcome-section {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: #F5F5DC; 
            background-color: #001f3f; 
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            height: 100%; 
        }
        
        .welcome-section i {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            color: #FF8C00; 
        }

        
        @media (max-width: 992px) {
            .welcome-section {
            
                display: none;
            }
        }
        @media (max-width: 768px) {
            .login-container {
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
                <h1>Welcome Back!</h1>
                <p class="lead mt-3">Log in to manage your store, products, and orders. We're glad to see you again.</p>
            </div>
        </div>

        
        <div class="col-lg-6 col-md-8 col-12">
            <div class="login-container">
                <div class="login-header text-center mb-4">
                    <h2>Seller Log In</h2>
                    <p>Please enter your credentials to access your dashboard.</p>
                </div>

                <%-- Display success message passed from RegistrationServlet --%>
                <% if (request.getAttribute("successMessage") != null) { %>
                    <div class="alert alert-success" role="alert">
                        <%= request.getAttribute("successMessage") %>
                    </div>
                <% } %>
                
                <form action="login" method="post">
                    <div class="mb-3">
                        <label for="port_id" class="form-label">Unique Port ID</label>
                        <input type="text" name="port_id" id="port_id" class="form-control" minlength="4" maxlength="64" placeholder="Enter your Port ID" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" name="password" id="password" class="form-control" minlength="8" maxlength="64" placeholder="Enter your password" required>
                    </div>

                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-primary btn-login">Log In</button>
                    </div>
                </form>

             
                <c:if test="${not empty param.msg}">
                    <div class="alert alert-danger mt-3 text-center">
                        ${param.msg}
                    </div>
                </c:if>

                <div class="text-center mt-4">
                    <p class="signup-link">Don't have an account? <a href="Registration.jsp">Sign Up Here</a></p>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
