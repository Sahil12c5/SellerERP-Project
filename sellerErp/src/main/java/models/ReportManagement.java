package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db_config.GetConnection;

public class ReportManagement {
    private int reportId;
    private int productId;
    private String reporterId;
    private String reason;
    private String status; 
    

    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getReporterId() { return reporterId; }
    public void setReporterId(String reporterId) { this.reporterId = reporterId; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

 
    public boolean insertReport() throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = GetConnection.getConnection();
            ps = con.prepareStatement(
                "INSERT INTO reported_products (product_id, reporter_id, reason, status) VALUES (?, ?, ?, ?)"
            );
            ps.setInt(1, productId);
            ps.setString(2, reporterId);
            ps.setString(3, reason);
            ps.setString(4, status);

            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error inserting report", e);
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return rowsAffected > 0;
    }


    public boolean updateReportStatus() throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = GetConnection.getConnection();
            ps = con.prepareStatement(
                "UPDATE reported_products SET status=? WHERE report_id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, reportId);

            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error updating report status", e);
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return rowsAffected > 0;
    }

    public List<ReportManagement> getReportsBySellerId(String sellerPortId) throws Exception {
        List<ReportManagement> reportList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = GetConnection.getConnection();
       
            String sql = "SELECT rp.* FROM reported_products rp JOIN product p ON rp.product_id = p.product_id WHERE p.seller_port_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, sellerPortId);
            rs = ps.executeQuery();

            while (rs.next()) {
                ReportManagement report = new ReportManagement();
                report.setReportId(rs.getInt("report_id"));
                report.setProductId(rs.getInt("product_id"));
                report.setReporterId(rs.getString("reporter_id"));
                report.setReason(rs.getString("reason"));
                report.setStatus(rs.getString("status"));
                reportList.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error fetching reports", e);
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return reportList;
    }
    


    public List<ReportManagement> getReportsBySellerIdAndStatus(String sellerPortId, String statusFilter) throws SQLException {
        String sql = "SELECT r.report_id, r.product_id, r.reporter_id, r.reason, r.status " +
                     "FROM reported_products r " +
                     "JOIN product p ON r.product_id = p.product_id " +
                     "WHERE p.seller_port_id = ?";

       
        if (statusFilter != null && !statusFilter.equalsIgnoreCase("All")) {
            sql += " AND r.status = ?";
        }

        sql += " ORDER BY r.report_id DESC";

        List<ReportManagement> reports = new ArrayList<>();
        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sellerPortId);
            if (statusFilter != null && !statusFilter.equalsIgnoreCase("All")) {
                ps.setString(2, statusFilter);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReportManagement report = new ReportManagement();
                    report.setReportId(rs.getInt("report_id"));
                    report.setProductId(rs.getInt("product_id"));
                    report.setReporterId(rs.getString("reporter_id"));
                    report.setReason(rs.getString("reason"));
                    report.setStatus(rs.getString("status"));
                    reports.add(report);
                }
            }
        }
        return reports;
    }
}
