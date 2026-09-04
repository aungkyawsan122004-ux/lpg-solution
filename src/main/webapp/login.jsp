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
        body {
            font-family: 'Padauk', 'Plus Jakarta Sans', sans-serif;
            background-color: #333d4e; /* ပုံပါနောက်ခံအရောင်နှင့် ကိုက်ညီသော Dark Slate အရောင် */
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #334155;
        }
        .login-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 440px;
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
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            margin-bottom: 15px;
        }
        .form-control, .input-group-text {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            font-size: 0.95rem;
        }
        .form-control:focus {
            border-color: #f97316;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.15);
            background-color: #ffffff;
        }
        .btn-brand {
            background: #f97316;
            color: #ffffff;
            border-radius: 12px;
            padding: 12px;
            font-weight: 700;
            border: none;
            box-shadow: 0 4px 15px rgba(249, 115, 22, 0.3);
            transition: all 0.3s ease;
        }
        .btn-brand:hover {
            background: #ea580c;
            color: #ffffff;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="login-card mx-auto">
            <div class="text-center mb-4">
                <!-- ပုံပါအတိုင်း အဝါရောင် လိုဂိုတံဆိပ် (Badge) ထည့်သွင်းထားခြင်း -->
                <div>
                    <span class="brand-badge">
                        <i class="fa-solid fa-fire text-danger"></i> LPG Business Solution
                    </span>
                </div>
                <h4 class="fw-extrabold text-dark mt-2 mb-1">စနစ်သို့ အကောင့်ဝင်ရန်</h4>
                <p class="text-secondary small">အမည်နှင့် ဖုန်းနံပါတ်ဖြင့် အလွယ်တကူ ဝင်ရောက်ပါ</p>
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
