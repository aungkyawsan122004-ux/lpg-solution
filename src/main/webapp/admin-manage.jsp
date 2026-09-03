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
    <title>NexLPG Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; color: #0f172a; }
        .card-custom { background: #ffffff; border-radius: 16px; border: 1px solid #e2e8f0; padding: 25px; }
    </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary"><i class="fa-solid fa-user-shield me-2"></i>NexLPG Admin Management</h3>
            <a href="index.jsp" class="btn btn-outline-secondary rounded-pill fw-bold">
                <i class="fa-solid fa-globe me-1"></i> Website သို့သွားရန်
            </a>
        </div>

        <div class="row g-4">
            <!-- Add Content Form -->
            <div class="col-md-5">
                <div class="card-custom shadow-sm">
                    <h5 class="fw-bold mb-3"><i class="fa-solid fa-plus-circle text-primary me-2"></i>Content အသစ်ထည့်ရန်</h5>
                    <form action="${pageContext.request.contextPath}/AddContentServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">အမျိုးအစား (Category)</label>
                            <select name="category" class="form-select" required>
                                <option value="COURSE">COURSE (သင်တန်း)</option>
                                <option value="ARTICLE">ARTICLE (ဆောင်းပါး)</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Badge Type</label>
                            <select name="badgeType" class="form-select" required>
                                <option value="FREE">FREE</option>
                                <option value="VIP">VIP</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">ခေါင်းစဉ် (Title)</label>
                            <input type="text" name="title" class="form-control" placeholder="ခေါင်းစဉ် ရေးပါ..." required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">အကြောင်းအရာ အကျဉ်း (Description)</label>
                            <input type="text" name="description" class="form-control" placeholder="Card ပေါ်တွင် ပြသမည့် စာအကျဉ်း..." required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">အကြောင်းအရာ အပြည့်အစုံ (Full Content Details)</label>
                            <textarea name="contentBody" class="form-control" rows="6" placeholder="အသေးစိတ် အကြောင်းအရာများ ရေးသားရန်..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 fw-bold py-2 rounded-pill">
                            <i class="fa-solid fa-upload me-1"></i> တင်မည်
                        </button>
                    </form>
                </div>
            </div>

            <!-- Content List Table -->
            <div class="col-md-7">
                <div class="card-custom shadow-sm">
                    <h5 class="fw-bold mb-3"><i class="fa-solid fa-list text-primary me-2"></i>တင်ထားသော Content များ</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Badge</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try (Connection conn = DBConnection.getConnection();
                                         Statement stmt = conn.createStatement();
                                         ResultSet rs = stmt.executeQuery("SELECT * FROM contents ORDER BY id DESC")) {
                                        
                                        while(rs.next()) {
                                %>
                                <tr>
                                    <td><%= rs.getInt("id") %></td>
                                    <td class="fw-bold"><%= rs.getString("title") %></td>
                                    <td><span class="badge bg-info"><%= rs.getString("category") %></span></td>
                                    <td><span class="badge bg-secondary"><%= rs.getString("badge_type") %></span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/DeleteContentServlet?id=<%= rs.getInt("id") %>" 
                                           class="btn btn-outline-danger btn-sm rounded-pill"
                                           onclick="return confirm('သေချာပါသလား? ဖျက်လိုက်ပါက ပြန်ယူ၍ မရနိုင်ပါ။');">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } catch(Exception e) {
                                        out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
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
                <div class="card-custom shadow-sm">
                    <h5 class="fw-bold mb-3 text-warning">
                        <i class="fa-solid fa-crown me-2"></i>VIP Membership လျှောက်ထားသူများ
                    </h5>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>အမည်</th>
                                    <th>ဖုန်းနံပါတ်</th>
                                    <th>Payment Method</th>
                                    <th>Transaction No.</th>
                                    <th>Status</th>
                                    <th>လျှောက်ထားသည့်အချိန်</th>
                                    <th>Action</th>
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
                                    <td><%= rsSub.getInt("id") %></td>
                                    <td class="fw-bold"><%= rsSub.getString("user_name") %></td>
                                    <td><%= rsSub.getString("phone") %></td>
                                    <td><span class="badge bg-success"><%= rsSub.getString("payment_method") %></span></td>
                                    <td class="fw-bold text-primary"><%= rsSub.getString("transaction_no") %></td>
                                    <td>
                                        <% if("Approved".equalsIgnoreCase(status)) { %>
                                            <span class="badge bg-success"><i class="fa-solid fa-circle-check me-1"></i>Approved</span>
                                        <% } else { %>
                                            <span class="badge bg-warning text-dark"><i class="fa-solid fa-clock me-1"></i>Pending</span>
                                        <% } %>
                                    </td>
                                    <td class="small text-muted"><%= rsSub.getTimestamp("created_at") %></td>
                                    <td>
                                        <% if(!"Approved".equalsIgnoreCase(status)) { %>
                                            <!-- Approve Button -->
                                            <a href="approve-sub.jsp?id=<%= rsSub.getInt("id") %>" 
                                               class="btn btn-sm btn-success rounded-pill me-1" 
                                               onclick="return confirm('ဤ VIP လျှောက်ထားချက်ကို အတည်ပြုရန် သေချာပါသလား?');">
                                                <i class="fa-solid fa-check me-1"></i> အတည်ပြုမည်
                                            </a>
                                        <% } %>
                                        
                                        <!-- Delete Button -->
                                        <a href="delete-sub.jsp?id=<%= rsSub.getInt("id") %>" 
                                           class="btn btn-outline-danger btn-sm rounded-pill" 
                                           onclick="return confirm('ဤ VIP လျှောက်ထားချက်ကို ဖျက်ရန် သေချာပါသလား?');">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <%
                                        }
                                        if(!hasSub) {
                                            out.println("<tr><td colspan='8' class='text-center text-muted'>VIP လျှောက်ထားသူ မရှိသေးပါ။</td></tr>");
                                        }
                                    } catch(Exception e) {
                                        out.println("<tr><td colspan='8' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>
</html>