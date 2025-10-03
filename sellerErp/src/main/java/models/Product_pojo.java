package models;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db_config.GetConnection;

public class Product_pojo {
    private int product_id;
    private String seller_port_id;
    private String product_name;
    private String description;
    private int quantity;
    private BigDecimal price;
    private Timestamp created_at;
    private Timestamp updated_at;

   
    public int getProduct_id() { return product_id; }
    public void setProduct_id(int product_id) { this.product_id = product_id; }
    public String getSeller_port_id() { return seller_port_id; }
    public void setSeller_port_id(String seller_port_id) { this.seller_port_id = seller_port_id; }
    public String getProduct_name() { return product_name; }
    public void setProduct_name(String product_name) { this.product_name = product_name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Timestamp getCreated_at() { return created_at; }
    public void setCreated_at(Timestamp created_at) { this.created_at = created_at; }
    public Timestamp getUpdated_at() { return updated_at; }
    public void setUpdated_at(Timestamp updated_at) { this.updated_at = updated_at; }


    public boolean add() throws SQLException {
       
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO product (seller_port_id, product_name, description, quantity, price) VALUES (?, ?, ?, ?, ?)")) {
            
            ps.setString(1, seller_port_id);
            ps.setString(2, product_name);
            ps.setString(3, description);
            ps.setInt(4, quantity);
            ps.setBigDecimal(5, price);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean update() throws SQLException {
       
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE product SET product_name=?, description=?, quantity=?, price=?, updated_at=? WHERE product_id=?")) {
            
            ps.setString(1, product_name);
            ps.setString(2, description);
            ps.setInt(3, quantity);
            ps.setBigDecimal(4, price);
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            ps.setInt(6, product_id);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete() throws SQLException {
        String sql = "DELETE FROM product WHERE product_id=?";
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, product_id);

            return ps.executeUpdate() > 0;
        }
    }

    public static Product_pojo getById(int productId) throws SQLException {
        Product_pojo p = null;
     
        
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE product_id=?")) {
            
            ps.setInt(1, productId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Product_pojo();
                    p.setProduct_id(rs.getInt("product_id"));
                    p.setSeller_port_id(rs.getString("seller_port_id"));
                    p.setProduct_name(rs.getString("product_name"));
                    p.setDescription(rs.getString("description"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setPrice(rs.getBigDecimal("price"));
                    p.setCreated_at(rs.getTimestamp("created_at"));
                    p.setUpdated_at(rs.getTimestamp("updated_at"));
                }
            }
        }
        return p;
    }

    // New method to retrieve all products for a specific seller
    public static List<Product_pojo> getAllProductsBySeller(String sellerPortId) throws SQLException {
        List<Product_pojo> productList = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE seller_port_id = ?";
        
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, sellerPortId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product_pojo p = new Product_pojo();
                    p.setProduct_id(rs.getInt("product_id"));
                    p.setSeller_port_id(rs.getString("seller_port_id"));
                    p.setProduct_name(rs.getString("product_name"));
                    p.setDescription(rs.getString("description"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setPrice(rs.getBigDecimal("price"));
                    p.setCreated_at(rs.getTimestamp("created_at"));
                    p.setUpdated_at(rs.getTimestamp("updated_at"));
                    productList.add(p);
                }
            }
        }
        return productList;
    }
}