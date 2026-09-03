package com.lpg.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.lpg.util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        if (phone != null && !phone.trim().isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                
                // ဝင်လာတဲ့ ဖုန်းနံပါတ်နှင့် ညီမျှသော User (သို့မဟုတ်) Admin ကို ရှာဖွေခြင်း
                String sql = "SELECT * FROM users WHERE phone = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, phone);
                    
                    try (ResultSet rs = pstmt.executeQuery()) {
                        HttpSession session = request.getSession();
                        
                        if (rs.next()) {
                            String role = rs.getString("role"); // ADMIN, SUBSCRIBER, FREE_USER
                            String dbName = rs.getString("full_name");
                            
                            session.setAttribute("userName", dbName != null ? dbName : name);
                            session.setAttribute("userPhone", phone);
                            
                            // Role ကို စစ်ဆေးပြီး လမ်းကြောင်းခွဲခြင်း
                            if ("ADMIN".equalsIgnoreCase(role)) {
                                session.setAttribute("isAdmin", true);
                                response.sendRedirect("admin-manage.jsp"); // Admin Panel သို့
                            } else {
                                session.setAttribute("isAdmin", false);
                                response.sendRedirect("index.jsp"); // သာမန် User Website သို့
                            }
                            return;
                        } else {
                            // Database ထဲမရှိသေးသော ဖုန်းအသစ်ဖြစ်ပါက ပုံမှန် Free User အဖြစ် သတ်မှတ်မည်
                            session.setAttribute("isAdmin", false);
                            session.setAttribute("userName", name);
                            session.setAttribute("userPhone", phone);
                            
                            response.sendRedirect("index.jsp");
                            return;
                        }
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("login.jsp?error=database_error");
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid_phone");
        }
    }
}