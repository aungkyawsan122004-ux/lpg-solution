<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="my">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>အကောင့်ဝင်ရန် - NexLPG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Padauk:wght@400;700&family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --bg-light: #f8fafc;
        }
        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #eff6ff 0%, #f8fafc 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(37, 99, 235, 0.08);
            width: 100%;
            max-width: 420px;
        }
        .btn-brand {
            background: var(--primary);
            color: #ffffff;
            border-radius: 50px;
            padding: 12px;
            font-weight: 700;
            border: none;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.25);
            transition: 0.3s;
        }
        .btn-brand:hover {
            background: var(--primary-dark);
            color: #ffffff;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="login-card mx-auto">
            <div class="text-center mb-4">
                <a href="index.jsp" class="text-decoration-none d-inline-flex align-items-center gap-2 mb-2">
                    <i class="fa-solid fa-fire text-danger fs-3"></i>
                    <span class="text-dark fw-bold fs-4">Nex</span><span class="text-primary fw-extrabold fs-4">LPG</span>
                </a>
                <h4 class="fw-bold text-dark mt-2">စနစ်သို့ အကောင့်ဝင်ရန်</h4>
                <p class="text-secondary small">နာမည်နှင့် ဖုန်းနံပါတ်ဖြင့် အလွယ်တကူ ဝင်ရောက်ပါ</p>
            </div>

            <!-- LoginServlet သို့ နာမည်နှင့် ဖုန်းနံပါတ် ပို့ပေးမည် -->
            <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold small text-secondary">အမည် (Name)</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted"><i class="fa-solid fa-user"></i></span>
                        <input type="text" name="name" class="form-control border-start-0 bg-light py-2" placeholder="သင့်နာမည်ထည့်ရန်" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small text-secondary">ဖုန်းနံပါတ် (Phone Number)</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted"><i class="fa-solid fa-phone"></i></span>
                        <input type="text" name="phone" class="form-control border-start-0 bg-light py-2" placeholder="ဥပမာ - 09753842456" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-brand w-100 mt-3">
                    အကောင့်ဝင်မည် <i class="fa-solid fa-arrow-right ms-2"></i>
                </button>
            </form>

            <div class="text-center mt-4">
                <a href="index.jsp" class="text-decoration-none text-muted small fw-bold">
                    <i class="fa-solid fa-arrow-left me-1"></i> ပင်မစာမျက်နှာသို့ ပြန်ရန်
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
