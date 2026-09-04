<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.lpg.util.DBConnection" %>
<%
    // Admin Session စစ်ဆေးခြင်း (Admin မဟုတ်လျှင် login.jsp သို့ ပြန်ပို့မည်)
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="my">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LPG BUSINESS SOLUTION | Admin Management Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --admin-bg: #f1f5f9;
            --card-bg: #ffffff;
            --primary-color: #f97316;
            --primary-hover: #ea580c;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
        }

        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background-color: var(--admin-bg);
            color: var(--text-main);
            min-height: 100vh;
            padding-bottom: 60px;
        }

        .dashboard-header {
            background-color: #333d4e; /* ပုံပါနောက်ခံအရောင်နှင့် ကိုက်ညီသော Dark Slate */
            color: #ffffff;
            padding: 35px 0;
            border-radius: 0 0 24px 24px;
            box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.2);
            margin-bottom: 40px;
        }

        .brand-badge {
            background: linear-gradient(135deg, #fef08a 0%, #fde047 100%);
            color: #713f12;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 12px;
        }

        .card-custom {
            background: var(--card-bg);
            border-radius: 20px;
            border: 1px solid var(--border-color);
            padding: 30px;
            box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
            transition: all 0.3s ease;
            height: 100%;
        }

        .card-custom:hover {
            box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.05);
        }

        .form-label {
            font-weight: 700;
            font-size: 0.9rem;
            color: #334155;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            background-color: #f8fafc;
            font-size: 0.95rem;
            transition: all 0.2s;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.15);
            background-color: #ffffff;
        }

        .btn-custom-primary {
            background-color: var(--primary-color);
            color: #ffffff;
            border-radius: 12px;
            padding: 12px 20px;
            font-weight: 700;
            border: none;
            transition: all 0.2s;
        }

        .btn-custom-primary:hover {
            background-color: var(--primary-hover);
            color: #ffffff;
            transform: translateY(-1px);
        }

        .table-custom th {
            background-color: #f8fafc;
            color: #475569;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 15px;
            border-bottom: 2px solid var(--border-color);
        }

        .table-custom td {
            padding: 16px 15px;
            vertical-align: middle;
            color: #334155;
            border-bottom: 1px solid var(--border-color);
        }

        .table-hover tbody tr:hover {
            background-color: #f8fafc;
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 0.75rem;
        }

        .badge-article { background-color: #ffedd5; color: #9a3412; }
        .badge-free { background-color: #dcfce7; color: #166534; }
        .badge-vip { background-color: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>

    <!-- Header Banner -->
    <div class="dashboard-header">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <!-- လိုဂိုတံဆိပ် (Badge) အသစ်ထည့်သွင်းထားခြင်း -->
                <div>
                    <span class="brand-badge">
                        <i class="fa-solid fa-fire text-danger"></i> LPG Business Solution
                    </span>
                </div>
                <h2 class="fw-extrabold mb-1"><i class="fa-solid fa-user-shield me-2 text-warning"></i>Admin Management Dashboard</h2>
                <p class="text-secondary mb-0 small text-light opacity-75">ဆောင်းပါးများနှင့် VIP အဖွဲ့ဝင်များကို စနစ်တကျ စီမံခန့်ခွဲရန်</p>
            </div>
            <a href="index.jsp" class="btn btn-light rounded-pill fw-bold px-4 shadow-sm text-dark">
                <i class="fa-solid fa-globe me-2 text-primary"></i> Website သို့သွားရန်
            </a>
        </div>
    </div>

    <div class="container">
        <div class="row g-4">
            
            <!-- Add Content Form -->
            <div class="col-lg-5">
                <div class="card-custom">
                    <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-circle-plus text-primary me-2"></i>ဆောင်းပါး အသစ်ထည့်ရန်</h5>
                    
                    <form action="${pageContext.request.contextPath}/AddContentServlet" method="post" enctype="multipart/form-data">
                        <!-- Category ကို ARTICLE တစ်ခုတည်းသာ အလိုအလျောက် သတ်မှတ်ပေးထားသည် -->
                        <input type="hidden" name="category" value="ARTICLE">

                        <div class="mb-3">
                            <label class="form-label">Badge အမျိုးအစား</label>
                            <select name="badgeType" class="form-select" required>
                                <option value="FREE">FREE (အခမဲ့)</option>
                                <option value="VIP">VIP (အထူး)</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">မျက်နှာဖုံးပုံ ရွေးချယ်ရန် (Image)</label>
                            <input type="file" name="imageFile" class="form-control" accept="image/*" required>
                            <div class="form-text small text-muted mt-1">ရှင်းလင်းသည့် ပုံဖိုင် (JPG, PNG) ကို ရွေးချယ်ပါ။</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">ခေါင်းစဉ် (Title)</label>
                            <input type="text" name="title" class="form-control" placeholder="ဆောင်းပါးခေါင်းစဉ် ရေးပါ..." required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">အကြောင်းအရာ အကျဉ်း (Description)</label>
                            <input type="text" name="description" class="form-control" placeholder="Card ပေါ်တွင် ပြသမည့် စာအကျဉ်း..." required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">အကြောင်းအရာ အပြည့်အစုံ (Full Content Details)</label>
                            <textarea name="contentBody" class="form-control" rows="5" placeholder="အသေးစိတ် ဆောင်းပါးပါ အကြောင်းအရာများ ရေးသားရန်..." required></textarea>
                        </div>

                        <button type="submit" class="btn btn-custom-primary w-100 py-3 shadow-sm">
                            <i class="fa-solid fa-cloud-arrow-up me-2"></i> ဆောင်းပါး တင်မည်
                        </button>
                    </form>
                </div>
            </div>

            <!-- Content List Table -->
            <div class="col-lg-7">
                <div class="card-custom">
                    <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-newspaper text-primary me-2"></i>တင်ထားပြီးသော ဆောင်းပါးများ</h5>
                    <div class="table-responsive">
                        <table class="table table-custom table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>ခေါင်းစဉ်</th>
                                    <th>Badge</th>
                                    <th class="text-end">လုပ်ဆောင်ချက်</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try (Connection conn = DBConnection.getConnection();
                                         Statement stmt = conn.createStatement();
                                         ResultSet rs = stmt.executeQuery("SELECT * FROM contents ORDER BY id DESC")) {
                                        
                                        boolean hasContent = false;
                                        while(rs.next()) {
                                            hasContent = true;
                                            String badgeType = rs.getString("badge_type");
                                            String badgeClass = "VIP".equalsIgnoreCase(badgeType) ? "badge-vip" : "badge-free";
                                %>
                                <tr>
                                    <td class="fw-bold text-muted">#<%= rs.getInt("id") %></td>
                                    <td>
                                        <div class="fw-bold text-dark text-truncate" style="max-width: 220px;"><%= rs.getString("title") %></div>
                                    </td>
                                    <td>
                                        <span class="badge-status <%= badgeClass %>"><%= badgeType %></span>
                                    </td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/DeleteContentServlet?id=<%= rs.getInt("id") %>" 
                                           class="btn btn-outline-danger btn-sm rounded-pill px-3 fw-bold"
                                           onclick="return confirm('ဤဆောင်းပါးကို ဖျက်ရန် သေချာပါသလား?');">
                                            <i class="fa-solid fa-trash-can me-1"></i> ဖျက်မည်
                                        </a>
                                    </td>
                                </tr>
                                <%
                                        }
                                        if(!hasContent) {
                                            out.println("<tr><td colspan='4' class='text-center text-muted py-4'>ဆောင်းပါးများ မရှိသေးပါ။</td></tr>");
                                        }
                                    } catch(Exception e) {
                                        out.println("<tr><td colspan='4' class='text-danger text-center'>Error: " + e.getMessage() + "</td></tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- VIP Subscriptions Table -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card-custom">
                    <h5 class="fw-bold mb-4 text-dark">
                        <i class="fa-solid fa-crown text-warning me-2"></i>VIP Membership လျှောက်ထားသူများ
                    </h5>
                    <div class="table-responsive">
                        <table class="table table-custom table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>အမည်</th>
                                    <th>ဖုန်းနံပါတ်</th>
                                    <th>Payment</th>
                                    <th>Transaction No.</th>
                                    <th>Status</th>
                                    <th>အချိန်</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try (Connection conn = DBConnection.getConnection();
                                         Statement stmt = conn.createStatement();
                                         ResultSet rsSub = stmt.executeQuery("SELECT * FROM subscriptions ORDER BY id DESC")) {
                                        
                                        boolean hasSub = false;
                                        while(rsSub.next()) {
                                            hasSub = true;
                                            String status = rsSub.getString("status");
                                            if(status == null) status = "Pending";
                                %>
                                <tr>
                                    <td class="fw-bold text-muted">#<%= rsSub.getInt("id") %></td>
                                    <td class="fw-bold text-dark"><%= rsSub.getString("user_name") %></td>
                                    <td><%= rsSub.getString("phone") %></td>
                                    <td><span class="badge bg-light text-dark border px-2 py-1"><%= rsSub.getString("payment_method") %></span></td>
                                    <td class="fw-bold text-primary"><%= rsSub.getString("transaction_no") %></td>
                                    <td>
                                        <% if("Approved".equalsIgnoreCase(status)) { %>
                                            <span class="badge bg-success bg-opacity-10 text-success px-3 py-1.5 rounded-pill fw-bold">
                                                <i class="fa-solid fa-circle-check me-1"></i> Approved
                                            </span>
                                        <% } else { %>
                                            <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-1.5 rounded-pill fw-bold">
                                                <i class="fa-solid fa-clock me-1"></i> Pending
                                            </span>
                                        <% } %>
                                    </td>
                                    <td class="small text-muted"><%= rsSub.getTimestamp("created_at") %></td>
                                    <td class="text-end">
                                        <div class="d-flex justify-content-end gap-2">
                                            <% if(!"Approved".equalsIgnoreCase(status)) { %>
                                                <a href="approve-sub.jsp?id=<%= rsSub.getInt("id") %>" 
                                                   class="btn btn-sm btn-success rounded-pill px-3 fw-bold shadow-sm" 
                                                   onclick="return confirm('ဤ VIP လျှောက်ထားချက်ကို အတည်ပြုရန် သေချာပါသလား?');">
                                                    <i class="fa-solid fa-check me-1"></i> အတည်ပြု
                                                </a>
                                            <% } %>
                                            <a href="delete-sub.jsp?id=<%= rsSub.getInt("id") %>" 
                                               class="btn btn-outline-danger btn-sm rounded-pill px-3 fw-bold" 
                                               onclick="return confirm('ဤ VIP လျှောက်ထားချက်ကို ဖျက်ရန် သေချာပါသလား?');">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                        if(!hasSub) {
                                            out.println("<tr><td colspan='8' class='text-center text-muted py-4'>VIP လျှောက်ထားသူ မရှိသေးပါ။</td></tr>");
                                        }
                                    } catch(Exception e) {
                                        out.println("<tr><td colspan='8' class='text-danger text-center'>Error: " + e.getMessage() + "</td></tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
