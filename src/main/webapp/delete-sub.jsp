<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.lpg.util.DBConnection" %>
<%
    // URL ကနေ id ကို လက်ခံမည်
    String idStr = request.getParameter("id");
    
    if (idStr != null) {
        try (Connection conn = DBConnection.getConnection()) {
            // Database ထဲက သက်ဆိုင်ရာ VIP Data ကို တိုက်ရိုက် ဖျက်မည်
            String sql = "DELETE FROM subscriptions WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(idStr));
            pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ဖျက်ပြီးပါက admin-manage.jsp သို့ ပြန်ညွှန်းမည်
    response.sendRedirect("admin-manage.jsp");
%>