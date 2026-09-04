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

@WebServlet("/AddContentServlet")
public class AddContentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String category = request.getParameter("category");
        String badgeType = request.getParameter("badgeType");
        String imageUrl = request.getParameter("imageUrl"); // ပုံလင့်ခ်ကို လက်ခံရယူခြင်း
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String contentBody = request.getParameter("contentBody");

        try (Connection conn = DBConnection.getConnection()) {
            // SQL Query ထဲသို့ image_url ထည့်သွင်းခြင်း
            String sql = "INSERT INTO contents (category, badge_type, image_url, title, description, content_body) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category);
            pstmt.setString(2, badgeType);
            pstmt.setString(3, imageUrl);
            pstmt.setString(4, title);
            pstmt.setString(5, description);
            pstmt.setString(6, contentBody);

            pstmt.executeUpdate();
            pstmt.close();
            
            // တင်ပြီးပါက admin-manage.jsp သို့ ပြန်ညွှန်းမည်
            response.sendRedirect(request.getContextPath() + "/admin-manage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
