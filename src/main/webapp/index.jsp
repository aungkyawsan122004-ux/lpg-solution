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
    <title>LPG BUSINESS SOLUTION | မြန်မာ့ LPG လုပ်ငန်းဆိုင်ရာဗဟုသုတများနှင့် ဆောင်းပါးများ</title>
    
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
            --text-muted: #94a3b8;
            --border-subtle: #e5e7eb;
        }

        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-earth);
            color: var(--text-dark);
            line-height: 1.7;
        }

        .top-navbar {
            background-color: var(--surface-white);
            border-bottom: 1px solid var(--border-subtle);
            padding: 10px 0;
            box-shadow: 0 4px 20px rgba(0,0,0,0.03);
        }

        /* Custom Logo Design Styles */
        .brand-logo-container {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .logo-icon-wrapper {
            position: relative;
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #1f2937 0%, #0f172a 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(31, 41, 55, 0.2);
            transition: transform 0.3s ease;
        }

        .brand-logo-container:hover .logo-icon-wrapper {
            transform: scale(1.05) rotate(-3deg);
        }

        .logo-icon-wrapper i {
            font-size: 1.25rem;
            color: var(--brand-accent);
        }

        .logo-text-group {
            display: flex;
            flex-direction: column;
        }

        .logo-title {
            font-weight: 800;
            font-size: 1.1rem;
            color: var(--brand-primary);
            letter-spacing: 0.5px;
            line-height: 1.2;
        }

        .logo-subtitle {
            font-size: 0.65rem;
            font-weight: 700;
            color: var(--brand-accent);
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .nav-links-top {
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.2s;
        }

        .nav-links-top:hover {
            color: var(--brand-accent);
        }

        .hero-banner-custom {
            position: relative;
            background: linear-gradient(rgba(15, 23, 42, 0.92), rgba(15, 23, 42, 0.88));
            padding: 140px 0;
            color: #ffffff;
            text-align: center;
        }

        .hero-banner-custom h1 {
            font-weight: 800;
            font-size: 2.75rem;
            margin-bottom: 20px;
            letter-spacing: -0.5px;
        }

        .hero-banner-custom p {
            font-size: 1.15rem;
            max-width: 750px;
            margin: 0 auto 30px auto;
            color: #e2e8f0;
        }

        .hero-btn {
            background-color: var(--brand-accent);
            color: #fff;
            padding: 12px 32px;
            border-radius: 8px;
            font-weight: 700;
            text-transform: uppercase;
            border: none;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            box-shadow: 0 4px 15px rgba(249, 115, 22, 0.3);
        }

        .hero-btn:hover {
            background-color: #ea580c;
            color: #fff;
            transform: translateY(-2px);
        }

        .category-heading {
            text-align: center;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--brand-primary);
            margin-bottom: 8px;
            font-size: 1.35rem;
        }

        .category-subheading {
            text-align: center;
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 40px;
        }

        .content-grid-card {
            background: var(--surface-white);
            border: 1px solid var(--border-subtle);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.04);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .content-grid-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(249, 115, 22, 0.1);
            border-color: #fed7aa;
        }

        .card-img-holder {
            height: 220px;
            background-color: #f1f5f9;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .card-body-custom {
            padding: 24px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .badge-pill-custom {
            font-size: 0.75rem;
            font-weight: 700;
            padding: 6px 14px;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
            margin-bottom: 12px;
        }
        .badge-free-custom { background-color: #e6f4ea; color: #137333; }
        .badge-vip-custom { background-color: #fce8e6; color: #c5221f; }

        .footer-dark {
            background-color: #0f172a;
            color: #cbd5e1 !important;
            padding: 70px 0 30px 0;
            font-size: 0.9rem;
        }

        .footer-dark h5 {
            color: #ffffff;
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .footer-dark ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-dark ul li {
            margin-bottom: 10px;
            color: #cbd5e1 !important;
        }

        .footer-dark ul li a {
            color: #cbd5e1 !important;
            text-decoration: none;
            transition: color 0.2s;
        }

        .footer-dark ul li a:hover {
            color: #ffffff !important;
        }

        .footer-dark p {
            color: #cbd5e1 !important;
        }

        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.1);
            margin-top: 50px;
            padding-top: 25px;
            text-align: center;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

    <!-- Top Navigation Bar -->
    <header class="top-navbar sticky-top">
        <div class="container d-flex justify-content-between align-items-center">
            <!-- Enhanced Custom Logo -->
            <a class="brand-logo-container" href="index.jsp">
                <div class="logo-icon-wrapper">
                    <i class="fa-solid fa-fire-flame-curved"></i>
                </div>
                <div class="logo-text-group">
                    <span class="logo-title">LPG BUSINESS</span>
                    <span class="logo-subtitle">SOLUTION</span>
                </div>
            </a>
            
            <nav class="d-none d-lg-flex align-items-center gap-4">
                <a href="index.jsp" class="nav-links-top">ပင်မစာမျက်နှာ</a>
                <a href="#articles" class="nav-links-top">ဆောင်းပါးများ</a>
                <a href="#pricing" class="nav-links-top">VIP အဖွဲ့ဝင်ရန်</a>
            </nav>

            <div class="d-flex align-items-center gap-3">
                <% if (loggedInPhone != null) { %>
                    <span class="small text-secondary d-none md-inline bg-light px-3 py-1.5 rounded border shadow-sm">
                        <i class="fa-solid fa-user-circle me-1 text-primary"></i>
                        <b class="text-dark"><%= displayName %></b>
                    </span>
                    <% if (isVipApproved) { %>
                        <span class="badge bg-danger text-white px-3 py-2 rounded-pill fs-7 fw-bold shadow-sm">
                            <i class="fa-solid fa-crown me-1 text-warning"></i> VIP
                        </span>
                    <% } else { %>
                        <span class="badge bg-secondary text-white px-3 py-2 rounded-pill fs-7">
                            Free
                        </span>
                    <% } %>
                    <a href="LogoutServlet" class="btn btn-outline-danger btn-sm px-3 fw-bold rounded-pill">ထွက်ရန်</a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-outline-dark btn-sm px-3 fw-bold rounded-pill">အကောင့်ဝင်ရန်</a>
                    <a href="subscribe.jsp" class="btn hero-btn btn-sm py-2 rounded-pill">အဖွဲ့ဝင်ရန်</a>
                <% } %>
            </div>
        </div>
    </header>

    <!-- Hero Banner Section -->
    <section class="hero-banner-custom">
        <div class="container">
            <span class="badge bg-warning text-dark px-3.5 py-2 rounded-pill mb-3 fw-bold shadow-sm">
                <i class="fa-solid fa-fire me-1 text-danger"></i> မြန်မာ့ LPG စက်မှုလုပ်ငန်းနှင့် နည်းပညာဗဟို
            </span>
            <h1>LPG လုပ်ငန်းဆိုင်ရာ ဗဟုသုတများနှင့် ဆောင်းပါးများ</h1>
            <p>
                စက်ရုံဆိုင်ရာ ဘေးကင်းလုံခြုံရေး၊ မီးသတ်စံချိန်မီ တပ်ဆင်နည်းစနစ်များ နှင့် လုပ်ငန်းသုံး ကျွမ်းကျင်ဗဟုသုတ ဆောင်းပါးများကို တစ်နေရာတည်းတွင် စနစ်တကျ လေ့လာနိုင်ပါသည်။
            </p>
            <a href="#articles" class="hero-btn">ဆောင်းပါးများ ဖတ်ရှုမည်</a>
        </div>
    </section>

    <!-- Main Content Dynamic Section -->
    <section class="py-5">
        <div class="container my-3">
            
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    if(conn != null) {
                        stmt = conn.createStatement();
            %>

            <!-- SECTION: ဆောင်းပါးများ (Articles) -->
            <div id="articles" class="mb-5 pt-4">
                <h3 class="category-heading"><i class="fa-solid fa-book-open-reader text-primary me-2"></i>LPG လုပ်ငန်းဆိုင်ရာ ဗဟုသုတနှင့် ဆောင်းပါးများ</h3>
                <p class="category-subheading">လုပ်ငန်းရှင်များနှင့် ကျွမ်းကျင်ပညာရှင်များအတွက် သိသင့်သိထိုက်သော အချက်အလက်များ</p>
                
                <div class="row g-4">
                    <%
                        rs = stmt.executeQuery("SELECT * FROM contents WHERE category = 'ARTICLE' ORDER BY id DESC");
                        boolean hasArticle = false;
                        while(rs.next()) {
                            hasArticle = true;
                            String badge = rs.getString("badge_type");
                            String badgeClass = badge.equalsIgnoreCase("VIP") ? "badge-vip-custom" : "badge-free-custom";
                            String dbImgArt = rs.getString("image_url");
                    %>
                    <div class="col-md-4">
                        <div class="content-grid-card">
                            <!-- Database မှ Base64 ပုံကို တိုက်ရိုက်ခေါ်သုံးခြင်း -->
                            <div class="card-img-holder" style="background-image: url('<%= (dbImgArt != null && !dbImgArt.isEmpty()) ? dbImgArt : "" %>');"></div>
                            <div class="card-body-custom">
                                <div>
                                    <span class="badge-pill-custom <%= badgeClass %> mb-2"><%= badge %> ARTICLE</span>
                                    <h5 class="fw-bold text-dark mb-2 fs-5"><%= rs.getString("title") %></h5>
                                    <p class="text-secondary small mb-3"><%= rs.getString("description") %></p>
                                </div>
                                <a href="content-detail.jsp?id=<%= rs.getInt("id") %>" class="text-dark text-decoration-none fw-bold small d-flex align-items-center gap-2 mt-2">
                                    ဖတ်ရှုရန် <i class="fa-solid fa-arrow-right text-primary"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <% 
                        } 
                        if(!hasArticle) {
                    %>
                    <div class="col-12 text-center py-4"><p class="text-muted">ဆောင်းပါးများ မရှိသေးပါ။ Admin Panel မှ စတင်ထည့်သွင်းပါ။</p></div>
                    <% } %>
                </div>
            </div>

            <%
                    }
                } catch(Exception e) {
                    out.println("<p class='text-danger text-center'>Database Error: " + e.getMessage() + "</p>");
                } finally {
                    if(rs != null) rs.close();
                    if(stmt != null) stmt.close();
                    if(conn != null) conn.close();
                }
            %>

            <!-- Subscription Section -->
            <div id="pricing" class="py-5 mt-4">
                <div class="bg-white border rounded-4 p-5 text-center mx-auto shadow-sm" style="max-width: 540px;">
                    <i class="fa-solid fa-crown text-warning display-4 mb-3"></i>
                    <h3 class="fw-bold text-dark mb-2">VIP Membership Plan</h3>
                    <div class="my-3">
                        <span class="display-4 fw-extrabold text-dark">30,000</span>
                        <span class="text-secondary fs-6 fw-semibold"> Ks / လစဉ်</span>
                    </div>
                    <p class="text-secondary mb-4 small px-2">
                        သင်တန်း ဗီဒီယိုများ၊ အဆင့်မြင့် လုပ်ငန်းသုံး ဗဟုသုတဆောင်းပါးများနှင့် နည်းပညာ အကူအညီများကို အကန့်အသတ်မရှိ ရရှိပါမည်။
                    </p>
                    <a href="subscribe.jsp" class="hero-btn w-100 py-3 text-uppercase shadow-sm rounded-pill">ယခုပဲ အဖွဲ့ဝင်မည်</a>
                </div>
            </div>

        </div>
    </section>

    <!-- Dark Footer -->
    <footer class="footer-dark">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <h5 class="text-white">LPG BUSINESS SOLUTION</h5>
                    <p class="small">မြန်မာနိုင်ငံအတွင်းရှိ LPG လုပ်ငန်းရှင်များ နှင့် စိတ်ပါဝင်စားသူများအတွက် ဘေးကင်းလုံခြုံရေးနှင့် နည်းပညာဗဟုသုတများကို ဖြန့်ဝေပေးနေသော စင်တာဖြစ်သည်။</p>
                </div>
                <div class="col-md-3">
                    <h5>လင့်ခ်များ</h5>
                    <ul>
                        <li><a href="index.jsp">ပင်မစာမျက်နှာ</a></li>
                        <li><a href="#articles">ဆောင်းပါးများ</a></li>
                        <li><a href="subscribe.jsp">အဖွဲ့ဝင်ရန်</a></li>
                    </ul>
                </div>
                <div class="col-md-5">
                    <h5>ဆက်သွယ်ရန်</h5>
                    <ul class="small">
                        <li><i class="fa-solid fa-location-dot me-2 text-warning"></i> ရန်ကုန်မြို့, မြန်မာနိုင်ငံ</li>
                        <li><i class="fa-solid fa-phone me-2 text-warning"></i> +95 9 123 456 789</li>
                        <li><i class="fa-solid fa-envelope me-2 text-warning"></i> support@nexlpg.com</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p class="mb-0">&copy; 2026 LPG BUSINESS SOLUTION. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
