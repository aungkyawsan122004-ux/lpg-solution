package com.lpg.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Base64;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.lpg.util.DBConnection;

@WebServlet("/AddContentServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddContentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String category = request.getParameter("category");
        String badgeType = request.getParameter("badgeType");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String contentBody = request.getParameter("contentBody");

        String imageUrl = "";

        try {
            // စက်ထဲမှ တင်လိုက်သော ပုံဖိုင်ကို ရယူခြင်း
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileContent = filePart.getInputStream();
                byte[] imageBytes = fileContent.readAllBytes();
                
                // ပုံဖိုင်ကို Base64 သို့ ပြောင်းလဲခြင်း (Cloud hosting တွင် ပုံပျောက်ဆုံးမှု မရှိစေရန်)
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                String mimeType = filePart.getContentType();
                imageUrl = "data:" + mimeType + ";base64," + base64Image;
            }

            try (Connection conn = DBConnection.getConnection()) {
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
            }

            response.sendRedirect(request.getContextPath() + "/admin-manage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
