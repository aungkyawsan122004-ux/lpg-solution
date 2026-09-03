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

@WebServlet("/SubscribeServlet")
public class SubscribeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String userName = request.getParameter("userName");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");
        String transactionNo = request.getParameter("transactionNo");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO subscriptions (user_name, phone, payment_method, transaction_no) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.setString(2, phone);
            pstmt.setString(3, paymentMethod);
            pstmt.setString(4, transactionNo);

            pstmt.executeUpdate();
            pstmt.close();
            
            response.getWriter().println("<script>" +
                    "alert('VIP လျှောက်လွှာ ပေးပို့မှု အောင်မြင်ပါသည်။ Admin အဖွဲ့မှ ငွေလွှဲချက် စစ်ဆေးပြီးပါက VIP အဖြစ် အတည်ပြုပေးပါမည်။');" +
                    "window.location.href='index.jsp';" +
                    "</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}