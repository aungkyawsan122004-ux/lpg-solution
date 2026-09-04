<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.lpg.util.DBConnection" %>
<%
    String loggedInPhone = (String) session.getAttribute("userPhone");
    boolean isVipApproved = false;
    String displayName = loggedInPhone; 

    if (loggedInPhone != null) {
        try (Connection conn = DBConnection.getConnection()) {
            
            String nameSql = "SELECT user_name FROM subscriptions WHERE phone = ?";
            try (PreparedStatement pName = conn.prepareStatement(nameSql)) {
                pName.setString(1, loggedInPhone);
                try (ResultSet rsName = pName.executeQuery()) {
                    if (rsName.next()) {
                        String dbName = rsName.getString("user_name");
                        if (dbName != null && !dbName.trim().isEmpty()) {
                            displayName = dbName;
                        }
                    }
                }
            }

            String checkVip = "SELECT * FROM subscriptions WHERE phone = ? AND status = 'Approved' AND end_date >= CURDATE()";
            try (PreparedStatement pCheck = conn.prepareStatement(checkVip)) {
                pCheck.setString(1, loggedInPhone);
                try (ResultSet rsVip = pCheck.executeQuery()) {
                    if (rsVip.next()) {
                        isVipApproved = true;
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
    <title>NexLPG | မြန်မာ့ LPG နည်းပညာနှင့် စီးပွားရေး ဗဟို</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #f97316;
            --primary-dark: #ea580c;
            --secondary-color: #1e293b;
            --bg-light: #f8fafc;
            --surface-white: #ffffff;
            --border-light: #e2e8f0;
            --text-main: #0f172a;
            --text-sub: #475569;
        }

        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-main);
            line-height: 1.7;
        }

        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-light);
            box-shadow: 0 4px 20px rgba(30, 41, 59, 0.03);
        }

        .brand-logo {
            height: 42px;
            width: auto;
            object-fit: contain;
        }

        .hero-banner {
            padding: 150px 0 70px;
            background: linear-gradient(135thin, #fff7ed 0%, #fef3c7 50%, var(--bg-light) 100%);
            background: linear-gradient(135deg, #fff7ed 0%, var(--bg-light) 100%);
        }

        .app-card {
            background: var(--surface-white);
            border: 1px solid var(--border-light);
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(30, 41, 59, 0.02);
            transition: all 0.35s cubic-bezier(0.165, 0.84, 0.44, 1);
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .app-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 35px rgba(249, 115, 22, 0.08);
            border-color: #fed7aa;
        }

        .badge-style {
            font-weight: 700;
            padding: 6px 14px;
            border-radius: 20px;
            display: inline-block;
            font-size: 0.85rem;
        }

        .badge-free { background-color: #dcfce7; color: #15803d; }
        .badge-vip { background-color: #fee2e2; color: #b91c1c; }
        .badge-course { background-color: #ffedd5; color: #c2410c; }

        .pricing-card {
            background: #ffffff;
            border: 2px solid var(--primary);
            border-radius: 28px;
            padding: 45px 35px;
            box-shadow: 0 15px 35px rgba(249, 115, 22, 0.08);
        }

        .btn-brand {
            background: var(--primary);
            color: #ffffff;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 700;
            border: none;
            box-shadow: 0 4px 15px rgba(249, 115, 22, 0.3);
            transition: 0.3s;
        }

        .btn-brand:hover {
            background: var(--primary-dark);
            color: #ffffff;
            box-shadow: 0 6px 20px rgba(249, 115, 22, 0.4);
        }

        .section-header {
            border-left: 4px solid var(--primary);
            padding-left: 14px;
            font-weight: 800;
            color: var(--secondary-color);
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top navbar-custom px-4">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="index.jsp">
                <img src="k.jpg" alt="NexLPG Logo" class="brand-logo">
            </a>
            <div class="d-flex align-items-center gap-3">
                
                <% if (loggedInPhone != null) { %>
                    <span class="small text-secondary d-none d-md-inline">
                        <i class="fa-solid fa-user-circle me-1 text-primary"></i>
                        <b class="text-dark"><%= displayName %></b>
                    </span>
                    <% if (isVipApproved) { %>
                        <span class="badge bg-danger text-white px-3 py-2 rounded-pill fs-6 fw-bold shadow-sm">
                            <i class="fa-solid fa-crown me-1 text-warning"></i> VIP Member
                        </span>
                    <% } else { %>
                        <span class="badge bg-light text-secondary border px-3 py-2 rounded-pill fs-6">
                            <i class="fa-solid fa-user me-1"></i> Free Member
                        </span>
                    <% } %>
                    <a href="LogoutServlet" class="btn btn-outline-danger btn-sm rounded-pill px-3 fw-bold">ထွက်ရန်</a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-outline-dark btn-sm rounded-pill px-3 fw-bold">အကောင့်ဝင်ရန်</a>
                    <a href="subscribe.jsp" class="btn btn-brand btn-sm">VIP အဖွဲ့ဝင်ရန်</a>
                <% } %>
              
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-banner text-center">
        <div class="container">
            <span class="badge bg-white border border-warning text-dark px-3 py-2 rounded-pill mb-3 shadow-sm">
                <i class="fa-solid fa-fire-flame-curved text-primary me-1"></i> မြန်မာ့ LPG နည်းပညာနှင့် စီးပွားရေး ဗဟို
            </span>
            <h1 class="display-5 fw-bold mb-3 text-dark">LPG နည်းပညာ သင်တန်းများနှင့် သတင်းအချက်အလက်များ</h1>
            <p class="fs-5 mx-auto mb-4 text-secondary" style="max-width: 720px;">
                စက်ရုံ/ဆိုင်ခန်း ဘေးကင်းလုံခြုံရေး၊ မီးသတ်စံချိန်မီ တပ်ဆင်နည်း သင်တန်းများနှင့် ပြည်တွင်း/ပြည်ပ LPG စီးပွားရေး သတင်းဆောင်းပါးများကို စနစ်တကျ လေ့လာပါ။
            </p>
        </div>
    </section>

    <!-- Content Section -->
    <section class="py-5">
        <div class="container">
              
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    if(conn != null) {
                        stmt = conn.createStatement();
            %>

            <!-- SECTION 1: သင်တန်းများ (Courses) -->
            <div class="mb-5">
                <h4 class="fw-bold mb-4 section-header">
                    <i class="fa-solid fa-graduation-cap me-2 text-primary"></i>ကျွမ်းကျင်မှု သင်တန်းများ (Courses)
                </h4>
                <div class="row g-4">
                    <%
                        rs = stmt.executeQuery("SELECT * FROM contents WHERE category = 'COURSE' ORDER BY id DESC");
                        boolean hasCourse = false;
                        while(rs.next()) {
                            hasCourse = true;
                            String badge = rs.getString("badge_type");
                            String badgeClass = badge.equalsIgnoreCase("VIP") ? "badge-vip" : (badge.equalsIgnoreCase("FREE") ? "badge-free" : "badge-course");
                    %>
                    <div class="col-md-4">
                        <div class="app-card">
                            <div>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="badge-style <%= badgeClass %>"><%= badge %></span>
                                </div>
                                <h5 class="fw-bold text-dark mb-2"><%= rs.getString("title") %></h5>
                                <p class="text-secondary small mb-3"><%= rs.getString("description") %></p>
                            </div>
                            <a href="content-detail.jsp?id=<%= rs.getInt("id") %>" class="text-primary text-decoration-none fw-bold small">
                                အသေးစိတ် ကြည့်မည် <i class="fa-solid fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                    <% 
                        } 
                        if(!hasCourse) {
                    %>
                    <div class="col-12"><p class="text-muted">သင်တန်းများ မရှိသေးပါ။ Admin Panel မှ စတင်ထည့်သွင်းပါ။</p></div>
                    <% } %>
                </div>
            </div>

            <!-- SECTION 2: ဆောင်းပါးများ (Articles) -->
            <div class="mb-5">
                <h4 class="fw-bold mb-4 section-header">
                    <i class="fa-solid fa-newspaper me-2 text-primary"></i>သတင်းနှင့် အသိပညာပေး ဆောင်းပါးများ (Articles)
                </h4>
                <div class="row g-4">
                    <%
                        rs = stmt.executeQuery("SELECT * FROM contents WHERE category = 'ARTICLE' ORDER BY id DESC");
                        boolean hasArticle = false;
                        while(rs.next()) {
                            hasArticle = true;
                            String badge = rs.getString("badge_type");
                            String badgeClass = badge.equalsIgnoreCase("VIP") ? "badge-vip" : "badge-free";
                    %>
                    <div class="col-md-4">
                        <div class="app-card">
                            <div>
                                <span class="badge-style <%= badgeClass %> mb-3"><%= badge %> ARTICLE</span>
                                <h5 class="fw-bold text-dark mb-2"><%= rs.getString("title") %></h5>
                                <p class="text-secondary small mb-3"><%= rs.getString("description") %></p>
                            </div>
                            <a href="content-detail.jsp?id=<%= rs.getInt("id") %>" class="text-primary text-decoration-none fw-bold small">
                                ဖတ်ရှုရန် <i class="fa-solid fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                    <% 
                        } 
                        if(!hasArticle) {
                    %>
                    <div class="col-12"><p class="text-muted">ဆောင်းပါးများ မရှိသေးပါ။ Admin Panel မှ စတင်ထည့်သွင်းပါ။</p></div>
                    <% } %>
                </div>
            </div>

            <%
                    }
                } catch(Exception e) {
                    out.println("<p class='text-danger'>Database Error: " + e.getMessage() + "</p>");
                } finally {
                    if(rs != null) rs.close();
                    if(stmt != null) stmt.close();
                    if(conn != null) conn.close();
                }
            %>

            <!-- Subscription Section -->
            <div id="pricing" class="py-5 mt-4">
                <div class="pricing-card text-center mx-auto" style="max-width: 500px;">
                    <i class="fa-solid fa-crown text-primary display-4 mb-3"></i>
                    <h3 class="fw-bold text-dark">VIP Membership Plan</h3>
                    <div class="my-4">
                        <span class="display-5 fw-bold text-primary">30,000</span>
                        <span class="text-secondary fs-6"> Ks / လစဉ်</span>
                    </div>
                    <p class="text-secondary mb-4">
                        သင်တန်း ဗီဒီယိုများ၊ VIP ဆောင်းပါးများနှင့် နည်းပညာ အကူအညီများကို အကန့်အသတ်မရှိ ရရှိပါမည်။
                    </p>
                    <a href="subscribe.jsp" class="btn btn-brand w-100 py-3 text-uppercase">ယခုပဲ အဖွဲ့ဝင်မည်</a>
                </div>
            </div>

        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
