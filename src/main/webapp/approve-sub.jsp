<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.lpg.util.DBConnection" %>
<%
    String idStr = request.getParameter("id");
    
    if (idStr != null) {
        try (Connection conn = DBConnection.getConnection()) {
            String updateSql = "UPDATE subscriptions SET status = 'Approved', "
                             + "start_date = CURRENT_DATE, "
                             + "end_date = DATE_ADD(CURRENT_DATE, INTERVAL 1 MONTH) "
                             + "WHERE id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setInt(1, Integer.parseInt(idStr));
            updateStmt.executeUpdate();
            updateStmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    response.sendRedirect("admin-manage.jsp");
%>