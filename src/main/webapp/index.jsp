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
    <title>NexLPG | မြန်မာ့ LPG လုပ်ငန်းဆိုင်ရာဗဟုသုတများနှင့် ဆောင်းပါးများ</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #f97316;
            --primary-gradient: linear-gradient(135deg, #f97316 0%, #ea580c 100%);
            --secondary-color: #0f172a;
            --bg-light: #f8fafc;
            --surface-white: #ffffff;
            --border-light: #e2e8f0;
            --text-main: #1e293b;
            --text-sub: #64748b;
        }

        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-main);
            line-height: 1.8;
        }

        /* Modern Glassmorphism Navbar */
        .navbar-custom {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.03);
            padding: 12px 0;
            transition: all 0.3s ease;
        }

        .brand-logo {
            height: 56px;
            width: auto;
            object-fit: contain;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.06));
        }

        /* Gorgeous Dynamic Hero Section */
        .hero-banner {
            padding: 170px 0 90px;
            background: radial-gradient(circle at top right, rgba(249, 115, 22, 0.08), transparent 40%),
                        radial-gradient(circle at bottom left, rgba(15, 23, 42, 0.04), transparent 50%),
                        #ffffff;
            border-bottom: 1px solid var(--border-light);
            position: relative;
            overflow: hidden;
        }

        .hero-badge {
            background: linear-gradient(135deg, #fff7ed 0%, #ffedd5 100%);
            border: 1px solid #fed7aa;
            color: #c2410c;
            font-weight: 700;
            padding: 8px 20px;
            border-radius: 50px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.08);
        }

        /* Premium Modern Cards with Soft Elevation */
        .app-card {
            background: var(--surface-white);
            border: 1px solid rgba(226, 232, 240, 0.8);
            border-radius: 24px;
            padding: 32px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.02);
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        .app-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .app-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 45px rgba(249, 115, 22, 0.12);
            border-color: #fed7aa;
        }

        .app-card:hover::after {
            opacity: 1;
        }

        .badge-style {
            font-weight: 700;
            padding: 6px 16px;
            border-radius: 30px;
            display: inline-block;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }

        .badge-free { background-color: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        .badge-vip { background-color: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
        .badge-course { background-color: #fff7ed; color: #ea580c; border: 1px solid #fed7aa; }

        /* Modern Pricing Plan Card */
        .pricing-card {
            background: linear-gradient(145deg, #ffffff 0%, #fffbf7 100%);
            border: 2px solid #fed7aa;
            border-radius: 32px;
            padding: 50px 40px;
            box-shadow: 0 25px 50px rgba(249, 115, 22, 0.08);
            position: relative;
            overflow: hidden;
        }

        .pricing-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 8px;
            background: var(--primary-gradient);
        }

        /* Buttons with Vibrant Gradients */
        .btn-brand {
            background: var(--primary-gradient);
            color: #ffffff;
            border-radius: 50px;
            padding: 14px 32px;
            font-weight: 700;
            border: none;
            box-shadow: 0 8px 20px rgba(249, 115, 22, 0.3);
            transition: all 0.3s ease;
        }

        .btn-brand:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(249, 115, 22, 0.4);
            color: #ffffff;
        }

        .section-header {
            font-weight: 800;
            color: var(--secondary-color);
            position: relative;
            padding-bottom: 12px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--primary-gradient);
            border-radius: 2px;
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top navbar-custom px-4">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <img src="k.jpg" alt="NexLPG Logo" class="brand-logo">
            </a>
            <div class="d-flex align-items-center gap-3">
                <% if (loggedInPhone != null) { %>
                    <span class="small text-secondary d-none d-md-inline bg-white px-3 py-1.5 rounded-pill border shadow-sm">
                        <i class="fa-solid fa-user-circle me-1 text-primary"></i>
                        <b class="text-dark"><%= displayName %></b>
                    </span>
                    <% if (isVipApproved) { %>
                        <span class="badge bg-danger text-white px-3 py-2 rounded-pill fs-6 fw-bold shadow-sm">
                            <i class="fa-solid fa-crown me-1 text-warning"></i> VIP Member
                        </span>
                    <% } else { %>
                        <span class="badge bg-white text-secondary border px-3 py-2 rounded-pill fs-6">
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
            <div class="hero-badge mb-4 mx-auto">
                <i class="fa-solid fa-fire-flame-curved text-primary"></i> မြန်မာ့ LPG လုပ်ငန်းဆိုင်ရာဗဟုသုတများနှင့် ဆောင်းပါးများ
            </div>
            <h1 class="display-5 fw-extrabold mb-4 text-dark" style="letter-spacing: -1px;">
                LPG လုပ်ငန်းဆိုင်ရာ ဗဟုသုတများနှင့် ဆောင်းပါးများ
            </h1>
            <p class="fs-5 mx-auto mb-4 text-secondary" style="max-width: 740px;">
                စက်ရုံ/ဆိုင်ခန်း ဘေးကင်းလုံခြုံရေး၊ မီးသတ်စံချိန်မီ တပ်ဆင်နည်းများနှင့် ပြည်တွင်း/ပြည်ပ LPG လုပ်ငန်းသုံး ကျွမ်းကျင်ဗဟုသုတ ဆောင်းပါးများကို စနစ်တကျ လေ့လာပါ။
            </p>
        </div>
    </section>

    <!-- Content Section -->
    <section class="py-5">
        <div class="container py-4">
              
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
                <h4 class="section-header">
                    <i class="fa-solid fa-graduation-cap text-primary"></i>ကျွမ်းကျင်မှု သင်တန်းများ (Courses)
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
                                <p class="text-secondary small mb-4"><%= rs.getString("description") %></p>
                            </div>
                            <a href="content-detail.jsp?id=<%= rs.getInt("id") %>" class="text-primary text-decoration-none fw-bold small d-inline-flex align-items-center gap-1">
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
                <h4 class="section-header">
                    <i class="fa-solid fa-newspaper text-primary"></i>LPG လုပ်ငန်းဆိုင်ရာ ဗဟုသုတနှင့် ဆောင်းပါးများ (Articles)
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
                                <p class="text-secondary small mb-4"><%= rs.getString("description") %></p>
                            </div>
                            <a href="content-detail.jsp?id=<%= rs.getInt("id") %>" class="text-primary text-decoration-none fw-bold small d-inline-flex align-items-center gap-1">
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
                <div class="pricing-card text-center mx-auto" style="max-width: 520px;">
                    <div class="mb-3">
                        <i class="fa-solid fa-crown text-warning display-4"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-2">VIP Membership Plan</h3>
                    <div class="my-4">
                        <span class="display-4 fw-extrabold text-primary">30,000</span>
                        <span class="text-secondary fs-6 fw-semibold"> Ks / လစဉ်</span>
                    </div>
                    <p class="text-secondary mb-4 px-2">
                        သင်တန်း ဗီဒီယိုများ၊ လုပ်ငန်းသုံး ဗဟုသုတဆောင်းပါးများနှင့် နည်းပညာ အကူအညီများကို အကန့်အသတ်မရှိ ရရှိပါမည်။
                    </p>
                    <a href="subscribe.jsp" class="btn btn-brand w-100 py-3 text-uppercase shadow-sm">ယခုပဲ အဖွဲ့ဝင်မည်</a>
                </div>
            </div>

        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
