package com.lpg.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.lpg.util.DBConnection;

@WebServlet("/DeleteContentServlet")
public class DeleteContentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr != null) {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "DELETE FROM contents WHERE id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(idStr));
                pstmt.executeUpdate();
                pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // ဖျက်ပြီးပါက Admin Page သို့ ပြန်ညွှန်းမည်
        response.sendRedirect(request.getContextPath() + "/admin-manage.jsp");
    }
}