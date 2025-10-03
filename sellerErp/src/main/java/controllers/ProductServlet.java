package controllers;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import models.Product_pojo;
import models.UserPojo;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 Get session and user object
        HttpSession session = request.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");

        if (session == null || user == null) {
            response.sendRedirect("login.jsp?msg=Please+log+in+to+manage+products");
            return;
        }

        String sellerPortId = user.getPortId(); // Get port_id from UserPojo
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("product_id");

        try {
            // Fetch all products for this seller
            List<Product_pojo> productList = Product_pojo.getAllProductsBySeller(sellerPortId);
            request.setAttribute("productList", productList);

            // Handle edit action
            if ("edit".equals(action) && productIdStr != null) {
                int productId = Integer.parseInt(productIdStr);
                Product_pojo editProduct = Product_pojo.getById(productId);

                if (editProduct != null && editProduct.getSeller_port_id().equals(sellerPortId)) {
                    request.setAttribute("editProduct", editProduct);
                } else {
                    request.setAttribute("error", "Product not found or unauthorized access.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid product ID format.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("product.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 Validate session and user
        HttpSession session = request.getSession(false);
        UserPojo user = (UserPojo) session.getAttribute("user");

        if (session == null || user == null) {
            response.sendRedirect("login.jsp?msg=Your+session+has+expired.+Please+log+in+again.");
            return;
        }

        String sellerPortId = user.getPortId();
        String action = request.getParameter("action");

        try {
            Product_pojo pojo = new Product_pojo();
            pojo.setSeller_port_id(sellerPortId);

            if ("add".equals(action) || "update".equals(action)) {
                // Extract form data
                String productName = request.getParameter("product_name");
                String description = request.getParameter("description");
                String quantityStr = request.getParameter("quantity");
                String priceStr = request.getParameter("price");

                // Validate required fields
                if (productName == null || productName.trim().isEmpty() ||
                    description == null || description.trim().isEmpty() ||
                    quantityStr == null || quantityStr.trim().isEmpty() ||
                    priceStr == null || priceStr.trim().isEmpty()) {
                    response.sendRedirect("products?error=All+fields+are+required.");
                    return;
                }

                // Parse and validate numeric values
                int quantity;
                BigDecimal price;
                try {
                    quantity = Integer.parseInt(quantityStr);
                    price = new BigDecimal(priceStr);
                    if (quantity < 0) {
                        response.sendRedirect("products?error=Quantity+cannot+be+negative.");
                        return;
                    }
                    if (price.compareTo(BigDecimal.ZERO) < 0) {
                        response.sendRedirect("products?error=Price+cannot+be+negative.");
                        return;
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("products?error=Invalid+number+format+for+Quantity+or+Price.");
                    return;
                }

                // Set product data
                pojo.setProduct_name(productName);
                pojo.setDescription(description);
                pojo.setQuantity(quantity);
                pojo.setPrice(price);

                if ("add".equals(action)) {
                    pojo.add();
                    response.sendRedirect("products?msg=Product+added+successfully");
                } else if ("update".equals(action)) {
                    int productId = Integer.parseInt(request.getParameter("product_id"));
                    Product_pojo existingProduct = Product_pojo.getById(productId);

                    if (existingProduct != null && existingProduct.getSeller_port_id().equals(sellerPortId)) {
                        pojo.setProduct_id(productId);
                        pojo.update();
                        response.sendRedirect("products?msg=Product+updated+successfully");
                    } else {
                        response.sendRedirect("products?error=Unauthorized+to+update+this+product.");
                    }
                }

            } else if ("delete".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("product_id"));
                Product_pojo existingProduct = Product_pojo.getById(productId);

                if (existingProduct != null && existingProduct.getSeller_port_id().equals(sellerPortId)) {
                    pojo.setProduct_id(productId);
                    pojo.delete();
                    response.sendRedirect("products?msg=Product+deleted+successfully");
                } else {
                    response.sendRedirect("products?error=Unauthorized+to+delete+this+product.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("products?error=A+database+error+occurred.");
        } catch (NumberFormatException e) {
            response.sendRedirect("products?error=Invalid+product+ID.");
        }
    }
}