<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="my">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexLPG | VIP Membership Signup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; color: #0f172a; }
        .sub-card { background: #ffffff; border-radius: 20px; border: 1px solid #e2e8f0; padding: 40px; }
    </style>
</head>
<body class="py-5">
    <div class="container" style="max-width: 600px;">
        <a href="index.jsp" class="btn btn-outline-secondary rounded-pill mb-4 fw-bold">
            <i class="fa-solid fa-arrow-left me-1"></i> ပင်မစာမျက်နှာသို့
        </a>

        <div class="sub-card shadow-sm">
            <h4 class="fw-bold text-center text-primary mb-3">
                <i class="fa-solid fa-crown text-warning me-2"></i>VIP Membership လျှောက်ထားရန်
            </h4>
            <p class="text-muted text-center small mb-4">
                လစဉ်ကြေး <b>30,000 Ks</b> အား KPay / WavePay မှတစ်ဆင့် လွှဲပြောင်းပြီး အောက်ပါ Form ကို ဖြည့်သွင်းပါ။
            </p>

            <form action="${pageContext.request.contextPath}/SubscribeServlet" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">သင့်အမည်</label>
                    <input type="text" name="userName" class="form-control" placeholder="အမည် ရေးပါ..." required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">ဖုန်းနံပါတ်</label>
                    <input type="text" name="phone" class="form-control" placeholder="09xxxxxxxxx" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">ငွေလွှဲသည့် နည်းလမ်း</label>
                    <select name="paymentMethod" class="form-select" required>
                        <option value="KBZ Pay">KBZ Pay (09123456789 - U AUNG AUNG)</option>
                        <option value="Wave Pay">Wave Pay (09123456789 - U AUNG AUNG)</option>
                        <option value="CB Pay">CB Pay (09123456789 - U AUNG AUNG)</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold">ငွေလွှဲ Transaction No. (နောက်ဆုံး ၆ လုံး)</label>
                    <input type="text" name="transactionNo" class="form-control" placeholder="ဥပမာ - 482910" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-3 rounded-pill fw-bold">
                    <i class="fa-solid fa-paper-plane me-2"></i> လျှောက်လွှာ ပေးပို့မည်
                </button>
            </form>
        </div>
    </div>
</body>
</html>