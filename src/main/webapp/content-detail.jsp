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
    <title><%= !title.isEmpty() ? title : "Detail" %> - NexLPG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --brand-primary: #1f2937;
            --brand-accent: #f97316;
            --bg-earth: #f8fafc;
            --surface-white: #ffffff;
            --text-dark: #111827;
            --text-muted: #64748b;
            --border-subtle: #e2e8f0;
        }

        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-earth);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px 0;
        }

        .main-container {
            width: 100%;
            max-width: 850px;
            margin: 0 auto;
            padding: 0 15px;
        }

        .back-btn {
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--text-muted);
            background: var(--surface-white);
            border: 1px solid var(--border-subtle);
            padding: 8px 20px;
            transition: all 0.2s ease;
            box-shadow: 0 2px 6px rgba(0,0,0,0.02);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .back-btn:hover {
            background: var(--brand-primary);
            color: #fff;
            border-color: var(--brand-primary);
        }

        .detail-card {
            background: var(--surface-white);
            border-radius: 24px;
            border: 1px solid var(--border-subtle);
            padding: 45px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.04);
        }

        .badge-category {
            background-color: #e2e8f0;
            color: var(--brand-primary);
            font-weight: 700;
            font-size: 0.8rem;
            padding: 6px 16px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .badge-vip {
            background-color: #fce8e6;
            color: #c5221f;
            font-weight: 700;
            font-size: 0.8rem;
            padding: 6px 16px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .badge-free {
            background-color: #e6f4ea;
            color: #137333;
            font-weight: 700;
            font-size: 0.8rem;
            padding: 6px 16px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .content-title {
            font-weight: 800;
            color: var(--text-dark);
            font-size: 2rem;
            letter-spacing: -0.5px;
            line-height: 1.3;
        }

        .description-box {
            background-color: #f8fafc;
            border-left: 4px solid var(--brand-accent);
            padding: 20px;
            border-radius: 0 12px 12px 0;
            color: var(--text-muted);
            font-size: 1.05rem;
            font-style: italic;
        }

        .lock-icon-box {
            width: 80px;
            height: 80px;
            background: #fef3c7;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
            box-shadow: 0 10px 25px rgba(245, 158, 11, 0.15);
        }

        .lock-icon-box i {
            font-size: 2.25rem;
            color: #d97706;
        }

        .vip-action-btn {
            background-color: var(--brand-accent);
            color: #fff;
            border: none;
            padding: 14px 32px;
            border-radius: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(249, 115, 22, 0.3);
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .vip-action-btn:hover {
            background-color: #ea580c;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(249, 115, 22, 0.4);
        }
    </style>
</head>
<body>
    <div class="main-container">
        <a href="index.jsp" class="back-btn rounded-pill mb-4">
            <i class="fa-solid fa-arrow-left"></i> ပင်မစာမျက်နှာသို့ ပြန်သွားရန်
        </a>

        <div class="detail-card">
            <% if (canAccess) { %>
                <div class="d-flex align-items-center gap-2 mb-4">
                    <span class="badge-category"><%= category %></span>
                    <span class="<%= "VIP".equalsIgnoreCase(badgeType) ? "badge-vip" : "badge-free" %>">
                        <i class="<%= "VIP".equalsIgnoreCase(badgeType) ? "fa-solid fa-crown me-1 text-warning" : "fa-solid fa-check me-1" %>"></i> <%= badgeType %>
                    </span>
                </div>
                
                <h1 class="content-title mb-3"><%= title %></h1>
                
                <% if (description != null && !description.trim().isEmpty()) { %>
                    <div class="description-box mb-4">
                        <%= description %>
                    </div>
                <% } %>
                
                <hr class="my-4" style="border-color: var(--border-subtle);">
                
                <!-- အကြောင်းအရာ အပြည့်အစုံ -->
                <div class="text-dark" style="white-space: pre-line; line-height: 1.9; font-size: 1.05rem;">
                    <%= contentBody != null && !contentBody.trim().isEmpty() ? contentBody : description %>
                </div>
            <% } else { %>
                <div class="text-center py-4">
                    <div class="lock-icon-box">
                        <i class="fa-solid fa-lock"></i>
                    </div>
                    <h2 class="fw-extrabold text-dark mb-2" style="font-size: 1.75rem;">VIP အဖွဲ့ဝင်များသာ ကြည့်ရှုနိုင်ပါသည်</h2>
                    <p class="text-muted mb-4 mx-auto" style="max-width: 450px; line-height: 1.6;">
                        ဤသင်တန်း သို့မဟုတ် ဆောင်းပါးကို အပြည့်အစုံ ဖတ်ရှုရန် VIP အဖွဲ့ဝင်အဖြစ် အမြန်ဆုံး လျှောက်ထားပေးပါ။
                    </p>
                    <a href="subscribe.jsp" class="vip-action-btn">
                        <i class="fa-solid fa-crown me-2"></i> ယခုပဲ VIP လျှောက်မည်
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
