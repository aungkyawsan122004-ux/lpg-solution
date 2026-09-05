<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="my">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexLPG | VIP Membership Signup</title>
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
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }

        .signup-wrapper {
            width: 100%;
            max-width: 580px;
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

        .sub-card {
            background: var(--surface-white);
            border-radius: 24px;
            border: 1px solid var(--border-subtle);
            padding: 45px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.04);
        }

        .header-icon-box {
            width: 60px;
            height: 60px;
            background: #fef3c7;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
            box-shadow: 0 8px 20px rgba(245, 158, 11, 0.15);
        }

        .header-icon-box i {
            font-size: 1.75rem;
            color: #d97706;
        }

        .form-label {
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--brand-primary);
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            padding: 12px 16px;
            border-radius: 12px;
            border: 1px solid var(--border-subtle);
            font-size: 0.95rem;
            background-color: #f8fafc;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            background-color: #ffffff;
            border-color: var(--brand-accent);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        .price-highlight {
            color: var(--brand-accent);
            font-weight: 800;
        }

        .submit-btn {
            background-color: var(--brand-accent);
            color: #fff;
            border: none;
            padding: 14px;
            border-radius: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(249, 115, 22, 0.3);
            transition: all 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #ea580c;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(249, 115, 22, 0.4);
        }
    </style>
</head>
<body>
    <div class="signup-wrapper">
        <a href="index.jsp" class="back-btn rounded-pill mb-4">
            <i class="fa-solid fa-arrow-left"></i> ပင်မစာမျက်နှာသို့
        </a>

        <div class="sub-card">
            <div class="header-icon-box">
                <i class="fa-solid fa-crown"></i>
            </div>
            
            <h4 class="fw-extrabold text-center text-dark mb-2" style="font-size: 1.5rem;">
                VIP Membership လျှောက်ထားရန်
            </h4>
            <p class="text-muted text-center small mb-4" style="line-height: 1.6;">
                လစဉ်ကြေး <span class="price-highlight">30,000 Ks</span> အား KPay / WavePay မှတစ်ဆင့် လွှဲပြောင်းပြီး အောက်ပါ Form ကို ဖြည့်သွင်းပါ။
            </p>

            <form action="${pageContext.request.contextPath}/SubscribeServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">သင့်အမည်</label>
                    <input type="text" name="userName" class="form-control" placeholder="အမည် ရေးပါ..." required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">ဖုန်းနံပါတ်</label>
                    <input type="text" name="phone" class="form-control" placeholder="09xxxxxxxxx" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">ငွေလွှဲသည့် နည်းလမ်း</label>
                    <select name="paymentMethod" class="form-select" required>
                        <option value="" selected disabled>ငွေလွှဲမည့် ဘဏ်/ငွေကြေးစနစ် ရွေးချယ်ပါ</option>
                        <option value="KBZ Pay">KBZ Pay (09123456789 - U AUNG AUNG)</option>
                        <option value="Wave Pay">Wave Pay (09123456789 - U AUNG AUNG)</option>
                        <option value="CB Pay">CB Pay (09123456789 - U AUNG AUNG)</option>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label class="form-label">ငွေလွှဲ Transaction No. (နောက်ဆုံး ၆ လုံး)</label>
                    <input type="text" name="transactionNo" class="form-control" placeholder="ဥပမာ - 482910" required>
                </div>
                
                <button type="submit" class="submit-btn w-100">
                    <i class="fa-solid fa-paper-plane me-2"></i> လျှောက်လွှာ ပေးပို့မည်
                </button>
            </form>
        </div>
    </div>
</body>
</html>
