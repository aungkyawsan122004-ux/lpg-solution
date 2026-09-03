<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.lpg.util.DBConnection" %>
<%
    String idStr = request.getParameter("id");
    int contentId = 0;
    String title = "";
    String category = "";
    String badgeType = "";
    String description = "";
    String contentBody = "";
    
    boolean canAccess = true; // Default အနေဖြင့် ဝင်ခွင့်ရှိသည်

    if (idStr != null) {
        try {
            contentId = Integer.parseInt(idStr);
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT * FROM contents WHERE id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, contentId);
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    title = rs.getString("title");
                    category = rs.getString("category");
                    badgeType = rs.getString("badge_type");
                    description = rs.getString("description");
                    contentBody = rs.getString("content_body");
                }
                rs.close();
                pstmt.close();
                
                // အကယ်၍ Content က VIP ဖြစ်နေလျှင် User တွင် Approved ဖြစ်ပြီး သက်တမ်းမကုန်သေးသော VIP Status ရှိမရှိ စစ်ဆေးမည်
                if ("VIP".equalsIgnoreCase(badgeType)) {
                    String userPhone = (String) session.getAttribute("userPhone");
                    if (userPhone == null) {
                        canAccess = false;
                    } else {
                        // သက်တမ်း (end_date >= CURDATE()) ပါ ထည့်သွင်းစစ်ဆေးခြင်း
                        String checkVip = "SELECT * FROM subscriptions WHERE phone = ? AND status = 'Approved' AND end_date >= CURDATE()";
                        PreparedStatement pCheck = conn.prepareStatement(checkVip);
                        pCheck.setString(1, userPhone);
                        ResultSet rsVip = pCheck.executeQuery();
                        if (!rsVip.next()) {
                            canAccess = false; // VIP မဟုတ်တော့ပါ သို့မဟုတ် သက်တမ်းကုန်သွားပါက ဝင်ခွင့်မရှိ
                        }
                        rsVip.close();
                        pCheck.close();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="my">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %> - NexLPG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; color: #0f172a; }
        .detail-card { background: #ffffff; border-radius: 20px; border: 1px solid #e2e8f0; padding: 40px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); }
    </style>
</head>
<body class="py-5">
    <div class="container" style="max-width: 850px;">
        <a href="index.jsp" class="btn btn-outline-primary rounded-pill mb-4 fw-bold">
            <i class="fa-solid fa-arrow-left me-2"></i>ပင်မစာမျက်နှာသို့ ပြန်သွားရန်
        </a>

        <div class="detail-card shadow-sm">
            <% if (canAccess) { %>
                <div class="mb-3">
                    <span class="badge bg-primary px-3 py-2 rounded-pill"><%= category %></span>
                    <span class="badge <%= "VIP".equalsIgnoreCase(badgeType) ? "bg-danger" : "bg-success" %> px-3 py-2 rounded-pill"><%= badgeType %></span>
                </div>
                
                <h2 class="fw-bold mb-3 text-dark"><%= title %></h2>
                <p class="text-secondary border-start border-4 border-primary ps-3 fst-italic mb-4">
                    <%= description %>
                </p>
                <hr class="my-4">
                
                <!-- အကြောင်းအရာ အပြည့်အစုံ -->
                <div class="fs-5 text-dark" style="white-space: pre-line; line-height: 1.9;">
                    <%= contentBody != null ? contentBody : description %>
                </div>
            <% } else { %>
                <div class="text-center py-5">
                    <i class="fa-solid fa-lock text-warning display-1 mb-4"></i>
                    <h2 class="fw-bold text-danger">VIP အဖွဲ့ဝင်များသာ ကြည့်ရှုနိုင်ပါသည်</h2>
                    <p class="text-secondary mb-4">ဤသင်တန်း သို့မဟုတ် ဆောင်းပါးကို ဖတ်ရှုရန် VIP အဖွဲ့ဝင်အဖြစ် အမြန်ဆုံး လျှောက်ထားပေးပါ။</p>
                    <a href="subscribe.jsp" class="btn btn-warning fw-bold px-4 py-2 rounded-pill shadow-sm">
                        <i class="fa-solid fa-crown me-1"></i> ယခုပဲ VIP လျှောက်မည်
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>