<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="my">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>အကောင့်ဝင်ရန် - LPG Business Solution</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --brand-primary: #f97316;
            --brand-dark: #0f172a;
            --bg-gradient: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        }
        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background: var(--bg-gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #334155;
        }
        .login-card {
            background: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 440px;
            position: relative;
            overflow: hidden;
        }
        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(90deg, #f97316, #ef4444);
        }
        .form-control, .input-group-text {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            font-size: 0.95rem;
        }
        .form-control:focus {
            border-color: var(--brand-primary);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.15);
            background-color: #ffffff;
        }
        .btn-brand {
            background: linear-gradient(135deg, #f97316 0%, #ea580c 100%);
            color: #ffffff;
            border-radius: 12px;
            padding: 12px;
            font-weight: 700;
            border: none;
            box-shadow: 0 4px 15px rgba(249, 115, 22, 0.3);
            transition: all 0.3s ease;
        }
        .btn-brand:hover {
            background: linear-gradient(135deg, #ea580c 0%, #c2410c 100%);
            color: #ffffff;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="login-card mx-auto">
            <div class="text-center mb-4">
                <a href="index.jsp" class="text-decoration-none d-inline-flex align-items-center gap-2 mb-2">
                    <div class="bg-warning bg-opacity-10 p-2 rounded-circle">
                        <i class="fa-solid fa-fire text-warning fs-3"></i>
                    </div>
                </a>
                <h4 class="fw-extrabold text-dark mt-2 mb-1">LPG BUSINESS SOLUTION</h4>
                <p class="text-secondary small">စနစ်သို့ အကောင့်ဝင်ရောက်ရန် အချက်အလက်များ ထည့်ပါ</p>
            </div>

            <!-- LoginServlet သို့ နာမည်နှင့် ဖုန်းနံပါတ် ပို့ပေးမည် -->
            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold small text-secondary">အမည် (Name)</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted"><i class="fa-solid fa-user"></i></span>
                        <input type="text" name="name" class="form-control border-start-0 py-2" placeholder="သင့်နာမည်ထည့်ရန်" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small text-secondary">ဖုန်းနံပါတ် (Phone Number)</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted"><i class="fa-solid fa-phone"></i></span>
                        <input type="text" name="phone" class="form-control border-start-0 py-2" placeholder="ဥပမာ - 09753842456" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-brand w-100 mt-3 text-uppercase">
                    အကောင့်ဝင်မည် <i class="fa-solid fa-arrow-right ms-2"></i>
                </button>
            </form>

            <div class="text-center mt-4 pt-2 border-top">
                <a href="index.jsp" class="text-decoration-none text-muted small fw-bold">
                    <i class="fa-solid fa-arrow-left me-1"></i> ပင်မစာမျက်နှာသို့ ပြန်ရန်
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
