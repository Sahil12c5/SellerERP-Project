package models;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;

import db_config.GetConnection; 


public class OrderManagement_pojo {

    private int order_id;
    private String buyer_id;
    private String seller_port_id;
    private Timestamp order_date;
    private BigDecimal total_amount;
    private String status;
    private String delivery_address;

   
    public int getOrder_id() {
        return order_id;
    }
    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }
    public String getBuyer_id() {
        return buyer_id;
    }
    public void setBuyer_id(String buyer_id) {
        this.buyer_id = buyer_id;
    }
    public String getSeller_port_id() {
        return seller_port_id;
    }
    public void setSeller_port_id(String seller_port_id) {
        this.seller_port_id = seller_port_id;
    }
    public Timestamp getOrder_date() {
        return order_date;
    }
    public void setOrder_date(Timestamp order_date) {
        this.order_date = order_date;
    }
    public BigDecimal getTotal_amount() {
        return total_amount;
    }
    public void setTotal_amount(BigDecimal total_amount) {
        this.total_amount = total_amount;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getDelivery_address() {
        return delivery_address;
    }
    public void setDelivery_address(String delivery_address) {
        this.delivery_address = delivery_address;
    }

    public void insertOrder() throws Exception {
  
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO orders (buyer_id, seller_port_id, total_amount, status, delivery_address) VALUES (?, ?, ?, ?, ?)")) {
            ps.setString(1, this.buyer_id);
            ps.setString(2, this.seller_port_id);
            ps.setBigDecimal(3, this.total_amount);
            ps.setString(4, this.status);
            ps.setString(5, this.delivery_address);
            ps.executeUpdate();
        }
    }

   
    public void updateOrder() throws Exception {
        
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE orders SET status = ?, delivery_address = ?, total_amount = ? WHERE order_id = ?")) {
            ps.setString(1, this.status);
            ps.setString(2, this.delivery_address);
            ps.setBigDecimal(3, this.total_amount);
            ps.setInt(4, this.order_id);
            ps.executeUpdate();
        }
    }

   
    public static List<OrderManagement_pojo> getAllOrdersBySeller(String sellerPortId, String statusFilter) throws Exception {
        List<OrderManagement_pojo> orderList = new ArrayList<>();
        
     
        StringBuilder sql = new StringBuilder("SELECT * FROM orders WHERE seller_port_id = ?");
        
   
        boolean hasFilter = statusFilter != null && !statusFilter.isEmpty() && !"All".equalsIgnoreCase(statusFilter);
        if (hasFilter) {
            sql.append(" AND status = ?");
        }
        sql.append(" ORDER BY order_date DESC");

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            ps.setString(1, sellerPortId);
            
         
            if (hasFilter) {
                ps.setString(2, statusFilter);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderManagement_pojo order = new OrderManagement_pojo();
                    order.setOrder_id(rs.getInt("order_id"));
                    order.setBuyer_id(rs.getString("buyer_id"));
                    order.setSeller_port_id(rs.getString("seller_port_id"));
                    order.setOrder_date(rs.getTimestamp("order_date"));
                    order.setTotal_amount(rs.getBigDecimal("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setDelivery_address(rs.getString("delivery_address"));
                    orderList.add(order);
                }
            }
        }
        return orderList;
    }
    
    
    public static OrderManagement_pojo getOrderById(int id) throws Exception {
        OrderManagement_pojo order = null;
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM orders WHERE order_id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new OrderManagement_pojo();
                    order.setOrder_id(rs.getInt("order_id"));
                    order.setBuyer_id(rs.getString("buyer_id"));
                    order.setSeller_port_id(rs.getString("seller_port_id"));
                    order.setOrder_date(rs.getTimestamp("order_date"));
                    order.setTotal_amount(rs.getBigDecimal("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setDelivery_address(rs.getString("delivery_address"));
                }
            }
        }
        return order;
    }
}
