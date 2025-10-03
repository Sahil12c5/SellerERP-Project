<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, models.Product_pojo, models.UserPojo" %>
<%
    // 🔐 Session-based authentication using UserPojo object
    UserPojo user = (UserPojo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+log+in+to+manage+products");
        return;
    }

    // Extract port_id from authenticated user
    String sellerPortId = user.getPortId();

    // Data from servlet
    List<Product_pojo> productList = (List<Product_pojo>) request.getAttribute("productList");
    Product_pojo editProduct = (Product_pojo) request.getAttribute("editProduct");

    // Handle flash messages (session-scoped)
    String flash = (String) session.getAttribute("flash");
    if (flash != null) {
        session.removeAttribute("flash");
    }
%>

<%!
    // Utility method to escape HTML for safety
    public static String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "<")
                .replace(">", ">")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    
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
        .main-content { 
            flex: 1; 
        }
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
            padding: 0.75rem; 
            transition: background-color 0.3s ease; 
        }
        .btn-custom:hover { 
            background-color: #E57A00; 
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            color: white;
            font-weight: 600;
            padding: 0.75rem;
            transition: background-color 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }
        .table thead th { 
            background-color: #001f3f; /* Deep Navy Blue */
            font-weight: 600; 
            color: #F5F5DC; /* Beige text */
        }
        .table-hover tbody tr:hover { 
            background-color: rgba(0, 31, 63, 0.05); /* Navy Blue hover effect */
        }
        .btn-primary {
            background-color: #FF8C00;
            border-color: #FF8C00;
        }
        .btn-primary:hover {
            background-color: #E57A00;
            border-color: #E57A00;
        }
        .btn-danger {
            background-color: #DC3545;
            border-color: #DC3545;
        }
        .btn-danger:hover {
            background-color: #C82333;
            border-color: #C82333;
        }
        
        /* Action buttons spacing */
        .action-buttons {
            display: flex;
            gap: 0.75rem; /* Add spacing between buttons */
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
        <a class="navbar-brand" href="Dashboard.jsp"><i class="fa-solid fa-store"></i> Seller ERP</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="Dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="products"><i class="fa-solid fa-box-open"></i> Products</a></li>
                <li class="nav-item"><a class="nav-link" href="manage_orders?action=view"><i class="fa-solid fa-truck-fast"></i> Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="reports?status=all"><i class="fa-solid fa-flag"></i> Reports</a></li>
                <li class="nav-item"><a class="nav-link" href="update_profile.jsp"><i class="fa-solid fa-user-gear"></i> Profile</a></li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="nav-link text-white me-3">
                        <i class="fa-solid fa-user"></i> 
                        Welcome, <strong><%= escapeHtml(user.getName()) %></strong>
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
<% if (flash != null) { %>
    <div class="success-popup">
        <i class="fa-solid fa-check-circle"></i> <%= escapeHtml(flash) %>
    </div>
<% } %>
<% if (request.getParameter("msg") != null) { %>
    <div class="success-popup">
        <i class="fa-solid fa-check-circle"></i> <%= escapeHtml(request.getParameter("msg")) %>
    </div>
<% } %>

<div class="container my-5 main-content">
    <div class="row justify-content-center">
        <div class="col-lg-11">
            <div class="management-container">
                <div class="management-header text-center mb-4">
                    <h2><i class="fa-solid fa-box-open"></i> Product Management</h2>
                </div>

                <!-- Error messages (non-popup, stay on page) -->
                <% if (request.getParameter("error") != null) { %>
                    <div class="error-message">
                        <i class="fa-solid fa-exclamation-circle me-2"></i><%= escapeHtml(request.getParameter("error")) %>
                    </div>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <i class="fa-solid fa-exclamation-circle me-2"></i><%= escapeHtml((String) request.getAttribute("error")) %>
                    </div>
                <% } %>

                <div class="row g-5">
                    <div class="col-lg-4">
                        <h4 class="mb-3" id="form-title">
                            <% if (editProduct != null) { %>
                                <i class="fa-solid fa-pen-to-square"></i> Edit Product #<%= editProduct.getProduct_id() %>
                            <% } else { %>
                                <i class="fa-solid fa-plus-circle"></i> Add New Product
                            <% } %>
                        </h4>
                        <form action="products" method="post">
                            <input type="hidden" name="action" value="<%= (editProduct != null) ? "update" : "add" %>">
                            <input type="hidden" name="product_id" value="<%= (editProduct != null) ? editProduct.getProduct_id() : "" %>">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Product Name</label>
                                <input type="text" name="product_name" class="form-control" value="<%= (editProduct != null) ? escapeHtml(editProduct.getProduct_name()) : "" %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Description</label>
                                <textarea name="description" class="form-control" rows="3" required><%= (editProduct != null) ? escapeHtml(editProduct.getDescription()) : "" %></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Quantity</label>
                                    <input type="number" name="quantity" class="form-control" value="<%= (editProduct != null) ? editProduct.getQuantity() : "" %>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Price</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" name="price" class="form-control" value="<%= (editProduct != null) ? editProduct.getPrice() : "" %>" required>
                                    </div>
                                </div>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-custom">
                                    <%= (editProduct != null) ? "Update Product" : "Add Product" %>
                                </button>
                                <% if (editProduct != null) { %>
                                    <a href="products" class="btn btn-secondary">Cancel Edit</a>
                                <% } %>
                            </div>
                        </form>
                    </div>

                    <div class="col-lg-8">
                        <h4 class="mb-3"><i class="fa-solid fa-list-ul"></i> Your Products</h4>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Created Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (productList != null && !productList.isEmpty()) {
                                            for (Product_pojo p : productList) {
                                    %>
                                        <tr>
                                            <td><%= p.getProduct_id() %></td>
                                            <td><%= escapeHtml(p.getProduct_name()) %></td>
                                            <td><%= escapeHtml(p.getDescription()) %></td>
                                            <td><%= p.getQuantity() %></td>
                                            <td>$<%= p.getPrice() %></td>
                                            <td><%= p.getCreated_at() %></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <form action="products" method="get">
                                                        <input type="hidden" name="action" value="edit">
                                                        <input type="hidden" name="product_id" value="<%= p.getProduct_id() %>">
                                                        <button type="submit" class="btn btn-sm btn-primary"><i class="fa-solid fa-pencil"></i></button>
                                                    </form>
                                                    <form action="products" method="post">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="product_id" value="<%= p.getProduct_id() %>">
                                                        <button type="submit" class="btn btn-sm btn-danger"><i class="fa-solid fa-trash-can"></i></button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    <%
                                            }
                                        } else {
                                    %>
                                        <tr><td colspan="7" class="text-center p-4">You have not added any products yet.</td></tr>
                                    <% } %>
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